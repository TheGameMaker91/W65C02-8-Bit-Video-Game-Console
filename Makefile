AS	= ca65
CC	= cc65
LD	= ld65

CONFIG	= SYSTEM.CFG
LDFLAGS	= -C $(CONFIG)
BIN		= SYSTEM.BIN

.PHONY: all
all: POST bin
	@echo Make has built the 6502 binary.

POST: RESET.S65 POST.S65
	$(AS) RESET.S65 -o reset.o
	$(AS) POST.S65 -o post.o

bin: $(SYSTEM.CFG) reset.o post.o
	$(LD) $(LDFLAGS) reset.o post.o -o $(BIN)

clean:
	rm -rf *.o *.BIN

hexdump:
	hexdump -C $(BIN)