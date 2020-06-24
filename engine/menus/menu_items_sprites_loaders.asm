; load all main menu items sprites OAM and tiles data
loadMenuItemsSprites: ;05:5C1C
; load items OAM data
    ld hl, wItemIdSlot1
    ld e, $08 ; start tile id from vram, 4 tiles per item sprite
    ld b, 0 ; items slots rowId
loadItemsOAMLoop:
    ld c, 2 ; item slots columns, right to left
columnLoop:
    ld a, [hl] ; get item id
    push hl ; store item slot id
    ld hl, itemsPaletteIndexTable
    add a, l
    ld l, a
    ld a, $00
    adc a, h
    ld h, a
    ld d, [hl] ; get item palette index
    push de
    ld hl, wOAMBufferC9+8 ;$C908
    call getOamBufferAddress
    ld a, b
    add a
    ld d, a
    ld a, $02
    sub a, c
    add a, d
    add a
    add a
    add a
    add a, l
    ld l, a ; $CX08 + ( (2 - col  + (row * 2)) * 8 )
    pop de ; d: palId, e: start tileId
    ld a, b
    cp a, 3
    jr c, .Label15C50
    ld a, [wSelectedCharacter]
    or a
    jr z, .Label15C53 ; if chris, skip row 4 (chris has only 3 slots rows)
.Label15C50
    call calcAndLoadItemSpriteOamData
.Label15C53
    pop hl ; restore itemId addr
    inc hl ; next itemId
    dec c ; next column
    jr nz, columnLoop 
    inc b
    ld a, b
    cp a, 4 ; max items rows
    jr c, loadItemsOAMLoop
;
; load OAM data finished, now load sprite tiles data in sprites tile buffer
    ld de, wSpriteTilesBuffer+$80
    ld hl, wItemIdSlot1
    ld b, 8 ; max held items
loadItemTileDataLoop:
    push bc ; store items count
    push hl ; store itemId
    push de ; store sprite buffer
    ld l, [hl]
    ld h, 0
    add hl, hl ; get item sprite offset by ID
    ld de, itemsSpriteTable
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a ; get item sprite tile pointer
    pop de
    ld b, 2 ; each item sprite is composed by 2 8x16 sub-sprites
loadItemSubSpriteLoop
    ld c, $20 ; 2 tiles length
.loadTilesDataLoop
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, .loadTilesDataLoop
    ld a, l
    add a, $A0 ; offset to next half sprite tiles
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec b
    jr nz, loadItemSubSpriteLoop
    pop hl
    inc hl
    pop bc
    dec b
    jr nz, loadItemTileDataLoop
    ret
;5C91

; hl: oam buffer address
; d: palId
; e: tileId
; b: slot rowId
; c: slot colId
calcAndLoadItemSpriteOamData: ;05:5C91
; calc item sprite left half oam data
    push de
    ld a, b ; slots rowId
    add a
    add a
    add a
    add a
    add a, 64 ; px 
    pop de
    ld [hl], a ; set item sprite y-pos (64 + rowId * 16)
    ld a, [wSelectedCharacter]
    or a
    jr nz, .Label15CA5 ; if jill
; if chris, we add a 16px offset to each sprite y-pos, because he has 6 slots, 
; and the top slots row is one row lower than jill's
    ld a, [hl]
    add a, 16
    ld [hl], a
.Label15CA5
    inc l ; oam x-pos
    push de
    ld a, 2
    sub a, c ; get column index
    inc a
    add a
    add a
    add a
    ld e, a ; tileXpos ( ((2 - colId)+1)*8 )
    add a
    add a, e
    add a, 88 ; px
    pop de
    ld [hli], a ; set item sprite x-pos ( (tileXpos*2) + tileXpos + 88 )
    ld [hl], e ; set sprite tileId
    inc e
    inc e ; right half tile id
    inc l
    ld [hl], d ; set attribute flags
    inc l
; calc item sprite right half oam data
    push de
    ld a, b
    add a
    add a
    add a
    add a
    add a, 64 ; px
    pop de
    ld [hl], a ; set item sprite y-pos (64 + rowId * 16)
    ld a, [wSelectedCharacter]
    or a
    jr nz, .Label15CCF ;if jill
; if chris ( same as left half )
    ld a, [hl]
    add a, 16 ; px
    ld [hl], a
.Label15CCF
    inc l
    push de
    ld a, 2
    sub a, c
    inc a
    add a
    add a
    add a
    ld e, a ; tileXpos ( ((2 - colId)+1)*8 )
    add a
    add a, e
    add a, 96
    pop de
    ld [hli], a ; set item sprite x-pos ( (tileXpos*2) + tileXpos + 88 )
    ld [hl], e ; set sprite tileId
    inc e
    inc e
    inc l
    ld [hl], d ; set attribute flags
    inc l
    ret
