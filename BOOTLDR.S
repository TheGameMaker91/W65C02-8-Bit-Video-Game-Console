.segment "ZP"
ButtonState: .res 1

.segment "BOOTLDR"
.include "HAL.INC"

Start:
    LDA #%11111111
    STA VIA_DDRA

    CLC
    BCS Test1
    JMP Test2
Hlt:
    JMP Hlt
Test1:
    LDA #%11000011
    STA VIA_IORA

    JMP Hlt
Test2:
    LDA #%11011011
    STA VIA_IORA

    JMP Hlt
