.segment "BOOTLDR"
.include "HAL.INC"

; Begin official execution of the bootloader code:
Start:
    LDA #$FC
    STA VIA_PORTA
Hlt:
    JMP Hlt
