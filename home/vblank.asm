
Vblank:: ;00:030E
    di
    push af
    push bc
    push de
    push hl
    ld a, [rLCDC]  ;lcd control
    or a, $02
    ld [rLCDC], a ;lcd control
    ld a, [wOAMDMAretOpcode]
    add a, $C9
    ld [$FF81], a
    call OAMDMATransfer ;Warning - RAM-only procedure
    ld a, [vramBank]  ;vram bank select
    push af
    xor a
    ld [vramBank], a ;vram bank select
    ld a, [wHDMAtrigger]
    or a
    jr z, .skipHDMA

;set HMDA souce, dest and count
    ld hl, wSpriteTilesBuffer ;$CB00
    ld a, h
    ld [$FF51], a ;hdma source high
    ld a, l
    and a, $F8
    ld [$FF52], a ;hdma source low
    xor a
    ld [$FF53], a ;hdma dest high
    ld [$FF54], a ;hdma dest low
    ld a, $63
    ld [$FF55], a ;hdma count
    xor a
    ld [wHDMAtrigger], a ;disable HMDA

.skipHDMA
    pop af
    and a, $01
    ld [vramBank], a ;vram bank select
    ld a, [wScreenYPos]
    ld [rSCY], a ;scroll screen Y
    ld a, [wCurrentRomBank]
    push af
    ld a, $01
    call BankSwitch
    call ReadJoypad
    xor a
    ld [wc103], a
    ld a, BANK(updateMusic) ;$06
    call BankSwitch
    call updateMusic
    pop af
    call BankSwitch
    ld hl, wFrameRate
    inc [hl]
    ld hl, wAnimatedRoomSpritesFrameRate ;c1b0
    inc [hl]
    ld a, [wButtonPressId]
    and a, AB_INPUT | START_SEL_INPUT ;$0F
    cp a, AB_INPUT | START_SEL_INPUT ;$0F
    jp z, SoftReset ;391
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
