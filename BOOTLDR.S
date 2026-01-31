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
READ_LOOP:
    PHA
    LDA VIA_PORTB
    AND #%00000100
    BEQ BIT_LOW
    SEC
    BCS SHIFT
BIT_LOW:
    CLC
SHIFT:
    PLA
    ROL A

    PHA
    LDA #%00000001
    STA VIA_PORTB
    LDA #%00000011
    STA VIA_PORTB
    PLA

    DEX
    BNE READ_LOOP

    EOR #$FF
    STA VIA_PORTA
    JMP Start
Stop:
    JMP Stop
