; accepts two pointers to string in rdi and rsi registers
; should compare strings and return 1 if they are equal, otherwise 0
; return value holds in rax
section .text
global string_equals;
string_equals:
	push rbp;
	mov rbp, rsp
	
	mov rax, 0; return value
	mov rdx, 0; counter
.loop:
	mov al, [rdi + rdx]; save first symbol
	movzx r8, byte [rsi + rdx]; save second symbol
	cmp r8b, al;compare current symbols
	jne .not_equal;
	cmp r8, 0;check the end of string
	je .equal;
	jmp .loop;
.not_equal:
	mov rax, 0;
	jmp done;
.equal:
	mov rax, 1;
	jmp done;
done:
	leave;
	ret;
