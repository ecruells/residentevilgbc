updateLoadSaveMenuCursor:: ;01:56E7
    ld hl, wOAMBufferC9
    call getOamBufferAddress
    ld a, [wCursorPosId]
    add a
    add a
    add a
    add a
    add a, 48
    ld [hl], a ; cursor Y pos
    inc l
    ld [hl], 8 ; cursor X pos
    inc l
    ld [hl], 0 ; tile id
    inc l
    ld [hl], OAMF_XFLIP | 0 ; attributes
    ret