.segment "BOOTLDR"
.include "HAL.INC"

Pattern:    .byte $AA

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
    LDA Pattern
    ASL
    STA Pattern
    STA VIA_IORB
    JMP Bootcode
ButtonPressed:
    LDA #$AA
    STA Pattern
    STA VIA_IORB
    JMP Bootcode
Hlt:
    JMP Hlt
