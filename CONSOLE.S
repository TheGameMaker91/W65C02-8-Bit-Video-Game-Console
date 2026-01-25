.segment "BIOS_CODE"
; Load the bootloader. It is here that all of the console firmware will be written. Then the bootloader comes at the end.
.global LoadBootloader
LoadBootloader:
    TYA                 ; Transfer Y into A
    STA BootLdr         ; Store #$7A into the lower byte
    TXA                 ; Transfer X into A
    STA BootLdr+1       ; Store #$FF into the higher byte
    
    JMP (BootLdr)       ; Begin bootloader execution at $FF7A.

;==============================
; Zero Page Segment
;==============================
.segment "ZP"
BootLdr:        .res 2
