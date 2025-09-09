;this function accepts a buffer adress in rdi register
;and a buffer size in rsi register
;read size symbols from stdin to buffer without whitespaces
;stops and return zero if a word size more that buffer specified
;otherwise return a buffer adress

section .text

extern read_char

global read_word

read_word:
	push rbp; create stack frame 
	mov rbp, rsp;
	
	mov rcx, 0; rcx is counter of word length
.loop:		; read one by one symbols from stdin
	push rdi; save all callee save registers that we need
	push rsi;
	push rcx; 
	call read_char wrt ..plt; now the symbol code saved into rax
	pop rcx;
	pop rsi;
	pop rdi;
	cmp rax, 0x20;
	je .loop;
	cmp rax, 0x9;
	je .loop;
	cmp rax, 0xA;
	je .loop;
	mov byte [rdi + rcx], al;
	cmp byte al, 0;
	je .end_of_word;
	inc rcx;
	cmp rcx, rsi;
	je .overflow;
	jmp .loop;

.end_of_word:
	leave;
	mov rax, rdi;
	ret;
.overflow:
	leave;
	mov rax, 0;
	ret;
