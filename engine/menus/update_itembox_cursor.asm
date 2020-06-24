updateItemboxCursor: ;04:4A00
; update oam
    ld hl, wOAMBufferC9+$60
    call getOamBufferAddress
    ld a, [wSelectedItemBoxSlotId]
    add a, 44 ; add cursor x-pos offset
    ld c, a
    ld [hl], 88 ; y-pos
    inc l
    ld [hl], c ; x-pos
    inc l
    ld [hl], $38 ; tileId
    inc l
    ld [hl], 1 ; attributes
    inc l
; create and load cursor sprite (5x2 pixels cursor)
    ld hl, wSpriteTilesBufferCE+$80
    ld c, 5 ; pixels heigth
.Label10A1C
    ld [hl], $C0
    inc hl
    ld [hl], $00
    inc hl
    inc de
    dec c
    jr nz, .Label10A1C
    ld c, 11
; rest of sprite is transparent
.Label10A28
    ld [hl], $00
    inc hl
    ld [hl], $00
    inc hl
    inc de
    dec c
    jr nz, .Label10A28
    ret
;4A33
