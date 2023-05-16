.section .text
	.global _sbst_mult_3
	.type _sbst_mult_3, @function

_sbst_mult_3:

	// Save the return address
	la		t0,	save_ra_mult
	sw		ra, 0(t0)

	li		x10, 0 // use x10 to accumulate the signature
	la		x2, MUL_PATTERNS
	addi	x11, x2, 20 // x11 contains the final address of section MUL_PATTERNS + 4 (npatterns*4 + 4, where the +4 for allows to loop on the last element!)
outer_loop:
	lw		x3, 0(x2) // first element of MULT, x2 is index i
	add 	x4, x0, x2 // copy current x2 in x4, x4 is index j
inner_loop:	
	lw		x5, 0(x4) // second element of mult
	mul		x6, x3, x5
	mulh	x7, x3, x5
	mulhu	x8, x3, x5
	mulhsu	x9, x3, x5
	pv.dotsp.h x12, x3, x5
	pv.dotsp.b x13, x3, x5
	pv.dotup.h	x14, x3, x5
	pv.dotup.b	x15, x3, x5
	pv.dotusp.h	x16, x3, x5
	pv.dotusp.b	x17, x3, x5
	add		x10, x10, x6
	add		x10, x10, x7
	add		x10, x10, x8
	add		x10, x10, x9
	add		x10, x10, x12
	add		x10, x10, x13
	add		x10, x10, x14
	add		x10, x10, x15
	add		x10, x10, x16
	add		x10, x10, x17
	addi	x4, x4, 4
	bne		x4, x11, inner_loop
	addi	x2, x2, 4
	bne		x2, x11, outer_loop // Check so that it stops looping once all patterns have been tested.

	// store the signature
	la		x1,	mult_signature
	lw		x2, 0(x1)
	add		x10, x10, x2
	sw		x10, 0(x1)

// Restore the return address
	la		t0, save_ra_mult
	lw		ra, 0(t0)
	ret

	// -------------------------------------
	.section ".TEST_RODATA", "a"

MUL_PATTERNS:
	.long 0x0f0f0f0f
	.long 0xf0f0f0f0
	.long 0x10101010
	.long 0xcd4f563e

// ---------------------------------

	.section ".TEST_DATA", "aw"

save_ra_mult:
	.space 4
