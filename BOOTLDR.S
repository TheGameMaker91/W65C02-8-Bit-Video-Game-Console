.segment "BOOTLDR"
.include "HAL.INC"

Start:
    LDX #$00
    LDA #$FF
    STA $0200, X
    INX

    LDA #$AA
    STA $0200, X
    INX

    LDA $0200
    STA VIA_DDRA

    LDA $0201
    STA VIA_IORA
Hlt:
    JMP Hlt
