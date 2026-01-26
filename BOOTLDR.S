.segment "BOOTLDR"
.include "HAL.INC"

; Begin official execution of the bootloader code:
Start:
    LDA #%00000001
    STA VIA_DDRA

    LDA #$00
    STA VIA_PORTA

    LDA #%01000000
    STA VIA_ACR

    LDA #<$FFFF
    STA VIA_T1CL
    LDA #>$FFFF
    STA VIA_T1CH
Blink:
    LDA VIA_IFR
    AND #%01000000
    BEQ Blink

    LDA VIA_PORTA
    EOR #%00000001
    STA VIA_PORTA

    LDA VIA_T1CL
    JMP Blink
