.segment "ZP"
BUTTONS = $00FF

.segment "BOOTLDR"
.include "HAL.INC"

; Begin official execution of the bootloader code:
InitVIA:
    LDA #%11111111
    STA VIA_DDRA
    LDA #%00000011
    STA VIA_DDRB
    RTS

ReadButtonsAndLEDs:
    LDA #%00000000
    STA VIA_PORTB
    LDA #%00000001
    STA VIA_PORTB

    LDX #8
    LDA #0
    STA BUTTONS

ReadLoop:
    LDA VIA_PORTB
    AND #%00000100
    ROL BUTTONS

    ; Pulse clock:
    LDA #%00000011
    STA VIA_PORTB
    LDA #%00000001
    STA VIA_PORTB

    DEX
    BNE ReadLoop

    LDA BUTTONS
    EOR #%11111111
    STA VIA_PORTA

    RTS
