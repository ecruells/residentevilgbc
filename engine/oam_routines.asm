; swap the current OAM Buffer flag
; 0: $C900
; 1: $CA00
swapCurrentOAMBuffer:: ;01:4457
    ld a, [wCurrentOAMBufferFlag]
    xor a, 1
    ld [wCurrentOAMBufferFlag], a
    ret

; copy the content of the OAM buffer from $C900 to $CA00
copyOAMBufferC9toCA:: ;01:4460
	ld hl, wOAMBufferC9
	ld de, wOAMBufferCA
	ld b, 160 ; bytes
.copyLoop
	ld a, [hli]
	ld [de], a
	inc e
	dec b
	jr nz, .copyLoop
	ret

; copy the OAM DMA transfer routine to hram
initOAMDMARoutine:: ;01:446F
    ld hl, OamDmaTransferRoutine
    ld de, OAMDMATransfer
    ld b, 10 ; bytes
.copyloop
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .copyloop
    ret

; OAM DMA transfer routine to be copied into HiRam
; source OAM buffer could be $C9 or $CA, depending of the current OAM buffer flag
OamDmaTransferRoutine: ;01:447E
	ld a, $C9
	ld [rDMA], a
	ld a, $2C
.dmaTransferLoop
	dec a
	jr nz, .dmaTransferLoop
	ret

; hide sprites by setting Y position to -64
hideSprites:: ;01:4488
    call swapCurrentOAMBuffer
    call hideOAM
    call swapCurrentOAMBuffer
    jp hideOAM

hideOAM:: ;01:4494
    ld hl, wOAMBufferC9 ;$C900
    call getOamBufferAddress
    ld de, $4
    ld b, $28 ; delay
    ld a, $C0
.loop44A1
    ld [hl], a
    add hl, de
    dec b
    jr nz, .loop44A1
    ret
    