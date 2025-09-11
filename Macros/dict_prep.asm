%line 3+1 dict.asm
[section .rodata]
long_key: db 'this key is too long', 10, 0
length_long_key: dq $ - long_key
unfound_key: db 'this dictionary does not consists that key', 10, 0
length_unfound_key: dq $ - unfound_key


[section .data]
%line 2+1 colon.inc
third_word:

 dq 0
%line 9+1 colon.inc
db "nasm", 0
%line 2+1 words.inc
db "net wide assembly", 0
%line 2+1 colon.inc
second_word:
%line 6+1 colon.inc
 dq third_word
%line 9+1 colon.inc
db "Moscow", 0
%line 4+1 words.inc
db "It is the capital of Russian Federation", 0
%line 2+1 colon.inc
first_word:
%line 6+1 colon.inc
 dq second_word
%line 9+1 colon.inc
db "firstword", 0
%line 6+1 words.inc
db "first word explanation", 0
%line 13+1 dict.asm
[section .text]

[extern string_copy]
[extern string_equals]
[extern string_length]
[extern print_newline]
[extern print_string]



[global find_word]
find_word:

 push rbp
 mov rbp, rsp
 push rdi


 mov r8, [first_word]
 .loop:
 lea rdi, [r8 + 8]
 sub rsp, 256
 mov rsi, rsp
 mov rdx, 255

 push r8
 call string_copy wrt ..plt
 pop r8

 cmp rax, rsp
 jne .error_copy_string
 mov rdi, [rbp + 8]

 mov rsi, rax
 push r8
 call string_equals wrt ..plt
 pop r8
 add rsp, 256
 cmp rax, 1
 je .found_value
 mov r8, [r8]
 cmp r8, 0
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



 lea rdi, [r8 + 8]
 call string_length

 lea rax, [r8 + 9 + rax*1]

 mov rdi, rax
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
