; RESET.S65: Contains pre-POST reset vector.
;==============================
; Code Segment
;==============================
.setcpu "65C02"

.segment "BIOS_CODE"
.org $E000

; Import the global symbol "POST_Init":
;.import Boot

;==============================
; Reset Routine
;==============================
Reset:
    ;SEI                 ; Disable interrupts
    ;CLD                 ; Clear decimal mode
    ;LDX #$FF
    ;TXS                 ; Initialize stack

    LDA #$AA
    LDX #$00
Loop:
    TAX
    INX
    JMP Loop

;==============================
; Vectors
;==============================
.segment "VECTORS"
.org $FFFA              ; Reset vector location
.word 0                 ; NMI
.word Reset             ; Address of the reset vector (where execution begins)
.word 0                 ; IRQ/BRK
