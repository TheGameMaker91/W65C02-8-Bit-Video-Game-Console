; RESET.S65: Contains pre-POST reset vector.
;==============================
; Zero Page Segment
;==============================
.segment "ZP"
ptr             = $00

;==================================
; Code Segment & Reset Vector
;==================================
.segment "BIOS_CODE"
Reset_Vector:
    SEI                 ; Disable interrupts
    CLD                 ; Clear decimal mode
    LDX #$FF
    TXS                 ; Initialize stack

    NOP
    LDX #$00
ClearZP:
    STA $00, X
    INX
    BNE ClearZP

    ; Begin clear system RAM:
    LDA #$00
    STA ptr
    LDA #$02
    STA ptr+1

    LDY #$00
    ; Clear the RAM where the VDG will read from:
ClearRAM:
    STA (ptr), Y
    INY
    BNE ClearRAM
    INC ptr+1
    LDA ptr+1
    CMP #$20
    BNE ClearRAM

    ; Begin clear VRAM:
    LDA #$00
    STA ptr
    LDA #$14
    STA ptr+1

    LDY #$00
    ; Clear the RAM where the VDG will read from:
ClearVRAM:
    STA (ptr), Y
    INY
    BNE ClearVRAM
    INC ptr+1
    LDA ptr+1
    CMP #$20
    BNE ClearVRAM

    ; Tranafer control to the firmware:
    .import firmware_init
    JMP firmware_init

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