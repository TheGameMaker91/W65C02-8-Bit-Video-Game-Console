.segment "ZP"
BUTTONS = $00FF

.segment "BOOTLDR"
.include "HAL.INC"

Start:
    LDX #%01100110
    ROR
    STX VIA_DDRA

Halt:
    JMP Halt
