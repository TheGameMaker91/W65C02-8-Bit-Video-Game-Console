.segment "BOOTLDR"
.include "HAL.INC"

Start:
    LDX #$00

    LDA #$FF
    STA RAM_START, X
    INX

    LDA #$AA
    STA RAM_START, X
    INX

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
    STA RAM_START, X
    INX
    RTS
RetrieveMemory:
    LDA RAM_START, X
    RTS
