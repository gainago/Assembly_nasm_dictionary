section .text
global print_string:function

extern string_length;

print_string:
	push rbp;
	mov rbp, rsp;
	push rdi;	;string address in rdi register, save it on stack
	call string_length wrt ..plt
		; after that in rax we will have length of string
	mov r11, rax	; save length
	mov rax, 1	; sys_call write
	mov rdi, 1	; file descriptor
	pop rsi		; take address string from stack
	mov rdx, r11	; set length of string
	syscall		; call system call write		
	leave		; delete stack frame
	ret		; exit of function

