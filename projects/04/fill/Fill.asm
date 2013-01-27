// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, the
// program clears the screen, i.e. writes "white" in every pixel.

// Put your code here.

    @color				// -1 -> black or 0 -> white
    M=0
    
	@curPixelWord		// runs from SCREEN address to end 
    M=0
	
	@SCREEN
	D=A
	@8192				// 256 rows x 32 words (containing 16 pixels)				
	D=D+A
	@_MAX_PIXEL_WORD	// last pixel word to draw
	M=D

	(CHECK_FOR_INPUT)
    @KBD				// store current key in D
    D=M
    @WHITEN				// key == 0 (no key) -> whiten screen
    D;JEQ

	  //(BLACKEN)
    @color
    M=-1                // -1 -> 111111...1
    @FILL_SCREEN
    0;JMP

		(WHITEN)
    @SCREEN				// don't paint screen if it is white already
    D=M
    @CHECK_FOR_INPUT
    D;JEQ               

    @color				
    M=0					// 0 -> 000000...0

			(FILL_SCREEN)
    @SCREEN				// set screen pointer to screen start
    D=A
	@curPixelWord
    M=D

				(NEXT_PIXEL_WORD)
	@color              // put color in D
    D=M

    @curPixelWord		// put color to current screen word
    A=M
    M=D

    @curPixelWord       // move to next pixel word
    M=M+1

    @_MAX_PIXEL_WORD	// check if done
	D=M
    @curPixelWord               
    D=D-M
    @NEXT_PIXEL_WORD
    D;JGT

    @CHECK_FOR_INPUT
    0;JMP