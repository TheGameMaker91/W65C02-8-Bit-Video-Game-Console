.segment "BOOTLDR"
.include "HAL.INC"

; Begin official execution of the bootloader code:
Start:
    LDA #$FF
    STA VIA_DDRA

    LDA #$7A
    STA VIA_PORTA
BlinkerLoop:
    EOR #%01000000
    STA VIA_PORTA
    EOR #%00010000
    STA VIA_PORTA

    LDX #$FF
DelayOuter:
    LDY #$FF
DelayInner:
    DEY
    BNE DelayInner
    DEX
    BNE DelayOuter
    JMP BlinkerLoop
