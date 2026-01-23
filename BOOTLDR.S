.segment "BOOTLDR"
.include "HAL.INC"

.global Boot
Boot:
    LDA #$FF
    STA VIA_DDRA

    CLC
    LDA #$7F
    ADC #$7F
    STA VIA_IORA
Hlt:
    JMP Hlt
