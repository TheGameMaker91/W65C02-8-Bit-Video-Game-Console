AS	= ca65
CC	= cc65
LD	= ld65

CONFIG	= SYSTEM.CFG
LDFLAGS	= -C $(CONFIG)
BIN		= SYSTEM.BIN

.PHONY: all
all: POST bin
	@echo Make has built the 6502 binary.

POST: RESET.S POST.S
	$(AS) RESET.S -o reset.o
	$(AS) POST.S -o post.o

bin: $(SYSTEM.CFG) reset.o post.o
	$(LD) $(LDFLAGS) reset.o post.o -o $(BIN)

clean:
	rm -rf *.o *.BIN

hexdump:
	hexdump -C $(BIN)
