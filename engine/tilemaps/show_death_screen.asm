showDeathScreen: ;01:4538
    call resetPalettes
    call hideSprites
    ld a, SET_FADE_IN
    ld [wPaletteFadeCounter], a
    ld hl, deathScreenTilemapStruct
    ld a, 32 ; tiles width (wider for both death screens)
    call loadTileMapImage
    ld a, [wEntityId]
    cp a, CHRIS
    jr z, deathScreenLoop ; jump if chris
;else, update character tiles with jill's
.updateJillsTiles
    ld hl, _SCRN0+$B4
    ld de, _SCRN0+$106
    ldbc 5, 7
.updateTileHorizontally
    push bc
    push de
    push hl
.updateTileVertically
    call vblankWait
    ld a, [hl]
    ld [de], a
    ld a, $01
    ld [rVBK], a ;vram bank select
    ld a, [hli]
    ld [de], a
    inc e
    xor a
    ld [rVBK], a ;vram bank select
    dec c
    jr nz, .updateTileVertically
    pop hl
    ld de, $20
    add hl, de
    pop de
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop bc
    dec b
    jr nz, .updateTileHorizontally
deathScreenLoop:
    call haltCPU
    ld a, [wPaletteFadeCounter]
    cp a, FADE_OUT_FINISHED
    ret z
    ld a, [wButtonPressId]
    and a, A_START_INPUT
    jr z, .Label45A1
    ld a, [wPaletteFadeCounter]
    or a
    jr z, .Label459C
    cp a, SET_FADE_OUT
    jr nc, .Label45A1
.Label459C
    ld a, SET_FADE_OUT
    ld [wPaletteFadeCounter], a
.Label45A1
    ld hl, deathScreenTilemapStruct+8
    call loadBgImagePalette
    jr deathScreenLoop
;45A9