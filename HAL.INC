.ifndef __HAL_INC__
.define __HAL_INC__

; RAM locations:
RAM_START       = $0200

; Cartridge Slot Variables:
CART_ADDR_START = $4000

; VIA Chip Registers:
VIA_PORTB       = $C000
VIA_PORTA       = $C001
VIA_DDRB        = $C002
VIA_DDRA        = $C003
VIA_T1CL        = $C004
VIA_T1CH        = $C005
VIA_T1LL        = $C006
VIA_T1LH        = $C007
VIA_T2CL        = $C008
VIA_T2CH        = $C009
VIA_SR          = $C00A
VIA_ACR         = $C00B
VIA_PCR         = $C00C
VIA_IFR         = $C00D
VIA_IER         = $C00E
VIA_IORA_NH     = $C00F

.endif
