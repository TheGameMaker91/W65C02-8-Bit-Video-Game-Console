.org $4000
.segment "BOOTLOADER"
.include "HAL.INC"

.global Boot
Boot:
Hlt:
    JMP Hlt
