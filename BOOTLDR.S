.segment "BOOTLDR"
.include "HAL.INC"

; Begin official execution of the bootloader code:
Bootldr:
    TYA
    LDY #$FF
    STA VIA_DDRA

    TAY
    STA VIA_IORA
Hlt:
    JMP Hlt
    