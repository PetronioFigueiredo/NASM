.section .text

.globl _start

_start:
    pushq $3           # Push exponent (second argument)
    pushq $2           # Push base (first argument)
    call power         # Calculate 2^3
    addq $16, %rsp    # Cleanup stack (8 bytes per arg * 2)
    pushq %rax         # Save result (2^3)

    pushq $2           # Push exponent (second argument)
    pushq $5           # Push base (first argument)
    call power         # Calculate 5^2
    addq $16, %rsp    # Cleanup stack

    popq %rbx          # Retrieve first result (2^3)
    addq %rax, %rbx    # Sum results (2^3 + 5^2)

    movq $60, %rax     # System call for exit
    movq %rbx, %rdi    # Exit status = result
    syscall

.type power, @function
power:
    pushq %rbp         # Save base pointer
    movq %rsp, %rbp    # Set new base pointer
    subq $8, %rsp      # Allocate local storage

    movq 16(%rbp), %rbx # Get base from stack
    movq 24(%rbp), %rcx # Get exponent from stack
    movq %rbx, -8(%rbp) # Initialize result with base

power_loop_start:
    cmpq $1, %rcx      # Check if exponent == 1
    je end_power

    movq -8(%rbp), %rax # Load current result
    imulq %rbx, %rax   # Multiply by base
    movq %rax, -8(%rbp) # Store updated result
    decq %rcx          # Decrement exponent
    jmp power_loop_start

end_power:
    movq -8(%rbp), %rax # Return value
    movq %rbp, %rsp    # Restore stack pointer
    popq %rbp          # Restore base pointer
    ret
