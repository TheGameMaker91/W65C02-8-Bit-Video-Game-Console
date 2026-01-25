.segment "BOOTLDR"
.include "HAL.INC"

reset:
    LDA #$FF         ; Set all pins on Port B to output
    STA VIA_DDRA

    ; Set initial starting state: 0b01111010 ($7A)
    ; Bit 6 is High (1), so the Inverse Bit 4 must be Low (0)
    LDA #%01101010   ; Bit 4 is now 0 (Inverse of Bit 6 being 1)
    STA VIA_PORTA

main_loop:
    ; 1. Delay so you can actually see the transition
    JSR delay_sub

    ; 2. Toggle the Master Blinker (Bit 6)
    LDA VIA_PORTA
    EOR #%01000000   ; Toggle Bit 6
    STA VIA_PORTA

    ; 3. Logical Check: Make Bit 4 the inverse of Bit 6
    AND #%01000000   ; Isolate Bit 6 to check its new state
    BEQ set_bit_4    ; If Bit 6 is now 0, go set Bit 4 to 1
    
    ; If Bit 6 is 1, we must clear Bit 4 to 0
    LDA VIA_PORTA
    AND #%11101111   ; Force Bit 4 to 0
    STA VIA_PORTA
    JMP main_loop

set_bit_4:
    LDA VIA_PORTA
    ORA #%00010000   ; Force Bit 4 to 1
    STA VIA_PORTA
    JMP main_loop

; --- Delay Subroutine ---
delay_sub:
    LDX #$FF
outer:
    LDY #$FF
inner:
    DEY
    BNE inner
    DEX
    BNE outer
    RTS

