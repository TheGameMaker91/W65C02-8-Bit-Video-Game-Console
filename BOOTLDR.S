.segment "BOOTLDR"
.include "HAL.INC"

SN76489_DATA    = $A000

Boot:
    LDA #$90
    STA SN76489_DATA
    LDA #$20
    STA SN76489_DATA
    LDA #$00
    STA SN76489_DATA
    LDA #$9F
    STA SN76489_DATA

    LDA #$FF
    STA VIA_DDRB

    LDA #$FF
    STA VIA_IORB
Loop:
    JMP Loop
