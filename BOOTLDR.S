.segment "BOOTLDR"
.include "HAL.INC"

Start:
    LDA #$AA
    PHA
    LDA #$FF
    PHA

    PLA
    STA VIA_DDRB

    PLA
    STA VIA_IORB
Hlt:
    JMP Hlt
