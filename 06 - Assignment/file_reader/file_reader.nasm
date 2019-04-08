section .text

_start:
	xor	eax, eax
	xor	ebx, ebx
	xor	ecx, ecx
	xor	edx, edx
	jmp	two

one:
	pop	ebx

	mov	al, 5
	xor	ecx, ecx
	int	0x80

	mov	esi, eax
	jmp	read

exit:
	mov	al, 1
	xor	ebx, ebx
	int	0x80

read:
	mov	ebx, esi
	mov	al, 3
	sub	esp, 1
	lea	ecx, [esp]
	mov	dl, 1
	int	0x80

	xor	ebx, ebx
	cmp	eax, ebx
	je	exit

	mov	al, 4
	mov	bl, 1
	mov	dl, 1
	int	0x80

	add	esp, 1
	jmp	read

two:
	call	one
	string	db "/tmp/del.txt"
