; de: sprite oam data
loadRoomItemSpriteData: ;00:1309
    ld a, [wLastSpriteInSortedSpritesList]
    ld l, a
    ld a, [wLastSpriteInSortedSpritesList+1]
    ld h, a
    ld a, [de]
    ld [hli], a ; z-order
    inc de
    ld a, [de]
    ld [hli], a ; sprite Id
    inc de
    ld a, [de]
    ld [hli], a ; 0
    inc de
    ld a, [de]
    ld [hli], a ; screen x pos
    inc de
    ld a, [de]
    push bc
    ld c, a
    ld a, [wScreenYPos]
    ld b, a
    ld a, c
    sub a, b ; update y position with scrolling
    pop bc
    ld [hli], a ; screen y pos
    inc de
    ld a, [de]
    ld [hli], a ; width
    inc de
    ld a, [de]
    ld [hli], a ; height
    inc de
    ld a, [de]
    ld [hli], a ; facing
    inc de
    ld a, [de]
    ld [hli], a ; frame Id
    inc de
    ld a, [de]
    ld [hli], a ; amin Id
    ld [hl], 0 ; reset next sprite
    ld a, l
    ld [wLastSpriteInSortedSpritesList], a
    ld a, h
    ld [wLastSpriteInSortedSpritesList+1], a
    ret


resetSpriteStructsBuffers:: ;00:1342
; reset sprites tiles data buffer
    ld hl, wSpriteTilesBuffer
    ld a, l
    ld [wSpriteTilesBufferPointer], a
    ld a, h
    ld [wSpriteTilesBufferPointer+1], a
; reset sorted sprite list
    ld hl, wSortedSpritesList
    ld a, l
    ld [wLastSpriteInSortedSpritesList], a
    ld a, h
    ld [wLastSpriteInSortedSpritesList+1], a
    ld [hl], 0
; reset sprites used counters
    xor a
    ld [wSpritesOamUsedCounter], a ; used to count sprites oam
    ld [wSpritesUsedCounter], a ; used to count sprites tiles in vram
    ret

; load and draw all room screen sprites (chars, enemies, objects, room items and special sprites)
; ordered by draw priority
;
loadAllSpritesTilesData:: ;00:1362
    ld de, wSortedSpritesList
loop1365:
    ld a, [de]
    or a
    ret z ; return if there are no sprites
    push de
    inc de
    ld a, [de] ; get special sprite load routine address (or sprite id)
    ld l, a
    inc de
    ld a, [de] ; high value is != 0 only on special sprite load (firegun or blood sprites)
    ld h, a
    inc de
    ld a, h
    or a
    jr nz, .Label1387 ; if special sprite
    ld a, l
    cp a, 8
    jr c, .Label1381 ; load room item sprites
; else, load entity sprite
    ld [wCurrentSpriteCharId], a
    ld hl, loadEntitySpriteTilesData
    jr .Label1387
.Label1381
    ld [wRoomItemAttributes], a
    ld hl, loadRoomItemSpriteTilesData
.Label1387
    ld bc, continueNextSpriteLoad ; set return pointer
    push bc
    jp hl
continueNextSpriteLoad:
    pop de
    ld a, e
    add a, 10 ; to next sprite draw data
    ld e, a
    ld a, d
    adc a, 0
    ld d, a
    jr loop1365
