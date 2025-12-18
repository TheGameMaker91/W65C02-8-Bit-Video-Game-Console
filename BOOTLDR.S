.org $4000
.segment "BIOS_CODE"
.include "HAL.INC"

.global Boot
Boot:
Hlt:
    JMP Hlt
