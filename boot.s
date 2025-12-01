.segment "VECTORS"
.org $FFFA              ; Reset vector location
.word reset             ; Address of the reset vector (where execution begins)

.segment "CODE"
.org $8000              ; Set program start location

reset:
        SEI             ; Set Interrupt Disable flag (disable interrupts)
        CLD             ; Clear Decimal Mode flag (set to binary mode)
        LDX #$FF        ; Load the value $FF into the X register
        TXS             ; Transfer the value of X register to the stack pointer (set stack pointer to $FF)
