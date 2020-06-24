; load an entity sprite animation frame tiles data to tiles buffer memory. 
; Based on its draw information, the raw tiles data are scaled before load them into memory.
; When all scaled data is stored in memory, the tiles are post processed to apply effects like
; submerge in water (dittering) or apply a room overlap mask. 
;
; de: entity draw data pointer from sorted sprite list (pointing to screen x position)
loadEntitySpriteTilesData: ;00:2BE9
    dec de
    dec de
    dec de 
    ld a, [de] ; z-order
    ld [wCurrentSpriteZOrder], a
    inc de
    inc de
    inc de
    ld a, [de] ; screen x position
    ld [wCurrentSpriteScreenX], a
    inc de
    ld a, [de] ; screen y position
    ld [wCurrentSpriteScreenY], a
    inc de
    ld a, [de] ; width
    ld [wCurrentSpriteWidth], a
    inc de
    ld a, [de] ; height
    ld [wCurrentSpriteHeight], a
    inc de
    ld a, [de] ;  facing
    ld c, a ; store facing in c
    inc de
    ld a, [de]  ; frame id
    push af 
    inc de
    ld a, [de] ; animation ID
    ld l, a
    ld e, 0 ; back to z-order value
;
; calculate the width ID to get later the horizontal shrink table
;
    ld a, [wCurrentSpriteWidth]
    cp a, 33
; jump if width >= 33, but this condition can never be met, because width cannot be greater than 31
    jr nc, .Label2C25
; if width < 33
    ld d, a
    ld a, 32
    sub a, d
    srl a
    ld e, a ; (32 - width) / 2
    cp a, 13
    jr c, .Label2C25 ; jump if result < 13
; else, set width ID to 12 (to get here, width has to be 4px or less)
    ld e, 12
.Label2C25
    ld a, e ; set width ID
    ld [wCurrentSpriteWidthId], a
;
; get animation frame pointer
; a: entity char Id
; hl: animation Id (offset animationId by 64 bytes)
; c: facing Id
    ld h, 0
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld de, _chrisSpritesTable
    ld a, [wCurrentSpriteCharId]
    cp a, CHRIS
    jr z, .Label2C65
    ld de, _jillSpritesTable
    cp a, JILL
    jr z, .Label2C65
    ld de, _rebeccaSpritesTable
    cp a, REBECCA
    jr z, .Label2C65
    ld de, _weskerBarrySpritesTable
    cp a, WESKER
    jr z, .Label2C65
    cp a, BARRY
    jr z, .Label2C65
    ld de, _zombieSpritesTable
    cp a, ZOMBIE
    jr z, .Label2C65
    ld de, _yawnSpritesTable
    cp a, YAWN
    jr z, .Label2C65
	; else objects
    ld de, _objectsSpritesTable
.Label2C65
    ld a, [wCameraType]
    or a
    jr z, .Label2C6F ; jump if camera == 0 (normal)
; else offset 4 bytes to get the overhead camera frames pointers
    inc de
    inc de
    inc de
    inc de
.Label2C6F
    add hl, de ; apply animation offset on frame pointer
    ld a, [wCameraFacing]
    ld e, a
    ld a, c ; sprite facing
    add a, e
    and a, $1F
    ld [wPlayerCamFacing], a ; (camFacing + SprtFacing) & $1F
    srl a
    srl a
    add a
    add a
    add a
    ld e, a
    ld d, 0 ; facing offset ( PlayerCamFacing / 2 ) * 8
    add hl, de ; apply facing offset on pointer
    ld a, BANK(entitiesSpritesheetsTables)
    call bankSwitch
    ld a, [hli]
    ld c, a ; get sprite frames bank ID
    inc hl
    ld a, [hli]
    ld h, [hl]
    ld l, a ; sprite pointer
    pop af ; restore frame id
    srl a
    srl a
    srl a
    add a
    ld e, a ; ( frameId / 8 ) * 2
    ld d, 0
    add hl, de ; apply frame offset
