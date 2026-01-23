.segment "ZP"
ButtonState: .res 1

.segment "BOOTLDR"
.include "HAL.INC"

Start:
    CLC
    BCC Test
Hlt:
    JMP Hlt
Test:
    LDA #%11111111
    STA VIA_DDRA

    LDA #%11000011
    STA VIA_IORA

    JMP Hlt
    