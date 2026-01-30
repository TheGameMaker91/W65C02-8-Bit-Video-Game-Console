.segment "BOOTLDR"
.include "HAL.INC"

; Begin official execution of the bootloader code:
Start:
    LDA $0200
    STA VIA_PORTA
Hlt:
    JMP Hlt
