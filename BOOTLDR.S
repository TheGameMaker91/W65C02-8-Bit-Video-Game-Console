.segment "BOOTLDR"
.include "HAL.INC"

Start:
    LDX #$FF
    STA VIA_DDRA

    LDX #$AA
    STA VIA_IORA
Hlt:
    JMP Hlt
