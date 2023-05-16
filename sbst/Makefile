PROGRAM_NAME = sbst

RISCV                    ?= ~/.riscv
RISCV_EXE_PREFIX         = $(RISCV)/bin/riscv32-unknown-elf-

all: $(PROGRAM_NAME).hex

$(PROGRAM_NAME).elf: crt0.S main.c test_fail.c syscalls.c vectors.S sbst_boot.S sbst_rf_1.S sbst_rf_2.S sbst_rf_3.S sbst_rf_4.S sbst_rf_5.S sbst_rf_6.S sbst_rf_7.S sbst_rf_8.S sbst_mult_1.S sbst_mult_2.S sbst_mult_3.S sbst_mult_4.S sbst_div_1.S sbst_div_2.S sbst_alu_1.S sbst_alu_2.S sbst_alu_3.S sbst_alu_4.S sbst_alu_5.S sbst_alu_6.S sbst_alu_7.S sbst_alu_8.S sbst_alu_9.S sbst_alu_10.S sbst_alu_11.S sbst_alu_12.S sbst_alu_13.S sbst_alu_14.S sbst_alu_15.S sbst_alu_16.S march_algorithm.S
	$(RISCV_EXE_PREFIX)gcc -march=rv32imcxpulpv2 -o $@ -w -Os -g -nostdlib \
		-Xlinker -Map=$(PROGRAM_NAME).map \
		-T link.ld \
		-static \
		$^  \
		-I $(RISCV)/riscv32-unknown-elf/include \
		-L $(RISCV)/riscv32-unknown-elf/lib \
		-lc -lm -lgcc

%.hex: %.elf
	$(RISCV_EXE_PREFIX)objcopy -O verilog $< $@
	sed -i 's/@0020/@001C/; s/@0021/@001D/; s/@0022/@001E/; s/@0023/@001F/' $@


clean:
	rm -rf $(PROGRAM_NAME).elf $(PROGRAM_NAME).hex $(PROGRAM_NAME).map