;5CE6

; load the examined item big sprite, scaling it by duplicate the size of each pixel
loadItemBigSprite: ;05:5CE6
    ld a, $01
    ld [rVBK], a ;vram bank select
    ld hl, _VRAM+$1000 ; black tiles
    ld b, 176
.clearSpriteTilesLoop
    ld a, [rSTAT]  ;lcd status
    and a, STATF_LCD
    jr z, .clearSpriteTilesLoop
.waitVblankLoop
    ld a, [rSTAT]  ;lcd status
    and a, STATF_LCD
    jr nz, .waitVblankLoop
; clear big item sprite tiles
    xor a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    dec b
    jr nz, .clearSpriteTilesLoop
; get selected item Id
    ld a, [wSelectedItemId]
    ld l, a
    ld h, 0
    add hl, hl
    ld de, itemsSpriteTable
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld de, _VRAM+$1220 ;item big sprite start tile
; an item sprite is 16x16, using 2 8x16 sprites (2x2 tiles), when scaled, it becomes 4x4 tiles
    ld b, 4 ; h-tiles number
scaleSpriteTileLoop:
    ld c, $10 ; bytes per tile
; two loops by tile, even loops for left half and right loops for right half
scaleTileByteLoop:
    push bc
    ld a, b
    and a, $01 ; check for even or odd h-tile columns
    jr z, .scaleLeftMostLinePixels
; scale right most line pixels
    ld a, [hli]
    call scaleRightMostLineBitplane
    ld c, a
    ld a, [hli]
    call scaleRightMostLineBitplane
    ld b, a
    jr .Label15D38
.scaleLeftMostLinePixels
    ld a, [hli]
    call scaleLeftMostLineBitplane
    ld c, a
    ld a, [hli]
    call scaleLeftMostLineBitplane
    ld b, a
.Label15D38
; store h-scaled half bitplane twice to duplicate pixels vertically
    call vblankWait
    ld a, c
    ld [de], a
    inc de
    ld a, b
    ld [de], a
    inc de
    ld a, c
    ld [de], a
    inc de
    ld a, b
    ld [de], a
    inc de
    pop bc
    dec c
    jr nz, scaleTileByteLoop
    ld a, b
    and a, $01
    jr z, .backToPreviousTile
; go to item sprite right half sprite tiles pointer
    ld a, l
    add a, $A0
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    jr .Label15D62
.backToPreviousTile ; to scale the right most parts
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
.Label15D62
    ld a, e
    add a, $40
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    dec b
    jr nz, scaleSpriteTileLoop
    xor a
    ld [rVBK], a ;vram bank select
; get item palette index
    ld hl, itemsPaletteIndexTable
    ld a, [wSelectedItemId]
    add a, l
    ld l, a
    ld a, 0
    adc a, h
    ld h, a
    ld l, [hl]
    ld h, 0 ;set pal id in hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld de, itemsPalette
    add hl, de ; get item palette
; load item obj palette in last bg palette index
    ld c, 56 ; bg palette color index (BG7 - color 0), no auto increment
    ld b, 4 ; palette colors count
.loadPaletteLoop
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld a, [wPaletteFadeCounter]
    and a, MAX_FADE_STEPS
    call changeColorDarkness
    call vblankWait
    ld a, c
    ld [rBCPS], a ;bg color index
    ld a, e
    ld [rBCPD], a ;bg color data
    inc c
    call vblankWait
    ld a, c
    ld [rBCPS], a ;bg color index
    ld a, d
    ld [rBCPD], a ;bg color data
    inc c
    dec b
    jr nz, .loadPaletteLoop
    ret
;5DAE

; scale x2 the left most bits from a line bitplane
;
; a: 8bit tile line bitplane
scaleLeftMostLineBitplane: ;05:5DAE
    push de
    ld e, a
    ld d, 0
    ld a, e
    and a, %10000000
    call nz, d_OR_11000000
    ld a, e
    and a, %01000000
    call nz, d_OR_00110000
    ld a, e
    and a, %00100000
    call nz, d_OR_00001100
    ld a, e
    and a, %00010000
    call nz, d_OR_00000011
    ld a, d
    pop de
    ret
;5DCD

