.segment "BOOTLDR"
.include "HAL.INC"

SN76489_DATA    = $A000

Boot:
    LDA #$FF
    LDA VIA_DDRA

    LDA #$FF
    LDA VIA_IORA
Hlt:
    JMP Hlt

