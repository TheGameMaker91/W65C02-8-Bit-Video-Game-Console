; RESET.S65: Contains pre-POST reset vector.
;==============================
; Code Segment
;==============================
.segment "BIOS_CODE"
.org $4000

; Import the global symbol "POST_Init":
.import Boot

;==============================
; Reset Routine
;==============================
Reset:
    SEI                 ; Disable interrupts
    CLD                 ; Clear decimal mode
    LDX #$FF
    TXS                 ; Initialize stack

    JSR Boot

;==============================
; Vectors
;==============================
.segment "VECTORS"
.org $FFFC              ; Reset vector location
.word Reset             ; Address of the reset vector (where execution begins)
.word 0                 ; NMI
.word 0                 ; IRQ/BRK
