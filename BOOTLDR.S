.segment "BOOTLDR"
.include "HAL.INC"

; Begin official execution of the bootloader code:
Start:
    LDA #%00000001
    STA VIA_DDRA
Loop:
    LDA VIA_IORA
    EOR #%00000001
    STA VIA_IORA

    LDX #$FF

OuterDelay:
    LDY #$FF
InnerDelay:
    DEY
    BNE InnerDelay
    DEX
    BNE OuterDelay

    JMP Loop
    