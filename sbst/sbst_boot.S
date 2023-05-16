	.section .text
	.global _sbst_boot
	.type _sbst_boot, @function

_sbst_boot:

	lui	a0, %hi(__TEST_DATA_START)
	addi	a0, a0, %lo(__TEST_DATA_START)
	
	// Preserve all non-volatile registers (use section .TEST_DATA)
	la		t0, save_status
	sw		x1,	0*4(t0)
	sw		x2,	1*4(t0)
	sw		x3,	2*4(t0)
	sw		x4,	3*4(t0)
	sw		x8,	4*4(t0)
	sw		x9,	5*4(t0)
	sw		x10,	6*4(t0)
	sw		x11,	7*4(t0)
	sw		x12,	8*4(t0)
	sw		x13,	9*4(t0)
	sw		x14,	10*4(t0)
	sw		x15,	11*4(t0)
	sw		x16,	12*4(t0)
	sw		x17,	13*4(t0)
	sw		x18,	14*4(t0)
	sw		x19,	15*4(t0)
	sw		x20,	16*4(t0)
	sw		x21,	17*4(t0)
	sw		x22,	18*4(t0)
	sw		x23,	19*4(t0)
	sw		x24,	20*4(t0)
	sw		x25,	21*4(t0)
	sw		x26,	22*4(t0)
	sw		x27,	23*4(t0)

	// Disable interrupts (if they were enabled)
	// 1. Load the value of MSTATUS in t1
	csrrs		t1, mstatus, x0
	// 2. if bit3 of MSTATUS is 1, interrupts are on, so disable them
	// Masking with this and allows to set all bits to 0 except the one we want
	// to preserve, the interrupt handling enable
	andi		t0, t1, 0x00000008
	// save_interrupt contains the value of the interrupt bit
	la		t2,	save_interrupt
	// Save the info so we can use it to restore the interrupt if it was enabled
	sw		t0,	0(t2)
	csrrc		t1, mstatus, t0

//////////////////////////////////////////////////////////////

test_rf:
	la t0, ENABLE_FLAGS
	lw t1, 0(t0)
	andi t2, t1, 0x00000001
	beqz t2, test_mult
	call _sbst_rf_1
	call _sbst_rf_2
	call _sbst_rf_3
	call _sbst_rf_4
	call _sbst_rf_5
	call _sbst_rf_6
	call _sbst_rf_7
	call _sbst_rf_8
	// Check value of the signature
	la t0, GOLDEN_SIGNATURES
	la t1, rf_signature
	lw t2, 0*4(t0)
	lw t3, 0(t1)
	sub t4, t3, t2
	bnez t4, restore_status
	
test_mult:
	la t0, ENABLE_FLAGS
	lw t1, 0(t0)
	andi t2, t1, 0x00000002
	beqz t2, test_div
	call _sbst_mult_1
	call _sbst_mult_2
	call _sbst_mult_3
	call _sbst_mult_4
	// Check value of the signature
	la t0, GOLDEN_SIGNATURES
	la t1, mult_signature
	lw t2, 1*4(t0)
	lw t3, 0(t1)
	sub t4, t3, t2
	bnez t4, restore_status

test_div:
	la t0, ENABLE_FLAGS
	lw t1, 0(t0)
	andi t2, t1, 0x00000004
	beqz t2, test_alu
	call _sbst_div_1
	call _sbst_div_2
	// Check value of the signature
	la t0, GOLDEN_SIGNATURES
	la t1, div_signature
	lw t2, 2*4(t0)
	lw t3, 0(t1)
	sub t4, t3, t2
	bnez t4, restore_status

test_alu:
	la t0, ENABLE_FLAGS
	lw t1, 0(t0)
	andi t2, t1, 0x00000008
	beqz t2, restore_status
	call _sbst_alu_1
	call _sbst_alu_2
	call _sbst_alu_3
	call _sbst_alu_4
	call _sbst_alu_5
	call _sbst_alu_6
	call _sbst_alu_7
	call _sbst_alu_8
	call _sbst_alu_9
	call _sbst_alu_10
	call _sbst_alu_11
	call _sbst_alu_12
	call _sbst_alu_13
	call _sbst_alu_14
	call _sbst_alu_15
	call _sbst_alu_16
	// Check value of the signature
	la t0, GOLDEN_SIGNATURES
	la t1, alu_signature
	lw t2, 3*4(t0)
	lw t3, 0(t1)
	sub t4, t3, t2
	bnez t4, restore_status

	li t4, 0 // If all tests are successful, place 0 in t4

restore_status:
	// Restore non-volatile registers
	la		t0, save_status
	lw		x1,	0*4(t0)
	lw		x2,	1*4(t0)
	lw		x3,	2*4(t0)
	lw		x4,	3*4(t0)
	lw		x8,	4*4(t0)
	lw		x9,	5*4(t0)
	lw		x10,	6*4(t0)
	lw		x11,	7*4(t0)
	lw		x12,	8*4(t0)
	lw		x13,	9*4(t0)
	lw		x14,	10*4(t0)
	lw		x15,	11*4(t0)
	lw		x16,	12*4(t0)
	lw		x17,	13*4(t0)
	lw		x18,	14*4(t0)
	lw		x19,	15*4(t0)
	lw		x20,	16*4(t0)
	lw		x21,	17*4(t0)
	lw		x22,	18*4(t0)
	lw		x23,	19*4(t0)
	lw		x24,	20*4(t0)
	lw		x25,	21*4(t0)
	lw		x26,	22*4(t0)
	lw		x27,	23*4(t0)

	// Restore interrupts (if they were active before!)
	la		t2,	save_interrupt
	// Load back the info about the interrupt bit, so now it will be set again IF
	// it was set at the start
	lw		t0,	0(t2)
	csrrs		t1, mstatus, t0
	//
	ret

// -------------------------------------
	.section ".TEST_DATA", "aw"
	.global rf_signature
	.global mult_signature
	.global div_signature
	.global alu_signature

save_interrupt:
	.space 4
save_status:
	.space 96
rf_signature:
	.space 4
mult_signature:
	.space 4
div_signature:
	.space 4
alu_signature:
	.space 4

	.section ".TEST_RODATA", "a"

// bit 0 is the enable for RF, bit 1 is the enable for MULT,
// bit 2 is the enable for DIV, bit 3 is the enable for ALU.
ENABLE_FLAGS:
	.long 0x00000008
GOLDEN_SIGNATURES:
	.long 0x63067011 // RF golden signature
	.long 0x2E5E58DB // MULT golden signature
	.long 0x492DA3ED // DIV golden signature
	.long 0x3C2C5A05 // ALU golden signature

