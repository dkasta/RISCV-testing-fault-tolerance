.section .text
	.global _sbst_rf_1
	.type _sbst_rf_1, @function

_sbst_rf_1:

	// Save the return address
	la		t0,	save_ra
	sw		ra, 0(t0)

// First half of the registers
	la		x16,	RF_PATTERNS
	lw		x1,	0*4(x16)
	lw		x2,	1*4(x16)
	lw		x3,	2*4(x16)
	lw		x4,	3*4(x16)
	lw		x5,	4*4(x16)
	lw		x6,	5*4(x16)
	lw		x7,	6*4(x16)
	lw		x8,	7*4(x16)
	lw		x9,	8*4(x16)
	lw		x10,	9*4(x16)
	lw		x11,	10*4(x16)
	lw		x12,	11*4(x16)
	lw		x13,	12*4(x16)
	lw		x14,	13*4(x16)
	lw		x15,	14*4(x16)
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
	la		x1,	RF_PATTERNS
	lw		x16,	15*4(x1)
	lw		x17,	16*4(x1)
	lw		x18,	17*4(x1)
	lw		x19,	18*4(x1)
	lw		x20,	19*4(x1)
	lw		x21,	20*4(x1)
	lw		x22,	21*4(x1)
	lw		x23,	22*4(x1)
	lw		x24,	23*4(x1)
	lw		x25,	24*4(x1)
	lw		x26,	25*4(x1)
	lw		x27,	26*4(x1)
	lw		x28,	27*4(x1)
	lw		x29,	28*4(x1)
	lw		x30,	29*4(x1)
	lw		x31,	30*4(x1)
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

	// store the signature 
	la		x1,	rf_signature
	sw		x2,	0(x1)

	// Restore the return address
	la		t0, save_ra
	lw		ra, 0(t0)
	ret

// -------------------------------------
	.section ".TEST_RODATA", "a"

RF_PATTERNS:
	.long 0x12345678
	.long 0xcafecafe
	.long 0xdeadbeef
	.long 0xab45cdd6
	.long 0x12436709
	.long 0xabababab
	.long 0xffffffff
	.long 0x00010001
	.long 0x0f0f0f0f
	.long 0xf0f0f0f0
	.long 0x10101010
	.long 0xcd4f563e
	.long 0xeca704be
	.long 0x75401bed
	.long 0x53550e2e
	.long 0x500b5a13
	.long 0xca00fdfd
	.long 0xba55acc0
	.long 0x87654321
	.long 0x97182818
	.long 0x91929394
	.long 0x12bdf583
	.long 0xbeefdead
	.long 0xefacefac
	.long 0xfaceface
	.long 0xbeadfeef
	.long 0xb4dd97a3
	.long 0xcbd104ea
	.long 0xa6b3210e
	.long 0x76543210
	.long 0x11111111

// ---------------------------------

	.section ".TEST_DATA", "aw"

save_ra:
	.space 4
