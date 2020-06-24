clearItemDetailWindowBgMap:: ;00:34A9
    ld hl, _SCRN0+$41 ; start item detail window tilemap
    ld e, $00 ; tile id
    ld d, OAMF_VRAM1 | 7 ; tile attributes
    ld b, 11 ; tiles horizontally
.clearHLoop
    push hl
    ld c, 8 ; tiles vertically
.clearVLoop
    call vblankWait
    ld [hl], e ; set tile id
    ld a, $01
    ld [rVBK], a
    ld [hl], d ; set tile attributes
    xor a
    ld [rVBK], a
    push bc
    ld bc, $20 ; offset to next row
    add hl, bc
    pop bc
    inc e
    dec c
    jr nz, .clearVLoop
    pop hl
    inc l
    dec b
    jr nz, .clearHLoop
    ret
;34D1

; de: tilemap attributes pointer
loadDetailWindowTilemapAttributes: ;00:34D1
    ld hl, _SCRN0+$41 ;start item detail window tilemap
    ld b, 11 ; tiles horizontally
.updateTilesHLoop
    push hl
    ld c, 8 ; tiles vertically
.updateTilesVLoop
    call vblankWait
    ld a, $01
    ld [rVBK], a ;vram bank select
    ld a, [de] ; get attribute flags value
    or a, OAMF_VRAM1
    ld [hl], a
    xor a
    ld [rVBK], a ;vram bank select
    push bc
    ld bc, $20
    add hl, bc
    pop bc
    inc de
    dec c
    jr nz, .updateTilesVLoop
    pop hl
    inc l
    dec b
    jr nz, .updateTilesHLoop
    ret
;34F7

clearItemDetailWindowTiles: ;00:34F7
    ld a, $01
    ld [rVBK], a ; vram bank select
    ld hl, _VRAM+$1000 ; item detail window vram
    ld b, 22 * 8 ; tiles to clean
.waitExitVBlank
    ld a, [rSTAT]  ;lcd status
    and a, STATF_LCD
    jr z, .waitExitVBlank
.waitVblank
    ld a, [rSTAT]  ;lcd status
    and a, STATF_LCD
    jr nz, .waitVblank
    ld a, $FF ; clear tile data value
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    dec b
    jr nz, .waitExitVBlank
    xor a
    ld [rVBK], a ;vram bank select
    ret
;351D

loadRoomsMapWindow: ;00:351D
    ld a, BANK(roomsMapRects)
    call bankSwitch
    ld hl, roomsMapRects
    ld b, 45 ; room maps rects count (only mansion 1f map rooms)
drawRoomMapsRectsLoop
    push bc
    call drawRoomMapRect
    pop bc
    dec b
    jr nz, drawRoomMapsRectsLoop
; load rooms map palette
    ld a, $01
    call bankSwitch
    ld a, BANK(mapDetailPalette)
    ld hl, mapDetailPalette
    jp loadBgPalette
;353C
