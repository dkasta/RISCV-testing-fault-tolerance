.section .text
	.global _sbst_rf_8
	.type _sbst_rf_8, @function

_sbst_rf_8:

	// Save the return address
	la		t0,	save_ra
	sw		ra, 0(t0)

// First half of the registers
	la		x16,	RF_PATTERNS
	p.lw		x1,	4(x16!)
	p.lw		x2,	4(x16!)
	p.lw		x3,	4(x16!)
	p.lw		x4,	4(x16!)
	p.lw		x5,	4(x16!)
	p.lw		x6,	4(x16!)
	p.lw		x7,	4(x16!)
	p.lw		x8,	4(x16!)
	p.lw		x9,	4(x16!)
	p.lw		x10,	4(x16!)
	p.lw		x11,	4(x16!)
	p.lw		x12,	4(x16!)
	p.lw		x13,	4(x16!)
	p.lw		x14,	4(x16!)
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
	p.lw		x16,	4(x1!)
	p.lw		x17,	4(x1!)
	p.lw		x18,	4(x1!)
	p.lw		x19,	4(x1!)
	p.lw		x20,	4(x1!)
	p.lw		x21,	4(x1!)
	p.lw		x22,	4(x1!)
	p.lw		x23,	4(x1!)
	p.lw		x24,	4(x1!)
	p.lw		x25,	4(x1!)
	p.lw		x26,	4(x1!)
	p.lw		x27,	4(x1!)
	p.lw		x28,	4(x1!)
	p.lw		x29,	4(x1!)
	p.lw		x30,	4(x1!)
	p.lw		x31,	4(x1!)
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
	.long 0x54562aaa
	.long 0x589babaa
	.long 0xca33fcfc
	.long 0xfafacdde
	.long 0x57309173
	.long 0xddcddccd
	.long 0xfff00012
	.long 0x285012ae
	.long 0xabcdefab
	.long 0xfedcba11
	.long 0x3948005d
	.long 0xdcbf384b
	.long 0x27472901
	.long 0xbaccab99
	.long 0x9d8c1a2b
	.long 0x45287bdf
	.long 0xcb0cb07e
	.long 0xb6593019
	.long 0x283d3817
	.long 0x743dfc41
	.long 0x03cfbfdf
	.long 0x12674950
	.long 0xfbeadbac
	.long 0xed4896bf
	.long 0xfb472ca7
	.long 0xbefedb3a
	.long 0xadd17470
	.long 0x4dacafd8
	.long 0x84398077
	.long 0x54907981
	.long 0x33333333

// ---------------------------------

	.section ".TEST_DATA", "aw"

save_ra:
	.space 4
