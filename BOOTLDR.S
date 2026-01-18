.segment "BOOTLDR"
.include "HAL.INC"

Boot:
    LDA #%10000000
    STA VIA_DDRB

    LDA #%10000000
    STA VIA_IORB
Loop:
    LDA VIA_IORB
    AND #%00000000
    BEQ KeepOn
    LDA #%00000001
    STA VIA_IORB
KeepOn:
    JMP Loop
