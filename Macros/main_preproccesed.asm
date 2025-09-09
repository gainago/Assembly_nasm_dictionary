%line 5+1 main.asm
[section .data]
%line 2+1 colon.inc
third_word:

 dq 0
%line 9+1 colon.inc
db "third word", 0
%line 2+1 words.inc
db "third word explanation", 0
%line 2+1 colon.inc
second_word:
%line 6+1 colon.inc
 dq third_word
%line 9+1 colon.inc
db "second word", 0
%line 4+1 words.inc
db "second word explanation", 0
%line 2+1 colon.inc
first_word:
%line 6+1 colon.inc
 dq second_word
%line 9+1 colon.inc
db "first word", 0
%line 6+1 words.inc
db "first word explanation", 0
%line 8+1 main.asm
[section .rodata]
word_key: db 'too long key word', 0

[section .text]
[extern read_word]
[extern pring_string]
[extern print_newline]
[extern find_word]
[global _start]

_start:
 push rbp
 mov rbp, rsp
 sub rsp, 256
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

