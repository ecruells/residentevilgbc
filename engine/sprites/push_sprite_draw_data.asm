; push entity sprite draw data into sorted sprites list
;
; de: current entity data struct pointer (C3x0)
pushSpriteDrawDataInSortedSpritesList:: ;04:4B80
    push de ; spriteStatus
    push hl
    ld a, [wLastSpriteInSortedSpritesList]
    ld l, a
    ld a, [wLastSpriteInSortedSpritesList+1]
    ld h, a
    inc de 
    ld a, [de] ; sprite zOrder
    ld [hli], a
    inc de ; sprite screenX
    push de
    ld a, [wCurrentSpriteCharId]
    ld [hl], a
    inc hl
    ld [hl], 0
    inc hl
    pop de
    ld a, [de] ; sprite screenX
    ld [hl], a
    inc hl
    inc de
    ld a, [de] ; sprite screenY
    ld [hl], a
    inc hl
    inc de
    ld a, [de] ; sprite width
    ld [hl], a
    inc hl
    inc de
    ld a, [de] ; sprite height
    ld [hl], a
    inc hl
    inc de
    inc de
    inc de
    inc de
    ld a, [de] ; sprite facing
    ld [hl], a
    inc hl
    dec de
    dec de
    ld a, [de] ; sprite animation frame Id
    ld [hl], a
    inc hl
    dec de
    ld a, [de] ; sprite animation Id
    ld [hl], a
    inc hl
    ld [hl], 0
    ld a, l
    ld [wLastSpriteInSortedSpritesList], a
    ld a, h
    ld [wLastSpriteInSortedSpritesList+1], a
    pop hl
    pop de
    ret
