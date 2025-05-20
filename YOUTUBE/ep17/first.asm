;		BASIC TEMPLATE FO ASSEMBLY





section .data

section .text
global _start

_start:
	mov eax, 3
	mov ebx, 2
	cmp eax, ebx
	jl  lesser
	jmp end

lesser:

mov ecx,1

end:
	
	int 0x80

