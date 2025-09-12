section .text
global print_char:function 
extern print_string;

print_char:	;expect character code in rdi
	push rbp	;
	mov rbp, rsp	;
	sub rsp, 2	;
	mov [rsp], dil	;
	mov byte [rsp + 1], 0;
	mov rdi, rsp;
	call print_string wrt ..plt
		;accept address of string in rdi and write it
	leave;
	ret;
