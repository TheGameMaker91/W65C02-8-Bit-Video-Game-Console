.segment "BOOTLDR"
.include "HAL.INC"

Boot:
    LDA #%10000000
    STA VIA_DDRB
MirrorLoop:
    LDA VIA_IORB
    AND #%00000001
    ASL A
    STA VIA_IORB
    JMP MirrorLoop
