.segment "BOOTLDR"
.include "HAL.INC"

Start:
    JSR InitRAM
    
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

InitRAM:
    LDX #$00
    RTS
