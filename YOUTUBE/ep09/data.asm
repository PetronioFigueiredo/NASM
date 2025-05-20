;		BASIC TEMPLATE FO ASSEMBLY





section .data
	string1 DB "ABA",0h
	string2 DB "CDE'",0h

section .text
global _start

_start:
	


	mov bl,[string1]
	mov eax,1
	int 80h

