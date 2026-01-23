.segment "BOOTLDR"
.include "HAL.INC"

Start:
    LDA #$01
    AND #$0F
    TAX
    LDA #$FF
    STA VIA_DDRB

    TXA
    STA VIA_IORB
Hlt:
    JMP Hlt
