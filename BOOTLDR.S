.segment "BOOTLDR"
.include "HAL.INC"

Boot:
    LDA #%10000000
    STA VIA_DDRB
MirrorLoop:
    LDA VIA_IORB
    AND #%00000001
    CMP #$01
    BEQ SetPB7
    LDA #%00000000
    STA VIA_IORB
    JMP MirrorLoop
SetPB7:
    LDA #%10000000
    STA VIA_IORB
    JMP MirrorLoop
    