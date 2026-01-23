AS	= ca65 --cpu 65C02
CC	= cc65
LD	= ld65

CONFIG	= SYSTEM.CFG
LDFLAGS	= -C $(CONFIG)
BIN		= SYSTEM.BIN

.PHONY: all
all: POST bin
	@echo Make has built the 6502 binary.

POST: RESET.S BOOTLDR.S
	$(AS) RESET.S -o reset.o
	$(AS) BOOTLDR.S -o bootldr.o

bin: $(SYSTEM.CFG) reset.o bootldr.o
	$(LD) $(LDFLAGS) reset.o bootldr.o -o $(BIN)

clean:
	rm -rf *.o *.BIN

hexdump:
	hexdump -C $(BIN)
