; RESET.S65: Contains pre-POST reset vector.
;==============================
; Zero Page Segment
;==============================
.segment "ZP"
BootLdr:        .res 2

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

; == BEGIN VRAM CLEAR ==;
    LDA #$00
    LDX #$14
ClearPage:
    LDY #$00
ClearByte:
    STA $0000, X
    INY
    BNE ClearByte
    INX
    CPX #$20
    BNE ClearPage

    LDX #$FF            ; #%11111111 - The known state of the Y register on startup. Used for glue logic.
    LDY #$7A            ; #%01111010 - The known state of the X register on startup. Used for glue logic.

    ; Load the bootloader. It is here that all of the console firmware will be written. Then the bootloader comes at the end.
LoadBootloader:
    TYA                 ; Transfer Y into A
    STA BootLdr         ; Store #$7A into the lower byte
    TXA                 ; Transfer X into A
    STA BootLdr+1       ; Store #$FF into the higher byte
    
    JMP (BootLdr)       ; Begin bootloader execution at $FF7A.

;==================================
; NMI and IRQ Vector Intialization
;==================================
NMI_Vector:
    RTI
IRQ_Vector:
    RTI

.segment "BIOS_DATA"
; Here, we shall initialize all constants and error, warnng, and info messages
InfoStartup:        .byte $01, "[INFO]: Startup successful $", 0, 0
InfoCartFound:      .byte $01, "[INFO]: Cartridge loaded successfully at $4000 $", 0, 0
WarnNoController:   .byte $02, "[WARN]: No controller in port 1 $", 0, 0
ErrRAM:             .byte $03, "[ERR]: Could not initialize RAM $", 0, 0
ErrVIA:             .byte $03, "[ERR]: Could not intialize VIA $", 0, 0

;==================================
; Vectors
;==================================
.segment "VECTORS"
.word NMI_Vector        ; Address of the NMI Vector (where non masking interrupts happen;   $FFFA-$FFFB)
.word Reset_Vector      ; Address of the reset vector (where execution begins;              $FFFC-$FFFD)
.word IRQ_Vector        ; Address of the IRQ Vector (where interrupt request begins;        $FFFE-$FFFF)