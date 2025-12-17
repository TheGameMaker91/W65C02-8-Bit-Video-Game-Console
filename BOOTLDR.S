.org $6000
.segment "BIOS_CODE"
.include "HAL.INC"

.global Boot
Boot:
    LDX #$02
Start:
    LDA $6500, X
    CMP #$0B
    BEQ Halt
    INX
    JMP Start
Halt:
    JMP Halt
