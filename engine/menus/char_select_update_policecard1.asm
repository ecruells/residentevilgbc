updatePolicecardCursors: ;01:48BD
    ld hl, wOAMBufferC9+$60
    call getOamBufferAddress
    ldde 28, 78 ; cursor 1 pos x, y
    ldbc 140, 78 ; cursor 2 pos x, y
    ld a, [wPoliceCardXpos]
    cp a, 40
    jr z, .Label48D6
; if card is moving, hide cursors
    ldde 0, 0
    ldbc 0, 0
.Label48D6
    ld [hl], e ; x-pos
    inc l
    ld [hl], d ; y-pos
    inc l
    ld [hl], $48 ; tileId
    inc l
    ld [hl], 2 ; attributes
    inc l
    ld [hl], c ; x-pos
    inc l
    ld [hl], b ; y-pos
    inc l
    ld [hl], $48 ; tileId
    inc l
    ld [hl], OAMF_XFLIP | 2 ; attributes
    ret

updatePolicecardFacePosition:: ;01:48EA
    ld a, [wPoliceCardYpos]
    and a, $F8
    add a, 22 ; face sprite y pos
    ld d, a
    ld a, [wPoliceCardXpos]
    and a, $F8
    add a, 36 ; face sprite x pos
    ld e, a
    ld hl, wOAMBufferC9
    call getOamBufferAddress
    ld c, $30 ; chris face tiles id
    ld a, [wCursorPosId]
    or a
    jr z, .Label490A
    ld c, $18 ; jill face tiles id
.Label490A
    ld a, c
    ld [wVramTilesCounter], a
    xor a
    ld [wVramTileAttributes], a
    ldbc 4, 3 ; sprites pieces count (width, height)
    jp loadSpriteTilesOamInBuffer