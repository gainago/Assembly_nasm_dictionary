section .text

extern print_string:funtion;

global print_uint;
;function expect 8-byte integer in decimial format in rdi
print_uint: 	
	push rbp;
	mov rbp, rsp;

	push rbx;
	mov rax, rdi;	div makes division rdx:rax by rbx, remainder in rdx
	mov rdx, 0;	quotient in rax
	mov rbx, 10;
	sub rsp, 1;
	mov byte [rsp], 0; 
.division_loop:
	div rbx;
	add rdx, 48;
	sub rsp, 1;
	mov byte [rsp], dl;
	cmp rax, 0;
	je .end;
	mov rdx, 0;
	jmp .division_loop;
.end:
	mov rdi, rsp;
	call print_string wrt ..plt;	
	mov rbx, [rbp - 8];
	
	leave;
	ret;
