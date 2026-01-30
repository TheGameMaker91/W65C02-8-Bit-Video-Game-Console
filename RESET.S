; This file is the literal entry point of the system. This is where the code execution will begin
; after the POR circuit does its thing. The system is powered on, the 12V adapter is brought down 
; to 5V through the L7805, then it goes to a 555 timer that is setup in Monostable mode with a
; debounce function. This way, when the system is powered on, the CPU reset line is held low for a
; minimum of 2 clock cycles (see the W65C02SXP datasheet for more info). From there, the CPU begins 
; execution at the Reset_Vector ($FFFC-$FFFD). That reset vector tells the CPU where to begin system
; execution (see CONSOLE.S). In our case, the code is set to jump to $FF7A, which gives us exactly 
; 128 bytes because we don't overwrite the vectors. So we have from $FF7A-$FFFA. We clear zero page,
; clear the RAM, and jump to the firmware once we're all setup. The BIOS_DATA segment just holds 
; strings and constants.

; Initialize zero page variables here:
.segment "ZP"
ptr             = $00

;==================================
; Code Segment & Reset Vector
;==================================
.segment "BIOS_CODE"
.global ClearZP
.global ClearRAM
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