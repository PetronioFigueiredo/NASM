section .data

	prompt db "Guess (1-100):", 0
	prompt_len equ $ - prompt

	too_high db "Too high!", 10, 0
	too_high_len equ $ - too_high - 1

	too_low db "Too low!", 10, 0 - 1
	too_low_len equ $ - too_low

	correct db "you win!", 10, 0
	correct_len equ $ - correct - 1


section .bss
	guess resb 3 ; Stores 2 digits + newline
	secret resb 1; Stores the secret number (1-100)



section .text
	global _start

_start:
	; Generate randim number (1-100)
	call generate_random

game_loop:
	; Ask for guess
	mov eax, 4	; sys_write
	mov eax, 1	; stdout
	mov ecx, prompt
	mov edx, prompt_len
	int 0x80


	; Read input
	mov eax, 3	; sys_read
	mov ebx, 0	;stdin
	mov ecx, guess
	mov edx, 3	; Max 2 digits + new line
	int 0x80


	; Convert ASCII input to integer
	movzx eax, byte [guess]
	sub eax, '0'	; Convert ASCII digit to number
	cmp eax, [secret]
	jl .too_low
	jg .too_high
	je .correct

.too_low:
	; Print "Too low"
	mov eax, 4
	mov ebx, 1
	mov ecx, too_low
	mov edx, too_low_len
	int 0x80
	jmp game_loop

.too_high:
	; Print "Too high"
	mov eax, 4
	mov ebx, 1
	mov ecx, too_high
	mov edx, too_high_len
	int 0x80
	jmp game_loop
.correct:
	; Print "Correct"
	mov eax, 4
	mov ebx, 1
	mov ecx, correct
	mov edx, correct_len
	int 0x80

	; Exit
	mov eax, 1	; sys_exit
	mov ebx, 0
	int 0x80

	
; Generate a random numberr (1-100)
generate_random:
	; Use system time as seed (pseudo-random)
	mov eax, 13	; sys_time
	int 0x80
	and eax, 0x7F	; Limit to 127
	inc eax		; Ensure it's at least 1
	mov [secret], eax
	ret



































