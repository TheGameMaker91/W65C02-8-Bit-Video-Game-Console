.segment "BOOTLDR"
.include "HAL.INC"

Start:
    LDA #$FF
    STA VIA_DDRA

    LDA #$AA
    STA VIA_IORA
Hlt:
    JMP Hlt
