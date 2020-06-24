; deletes the selected save slot text in load/save menu
deleteSaveSlotText:: ;00:3EE0
    ld a, BANK(loadSaveMenuIndexes)
    call bankSwitch
    ld a, [wCursorPosId]
    add a
    ld l, a
    ld h, 0
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld de, _SCRN0+$93
    add hl, de
    ld b, 20 ; tiles count
.deleteTextLoop
    push bc
    push hl
    ld a, b
    dec a
    ld l, a
    ld h, 0
    add hl, hl
    push hl
    add hl, hl
    add hl, hl
    add hl, hl
    pop de
    add hl, de
    push hl
    ld de, loadSaveMenuIndexes
    ld a, [wCursorPosId]
    add a
    add a, $04
    add a, e
    ld e, a
    ld a, $00
    adc a, d
    ld d, a
    add hl, de
    ld a, [hl]
    add a, $80
    ld b, a
    ld de, loadSaveMenuIndexes+$18C
    ld a, [wCursorPosId]
    add a
    add a, $04
    add a, e
    ld e, a
    ld a, $00
    adc a, d
    ld d, a
    pop hl
    add hl, de
    ld c, [hl]
    pop hl
    call vblankWait
    ld [hl], b
    ld a, 1
    ld [rVBK], a ;vram bank select
    ld [hl], c
    xor a
    ld [rVBK], a ;vram bank select
    dec hl
    pop bc
    dec b
    jr nz, .deleteTextLoop
    ld a, $01
    jp bankSwitch
;3F43
