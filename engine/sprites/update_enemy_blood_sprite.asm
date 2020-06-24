; hl: blood frame id
; de: enemy entity struct pointer ($3x0)
updateEnemyBloodSprite: ;04:4BC4
    push bc
    push de
    push hl
    ld a, [wLastSpriteInSortedSpritesList]
    ld l, a
    ld a, [wLastSpriteInSortedSpritesList+1]
    ld h, a
    inc de
    ld a, [de]
    dec a
    ld [hl], a ; set z-order always above enemy sprite
    inc hl
    inc de
    push de
    ld de, loadBloodSpriteTilesOAM
    ld [hl], e 
    inc hl
    ld [hl], d
    inc hl
    pop de
    ld a, [de] 
    add a, 12
    ld [hl], a ; enemy screen x pos + 12
    inc hl
    inc de
    ld a, [de]
    ld [hl], a ; screen y
    inc hl
    inc de
    ld a, 8
    ld [hl], a ; blood sprite width
    inc hl
    inc de
    ld a, 16
    ld [hl], a ; blood sprite height
    inc hl
    ld a, e
    add a, 8
    ld e, a
    ld a, d
    adc a, 0
    ld d, a
    ld a, [de]
    ld [hl], a ; get enemy health
    inc hl
    ld [hl], 0 ; no frame id
    inc hl
    ld [hl], 0 ; no anim id
    inc hl
    ld [hl], 0 ; reset next sprite data
    ld a, l
    ld [wLastSpriteInSortedSpritesList], a
    ld a, h
    ld [wLastSpriteInSortedSpritesList+1], a
    pop hl
    pop de
    push hl
    ld hl, wEntityHeight - wEntityStructData
    add hl, de
    ld a, [hl] ; get enemy height
    srl a
    srl a
    srl a
    srl a
    ld c, a
    ld hl, wEntityScreenY - wEntityStructData
    add hl, de
    ld a, [hl]
    add a, c
    ld c, a ; get blood screen y ( height / 16 + screenY )
    ld a, [wLastSpriteInSortedSpritesList]
    sub a, 6
    ld l, a
    ld a, [wLastSpriteInSortedSpritesList+1]
    sbc a, 0
    ld h, a
    ld [hl], c ; update blood screen y
    pop hl
    pop bc
    ret
;4C34
