; RESET.S65: Contains pre-POST reset vector.
;==============================
; Code Segment
;==============================
.setcpu "65C02"

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

    LDA #$00
    LDX #$00
ClearZeroPage:
    STZ $00, X
    INX
    BNE ClearZeroPage

    CLC
    CLI
    JMP Boot

;==============================
; Vectors
;==============================
.segment "VECTORS"
.org $5FFC              ; Reset vector location
.word 0                 ; NMI
.word Reset             ; Address of the reset vector (where execution begins)
.word 0                 ; IRQ/BRK
