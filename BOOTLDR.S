.segment "ZP"
ButtonState: .res 1

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
