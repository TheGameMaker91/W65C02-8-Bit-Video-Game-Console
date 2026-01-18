.segment "BOOTLDR"
.include "HAL.INC"

Boot:
    LDA #%10000000
    STA VIA_DDRB
MirrorLoop:
    LDA VIA_IORB
    AND #%00000001
    ORA #%10000000
    STA VIA_IORB
    JMP MirrorLoop
