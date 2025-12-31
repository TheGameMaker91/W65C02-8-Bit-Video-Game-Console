; RESET.S65: Contains pre-POST reset vector.
;==============================
; Code Segment
;==============================
.setcpu "65C02"

.segment "BIOS_CODE"
.org $E000

; Import the global symbol "POST_Init":
;.import Boot

; VIA Registers
VIA_BASE    = $C000
VIA_ORA     = VIA_BASE
VIA_DDRA    = VIA_BASE + $0
VIA_T1C_L   = VIA_BASE + $4
VIA_T1C_H   = VIA_BASE + $5
VIA_ACR     = VIA_BASE + $B
VIA_PCR     = VIA_BASE + $C

;==============================
; Reset Routine
;==============================
Reset:
    SEI                 ; Disable interrupts
    CLD                 ; Clear decimal mode
    LDX #$FF
    TXS                 ; Initialize stack

Loop:
    ; Turn LED on
    LDA #%00000001
    STA VIA_ORA

    JSR Delay1s

    ; Turn LED off
    LDA #%00000000
    STA VIA_ORA

    JSR Delay1s

    JMP Loop

Delay1s:
    LDX #$FF
OuterLoop:
    LDY #$FF
InnerLoop:
    DEY
    BNE InnerLoop
    DEX
    BNE OuterLoop
    RTS

;==============================
; Vectors
;==============================
.segment "VECTORS"
.org $FFFC              ; Reset vector location
.word Reset             ; Address of the reset vector (where execution begins)
