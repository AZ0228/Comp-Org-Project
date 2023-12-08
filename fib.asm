ORG 100
Loop, Load R 
    Add A 
    Store R 
    Load A 
    Store B     
    Load R 
    Add B
    Store R 
    Load B 
    Store R 
    Load C 
    Add Neg1 
    Store C 
    Load C 
    Skip 2
    Jump Loop 
Halt
A,  Dec 0 // fib0
B,  Dec 1 // fib1
R,  Dec 0 // result
C,  Dec 10 // counter/loop control, 10 loops excluding 0 and 1
Neg1, Dec -1 // used to decrement
