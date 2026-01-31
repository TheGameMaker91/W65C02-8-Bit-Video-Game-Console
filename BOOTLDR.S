.segment "ZP"
BUTTONS = $00FF

.segment "BOOTLDR"
.include "HAL.INC"

Start:
    LDA #$05
    STA VIA_PORTA
Stop:
    JMP Stop
