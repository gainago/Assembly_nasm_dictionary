;read one character from stdin and return its code into rax
;if will error or EOF returns -1

section .text

global read_char:function

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
	jle .end_of_text;
	movzx rax, byte [rsp]
	jmp .continue;

.end_of_text:

	mov rax, -1;

.continue:
	
	add rsp, 16;
	leave;
	ret;
		
