.section .text
	.global _sbst_alu_4
	.type _sbst_alu_4, @function

_sbst_alu_4:

	// Save the return address
	la		t0,	save_ra_alu
	sw		ra, 0(t0)

	li		x10, 0 // use x10 to accumulate the signature
	la		x2, ALU_PATTERNS
	addi	x11, x2, 16 // x11 contains the final address of section ALU_PATTERNS + 4 (npatterns*4 + 4, where the +4 for allows to loop on the last element!)
outer_loop:
	lw		x3, 0(x2) // first element, x2 is index i
	add 	x4, x0, x2 // copy current x2 in x4, x4 is index j	
inner_loop:	
	lw		x5, 0(x4) // second element
	slt		x6, x3, x5
	sltu 	x7, x3, x5
	sgt		x8, x3, x5
	sgtu	x9, x3, x5
	and		x12, x3, x5
	or		x13, x3, x5
	xor		x1, x3, x5
	sll		x14, x3, x5
	srl		x15, x3, x5
	sub		x16, x3, x5
	sra		x17, x3, x5
	div		x18, x3, x5
	divu	x19, x3, x5
	rem		x20, x3, x5
	remu	x21, x3, x5
	p.min	x25, x3, x5
	p.max	x26, x3, x5
	p.ror	x27, x3, x5	
	pv.add.h x28, x3, x5
	pv.add.b x29, x3, x5
	pv.avg.h x30, x3, x5
	pv.avg.b x31, x3, x5
	add		x10, x10, x6
	add		x10, x10, x7
	add		x10, x10, x8
	add		x10, x10, x9
	add		x10, x10, x12
	add		x10, x10, x13
	add		x10, x10, x1
	add		x10, x10, x14
	add		x10, x10, x15
	add		x10, x10, x16
	add		x10, x10, x17
	add		x10, x10, x18
	add		x10, x10, x19
	add		x10, x10, x20
	add		x10, x10, x21
	add		x10, x10, x25
	add		x10, x10, x26
	add		x10, x10, x27
	add		x10, x10, x28
	add		x10, x10, x29
	add		x10, x10, x30
	add		x10, x10, x31
	addi	x4, x4, 4
	bne		x4, x11, inner_loop	
	c.add	x22, x3
	andi	x23, x3, 23
	p.abs	x24, x3
	add		x10, x10, x22
	add		x10, x10, x23
	add		x10, x10, x24
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
	.long 0xf0f0f0f0
	.long 0x10101010
	.long 0xcd4f563e

// ---------------------------------

	.section ".TEST_DATA", "aw"

save_ra_alu:
	.space 4
