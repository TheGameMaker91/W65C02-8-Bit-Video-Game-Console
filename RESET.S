; RESET.S65: Contains pre-POST reset vector.
;==============================
; Zero Page Segment
;==============================
.segment "ZP"
ZP_START        = $00
ZP_END          = $FF

;==================================
; Code Segment & Reset Vector
;==================================
.segment "BIOS_CODE"
.import Boot

.include "HAL.INC"

Reset_Vector:
    SEI                 ; Disable interrupts
    CLD                 ; Clear decimal mode
    LDX #$FF
    TXS                 ; Initialize stack

    LDA #%10101010
    STA VIA_DDRB
Loop:
    LDA #%10101010
    STA VIA_IORB
    JSR Delay

    LDA #%01010101
    STA VIA_IORB
    JSR Delay

    JMP Loop
Delay:
    LDX #$FF
D1:
    LDY #$FF
D2:
    DEY
    BNE D2
    DEX
    BNE D1
    RTS
    
;==================================
; NMI and IRQ Vector Intialization
;==================================
NMI_Vector:
    RTI
IRQ_Vector:
    RTI

;==================================
; Vectors
;==================================
.segment "VECTORS"
.word NMI_Vector        ; Address of the NMI Vector (where non masking interrupts happen;   $FFFA-$FFFB)
.word Reset_Vector      ; Address of the reset vector (where execution begins;              $FFFC-$FFFD)
.word IRQ_Vector        ; Address of the IRQ Vector (where interrupt request begins;        $FFFE-$FFFF)