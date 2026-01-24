.segment "BOOTLDR"
.include "HAL.INC"

; Begin official execution of the bootloader code:
Bootldr:
    TYA
    LDY #$FF
    STY VIA_DDRA

    TAY
    STY VIA_IORA
Hlt:
    JMP Hlt
    