; scale x2 the right most bits from a line bitplane
;
; a: 8bit tile line bitplane
scaleRightMostLineBitplane: ;05:5DCD
    push de
    ld e, a
    ld d, 0
    ld a, e
    and a, %0001000
    call nz, d_OR_11000000
    ld a, e
    and a, %00000100
    call nz, d_OR_00110000
    ld a, e
    and a, %00000010
    call nz, d_OR_00001100
    ld a, e
    and a, %00000001
    call nz, d_OR_00000011
    ld a, d
    pop de
    ret
;5DEC

d_OR_11000000: ;05:5DEC
    ld a, d
    or a, %11000000
    ld d, a
    ret
;5DF1

d_OR_00110000: ;05:5DF1
    ld a, d
    or a, %00110000
    ld d, a
    ret
;5DF6

d_OR_00001100: ;05:5DF6
    ld a, d
    or a, %00001100
    ld d, a
    ret
;5DFB

d_OR_00000011: ;05:5DFB
    ld a, d
    or a, %00000011
    ld d, a
    ret
;5E00

itemsPalette: ;05:5E00
	dw $00E0, $7BDE, $5294, $294A ; grey
	dw $00E0, $001E, $0014, $000A ; red
	dw $00E0, $03C0, $0280, $0140 ; green
	dw $00E0, $7BC0, $5280, $2940 ; light blue
	dw $00E0, $03DE, $0294, $014A ; orange
	dw $00E0, $01FE, $0154, $00AA ; brown
	dw $00E0, $781E, $5014, $280A ; violet
	dw $00E0, $5B5F, $3636, $0C63 ; face sprite skin color
;5E40


loadEquippedItemSprite: ;05:5E40
    ld a, [wEquippedItemId]
    ld hl, itemsPaletteIndexTable
    add a, l
    ld l, a
    ld a, 0
    adc a, h
    ld h, a
    ld d, [hl] ; get item palette index
    ld hl, wOAMBufferC9+$48 ; set OAM buffer address
    call getOamBufferAddress
; sprite left half oam data
    ld [hl], 104 ; y-pos
    inc l
    ld [hl], 80 ; x-pos
    inc l
    ld [hl], $30 ; tileId
    inc l
    ld [hl], d ; attributes
    inc l
; sprite right half oam data
    ld [hl], 104 ; y-pos
    inc l
    ld [hl], 88 ; x-pos
    inc l
    ld [hl], $32 ; tileId
    inc l
    ld [hl], d ; attributes
    inc l
; load sprite tiles data
    ld a, [wEquippedItemId]
    ld l, a
    ld h, 0
    add hl, hl
    ld de, itemsSpriteTable
    add hl, de
    ld a, [hli]
    ld h, [hl] ; get sprite address
    ld l, a
    ld de, wSpriteTilesBufferCE
    ld b, 2 ; sprite parts
.loadSpritePartsLoop
    ld c, $20 ; two tiles per part (8x16)
.loadTilesLoop
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, .loadTilesLoop
    ld a, l
    add a, $A0 ; to next sprite half tiles
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec b
    jr nz, .loadSpritePartsLoop
    ret
;5E90

loadItemboxItemSprite: ;05:5E90
    ld a, [wSelectedItemBoxSlotId]
    ld e, a
    ld d, 0 ; get selected slot id
    ld hl, wItemBoxSlot01
    add hl, de
    ld a, [hl] ; get selected itembox item id
    push af
    ld hl, itemsPaletteIndexTable
    add a, l
    ld l, a
    ld a, 0
    adc a, h
    ld h, a
    ld d, [hl] ; get item id palette id
    ld hl, wOAMBufferC9+$58 ; set oam buffer address
    call getOamBufferAddress
; sprite left half oam data
    ld [hl], 64 ; y-pos
    inc l
    ld [hl], 48 ; x-pos
    inc l
    ld [hl], $34 ; tileId
    inc l
    ld [hl], d ; attributes
    inc l
; sprite right half oam data
    ld [hl], 64 ; y-pos
    inc l
    ld [hl], 56 ; x-pos
    inc l
    ld [hl], $36 ; tileId
    inc l
    ld [hl], d ; attributes
    inc l
    pop af ; restore item id
; load item sprite data
    ld l, a
    ld h, 0
    add hl, hl
    ld de, itemsSpriteTable
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld de, wSpriteTilesBufferCE+$40
    ld b, 2 ; sprite parts
.loadSpritePartsLoop
    ld c, $20 ; two tiles per part (8x16)
.loadTilesLoop
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, .loadTilesLoop
    ld a, l
    add a, $A0 ; to next sprite half tiles
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec b
    jr nz, .loadSpritePartsLoop
    ret
;5EE7
