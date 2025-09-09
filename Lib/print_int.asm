section .text
extern print_uint;
extern print_char;
global print_int;
;function expects integer in rdi register
print_int:
	push rbp;
	mov rbp, rsp;
	
	cmp rdi, 0;
	jl .call_print_minus;
	jmp .continue;


.call_print_minus:
	call print_minus;	
	imul rdi, -1;
	
.continue:
	call print_uint wrt ..plt;
	
	leave;
	ret;
print_minus:
	push rbp;
	mov rbp, rsp;
	push rdi;
	mov rdi, 45;
	call print_char wrt ..plt;
	pop rdi;
	leave;
	ret;

