.section .text
	.global _sbst_div_2
	.type _sbst_div_2, @function

_sbst_div_2:

	// Save the return address
	la		t0,	save_ra_div
	sw		ra, 0(t0)

	li		x10, 0 // use x10 to accumulate the signature
	la		x2, DIV_PATTERNS
	addi	x11, x2, 20 // x11 contains the final address of section DIV_PATTERNS + 4 (npatterns*4 + 4, where the +4 for allows to loop on the last element!)
outer_loop:
	lw		x3, 0(x2) // first element of MULT, x2 is index i
	add 	x4, x0, x2 // copy current x2 in x4, x4 is index j
inner_loop:	
	lw		x5, 0(x4) // second element of mult
	div		x6, x3, x5
	rem	    x7, x3, x5
	divu	x8, x3, x5
	remu	x9, x3, x5
	add		x10, x10, x6
	add		x10, x10, x7
	add		x10, x10, x8
	add		x10, x10, x9
	addi	x4, x4, 4
	bne		x4, x11, inner_loop
	addi	x2, x2, 4
	bne		x2, x11, outer_loop // Check so that it stops looping once all patterns have been tested.

	// store the signature
	la		x1,	div_signature
	lw		x2, 0(x1)
	add		x10, x10, x2
	sw		x10, 0(x1)

// Restore the return address
	la		t0, save_ra_div
	lw		ra, 0(t0)
	ret

	// -------------------------------------
	.section ".TEST_RODATA", "a"

DIV_PATTERNS:
	.long 0x12436709
	.long 0xabababab
	.long 0xffffffff
	.long 0x00010001

// ---------------------------------

	.section ".TEST_DATA", "aw"

save_ra_div:
	.space 4
