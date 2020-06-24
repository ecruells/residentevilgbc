updatePolicecardLogoColorsPosition:: ;01:493A
    ld a, [wPoliceCardYpos]
    and a, $F8
    add a, 13 ; y-pos
    ld d, a
    ld a, [wPoliceCardXpos]
    and a, $F8
    add a, 2 ; x-pos
    ld e, a
    ld hl, wOAMBufferC9+$30
    call getOamBufferAddress
    xor a
    ld [wVramTilesCounter], a
    ld a, 1
    ld [wVramTileAttributes], a
    ldbc 4, 3 ; width, height
    jp loadSpriteTilesOamInBuffer
