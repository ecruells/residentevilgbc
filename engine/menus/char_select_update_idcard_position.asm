updatePolicecardTilesPosition: ;00:3C37
    ld a, BANK(characterSelectScreenTilesmap)
    call bankSwitch
    ld hl, characterSelectScreenTilesmap+$168 ; chris idcard tilemap
    ld de, characterSelectScreenTilesmap+$3BA ; chris idcard attributes
    ld a, [wCursorPosId]
    or a
    jr z, .Label3C4E ; if chris
; if jill
    ld hl, characterSelectScreenTilesmap+$16F ; jill idcard tilemap
    ld de, characterSelectScreenTilesmap+$3C1 ; jill idcard attributes
.Label3C4E
    ld a, l
    ld [wVramTilesCounter], a
    ld a, h
    ld [wVramTileAttributes], a
    ld a, e
    ld [wBgCurrentPointerBankId], a
    ld a, d
    ld [wBgStartBankId], a
    ld a, [wPoliceCardYpos]
    sub a, 16
    srl a
    srl a
    srl a
    ld l, a
    ld h, 0
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld de, _SCRN0 ;$9800
    add hl, de
    ld a, [wPoliceCardXpos]
    sub a, 8
    srl a
    srl a
    srl a
    add a, l
    ld l, a
    ldbc 7, 13 ; police id card tile size
    call updatePolicecardTiles
    ld a, 1
    jp bankSwitch

updatePolicecardTiles:: ;00:3C8D
    push bc
    push hl
.updateTilesVerticallyLoop
    push bc
    ld a, [wVramTilesCounter]
    ld e, a
    ld a, [wVramTileAttributes]
    ld d, a
    ld a, [wBgCurrentPointerBankId]
    ld c, a
    ld a, [wBgStartBankId]
    ld b, a
    call vblankWait
    ld a, [de]
    add a, $80 ; offset tile id
    ld [hl], a ; set tile id
    ld a, $01
    ld [rVBK], a
    ld a, [bc]
    ld [hl], a ; set tile attribute
    xor a
    ld [rVBK], a
    inc de
    ld a, e
    ld [wVramTilesCounter], a
    ld a, d
    ld [wVramTileAttributes], a
    inc bc
    ld a, c
    ld [wBgCurrentPointerBankId], a
    ld a, b
    ld [wBgStartBankId], a
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    cp a, HIGH(_SCRN1)
    jr c, .Label3CD0
    ld h, HIGH(_SCRN0)
.Label3CD0
    pop bc
    dec b
    jr nz, .updateTilesVerticallyLoop
    ld a, [wVramTilesCounter]
    add a, $0B
    ld [wVramTilesCounter], a
    ld a, [wVramTileAttributes]
    adc a, $00
    ld [wVramTileAttributes], a
    ld a, [wBgCurrentPointerBankId]
    add a, $0B
    ld [wBgCurrentPointerBankId], a
    ld a, [wBgStartBankId]
    adc a, 0
    ld [wBgStartBankId], a
    pop hl
    ld a, l
    and a, $E0
    ld c, a
    ld a, l
    inc a
    and a, $1F
    or a, c
    ld l, a
    pop bc
    dec c
    jr nz, updatePolicecardTiles ; update tiles horizontally loop
    ret
