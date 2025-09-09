section .text
global print_newline	;

extern print_char	;

print_newline:		;
	push rbp	;
	mov rbp, rsp	;

	mov rdi, 10	;
	call print_char	wrt ..plt;

	leave		;
	ret		;
	
