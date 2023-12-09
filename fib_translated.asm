0000100, 2 000010E  # Load A (initial value 0)
0000101, 2 000010F  # Load B (initial value 1)
0000102, 0 000010E  # Add A to B (R = A + B)
0000103, 3 0000110  # Store result in R (new Fibonacci number)
0000104, 2 000010F  # Load B
0000105, 3 000010E  # Store B in A (update A to old value of B)
0000106, 2 0000110  # Load R
0000107, 3 000010F  # Store R in B (update B to new Fibonacci number)
0000108, 2 0000111  # Load C (counter)
0000109, 0 0000112  # Add Neg1 to C (decrement C)
000010A, 3 0000111  # Store updated C
000010B, 2 0000111  # Load C
000010C, 5 0000002  # Skip next instruction if C is 0
000010D, 6 0000100  # Jump to Loop start
000010E, 1 0000000  # Halt
000010F, A, dec 0
0000110, B, dec 1
0000111, R, dec 0
0000112, C, dec 9
0000113, Neg1, dec -1