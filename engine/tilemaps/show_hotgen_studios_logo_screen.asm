; unused splash screen of HotGen Studios logo, developer of this (unreleased) port
loadHotGenStudiosLogoScreen: ;462B
    call hideSprites
    ld hl, hotgenLogoTilemapStruct
    ld a, 20 ; tiles width
    call loadTileMapImage
    ld a, SET_FADE_IN
    ld [wPaletteFadeCounter], a
    ld a, $80
    ld [wBgTransitionDirCounter], a
.logoFadeOutLoop
    call haltCPU
    ld a, [wPaletteFadeCounter]
    cp a, FADE_OUT_FINISHED
    ret z
    ld a, [wBgTransitionDirCounter]
    dec a
    ld [wBgTransitionDirCounter], a
    jr nz, .Label4657
    ld a, SET_FADE_OUT
    ld [wPaletteFadeCounter], a
.Label4657
    ld hl, hotgenLogoTilemapStruct+8
    call loadBgImagePalette
    jr .logoFadeOutLoop
;465F