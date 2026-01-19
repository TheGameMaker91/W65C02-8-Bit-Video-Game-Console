.segment "BOOTLDR"
.include "HAL.INC"

SN76489_DATA    = $A000

Boot:
    LDA #$90
    STA SN76489_DATA

    LDA #$10
    STA SN76489_DATA

    JMP Boot
    