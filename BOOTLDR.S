.segment "BOOTLDR"
.include "HAL.INC"
.global Boot

Boot:
    LDA #$FF
    STA VIA_DDRB

    LDA #$FF
    STA VIA_IORB
Hlt:
    JMP Hlt
