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

TEST: 
    .byte   $FF, $33, $AA, $55, $00, $00, $FF, $FF
    .byte   $4C, $32, $23, $23, $AA, $AA, $55, $55
    .byte   $00, $FF, $00, $FF, $CC, $33, $C3, $3C
    .byte   $01, $02, $04, $08, $10, $20, $40, $80

; Initialize the necessary console states:
.global firmware_init
firmware_init:
    LDA #$FF            ; THIS WILL NOT CHANGE UNLESS IT HAS TO!
    STA VIA_DDRA        ; Store $FC in A and write to the VIA!

    ; Now we'll do the rest of the firmware below here:
    LDA #$FF            ; Load $FF into A
    STA $0800           ; Store $FF (0b11111111) in $0800 (0b0000100000000000)  
    LDA #$00            ; Load $00 into A
    STA $0800           ; Store $00 (0b00000000) in $0800 (0b0000100000000000)
    LDA #$FF            ; Now we load $FF into A and
    STA $0801           ; store it in $0801, which will set the last bit (0b0000100000000001) allowing us to use it for EN

MainLoop:
    LDX #00
@NextByte:
    LDA TEST, X
    STA VIA_PORTA

    LDY #8              ; This is effectively the multiplier. Larger values will make the delay longer.

@WaitMulti:
    LDA #$FF
    STA VIA_T1CL
    STA VIA_T1CH

@WaitTimer:
    LDA VIA_IFR
    AND #%01000000
    BEQ @WaitTimer

    LDA VIA_T1CL

    DEY
    BNE @WaitMulti

    INX
    CPX #32
    BNE @NextByte
    JMP MainLoop

; This will be stored in the X and Y registers for the bootloader:
SetupRegisters:
    LDX #$FF            ; #%11111111 - The known state of the Y register on startup. Used for glue logic.
    LDY #$7A            ; #%01111010 - The known state of the X register on startup. Used for glue logic.

; Load the bootloader. It is here that all of the console firmware will be written. Then the bootloader comes at the end.
LoadBootloader:
    TYA                 ; Transfer Y into A
    STA BootLdr         ; Store #$7A into the lower byte
    TXA                 ; Transfer X into A
    STA BootLdr+1       ; Store #$FF into the higher byte

    JMP (BootLdr)       ; Begin bootloader execution at $FF7A.
