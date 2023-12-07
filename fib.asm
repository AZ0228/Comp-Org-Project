.data
    fib0: .word 0             # Initial Fibonacci numbers
    fib1: .word 1

.text
.globl main


main:
    li $t0, 0                # t0 will hold the lower Fibonacci number, initialized to F0
    li $t1, 1                # t1 will hold the higher Fibonacci number, initialized to F1
    li $t2, 10               # t2 will count down from 10 to 0 (to calculate 11th Fibonacci number)

loop:
    add $t3, $t0, $t1        # t3 = t0 + t1, calculate next Fibonacci number
    move $t0, $t1            # move t1 to t0 for next iteration
    move $t1, $t3            # move t3 to t1 for next iteration

    sub $t2, $t2, 1          # decrement the counter
    bgtz $t2, loop           # if the counter is greater than 0, loop again

    # At this point, $t1 contains the 11th Fibonacci number
    # You can now store it or print it as needed

    li $v0, 10               # exit program
    syscall