
vblank:: ;00:030E
    di
    push af
    push bc
    push de
    push hl
; enable sprite display
    ld a, [rLCDC]  ;lcd control
    or a, LCDCF_OBJON
    ld [rLCDC], a ; lcd control
; call DMA
    ld a, [wCurrentOAMBufferFlag]
    add a, HIGH(wOAMBufferC9)
    ld [OAMDMATransfer+1], a ; set OAM source
    call OAMDMATransfer ; hiRam routine
    ld a, [rVBK]  ;vram bank select
    push af
    xor a
    ld [rVBK], a ;vram bank select
    ld a, [wHDMAFlag]
    or a
    jr z, .hdmaFinished

; set HMDA values to transfer sprite tiles data from tiles buffer to vram tiles data
    ld hl, wSpriteTilesBuffer
    ld a, h
    ld [rHDMA1], a ;hdma source high
    ld a, l
    and a, %11111000
    ld [rHDMA2], a ;hdma source low
    xor a ; set dest at the start of hdma dest address ($0 == $8000)
    ld [rHDMA3], a ;hdma dest high
    ld [rHDMA4], a ;hdma dest low
; start hdma
; set general purpose mode
; set a transfer length of $640 bytes ($640 / $10 - 1 = $63)
    ld a, HDMA_GP_MODE | $63
    ld [rHDMA5], a ; hdma length-mode-start
    xor a
    ld [wHDMAFlag], a ; disable HMDA

.hdmaFinished
; continue vblank
    pop af
    and a, 1
    ld [rVBK], a ;vram bank select
    ld a, [wScreenYPos]
    ld [rSCY], a ; scroll screen Y
    ld a, [wCurrentRomBank]
    push af
    ld a, $01
    call bankSwitch
    call ReadJoypad
    xor a
    ld [wHaltCPUFlag], a ; disable halt CPU flag
    ld a, BANK(updateMusicAndSfxCaller)
    call bankSwitch
    call updateMusicAndSfxCaller
    pop af
    call bankSwitch
; increase game framerate counter
    ld hl, wFrameRateCounter
    inc [hl]
; increse sprites animation frame counter
    ld hl, wAnimatedRoomSpritesFrameCounter
    inc [hl]
    ld a, [wButtonPressId]
; check soft reset
    and a, AB_INPUT | START_SEL_INPUT
    cp a, AB_INPUT | START_SEL_INPUT
    jp z, softReset
; update LYC
    ld a, [wScreenYPos]
    ld c, a
    ld a, %01111111
    sub a, c
    ld [rLYC], a ;LY compare
    ld a, STATF_LYC
    ld [rSTAT], a ;lcd status
    pop hl
    pop de
    pop bc
    pop af
    reti
