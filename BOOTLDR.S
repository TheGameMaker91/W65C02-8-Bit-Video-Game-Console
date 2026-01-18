.segment "BOOTLDR"
.include "HAL.INC"

Boot:
    LDA #$FF
    STA VIA_DDRB
Loop:
    LDA #%10101010
    STA VIA_IORB
    JSR Delay

    LDA #%01010101
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
