.section .text
	.global _sbst_rf_6
	.type _sbst_rf_6, @function

_sbst_rf_6:

	// Save the return address
	la		t0,	save_ra
	sw		ra, 0(t0)

// First half of the registers
	li		x1,	0x56
	lui		x2,	0x454
	li		x3,	0x87974555
	lui		x4,	0x948
	li		x5,	0x64562755
	lui		x6,	0x776
	li		x7,	0x41651715
	lui		x8,	0x156
	li		x9,	0x97846728
	lui		x10, 0x7280
	li		x11, 0x47672679
	lui		x12, 0x772a
	li		x13, 0x177676b4
	lui		x14, 0x716a
	li		x15, 0x7864276a
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
	lui		x16,	0x000aaa0a
	li		x17,	0x6252647a
	lui		x18,	0xcba5
	li		x19,	0x54a41461
	lui		x20,	0x168b
	li		x21,	0x76571bbb
	lui		x22,	0x4457
	li		x23,	0xdd7176dd
	lui 	x24,	0xe5ee
	li		x25,	0xfff7175f
	lui		x26,	0x4168
	li		x27,	0x7681716f
	lui		x28,	0x778e
	li		x29,	0xbbb77878
	lui		x30,	0x71dd
	li		x31,	0xccc65471
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

// ---------------------------------

	.section ".TEST_DATA", "aw"

save_ra:
	.space 4
