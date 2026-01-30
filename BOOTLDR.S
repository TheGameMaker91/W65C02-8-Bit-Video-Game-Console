.segment "BOOTLDR"
.include "HAL.INC"

; Begin official execution of the bootloader code:
Start:
    LDA #%00000011
    STA VIA_DDRA

    LDA #$01
    STA VIA_PORTA

    LDA #%01000000
    STA VIA_ACR

    LDA #$00
    STA VIA_T1CL
    LDA #$FF
    STA VIA_T1CH

    LDX #$20
Blink:
WaitT1:
    LDA VIA_IFR
    AND #%01000000
    BEQ WaitT1

    LDA VIA_T1CL

    DEX
    BNE Blink

    LDA VIA_PORTA
    EOR #%00000011
    STA VIA_PORTA

    LDX #$20
    JMP Blink
