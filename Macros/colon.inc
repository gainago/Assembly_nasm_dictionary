%macro colon 2
%2:
%ifndef previously_label
	dq 0
%else
	dq  previously_label
%endif
%define previously_label %2
db %1, 0
%endmacro
