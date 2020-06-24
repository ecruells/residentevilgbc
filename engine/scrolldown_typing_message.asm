; copy each line of text to the above tiles from 2nd text line, and clear the last line
scrolldownTypingMessage:: ;05:6149
    ld hl, _SCRN0+$200 ; first line
    ld de, _SCRN0+$220 ; second line
    ld b, 4 ; lines of text
.loop16151
    ld c, 20
.copyTextLineLoop
    call vblankWait
    ld a, [de]
    ld [hli], a
    inc e
    dec c
    jr nz, .copyTextLineLoop
    ld a, e
    add a, 12
    ld e, a
    ld a, d
    adc a, 0
    ld d, a
    ld a, l
    add a, 12
    ld l, a
    ld a, h
    adc a, 0
    ld h, a
    dec b
    jr nz, .loop16151
    ld hl, charTileYPosition
    dec [hl]
    ld hl, charTileXPosition
    ld [hl], 0
    ret
