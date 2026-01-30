.segment "ZP"
BUTTONS = $00FF

.segment "BOOTLDR"
.include "HAL.INC"

; Begin official execution of the bootloader code:
Init:
    LDA #%00000011
    STA VIA_DDRB
    LDA #%11111111
    STA VIA_DDRA
    LDA #%00000001
    STA VIA_PORTB
ReadSwitches:
    LDA #%00000010
    STA VIA_PORTB
    NOP
    LDA #%00000001
    STA VIA_PORTB

    LDX #8
    LDA #$00
    STA BUTTONS
ReadLoop:
    LDA VIA_PORTB
    AND #%00000100
    BEQ BitLow
    SEC
    BCS Shift
BitLow:
    CLC
Shift:
    LDA #%00000011
    STA VIA_PORTB
    NOP
    LDA #%00000001
    STA VIA_PORTB

    DEX
    BNE ReadLoop

    LDA BUTTONS
    EOR #$FF
    STA VIA_PORTA
    
    JMP ReadSwitches
