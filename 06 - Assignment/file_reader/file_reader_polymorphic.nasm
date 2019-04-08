global _start

section .text

_start:
	xor ecx, ecx
	mul ecx
	push eax
	pop edx
	pop ebx
	jmp two

one:
	pop ebx
	inc al
	inc al
	mul al
	inc al
	int 0x80

	mov esi, eax
	jmp read

exit:
	mov al, 1
	xor ebx, ebx
	int 0x80

read:
	mov ebx, esi
	mov al, 3
	dec esp
	mov ecx, esp
	mov dl, 1
	int 0x80

	xor ebx, ebx
	cmp eax, ebx
	je exit

	mov al, 4
	mov bl, 1
	mov dl, 1
	int 0x80

	inc esp
	jmp read

two:
	call one
	string	db "/tmp/del.txt"
