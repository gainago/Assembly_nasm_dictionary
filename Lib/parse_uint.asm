;this function accepts adress of string in rdi register 
; returns the number  in rax
; count of characters count return in rdx 
section .text 
	global parse_uint:function
parse_uint:
	push rbp; create frame
	mov rbp, rsp;
	
	xor rdx, rdx; set zero in rdx because rdx will be counter of characters
	xor rax, rax; set zero because it will hold result
	mov r8, 10; r8 will be a multiplier
.loop:
	movzx r9d, byte [rdi + rdx]; set current character in r9 register
	cmp r9b, '0';
	jl .end_of_number;
	cmp r9b, '9';
	jg .end_of_number;
	sub r9, '0'; now r9 holds a number and not it is ASCII code
	push rax;
	mov rax, 0xFFFFFFFFFFFFFFFF;check overflow
	sub rax, r9;
	push rdx;
	mov rdx, 0;
	div r8;
	pop rdx;
	cmp [rsp], rax;[rsp] holds the current number
	jg .got_max_number;
	pop rax;
	push rdx;
	mul r8;
	pop rdx;
	add rax, r9;
	inc rdx;
	jmp .loop;
.got_max_number:
	pop rax;
	
.end_of_number:
	leave; delete stack frame
	ret;
	
	
