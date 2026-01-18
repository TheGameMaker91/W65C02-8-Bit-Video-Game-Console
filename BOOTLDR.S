.segment "BOOTLDR"
.include "HAL.INC"

Boot:
    LDA #%10000000
    STA VIA_DDRB
Loop:
    LDA VIA_IORB
    AND #%00000001
    ASL A
    STA VIA_IORB
    JMP Loop
