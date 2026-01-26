.segment "BOOTLDR"
.include "HAL.INC"

; Begin official execution of the bootloader code:
Start:
    LDA #$FF
    STA VIA_DDRA

    LDA #$AA
    STA VIA_PORTA
End:
    JMP End
