.section .text
	.global _sbst_rf_5
	.type _sbst_rf_5, @function

_sbst_rf_5:

	// Save the return address
	la		t0,	save_ra
	sw		ra, 0(t0)

// First half of the registers
	la		x16,	RF_PATTERNS
	p.lb		x1,	4(x16!)
	p.lbu		x2,	4(x16!)
	p.lh		x3, 4(x16!)
	p.lhu		x4,	4(x16!)
	p.lw		x5,	4(x16!)
	p.lb		x6,	4(x16!)
	p.lbu		x7,	4(x16!)
	p.lh		x8,	4(x16!)
	p.lhu		x9,	4(x16!)
	p.lw		x10,	4(x16!)
	p.lb		x11,	4(x16!)
	p.lbu		x12,	4(x16!)
	p.lh		x13,	4(x16!)
	p.lhu		x14,	4(x16!)
	p.lw		x15,	4(x16!)
	add	x17, x0, x16
	// Compute first part of the signature
	li		x16,	0
	add		x16, x16, x1
	add		x16, x16, x2
	add		x16, x16, x3
	add		x16, x16, x4
	add		x16, x16, x5
	add		x16, x16, x6
	add		x16, x16, x7
	add		x16, x16, x8
	add		x16, x16, x9
	add		x16, x16, x10
	add		x16, x16, x11
	add		x16, x16, x12
	add		x16, x16, x13
	add		x16, x16, x14
	add		x16, x16, x15
	// Move signature to x2
	add		x2, x0, x16
	// Load second half of the registers
	add		x1, x0, x17
	p.lb		x16,	4(x1!)
	p.lbu		x17,	4(x1!)
	p.lh		x18,	4(x1!)
	p.lhu		x19,	4(x1!)
	p.lw		x20,	4(x1!)
	p.lb		x21,	4(x1!)
	p.lbu		x22,	4(x1!)
	p.lh		x23,	4(x1!)
	p.lhu		x24,	4(x1!)
	p.lw		x25,	4(x1!)
	p.lb		x26,	4(x1!)
	p.lbu		x27,	4(x1!)
	p.lh		x28,	4(x1!)
	p.lhu		x29,	4(x1!)
	p.lw		x30,	4(x1!)
	p.lb		x31,	4(x1!)
	// compute second part of the signature
	add		x2, x2, x16
	add		x2, x2, x17
	add		x2, x2, x18
	add		x2, x2, x19
	add		x2, x2, x20
	add		x2, x2, x21
	add		x2, x2, x22
	add		x2, x2, x23
	add		x2, x2, x24
	add		x2, x2, x25
	add		x2, x2, x26
	add		x2, x2, x27
	add		x2, x2, x28
	add		x2, x2, x29
	add		x2, x2, x30
	add		x2, x2, x31

	// store the signature, cumulating it with previous sbst_rf_i
	la		x1,	rf_signature
	p.lw		x3, 0(x1!)
	add		x3, x3, x2
	p.sw		x3,	0(x1!)

	// Restore the return address
	la		t0, save_ra
	lw		ra, 0(t0)
	ret

// -------------------------------------
	.section ".TEST_RODATA", "a"

RF_PATTERNS:
	.long 0x21212121
	.long 0x30303030
	.long 0x49944994
	.long 0xccabccab
	.long 0xdadbdcdd
	.long 0xdfdffdfd
	.long 0x67896789
	.long 0x03304565
	.long 0x07780687
	.long 0xd0d0d0d0
	.long 0x0d0d0d0d
	.long 0xcfcffcd1
	.long 0xfc123fc1
	.long 0x56723460
	.long 0x497868aa
	.long 0xbbaabbaf
	.long 0xcdcdabc1
	.long 0xdcd56739
	.long 0xff00ff12
	.long 0xf123f123
	.long 0xeeefffee
	.long 0x36897dab
	.long 0xdacdabba
	.long 0xdcacdefa
	.long 0x123cdada
	.long 0x5649cdaf
	.long 0xffaa0011
	.long 0xddeabc32
	.long 0x459cf341
	.long 0xfffffaff
	.long 0x111cdcd4

// ---------------------------------

	.section ".TEST_DATA", "aw"

save_ra:
	.space 4
