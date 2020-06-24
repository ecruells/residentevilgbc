; hl: oam buffer address
; d: y-pos
; e: x-pos
; b: sprites used vertically
; c: sprites used horizontally
loadSpriteTilesOamInBuffer:: ;00:3D04
    push bc
    push de
.loadSpritesVerticallyLoop
    ld a, e ; x-pos
    cp a, -88
    jr nc, .loadNextSpriteTilesOam ; sprite is not visible
    ld a, d ; y-pos
    cp a, -112
    jr nc, .loadNextSpriteTilesOam ; sprite is not visible
; load oam
    ld [hli], a ; x-pos
    ld [hl], e ; y-pos
    inc l
    ld a, [wVramTilesCounter]
    ld [hl], a ; tile Id
    inc l
    ld a, [wVramTileAttributes]
    ld [hl], a ; attributes
    inc l
.loadNextSpriteTilesOam
    ld a, [wVramTilesCounter]
    add a, 2 ; tiles per sprites
    ld [wVramTilesCounter], a
    ld a, d
    add a, 16 ; y-pos offset
    ld d, a
    dec c
    jr nz, .loadSpritesVerticallyLoop
    pop de
    ld a, e
    add a, 8 ; x-pos offset
    ld e, a
    pop bc
    dec b
    jr nz, loadSpriteTilesOamInBuffer
    ret

; hl: oam buffer address
; b: sprites used horizontally
; c: sprites used vertically
; de: entity sprite screen position (y,x)
updateEntitySpritesOAM:: ;00:3D36
    push bc
    ld a, [wScreenYPos]
    ld c, a
    ld a, d
    sub a, c
    ld d, a
    pop bc
    ld a, [wVramTileAttributes]
    and a, OAMF_XFLIP
    jr z, loadSpriteTilesOamInBuffer
; load sprite tiles mirrored (this code is unused, as only the palette is assign in the attributes)
loadMirroredSpriteTilesOamInBuffer:
    ld a, b
    dec a
    add a
    add a
    add a
    dec a
    add a, e
    ld e, a
.updateMirroredSpritesOamHorizontally
    push bc
    push de
.updateMirroredSpritesOamVertically
    ld a, e
    cp a, -88
    jr nc, .loadNextMirroredSprite
    ld a, d
    cp a, -112
    jr nc, .loadNextMirroredSprite
    ld [hli], a ; x pos
    ld [hl], e ; y-pos
    inc l
    ld a, [wVramTilesCounter]
    ld [hli], a ; tile id
    ld a, [wVramTileAttributes]
    ld [hl], a ; attributes
    inc l
.loadNextMirroredSprite
    ld a, [wVramTilesCounter]
    add a, 2 ; tiles per sprites
    ld [wVramTilesCounter], a
    ld a, d
    add a, 16 ; y-pos offset
    ld d, a
    dec c
    jr nz, .updateMirroredSpritesOamVertically
    pop de
    ld a, e
    sub a, 8 ; x-pos offset
    ld e, a
    pop bc
    dec b
    jr nz, .updateMirroredSpritesOamHorizontally
    ret
