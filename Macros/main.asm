;main.asm
;this function read key word from stdin and call function
;to fing key value in words.inc
section .data

section .rodata
word_key: db 'too long key word', 0

section .text
extern read_word
extern print_string
extern print_newline
extern find_word
global _start

_start:
	push rbp;
	mov rbp, rsp; create stack frame
	sub rsp, 256; 256 = 16*16
	mov rdi, rsp
	mov rsi, 255
	call read_word wrt ..plt
	cmp rax, 0
	je .error_with_read
	mov rdi, rax
	call find_word wrt ..plt
	

.error_with_read:
	
	mov rdi, word_key
	call print_string
	call print_newline
	jmp .end
.end:
	add rsp, 256
	leave
	ret
	
