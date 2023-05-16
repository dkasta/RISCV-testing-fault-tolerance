.section .text
	.global _sbst_rf_2
	.type _sbst_rf_2, @function

_sbst_rf_2:

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

	// store the signature, cumulating it with previous sbst_rf_i
	la		x1,	rf_signature
	lw		x3, 0(x1)
	add		x3, x3, x2
	sw		x3,	0(x1)

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
