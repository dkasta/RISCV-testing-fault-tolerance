.section .text
	.global _sbst_rf_7
	.type _sbst_rf_7, @function

_sbst_rf_7:

	// Save the return address
	la		t0,	save_ra
	sw		ra, 0(t0)

// First half of the registers
	la		x16,	RF_PATTERNS
	lb		x1,	0*4(x16)
	lbu		x2,	1*4(x16)
	lh		x3,	2*4(x16)
	lhu		x4,	3*4(x16)
	lb		x5,	4*4(x16)
	lbu		x6,	5*4(x16)
	lh		x7,	6*4(x16)
	lhu		x8,	7*4(x16)
	lb		x9,	8*4(x16)
	lbu		x10,	9*4(x16)
	lh		x11,	10*4(x16)
	lhu		x12,	11*4(x16)
	lb		x13,	12*4(x16)
	lbu		x14,	13*4(x16)
	lh		x15,	14*4(x16)
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
	lhu		x16,	15*4(x1)
	lb		x17,	16*4(x1)
	lbu		x18,	17*4(x1)
	lh		x19,	18*4(x1)
	lhu		x20,	19*4(x1)
	lb		x21,	20*4(x1)
	lbu		x22,	21*4(x1)
	lh		x23,	22*4(x1)
	lhu		x24,	23*4(x1)
	lb		x25,	24*4(x1)
	lbu		x26,	25*4(x1)
	lh		x27,	26*4(x1)
	lhu		x28,	27*4(x1)
	lb		x29,	28*4(x1)
	lbu		x30,	29*4(x1)
	lh		x31,	30*4(x1)
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

    .long 0x56
    .long 0x454
    .long 0x87974555
    .long 0x948
    .long 0x64562755
    .long 0x776
    .long 0x41651715
    .long 0x156
    .long 0x97846728
    .long 0x7280
    .long 0x47672679
    .long 0x772a
    .long 0x177676b4
    .long 0x716a
    .long 0x7864276a
    .long 0x000aaa0a
    .long 0x6252647a
    .long 0xcba5
    .long 0x54a41461
    .long 0x168b
    .long 0x76571bbb
    .long 0x4457
    .long 0xdd7176dd
    .long 0xe5ee
    .long 0xfff7175f
    .long 0x4168
    .long 0x7681716f
    .long 0x778e
    .long 0xbbb77878
    .long 0x71dd
    .long 0xccc65471

// ---------------------------------

	.section ".TEST_DATA", "aw"

save_ra:
	.space 4
