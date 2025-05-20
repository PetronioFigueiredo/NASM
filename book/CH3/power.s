#PURPOSE: Program to illustrate how functions work
#	  This program will compute the value of 
#	  2^3 + 5^2



# Everything in the main program is stored in registers,
# so the data sections doesn't he anything.

.section .data


.section .text

.globl _start

_start:

	pushq $3		# push second argument
	pushq $2		# push first argument
	call power		# call the function
	addq $16, %rsp		# move the stack pointer back
	pushq %rax		# save the first answer before
				# calling hte next function

	pushq $2		# push second argument
	pushq $5		# push first argument
	call power		# call the function
	addq $16, %rsp		# moce the stack pointer back


	popq %rbx		# The second answer is already
				# in %eax. We saved the
				# first answer onto the stack,
				# ho now we can just pop it
				# out into %ebx

	addq %rax, %rbx		# add them together
				# the result is in %ebx

	movq $60, %rax		#exit (%ebx is returned)
	movq $1, %rax		# Exit equal result
	int $0x80

#PURPOSE: This function is used to compute
#	  the value od and number raised to 
#	  a power.


#INPUT:	  First argument - the base number
#	  Second argument - hte power to raise it to

#OUTPPUT: Will give the result as a return value

#NOTES: The power must be 1 or greater

#VARIABLES:
#	%ebx, holds the base number
#	%ecx, hods the power

#	-4(%ebp) - holds the current result

#	%eax is used to temporary storage

.type power, @function
power:
	pushq %rbp	# save old vase ponter
	movq %rsp, %rbp # make stack pointer the base pointer
	subq $8, %rsp	# get room for our local storage

	movq 16(%rbp), %rbx # put the first argument inn %rbx
	movq 24(%rbp), %rcx # put the second argument in %rcx
	movq %rbx, -8(%rbp) # store current result

power_loop_start:
	cmpq $1, %rcx	# if the power is 1, we are done
	je end_power
	
	mov -8(%rbp), %rax # move the curretn result into %eax
	imulq %rbx, %rax # multiply the current result 

	mov %rax, -8(%rbp) # store the current result

	decq %rcx	# decrease the power
	jmp power_loop_start # run for the next power

end_power:
	movq -4(%rbp), %rax #return value goes in %eax
	movq %rbp, %rsp	# restore the stack pointer
	popq %rbp	# restore the base pointer
	ret



