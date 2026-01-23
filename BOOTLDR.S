.segment "BOOTLDR"
.include "HAL.INC"

.global Boot
Boot:
    LDA #$FF
    STA VIA_DDRA

    CLC
    LDA #$4C
    ADC #$4C
    STA VIA_IORA
Hlt:
    JMP Hlt
