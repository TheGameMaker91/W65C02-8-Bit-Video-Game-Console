; Let us begin. The console is going to have many devices connected to it. As such, we'll need to know where everything is.
; The RAM is at $0000. It will be a 2KB RAM Chip (HM6116P-4). The ROM lives at $E000-$FFFF. This is for the reset vector.
; The RAM uses zero page at the top $0000-$00FF, then the stack pointer from $0100-$01FF. $0200-$07FF is the rest of RAM.
; With that out of the way, we have the VIA, which is where our tests have been going thus far. Whatever is stored in the
; A, X, and Y registers can be displayed in binary on the 8 LEDs connected to PORTA or PORTB. The other address spaces will
; be listed below. The address decoder, the 74HC138, has 8 Y outputs:
; - Y0: $0000-$07FF - System RAM ($1800 unused)
; - Y1: $2000-$3FFF - Cartridge RAM (up to 8KB)
; - Y2: $4000-$5FFF - Cartridge ROM 8KB-32KB (with bank switching)
; - Y3: $6000-$7FFF - Cartridge ROM 8KB-32KB (with bank switching)
; - Y4: $8000-$9FFF - !CE for whatever connects to the SN76489AN
; - Y5: $A000-$BFFF - !CE for whatever connects to the MC6847P VDG
; - Y6: $C000-$DFFF - VIA
; - Y7: $E000-$FFFF - System ROM (firmware/BIOS, or this)
; This is based on using A13, A14, and A15 to get full 8KB address spaces. With bank switching, we can use more than would 
; otherwise be usable. This clever trick will have to be used effectively as any mistakes would corrupt the integrity of 
; the cartridge. 

; Initialize zero page variables here:
.segment "ZP"
BootLdr = $02

; We're in the firmware section now:
.segment "FIRMWARE"

; Includes go here:
.include "HAL.INC"

; Initialize the necessary console states:
.global FirmwareInit
FirmwareInit:
    JSR SetupVIA
    JSR SetupFirmware
    JSR SetupRegisters
    JMP LoadBootloader

; Initialize the default state of the VIA regardless of its use:
SetupVIA:
    LDA #$FF
    STA VIA_DDRA
    STA VIA_DDRB

    LDA #%10000001
    STA VIA_PORTA
    STA VIA_PORTB
    RTS

; Intialize the firmare and initial setup:
SetupFirmware:
    LDA #$C0
    STA $0800           ; Store $C0 just outside of the 2KB boundaries where glue logic must be initiailized.
    LDA #$CC
    STA $0801
    LDX $A0
    STX $0802
    CLC
    ROR
    SEC

; This will be stored in the X and Y registers for the bootloader:
SetupRegisters:
    LDX #$FF            ; #%11111111 - The known state of the Y register on startup. Used for glue logic.
    LDY #$7A            ; #%01111010 - The known state of the X register on startup. Used for glue logic.
    RTS

; Load the bootloader. It is here that all of the console firmware will be written. Then the bootloader comes at the end.
LoadBootloader:
    TYA                 ; Transfer Y into A
    STA BootLdr         ; Store #$7A into the lower byte
    TXA                 ; Transfer X into A
    STA BootLdr+1       ; Store #$FF into the higher byte

    JMP (BootLdr)       ; Begin bootloader execution at $FF7A.
