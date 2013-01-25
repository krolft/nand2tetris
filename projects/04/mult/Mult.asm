// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[3], respectively.)

// Put your code here.

    @R0         // factorA <- R0
    D=M
    @factorA
    M=D

    @R1         // factorB <- R1
    D=M
    @factorB
    M=D

    @sum        // sum = 0
    M=0

(LOOP)

    @factorA    // load first factor to D
    D=M
    @END        // end if first factor is 0
    D;JEQ

    @factorB    // load second factor to D
    D=M

    @sum        // add second factor to sum
    M=M+D

    @factorA     // decrement first factor
    M=M-1

    @LOOP       // loop
    0;JMP

(END)

    @sum        // store sum to R2 (product)
    D=M
    @R2
    M=D

(WAIT)

    @WAIT
    0;JMP



