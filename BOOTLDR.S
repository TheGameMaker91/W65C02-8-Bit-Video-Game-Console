.segment "ZP"
ButtonState: .res 1

.segment "BOOTLDR"
.include "HAL.INC"

Start:
    LDA #$FF
    STA $0200

    LDA #$AA
    STA $0201

    LDX #$00
    LDA RAM_START, X
    STA VIA_DDRA

    LDX #$01
    LDA RAM_START, X
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
