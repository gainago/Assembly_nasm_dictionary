;main.asm
;this function read key word from stdin and call function
;to fing key value in words.inc
section .data

section .rodata
word_key: db 'too long key word or another error with input', 10, 0
explanation_of_input: db 'enter a key string', 10, 0

section .text
extern read_word
extern print_string
extern print_newline
extern find_word
extern exit
global _start

_start:
	push rbp;
	mov rbp, rsp; create stack frame
	mov rdi, explanation_of_input
	call print_string
	sub rsp, 256; 256 = 16*16
	mov rdi, rsp
	mov rsi, 255
	call read_word wrt ..plt
	push rax
	push rdi
	call print_newline
	pop rdi
	pop rax
	cmp rax, 0
	je .error_with_read
	cmp byte [rdi], 0
	je .error_with_read
	mov rdi, rax
	call find_word wrt ..plt
	jmp .end	

.error_with_read:
	
	mov rdi, word_key
	call print_string
	call print_newline
	jmp .end
.end:
	add rsp, 256
	leave
	mov rdi, 60
	call exit
	
