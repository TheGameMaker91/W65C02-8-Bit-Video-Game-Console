.segment "BOOTLDR"
.include "HAL.INC"

SN76489_DATA    = $A000

Boot:
<<<<<<< HEAD
    LDA #$FF
    LDA VIA_DDRA

    LDA #$FF
    LDA VIA_IORA
Hlt:
    JMP Hlt
=======
    LDA #$90
    STA SN76489_DATA

    LDA #$10
    STA SN76489_DATA

    JMP Boot
    
>>>>>>> e371a7716ecd0b776a3d11426f05b55e3856ca75
