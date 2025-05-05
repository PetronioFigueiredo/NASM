section .data	; Constants and static data
	
	msg db "Hello, world!", 0xA ; String with a new line
	len equ $ - msg		    ; Length of string


section .text	; Code
	global _start	; Entry point (for linker )


_start:
	; System call to write(1, msg, len)

	mov eax, 4	; sys_write syscall number
	mov ebx, 1	; stout file decriptor
	mov ecx, msg	; pointer to string
	mov edx, len	; string lenght
	int 0x80	; invoke kernel

	; System call exit(0)

	mov eax, 1	; sys_exit syscall number
	mov ebx, 0	; exit status
	int 0x80


