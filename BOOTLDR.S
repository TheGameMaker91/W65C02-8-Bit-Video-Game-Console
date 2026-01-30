.segment "BOOTLDR"
.include "HAL.INC"

; Begin official execution of the bootloader code:
Start:
    PLA
    STA VIA_PORTA
Hlt:
    JMP Hlt
