;		BASIC TEMPLATE FO ASSEMBLY





section .data

section .text
global _start

_start:
	mov eax, 11
	mov ecx, 2
	div ecx

	



;	mov eax,1
	int 80h

