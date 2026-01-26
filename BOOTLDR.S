.segment "BOOTLDR"
.include "HAL.INC"

; Begin official execution of the bootloader code:
Start:
    LDA #$AA
    STA $1401

    LDA #$FF
    STA VIA_DDRA

    LDA $1401
    STA VIA_PORTA
End:
    JMP End
