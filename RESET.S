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

Start:
    LDA #$FF
    STA VIA_DDRB

    LDA #$00
    STA VIA_IORB
BlinkLoop:
    LDA #<COUNT
    STA VIA_T1CL
    LDA #>COUNT
    STA VIA_T1CH
WaitT1:
    LDA VIA_IFR
    AND #%00000001
    BEQ WaitT1

    LDA #%00000001
    STA VIA_IFR

    LDA VIA_IORB
    EOR #$01
    STA VIA_IORB

    JMP BlinkLoop

;==================================
; NMI and IRQ Vector Intialization
;==================================
NMI_Vector:
    RTI
IRQ_Vector:
    RTI

.segment "BIOS_DATA"
COUNT = $FFFF

;==================================
; Vectors
;==================================
.segment "VECTORS"
.word NMI_Vector        ; Address of the NMI Vector (where non masking interrupts happen;   $FFFA-$FFFB)
.word Reset_Vector      ; Address of the reset vector (where execution begins;              $FFFC-$FFFD)
.word IRQ_Vector        ; Address of the IRQ Vector (where interrupt request begins;        $FFFE-$FFFF)
