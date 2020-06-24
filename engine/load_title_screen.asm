; load the title screen and start the loop for choose an option, 
; or wait for the rooms bgs demo slides
loadTitleScreen:: ;00:333B
    ld hl, titleScreenTilemapStruct
    ld a, 20 ; tiles width
    call loadTileMapImage
    xor a
    ld [wCursorPosId], a
    call hideSprites
    ld a, SET_FADE_IN
    ld [wPaletteFadeCounter], a
    ld hl, $300 ; 12.8 seconds (255 ticks = 4.25s)
    ld a, l
    ld [wTicksCounter], a
    ld a, h
    ld [wTicksCounterHigh], a
titleScreenLoop:
    call haltCPU
    ld a, [wPaletteFadeCounter]
    or a
    call z, updateTitleScreenCursorOptionsCaller
    ld a, [wPaletteFadeCounter]
    or a
    jr nz, .continueLoop
    ld a, [wTicksCounter]
    dec a
    ld [wTicksCounter], a
    cp a, $FF
    jr nz, .continueLoop
    ld a, [wTicksCounterHigh]
    dec a
    ld [wTicksCounterHigh], a
    cp a, $FF
    jr nz, .continueLoop
    jp showTitleRoomsBgsSlideDemo
.continueLoop
    ld a, [wPaletteFadeCounter]
    cp a, FADE_OUT_FINISHED
    ret z ; option was chosen, return when fade-out has finished
    or a
    jr nz, .Label339D
    ld a, [wButtonPressId]
    and a, START_INPUT
    jr z, .Label339D
 ; option chosen, start fade-out and play firegun sfx
    ld a, SET_FADE_OUT
    ld [wPaletteFadeCounter], a
    ld a, FIREGUN_SFX
    call playSFX
.Label339D
    ld a, [wPaletteFadeCounter]
    push af
    ld hl, titleScreenPaletteStruct
    call loadBgImagePalette
    pop af
    ld c, a
    ld a, [wPaletteFadeCounter]
    or a
    jr nz, titleScreenLoop
    ld a, c
    cp a, $01
    jr nz, titleScreenLoop
.playTitleVoice
    di
    titleVoicePcmPart1
    ld de, $480 ; pcm tempo 
    ld bc, $C30 / 16 ; pcm length
    ld a, BANK(playTitlePCM)
    call bankSwitch
    call playTitlePCM
    ld a, $01
    call bankSwitch
    ld bc, $1388 ; wait delay
    call waitDelay
    titleVoicePcmPart2
    ld de, $480 ; pcm tempo
    ld bc, $CC0 / 16 ; pcm length
    ld a, BANK(playTitlePCM)
    call bankSwitch
    call playTitlePCM
    ld a, $01
    call bankSwitch
    ei
    jp titleScreenLoop
