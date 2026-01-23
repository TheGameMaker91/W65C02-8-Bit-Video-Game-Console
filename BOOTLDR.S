.segment "BOOTLDR"
.include "HAL.INC"

Start:
    LDX #$FF
    STA VIA_DDRA

    LDX #$AA
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
