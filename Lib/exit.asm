global exit;
section .text
;output value takes from rdi register
exit:
	push rbp;
	mov rbp, rsp;
	mov rax, 60	;
	syscall		;
	ret		;
	leave;
	
	
