loadAndScaleDoorSprites: ;00:2D62
    ld a, BANK(doorsSpritesheet)
    call bankSwitch
    ld a, [wDoorSpritesUsedCounter]
    ld l, a
    ld h, 0
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld de, wSpriteTilesBuffer
    add hl, de
    ld a, [wDoorSpriteFrameAddress]
    ld e, a
    ld a, [wDoorSpriteFrameAddress+1]
    ld d, a
; load and scale door tiles
    call scaleAndLoadSpriteTilesIntoBuffer

    ld a, $01
    call bankSwitch
    ld a, [wDoorSpritesUsedCounter]
    ld l, a
    ld h, 0
    add hl, hl
    add hl, hl
    ld de, wOAMBufferC9
    add hl, de
    ld a, [wDoorSpriteYPos]
    ld e, a
    ld a, [wDoorSpriteXPos]
    ld d, a
    call getOamBufferAddress
    ld a, [wDoorSpritesUsedCounter]
    add a
    ld [wVramTilesCounter], a
    ld a, [wDoorSpritesAttributes]
    ld [wVramTileAttributes], a
    ld a, [wCurrentSpriteHeight]
    ld c, a
    and a, $0F
    jr z, .Label2DB8 ; is multiple of 16
; else, round up height
    ld a, c
    and a, $F0
    add a, 16
    ld c, a
.Label2DB8
    srl c
    srl c
    srl c
    srl c
    ld a, c ; get sprite used vertically
    add a
    add a
    ld b, a
    ld a, [wDoorSpritesUsedCounter]
    add a, b
    ld [wDoorSpritesUsedCounter], a
    ld b, 4 ; sprites used horizontally
    jp loadSpriteTilesOamInBuffer
