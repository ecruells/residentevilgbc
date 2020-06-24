loadMainMenuFaceSprite:: ;01:4918
    ldde 104, 16 ; face sprite position (y,x)
    ld hl, wOAMBufferC9
    call getOamBufferAddress
    ld c, 0 ; chris face tile id
    ld a, [wSelectedCharacter]
    or a
    jr z, .loadFaceSprite ; if chris
; if jill
    ld c, 4 ; jill face tile id
.loadFaceSprite
    ld a, c
    ld [wVramTilesCounter], a
    ld a, 7
    ld [wVramTileAttributes], a
    ldbc 2, 1
    jp loadSpriteTilesOamInBuffer