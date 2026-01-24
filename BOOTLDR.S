.segment "BOOTLDR"
.include "HAL.INC"

; Begin official execution of the bootloader code:
Bootldr:
    LDA #$FF
    STA VIA_DDRA

    LDA #$AA
    STY VIA_IORA
Hlt:
    JMP Hlt
    