;		BASIC TEMPLATE FO ASSEMBLY





section .data
	x dd 3.14
	y dd 2.1

section .text
global _start

_start:

	movss xmm0, [x] ; XMM registers are nuberer from XMM0 to XMM15
			; with the finality of handring float point numbers
	movss xmm1, [y]

	addss xmm0, xmm1
	subss xmm1, xmm1

	mov ebx, 1
	int 0x80

