; RESET.S65: Contains pre-POST reset vector.
;==============================
; Code Segment
;==============================
.setcpu "65C02"

.segment "ZP"
StackL:         .res 1
StackH:         .res 1

ZP_START        = $00
ZP_END          = $FF

;==============================
; Reset Routine
;==============================
.segment "BIOS_CODE"
.import Boot
;.org $E000

Reset:
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

    JMP Boot

.segment "BIOS_DATA"
MemoryMapping:
@Loop:
    JMP @Loop

;==============================
; Vectors
;==============================
.segment "VECTORS"
.word Reset             ; Address of the reset vector (where execution begins)
