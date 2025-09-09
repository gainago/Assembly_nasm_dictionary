;dict.asm

section .rodata
long_key: db 'this key is too long', 10, 0
length_long_key: dq $ - long_key
unfound_key: db 'this dictionary does not consists that key', 10, 0
length_unfound_key: dq $ - unfound_key

section .text

extern string_copy
extern string_equals
extern string_length
extern print_newline
extern print_string

extern first_word; will be in main
;expect a pointer to null terminared key string in rdi
;pointer to last word defined also null terminared string(in consider case last enterty pointing to null)
global find_word
find_word:
;first lable is first_word
	push rbp
	mov rbp, rsp
	push rdi ;save key string at rdp + 8
;created frame
;initialization data
	mov r8, [first_word];containce current adress
	.loop:
		lea rdi, [r8 + 8]
		sub rsp, 256; 16*16 obeyed ABI standart of alignment
		mov rsi, rsp
		mov rdx, 255
		
		push r8; push the adress of current label
		call string_copy wrt ..plt; for PIC
		pop r8

		cmp rax, rsp
		jne .error_copy_string
		mov rdi, [rbp + 8]
			;now rdi holds adress of key string
		mov rsi, rax
		push r8
		call string_equals wrt ..plt
		pop r8; need save because r8 is callee save
		add rsp, 256
		cmp rax, 1
		je .found_value
		mov r8, [r8]
		cmp r8, 0; if it is end of list
		je .end_of_list
		jmp .loop
.end_of_list:
	
	mov rax, 1
	mov rdi, 2
	mov rsi, unfound_key
	mov rdx, length_unfound_key
	syscall
	jmp .end
	

.found_value:
;we need to know start adress it is r8
;after thar located 8 bytes lable adress
;after that located key string
	lea rdi, [r8 + 8] 
	call string_length
;now rax holds length of string
	lea rax, [r8 + 9  + rax*1]; and add null symbol
;now rax containce start of value string
	mov rdi, rax;
	call print_string wrt ..plt
	call print_newline wrt ..plt
	
	jmp .end

.error_copy_string:
	
	mov rax, 1
	mov rdi, 2
	mov rsi, long_key
	mov rdx, length_long_key
	syscall
	
	call print_newline
	
	mov rax, 1
	mov rdi, 2
	mov rsi, rsp
	mov rdx, 256
	syscall
	call print_newline
	add rsp, 256
	jmp .end
.end:
	pop rdi
	leave
	ret
