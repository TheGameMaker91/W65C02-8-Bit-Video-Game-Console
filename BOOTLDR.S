.segment "BOOTLDR"
.include "HAL.INC"

Start:
    LDA #$FF
    STA $0200

    LDA #$AA
    STA $0201

    LDA $0200
    STA VIA_DDRA

    LDA $0201
    STA VIA_IORA
Hlt:
    JMP Hlt
