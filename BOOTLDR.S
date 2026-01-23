.segment "BOOTLDR"
.include "HAL.INC"

Start:
    LDA #$FF
    STA VIA_DDRA

    CLC
    LDA #$55
    ADC #$55
    STA VIA_IORA
Hlt:
    JMP Hlt
