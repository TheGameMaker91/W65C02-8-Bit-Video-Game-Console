.segment "BOOTLDR"
.include "HAL.INC"

Boot:
    LDA #$FF
    STA VIA_DDRB
Loop:
    LDA #%11001100
    STA VIA_IORB
    JSR Delay

    LDA #%00110011
    STA VIA_IORB
    JSR Delay

    JMP Loop
Delay:
    LDX #$FF
D1:
    LDY #$FF
D2:
    DEY
    BNE D2
    DEX
    BNE D1
    RTS
