;		BASIC TEMPLATE FO ASSEMBLY





section .data

section .text
global _start

_start:
	
	mov eax, 5
	mov ebx, 3
	sub eax, ebx


	;mov eax, 1
	int 80h

