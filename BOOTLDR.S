.segment "BOOTLDR"
.include "HAL.INC"

Boot:
    LDA #$FF
    STA VIA_DDRB
Loop:
    LDA #%10101010
    STA VIA_IORB
    JSR LongDelay

    LDA #%01010101
    STA VIA_IORB
    JSR LongDelay

    JMP Loop
LongDelay:
    LDX #$08
@Outer:
    JSR Delay
    DEX
    BNE @Outer
    RTS

Delay:
    LDY #$FF
D1: LDX #$FF
D2: DEX
    BNE D2
    DEY
    BNE D1
    RTS
