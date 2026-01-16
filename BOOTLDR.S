.org $F000

.include "HAL.INC"

.segment "ZP"
StackL:         .res 1
StackH:         .res 1
SP_Temp:        .res 1
LoopCounter:    .res 1
TempA:          .res 8
TempB:          .res 8
IndexX:         .res 1
IntexY:         .res 1
HeaderInfo:     .res 8

GameFlags:      .res 16
InputFlags:     .res 1
InterruptFlags: .res 1

RAMAddrL:       .res 1
RAMAddrH:       .res 1
ROMAddr:        .res 2

VDGState:       .res 1
SoundState:     .res 1

.segment "BOOTLDR"
TEST_PATTERN    = $AA

.global Boot
Boot:
    LDA $4000
    CMP #$3F
    BNE NoCart

    LDX #$00
@ReadHeader:
    LDA $4000, X
    STA HeaderInfo, X
    INX
    CPX #$08
    BNE @ReadHeader

    JSR PrintTestPatternVIA

    LDA HeaderInfo+6
    STA ROMAddr
    LDA HeaderInfo+7
    STA ROMAddr+1

    JMP (ROMAddr)
NoCart:
Hlt:
    JMP Hlt

PrintTestPatternVIA:
    LDA #$FF
    STA VIA_DDRA

    LDA TEST_PATTERN
    STA VIA_IORA

    RTS
