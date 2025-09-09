section .text

global read_char;

read_char:
	push rbp; create frame
	mov rbp, rsp;
		
	sub rsp, 16;allocate one byte for symbol and 15 for ABI alignment
	mov rax, 0; number of system call read
	mov rdi, 0; number of file descriptor(stdin)
	mov rsi, rsp;
	mov rdx, 1;
	syscall;
	cmp rax, 0; if EOF occur
	je .end_of_text;
	jmp .continue;

.end_of_text:

	mov qword [rsp], 0;

.continue:
	
	mov byte al, [rsp];
	add rsp, 16;
	leave;
	ret;
		
