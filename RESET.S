; RESET.S65: Contains pre-POST reset vector.
;==============================
; Zero Page Segment
;==============================
.segment "ZP"
BootLdr:        .res 2
ZP_START        = $00
ZP_END          = $FF

;==================================
; Code Segment & Reset Vector
;==================================
.segment "BIOS_CODE"
Reset_Vector:
    SEI                 ; Disable interrupts
    CLD                 ; Clear decimal mode
    LDX #$FF
    TXS                 ; Initialize stack

    LDX #$00
    LDA #$00
ClearZP:
    STA $00, X
    INX
    BNE ClearZP
    
    LDX #$7A            ; #%01111010 - The known state of the X register on startup. Used for glue logic.
    LDY #$FF            ; #%11111111 - The known state of the Y register on startup. Used for glue logic.
LoadBootloader:
    LDX #$00
    STA BootLdr
    LDY #$F0
    STA BootLdr+1
    
    JMP (BootLdr)       ; Begin bootloader execution at this location.
    
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