.segment "BOOTLDR"
.include "HAL.INC"

Bootcode:
    LDA #$7F
    STA VIA_DDRA
    LDA #$F0
    STA VIA_DDRB

    LDA VIA_IORA
    AND #%10000000
    BEQ ButtonReleased
    JMP ButtonPressed
ButtonReleased:
    LDA #$AA
    ASL
    STA VIA_IORB
    JMP Bootcode
ButtonPressed:
    LDA #$AA
    STA VIA_IORB
    JMP Bootcode
Hlt:
    JMP Hlt
