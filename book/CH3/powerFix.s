.section .text

.globl _start

_start:
	pushq	$3
	pushq	$2
	call	power
	addq	$16, %rsp

	pushq	%rax


	pushq	$2
	pushq	$5
	call	power
	addq	$16, %rsp

	push	%rbx

	addq	%rax, %rbx

	movq	$1, %rax
	int	$0x80



.type power, @function
power:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$8, %rsp


	movq	16(%rbp), %rax
	movq	24(%rbp), %rcx
	movq	%rbx, -8(%rbp)

power_loop_start:
	cmpq $1, %rcx
	je	end_power

	movq -8(%rbp), %rax
	imulq %rbx, %rax

	movq	%rax, -4(%rbp)

	decq	%rcx
	jmp	power_loop_start

end_power:
	movq -4(%rbp), %rax
	movq %rbp, %rsp
	popq %rbp
	ret



