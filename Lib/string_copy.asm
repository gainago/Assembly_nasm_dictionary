;string_copy.asm
;rdi: accepts adress of sourse string in rdi register 
;rsi: adress of destination buffer
;rdx: length of destination buffer without null terminated symbol
;this function copies string to the destination buffer
;rax: return adress of buffer if the string fits the buffer,
; otherwise returns zero
section .text
global string_copy
string_copy:

	push rbp; create stack frame	
	mov rbp, rsp;
	inc rdx;
; now rdx containce count of all possible characters within terminated symbol
	xor rcx, rcx; set null in counter
.loop:
	mov r8b, byte [rdi + rcx]; save current character from string in al
	mov byte [rsi + rcx], r8b; write current character in buffer
	inc rcx;
	cmp rcx, rdx;if this is max size of the buffer
	je .max_buffer_length;
	cmp r8b, 0; if this is end of string
	je .end_of_string;
	jmp .loop;

.max_buffer_length:
	mov rax, 0; set error code by default
	cmp r8b, 0;check if it is correct last symbol
	jne .last_symbol_is_not_ok;
	mov rax, rsi; seems that last symbol is ok
.last_symbol_is_not_ok:
	jmp .done;
.done:
	leave;
	ret;

.end_of_string:
	mov rax, rsi;
	jmp .done;
