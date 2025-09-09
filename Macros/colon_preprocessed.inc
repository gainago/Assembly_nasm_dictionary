%line 4+1 colon.inc
third_word:
%line 7+1 colon.inc
 dq 0
%line 12+1 colon.inc
db "third word", 0
%line 16+1 colon.inc
db "third word explanation", 0

%line 3+1 colon.inc

second_word:
%line 9+1 colon.inc
 dq third_word
%line 12+1 colon.inc
db "second word", 0
%line 19+1 colon.inc
db "second word explanation", 0

%line 3+1 colon.inc

first_word:
%line 9+1 colon.inc
 dq second_word
%line 12+1 colon.inc
db "first word", 0
%line 22+1 colon.inc
db "first word explanation", 0
