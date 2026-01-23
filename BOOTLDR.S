.segment "BOOTLDR"
.include "HAL.INC"

Start:
    JSR InitMemory

    LDA #$FF
    JSR StoreInMemory

    LDA #$AA
    JSR StoreInMemory

    LDX #$00
    JSR RetrieveMemory
    STA VIA_DDRA

    LDX #$01
    JSR RetrieveMemory
    STA VIA_IORA
Hlt:
    JMP Hlt
    
InitMemory:
    LDX #$00
    RTS
StoreInMemory:
    STA $0200, X
    INX
    RTS
RetrieveMemory:
    LDA $0200, X
    RTS
