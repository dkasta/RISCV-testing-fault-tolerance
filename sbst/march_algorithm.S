	.section .text
	.global _run_march_algorithm
	.type _run_march_algorithm, @function

_run_march_algorithm:
// TEST_RODATA: Memory region dedicated to patterns
// RAM: Memory to be tested with the march algorithm
// TEST_DATA: Memory region to store the test signature

	// March C Algorithm

	la	 x30, march_test_patterns
next_pattern:
	lw	     x2, 0(x30) // x30 contains the ram offset, starting from 0.
	xori	 x3, x2, -1  // store the corresponding pattern for 1 by inverting

	//la	     x8, __RAM_END
	//addi	 x8, x8, 4 // x8 contains RAM_END + 4, used to finish the march element loops
	la	 	 a0, __RAM_START
	addi	 x8, a0, 404 // To reduce test size/length, let's consider a few addresses
M1:	// w0 in any direction, we chose ascending
	sw	     x2, 0(a0)
	addi	 a0, a0, 4 //  next memory cell
	sub	     x16, x8, a0 // x16 = RAM end - current address
	bnez	 x16, M1 // x16 = 0 we reached the end of the memory (current addr = RAM end)

	la	 	 a0, __RAM_START // reset a0 to start of memory

M2:	// read and check that all cells have zero, then write 1. Ascending order.
	lw 	 	 x4, 0(a0)
	sub	 	 x4, x4, x2 // x4 = read_pattern - expected pattern. If 0, pattern matches
	bnez	 x4, march_error // if I don't read zero, there is an error. March returns 1
	sw	 	 x3, 0(a0) // store the pattern for 1
	
	addi	 a0, a0, 4
	sub 	 x16, x8, a0
	bnez 	 x16, M2

	la	 	 a0, __RAM_START
	
M3:	// read and check that all cells have 1, then write 0. Ascending order
	lw	 	 x4, 0(a0)

	sub	 	 x4, x4, x3 // x4 = read_pattern - expected pattern. If 0, pattern matches
	bnez 	 x4, march_error
	sw 	 	 x2, 0(a0)

	addi	 a0, a0, 4
	sub	 	 x16, x8, a0
	bnez	 x16, M3

	la	 	 a0, __RAM_START // reset a0 to start of memory


M4:	// read and check all cells are zero in any order. Here, ascending.

	lw	 	 x4, 0(a0)
	addi	 a0, a0, 4

	// INSERTING AN ERRONEOUS PATTERN TO GENERATE A MARCH TEST FAIL
	//addi	 x4, x4, 1
	//

	sub	 	 x4, x4, x2
	bnez 	 x4, march_error
	sub 	 x16, x8, a0
	bnez	 x16, M4

	//la	 	 a0, __RAM_END // reset a0 to end of memory, for descending order
	//la	 	 x8, __RAM_START
	//addi	 x8, x8, -4 // set x8 to RAM start -4 to end the march element loop

	// TO REDUCE TEST SIZE: test in descending order from RAM_START+400 downto RAM_START-4
	la		 a0, __RAM_START
	addi	 x8, a0, -4 // RAM_START-4
	addi	 a0, a0, 400 // RAM_START+400
M5:	// r0, w1 in descending order
	lw 	 	 x4, 0(a0)

	sub	 	 x4, x4, x2
	bnez 	 x4, march_error
	sw 	 	 x3, 0(a0)

	addi  	 a0, a0, -4  //descending order, so previous memory cell
	sub	 	 x16, a0, x8
	bnez 	 x16, M5
	
	//la	 	 a0, __RAM_END // reset a0 to end of memory, for descending order

	// TO REDUCE TEST SIZE: test in descending order from RAM_START+400 downto RAM_START-4
	la		 a0, __RAM_START
	addi	 a0, a0, 400 // RAM_START+400	
M6:	// r1, w0 in descending order
	lw	 	 x4, 0(a0)

	sub 	 x4, x4, x3
	bnez 	 x4, march_error
	sw	 	 x2, 0(a0)

	addi  	 a0, a0, -4
	sub	 	 x16, a0, x8
	bnez	 x16, M6

	//la	 	 a0, __RAM_END // reset a0 to end of memory, for descending order

	// TO REDUCE TEST SIZE: test in descending order from RAM_START+400 downto RAM_START-4
	la		 a0, __RAM_START
	addi	 a0, a0, 400 // RAM_START+400
M7:	// r0 in any order. Here, descending.
	lw 	 	 x4, 0(a0)
	addi  	 a0, a0, -4

	sub	 	 x4, x4, x2
	bnez	 x4, march_error
	sub 	 x16, a0, x8
	bnez	 x16, M7

	// Go back to the top, run from the start for the next pattern
	addi 	 x18, x18, 1 // Increase offset by 1 to load next march pattern
	li		 x11, 6
	addi 	 x30, x30, 4 // Prepare index for next march test pattern
	sub	 	 x19, x18, x11 // we loop for i < 6 (there are 6 patterns, i goes from 0 to 5)
	bnez	 x19, next_pattern

march_success:
	li	x31, 0
	ret

march_error:
	li	x31, 1
	ret


// -----------------------

	// Test rodata: to store patterns
	.section ".TEST_RODATA", "a"

// These are all the data background patterns for 0, the ones for 1
// can be obtained by inverting them
march_test_patterns:
	.long 0x00000000
	.long 0x0000ffff
	.long 0x00ff00ff
	.long 0x0f0f0f0f // 0000111100001111...
	.long 0x33333333 // 0011001100110011...
	.long 0x55555555  // 0101010101...

