.ifndef __HAL_INC__
.define __HAL_INC__

; These are the standard addresses on the proprietary "GPU" pins:
GPU_CTRL        = $6000
GPU_DATA        = $6001
GPU_STATUS      = $6002
GPU_PALETTE     = $6010

; Sound Chip Registers:
SND_ADDR_PORT   = $7000
SND_DATA_PORT   = $7001

; VIA Chip Registers:
VIA_ORB         = $8000
VIA_ORA         = $8001
VIA_DDRB        = $8002
VIA_DDRA        = $8003
VIA_T1CL        = $8004
VIA_T1CH        = $8005
VIA_T1LL        = $8006
VIA_T1LH        = $8007
VIA_T2CL        = $8008
VIA_T2CH        = $8009
VIA_SR          = $800A
VIA_ACR         = $800B
VIA_PCR         = $800C
VIA_IFR         = $800D
VIA_IER         = $800E
VIA_ORA_NH      = $800F

.endif
