0000100, 2 0000110  # Load R (initially 0)
0000101, 0 000010F  # Add B (R = R + B; R initially 0, B initially 1)
0000102, 3 0000110  # Store result in R
0000103, 2 000010F  # Load B
0000104, 3 000010E  # Store B in A (update A to old value of B)
0000105, 2 0000110  # Load R (new Fibonacci number)
0000106, 3 000010F  # Store R in B (update B to new Fibonacci number)
0000107, 2 0000111  # Load C (counter)
0000108, 0 0000112  # Add Neg1 to C (decrement C)
0000109, 3 0000111  # Store updated C
000010A, 2 0000111  # Load C
000010B, 5 0000002  # Skip next instruction if C is 0
000010C, 6 0000100  # Jump to Loop start
000010D, 1 0000000  # Halt
000010E, A, dec 0
000010F, B, dec 1
0000110, R, dec 0
0000111, C, dec 9
0000112, Neg1, dec -1

