.segment "BOOTLDR"
.include "HAL.INC"

; Begin official execution of the bootloader code:
Bootldr:
    TXA
    LDX #$FF
    STA VIA_DDRA

    TAX
    STA VIA_IORA
Hlt:
    JMP Hlt
    