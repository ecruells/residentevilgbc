updateTitleScreenCursorOptions:: ;05:60F4
    ld a, $01
    ld [rVBK], a
    ld hl, _SCRN0+$1E0 ; new game tile line
; d: new game tiles pal index
; e: load game tiles pal index
    ldde 2, 0
    ld a, [wCursorPosId]
    or a ; 0
    jr z, .updateNewGameTilesAttr ; new game selected
; load game selected, swap palette indexes
    ldde 0, 2
.updateNewGameTilesAttr
    ld b, $20 ; tiles width
.updateTilesAttributesLoop
    call vblankWait
    ld a, [hl]
    and a, %11111000 ; reset palette index
    or a, d ; set pal id
    ld [hli], a
    dec b
    jr nz, .updateTilesAttributesLoop
; update load game tiles attributes
    ld b, $20 ; tiles width
.loop16116
    call vblankWait
    ld a, [hl]
    and a, %11111000 ; reset palette index
    or a, e ; set pal id
    ld [hli], a
    dec b
    jr nz, .loop16116
    xor a
    ld [rVBK], a ;vram bank select
; check button presses, update cursor id and return
    ld a, [wButtonPressId]
    and a, UP_INPUT
    jr z, .label16135
    ld a, [wCursorPosId]
    or a
    jr z, .label16135
    xor a
    ld [wCursorPosId], a
.label16135
    ld a, [wButtonPressId]
    and a, DOWN_INPUT
    jr z, .label16148
    ld a, [wCursorPosId]
    cp a, 1
    jr z, .label16148
    ld a, 1
    ld [wCursorPosId], a
.label16148
    ret
