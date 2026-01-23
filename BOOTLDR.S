.segment "BOOTLDR"
.include "HAL.INC"

Start:
    LDA #%11001100
    PHA

    LDA #%11111111
    STA VIA_DDRA

    PLA
    STA VIA_IORA
Hlt:
    JMP Hlt
