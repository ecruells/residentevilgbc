sortSpriteListByDrawPriority:: ;FC:4CAA
    ld hl, wSortedSpritesList
    ld de, 10 ; sprite draw data structure length
    ld b, 0 ; sprites in list counter
.spritesCountLoop
    ld a, [hl]
    or a
    jr z, .Label3F0CBA ; no more sprites, break loop
    add hl, de ; next sprite data
    inc b
    jr .spritesCountLoop
.Label3F0CBA
    ld a, b
    cp a, 2
    ret c ; return if there's only 1 sprite, no priority sort needed
    dec a
    ld b, a
    ld c, a
evalSpritesPriorityLoop2:
    push bc
    ld hl, wSortedSpritesList
    ld de, wSortedSpritesList+10
evalSpritesPriorityLoop1:
    ld a, [hl]
    ld a, [de]
    cp a, [hl]
    jr nc, .Label3F0CDC ; if sprt2.priority >= sprt1.priority
; else, swap priority data
    push bc
    ld b, 10
.swapLoop
    ld c, [hl]
    ld a, [de]
    ld [hli], a
    ld a, c
    ld [de], a
    inc de
    dec b
    jr nz, .swapLoop
    pop bc
    jr .Label3F0CEC
.Label3F0CDC
    ld a, l
    add a, 10
    ld l, a
    ld a, h
    adc a, 0
    ld h, a
    ld a, e
    add a, 10
    ld e, a
    ld a, d
    adc a, 0
    ld d, a
.Label3F0CEC
    dec c
    jr nz, evalSpritesPriorityLoop1
    pop bc
    dec b
    jr nz, evalSpritesPriorityLoop2
    ret
;4CF4
