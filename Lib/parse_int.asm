;accepts adress of null terminated string in rdi register 
;should return int in rax and count of used characters in rdx

section .text
extern parse_uint
global parse_int:function
parse_int:
	push rbp;
	mov rbp, rsp; create stack frame
	
	xor rax, rax;set start value
	xor rdx, rdx;

	movzx r8, byte [rdi]; analyze first symbol
	cmp r8, '-';
	je .is_negative;
	cmp r8, '0';
	jb .done;
	cmp r8, '9';
	ja .done;
.is_positive:
	call positive_number;
	jmp .done;
	
.is_negative:
	call negative_number;
	jmp .done;

positive_number:
	call parse_uint wrt ..plt;
	bt rax, 63;
	jnc .normal_size_number_positive;
	call too_big_number;
 .normal_size_number_positive:
	ret;

negative_number:
	lea rdi, [rdi + 1];
	call parse_uint wrt ..plt;
	mov rcx, 0x8000000000000000;
	cmp rax, rcx;
	jbe .normal_size_number_negative;
	call too_big_number;
 .normal_size_number_negative:
	neg rax;
	ret;

too_big_number:
	push rdx; do not allow last character
	mov rdx, 0;
	mov r10, 10;
	div r10;
	pop rdx;
	dec rdx;
	ret;
parse_int.done:
	leave;
	ret;
