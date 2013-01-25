// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, the
// program clears the screen, i.e. writes "white" in every pixel.

// Put your code here.

    @color
    M=0

    @curPixelWord
    M=0

    @curPixelAddress
    M=0

        (CHECK_FOR_INPUT)
    @KBD
    D=M
    @WHITEN
    D;JEQ

            //[BLACKEN]
    @SCREEN
    D=M
    @CHECK_FOR_INPUT
    D;JNE               // already black?

    @color
    M=-1                // -1 -> 111111...1
    @FILL_SCREEN
    0;JMP

            (WHITEN)
    @SCREEN
    D=M
    @CHECK_FOR_INPUT
    D;JEQ               // already white?

    @color
    M=0
    @FILL_SCREEN
    0;JMP

                (FILL_SCREEN)

    @curPixelWord       // reset pixel word pointer
    M=0

                    (NEXT_PIXEL)

    @SCREEN
    D=A
    @curPixelWord
    D=D+M
    @curPixelAddress
    M=D

    @color              // put color in D
    D=M

    @curPixelAddress
    A=M
    M=D

    @curPixelWord       // move to next pixel word
    M=M+1

    D=M                 // check if done
    @8192               // 256 rows x 32 words (containing 16 pixels)
    D=A-D
    @NEXT_PIXEL
    D;JGT

    @CHECK_FOR_INPUT
    0;JMP