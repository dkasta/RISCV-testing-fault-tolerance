.section .text
	.global _sbst_alu_10
	.type _sbst_alu_10, @function

_sbst_alu_10:

	// Save the return address
	la		t0,	save_ra_alu
	sw		ra, 0(t0)

	li		x10, 0 // use x10 to accumulate the signature
	la		x2, ALU_PATTERNS
	addi	x11, x2, 20 // x11 contains the final address of section ALU_PATTERNS + 4 (npatterns*4 + 4, where the +4 for allows to loop on the last element!)
outer_loop:
	lw		x3, 0(x2) // first element, x2 is index i
	add 	x4, x0, x2 // copy current x2 in x4, x4 is index j	
inner_loop:	
	lw		x5, 0(x4) // second element
	pv.max.h	x6, x3, x5
	p.slet 	x7, x3, x5
	p.sletu	x8, x3, x5
	p.minu	x9, x3, x5
	p.maxu	x12, x3, x5
	p.mac	x13, x3, x5
	p.msu	x1, x3, x5
	add		x10, x10, x6
	add		x10, x10, x7
	add		x10, x10, x8
	add		x10, x10, x9
	add		x10, x10, x12
	add		x10, x10, x13
	add		x10, x10, x1
	addi	x4, x4, 4
	bne		x4, x11, inner_loop
	seqz	x14, x3
	snez	x15, x3
	sltz	x16, x3
	sgtz	x17, x3
	slti	x18, x3, 18
	sltiu	x19, x3, 19
	ori		x20, x3, 20
	xori	x21, x3, 21
	slli	x22, x3, 22
	srli	x23, x3, 23
	srai	x24, x3, 24
	lui		x25, 25
	auipc	x26, 26
	mv		x27, x3
	neg		x28, x3
	c.li	x29, 29
	c.lui	x30, 30
	p.cnt	x31, x3
	add		x10, x10, x14
	add		x10, x10, x15
	add		x10, x10, x16
	add		x10, x10, x17
	add		x10, x10, x18
	add		x10, x10, x19
	add		x10, x10, x20
	add		x10, x10, x21
	add		x10, x10, x22
	add		x10, x10, x23
	add		x10, x10, x24
	add		x10, x10, x25
	add		x10, x10, x26
	add		x10, x10, x27
	add		x10, x10, x28
	add		x10, x10, x29
	add		x10, x10, x30
	add		x10, x10, x31
	addi	x2, x2, 4
	bne		x2, x11, outer_loop // Check so that it stops looping once all patterns have been tested.

	// store the signature
	la		x1,	alu_signature
	lw		x2, 0(x1)
	add		x10, x10, x2
	sw		x10, 0(x1)

// Restore the return address
	la		t0, save_ra_alu
	lw		ra, 0(t0)
	ret

	// -------------------------------------
	.section ".TEST_RODATA", "a"

ALU_PATTERNS:
	.long 0xeca704be
	.long 0x75401bed
	.long 0x53550e2e
	.long 0x500b5a13

// ---------------------------------

	.section ".TEST_DATA", "aw"

save_ra_alu:
	.space 4
