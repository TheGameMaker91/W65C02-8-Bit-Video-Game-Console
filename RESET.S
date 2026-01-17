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

    LDX #$00
ClearZP:
    LDA #$00
    STA ZP_START, X
    INX
    CPX ZP_END+1
    BNE ClearZP

    ;JMP Boot

LDA #$FF
STA VIA_DDRB

LDX #$00
ClearPage:
    LDA #$AA
    STA $0100, X
    LDA $0100, X
    CMP #$AA
    BNE RamFail

    INX
    BNE ClearPage
RamPass:
    LDA #$FF
    STA VIA_IORB
    JMP RamPass
RamFail:
    LDA #$F0
    STA VIA_IORB
    JMP RamFail
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