; finally, store frame pointer in DE
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, c ; switch to sprite frame bank
    call bankSwitch
    ld a, [wSpriteTilesBufferPointer]
    ld l, a
    ld a, [wSpriteTilesBufferPointer+1]
    ld h, a
    push hl ; store sprite tile buffer memory address
;
; scale and load tiles in buffer
    call scaleAndLoadSpriteTilesIntoBuffer

    ld a, l
    ld [wSpriteTilesBufferPointer], a
    ld a, h
    ld [wSpriteTilesBufferPointer+1], a
    ld a, $01
    call bankSwitch
    pop hl

; apply effects on sprite in buffer
    push hl
    call applyWaterEffectOnSpriteCaller
    pop hl
    call applyBgOverlapMaskOnSpriteCaller
;
; get oam buffer pointer
    ld a, [wSpritesOamUsedCounter]
    ld l, a
    ld h, 0
    add hl, hl
    add hl, hl
    ld de, wOAMBufferC9
    add hl, de ; offset used sprites
    ld a, [wCurrentSpriteScreenX]
    ld e, a
    ld a, [wCurrentSpriteScreenY]
    ld d, a
    call getOamBufferAddress
; get vram tile position 
    ld a, [wSpritesUsedCounter]
    add a
    ld [wVramTilesCounter], a
; set entity palette number
    ld c, 0
    ld a, [wCurrentSpriteCharId]
    cp a, CHRIS
    jr z, .setEntityPaletteId
    ld c, 1
    cp a, JILL
    jr z, .setEntityPaletteId
    ld c, 2
    cp a, REBECCA
    jr z, .setEntityPaletteId
    ld c, 0
    cp a, BARRY
    jr z, .setEntityPaletteId
    ld c, 2
    cp a, WESKER
    jr z, .setEntityPaletteId
    ld c, 7
    cp a, ZOMBIE
    jr z, .setEntityPaletteId
    ld c, 4
    cp a, YAWN
    jr z, .setEntityPaletteId
	; else objects entities
    ld c, 4
.setEntityPaletteId
    ld a, c
    ld [wVramTileAttributes], a
; update the sprites used by the entity frame in buffer
    ld a, [wCurrentSpriteHeight]
    ld c, a
    and a, $0F
    jr z, .Label2D25 ; height is multiply of 16
; round up height
    ld a, c
    and a, $F0
    add a, 16
    ld c, a
.Label2D25
    srl c
    srl c
    srl c
    srl c ; height / 16 (number of sprites needed vertically)
    ld b, 4 ; number of max sprites horizontally
    call updateSpritesUsedCounter
    ld a, [wCurrentSpriteWidthId]
    cp a, 8 ; width > 16px
    jr c, .Label2D47 ; entity width > 16px
; optimization to avoid waste sprites with empty data when shank entity sprite is <= 16px
    ld a, e ; de: sprite screen y,x
    add a, 8
    ld e, a ; screen x + 8 (offset sprites to fit in 2 oam sprites horizontally)
    ld b, 2 ; reduce oam sprites horizontally
    ld a, [wVramTilesCounter]
    add a, c
    add a, c ; offset tile id
    ld [wVramTilesCounter], a
.Label2D47
    jp updateEntitySpritesOAM


; c: sprites used vertically
; b: sprites used horizontally
updateSpritesUsedCounter: ;00:2D4A
    push de
    xor a ; sprites counter = b * c
    ld e, b
.loop2D4D
    add a, c
    dec e
    jr nz, .loop2D4D
    ld e, a
    ld a, [wSpritesOamUsedCounter]
    add a, e
    ld [wSpritesOamUsedCounter], a
    ld a, [wSpritesUsedCounter]
    add a, e
    ld [wSpritesUsedCounter], a
    pop de
    ret

;00:2D62
