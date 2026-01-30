.segment "BOOTLDR"
.include "HAL.INC"

; Begin official execution of the bootloader code:
Start:
    LDA #$FF
    STA VIA_PORTA 
Hlt:
    JMP Hlt
