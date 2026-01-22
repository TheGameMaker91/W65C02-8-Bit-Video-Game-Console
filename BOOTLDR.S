.segment "BOOTLDR"
.include "HAL.INC"

.global Boot
Boot:
    LDA #$FF
    LDA VIA_DDRA

    LDA #$FF
    LDA VIA_IORA
Hlt:
    JMP Hlt
