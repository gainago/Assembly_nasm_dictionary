section .text
;address a string will be in RDI register
global string_length
string_length:

	push rbp	;enter of function
	mov rbp, rsp	;

	xor rax, rax	;set null in rax
.loop:
			;do not create frame in cycle
			;RAX is counter
	cmp byte [rdi + rax], 0;check if current symbol is null
	je .ret		;ends function
	inc rax		;
	bt rax, 63; if length is very long or incorrect
	jc .error	;
	jmp .loop	;
.error:	
	mov rax, -1	;
.ret:
	leave		;free frame
	ret		;	
