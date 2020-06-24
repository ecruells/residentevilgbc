; de: sprite tiles address
; hl: sprite tiles buffer
copyRoomItemTilesInBuffer:: ;00:2A37
    push bc
    ld a, [wCurrentSpriteWidth]
    srl a
    srl a
    srl a 
    ld b, a ; get sprites needed horizontally
Loop2A42:
    ld a, [wCurrentSpriteHeight]
    srl a
    srl a
    srl a
    ld c, a ; get sprites needed vertically
copyRoomItemTileLoop:
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    dec c
    jp nz, copyRoomItemTileLoop
    dec b
    jp nz, Loop2A42
    pop bc
    ret

; de: sprite draw data pointer (pointing to screen x pos)
loadRoomItemSpriteTilesData:: ;00:2A86
    dec de
    dec de
    dec de
    ld a, [de] ; z-order
    cp a, 1
    jr z, .Label2A9B
    cp a, $FE
    jr z, .Label2A9B ; if room item
; if main hall pillar
    inc a
    ld l, a
    ld a, [wEntityZOrder]
    cp a, l
    jp c, skipRoomSprite ; skip pillar sprite if player z-order < pillar z-order
.Label2A9B
    ld a, [de]  ; z-order
    ld h, a
    inc de
    inc de
    inc de
    ld a, [de]
    ld [wRoomSpriteScreenXPos], a
    inc de
    ld a, [de]
    ld [wRoomSpriteScreenYPos], a
    inc de
    ld a, [de]
    ld [wCurrentSpriteWidth], a 
    inc de
    ld a, [de]
    ld [wCurrentSpriteHeight], a
    inc de
    ld a, [de] ; get sprite tiles data bank
    call bankSwitch
    inc de
    ld a, [de]
    ld l, a
    inc de
    ld a, [de] ; get sprite tiles data address
    ld d, a
    ld e, l
    ld a, h
    cp a, 1
    jr z, .loadRoomItemSpriteTiles
    cp a, $FE
    jr z, .loadRoomItemSpriteTiles ; if room item
; if main hall pillar
    ld a, [wEntityScreenX]
    add a, 16
    ld l, a
    ld a, [wEntityWidth]
    srl a
    add a, l
    ld l, a
    ld a, [wRoomSpriteScreenXPos]
    cp a, l
    jr nc, skipRoomSprite
    ld a, [wEntityWidth]
    srl a
    ld l, a
    ld a, [wEntityScreenX]
    add a, 16
    sub a, l
    ld l, a
    ld a, [wRoomSpriteScreenXPos]
    ld h, a
    ld a, [wCurrentSpriteWidth]
    add a, h
    cp a, l
    jr c, skipRoomSprite
.loadRoomItemSpriteTiles
    ld a, [wSpriteTilesBufferPointer]
    ld l, a
    ld a, [wSpriteTilesBufferPointer+1]
    ld h, a
    call copyRoomItemTilesInBuffer
    ld a, l
    ld [wSpriteTilesBufferPointer], a
    ld a, h
    ld [wSpriteTilesBufferPointer+1], a
; load sprites oam
    ld a, $01
    call bankSwitch
    ld a, [wSpritesOamUsedCounter]
    ld l, a
    ld h, 0
    add hl, hl
    add hl, hl
    ld de, wOAMBufferC9
    add hl, de
    ld a, [wRoomSpriteScreenXPos]
    ld e, a
    ld a, [wRoomSpriteScreenYPos]
    ld d, a
    call getOamBufferAddress
    ld a, [wSpritesUsedCounter]
    add a
    ld [wVramTilesCounter], a
    ld a, [wRoomItemAttributes]
    ld [wVramTileAttributes], a ; only palette number is loaded
    ld a, [wCurrentSpriteHeight]
    srl a
    srl a
    srl a
    srl a
    ld c, a ; sprites count vertically
    ld a, [wCurrentSpriteWidth]
    srl a
    srl a
    srl a
    ld b, a ; sprites count horizontally
    call updateSpritesUsedCounter
    jp loadSpriteTilesOamInBuffer
skipRoomSprite:
    ld a, $01
    jp bankSwitch
;2B50


; de: sprite draw data pointer (pointing to screen x pos)
loadFiregunSpriteTilesOAM: ;00:2B50
    ld a, [de]
    ld [wRoomSpriteScreenXPos], a
    inc de
    ld a, [de]
    ld [wRoomSpriteScreenYPos], a
    inc de
    ld a, [de]
    ld [wCurrentSpriteWidth], a
    inc de
    ld a, [de]
    ld [wCurrentSpriteHeight], a
    inc de
    inc de
    ld a, [de]
    ld c, a
    ld a, [wSpritesOamUsedCounter]
    ld l, a
    ld h, 0
    add hl, hl
    add hl, hl
    ld de, wOAMBufferC9
    add hl, de
    ld a, [wRoomSpriteScreenXPos]
    ld e, a
    ld a, [wRoomSpriteScreenYPos]
    ld d, a
    call getOamBufferAddress
    ld a, c
    and a, $0F
    srl a
    srl a
    add a
    add a, $74 ; get firegun tile id ($74: first firegun tile id)
    ld [wVramTilesCounter], a
    ld a, 6 ; palette id
    ld [wVramTileAttributes], a
    ld a, [wSpritesOamUsedCounter]
    inc a
    ld [wSpritesOamUsedCounter], a
    ldbc 1, 1 ; 8x16 sprite
    jp loadSpriteTilesOamInBuffer

; de: sprite draw data pointer (pointing to screen x pos)
loadBloodSpriteTilesOAM: ; 00:2B9D
    ld a, [de]
    ld [wRoomSpriteScreenXPos], a
    inc de
    ld a, [de]
    ld [wRoomSpriteScreenYPos], a
    inc de
    ld a, [de]
    ld [wCurrentSpriteWidth], a
    inc de
    ld a, [de]
    ld [wCurrentSpriteHeight], a
    inc de
    ld a, [de]
    ld c, a
    ld a, [wSpritesOamUsedCounter]
    ld l, a
    ld h, 0
    add hl, hl
    add hl, hl
    ld de, wOAMBufferC9
    add hl, de
    ld a, [wRoomSpriteScreenXPos]
    ld e, a
    ld a, [wRoomSpriteScreenYPos]
    ld d, a
    call getOamBufferAddress
    ld a, c
    and a, $0F
    srl a
    srl a
    add a
    add a, $7A ; get blood tile id ($7A: first blood tile id)
    ld [wVramTilesCounter], a
    ld a, 5 ; palette id
    ld [wVramTileAttributes], a
    ld a, [wSpritesOamUsedCounter]
    inc a
    ld [wSpritesOamUsedCounter], a
    ldbc 1, 1 ; 8x16 sprite
    jp loadSpriteTilesOamInBuffer
;2BE9
