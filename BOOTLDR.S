.segment "ZP"
BUTTONS = $00FF

.segment "BOOTLDR"
.include "HAL.INC"

Start:
    LDA #$05
    CLC
    ROL A
    STA VIA_PORTB
Stop:
    JMP Stop
    