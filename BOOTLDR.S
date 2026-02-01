.segment "ZP"
BUTTONS = $00FF

.segment "BOOTLDR"
.include "HAL.INC"

Start:
    LDA #%00000010
    STA VIA_PORTB
    LDA #%00000011
    STA VIA_PORTB

    LDX #$08
    LDA #$00
ReadLoop:
    PHA
    LDA VIA_PORTB
    AND #%00000100
    BEQ BitLow
    SEC
    BCS Shift
BitLow:
    CLC
Shift:
    PLA
    ROR A

    PHA
    LDA #%00000001
    STA VIA_PORTB
    LDA #%00000011
    STA VIA_PORTB
    PLA

    DEX
    BNE ReadLoop

    EOR #$FF
    STA VIA_PORTA
    JMP Start
