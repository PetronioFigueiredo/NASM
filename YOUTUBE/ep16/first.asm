;		BASIC TEMPLATE FO ASSEMBLY





section .data

section .text
global _start

_start:
	mov eax, 2
	shr eax, 1 ;SHR stands for shift right equivalent of divide by 2
	shl eax, 1 ;SHL stands for shift left equivalent of multiply by 2
	sar eax, 1 ;SAL stasds fot arithmetic shift conservig siged number
	sal eax, 1 ;SAL stasds fot arithmetic shift conservig siged number
	



	;mov eax,1
	int 80h

