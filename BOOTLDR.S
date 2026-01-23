.segment "ZP"
ButtonState: .res 1

.segment "BOOTLDR"
.include "HAL.INC"

Start:
    LDA #%11111111
    STA VIA_DDRA

    LDA #%01010101
    BIT #$20
    BEQ NoMatch
    JMP Match
Hlt:
    JMP Hlt
Match:
    LDA #%11000011
    STA VIA_IORA

    JMP Hlt
NoMatch:
    LDA #%11011011
    STA VIA_IORA

    JMP Hlt
