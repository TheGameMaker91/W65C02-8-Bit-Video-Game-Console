; RESET.S65: Contains pre-POST reset vector.
;==============================
; Zero Page Segment
;==============================
.segment "ZP"
zp_val:         .res 1
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

    LDX #$00
ClearZP:
    LDA #$00
    STA ZP_START, X
    INX
    CPX ZP_END+1
    BNE ClearZP

    ;JMP Boot
TestVIA:
    LDA #$FF
    STA VIA_DDRB

    LDA #$CC
    STA zp_val

    LDA zp_val
    STA VIA_IORB
Hlt:
    JMP Hlt

;==================================
; NMI and IRQ Vector Intialization
;==================================
NMI_Vector:
    RTI
IRQ_Vector:
    RTI

.segment "BIOS_DATA"
MemoryMapping:
@Loop:
    JMP @Loop

;==================================
; Vectors
;==================================
.segment "VECTORS"
.word NMI_Vector        ; Address of the NMI Vector (where non masking interrupts happen;   $FFFA-$FFFB)
.word Reset_Vector      ; Address of the reset vector (where execution begins;              $FFFC-$FFFD)
.word IRQ_Vector        ; Address of the IRQ Vector (where interrupt request begins;        $FFFE-$FFFF)
