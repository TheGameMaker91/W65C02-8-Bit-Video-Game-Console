.org $F000

.include "HAL.INC"

.segment "ZP"

.segment "BOOTLDR"
TEST_PATTERN    = $AA

.global Boot
Boot:
    LDA #%00000001
    STA VIA_DDRB
@Loop:
    LDA VIA_IORB
    AND #%00000001
    ASL A
    STA VIA_IORB
    JMP @Loop
