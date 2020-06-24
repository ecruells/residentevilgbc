showSpriteDoorsAnimation:: ;00:0C80
    call hideSprites
    ld a, 0
    ld [wEntityAnimationId], a
    xor a
    ld [wEntityAnimationFrameId], a
    ld hl, _SCRN0
    ld bc, $400
;clear screen loop
.loop0C92
    call vblankWait
    xor a
    ld [rVBK], a ;vram bank select
    ld [hl], $80
    ld a, $01
    ld [rVBK], a ;vram bank select
    ld [hl], $08
    inc hl
    xor a
    ld [rVBK], a ;vram bank select
    dec bc
    ld a, b
    or a, c
    jr nz, .loop0C92
    ld a, SET_FADE_IN
    ld [wPaletteFadeCounter], a
    xor a
    ld [wDoorAnimationFrameCounter], a
    ld a, [wDoorSpriteId]
    cp a, DOUBLE_DOOR_A
    jp c, loadSingleDoorSprite ; if doorId < DOUBLE_DOOR_A then jump (single door sprite)

loadDoubleDoorSprites:
    call haltCPU
    call hideOAM
    xor a
    ld [wDoorSpritesUsedCounter], a
;
; scale and load left door sprite
;
    ld hl, doorsSpritesheet
    ld a, [wDoorSpriteId]
    and a, $07 ; get door sprite id
; apply door sprite offset
    ld e, a
    add a
    add a, e
    add a, h
    ld h, a
    ldde 48, 4 ; sprite height (48px) and width ID (4: 12px) 
    ldbc 62, 64 ; sprite screen position YX (62, 64)
    ld a, [wDoorAnimationFrameCounter]
    cp a, $08
    jr c, .LabelD05
    ld a, l
    add a, $80
    ld l, a
    ld a, h
    adc a, $01
    ld h, a
    ld e, $08
    ld a, [wDoorAnimationFrameCounter]
    cp a, $10
    jr c, .LabelD05
    sub a, $10
    ld c, a
    ld a, c
    srl a
    add a, d
    ld d, a
    ld a, b
    ld b, a
    ld a, c
    srl a
    srl a
    srl a
    ld c, a
    ld a, $40
    sub a, c
    ld c, a
.LabelD05
    ld a, l
    ld [wDoorSpriteFrameAddress], a
    ld a, h
    ld [wDoorSpriteFrameAddress+1], a
    ld a, d
    ld [wCurrentSpriteHeight], a
    ld a, e
    ld [wCurrentSpriteWidthId], a
    ld a, b
    sub a, e
    ld [wDoorSpriteYPos], a
    ld a, c
    ld [wDoorSpriteXPos], a
    ld a, [wDoorPaletteId]
    ld [wDoorSpritesAttributes], a
    call loadAndScaleDoorSprites
;
; scale and load right door sprites
;
    ld hl, doorsSpritesheet
    ld a, [wDoorSpriteId]
    and a, $07
    ld e, a
    add a
    add a, e
    add a, h
    ld h, a
    ldde 48, 4  ; sprite height (48px) and width ID (4: 12px) 
    ldbc 84, 64 ; sprite screen position YX (84, 64)
    ld a, [wDoorAnimationFrameCounter]
    cp a, $10
    jr c, .LabelD68
    sub a, $10
    ld c, a
    ld a, c
    srl a
    add a, d
    ld d, a
    ld a, c
    srl a
    srl a
    ld e, a
    ld a, $04
    sub a, e
    ld e, a
    cp a, $05
    jr c, .LabelD59
    ld e, $00
.LabelD59
    ld a, b
    add a, c
    ld b, a
    ld a, c
    srl a
    srl a
    srl a
    ld c, a
    ld a, $40
    sub a, c
    ld c, a
.LabelD68
    ld a, l
    ld [wDoorSpriteFrameAddress], a
    ld a, h
    ld [wDoorSpriteFrameAddress+1], a
    ld a, d
    ld [wCurrentSpriteHeight], a
    ld a, e
    ld [wCurrentSpriteWidth], a
    ld a, b
    ld [wDoorSpriteYPos], a
    ld a, c
    ld [wDoorSpriteXPos], a
    ld a, [wDoorPaletteId]
    ld [wDoorSpritesAttributes], a
    call loadAndScaleDoorSprites
;
; transfer both doors sprites tiles from buffer to vram
;
    call enableHDMA
    call swapCurrentOAMBuffer
	;fade-in door
    ld a, [wPaletteFadeCounter]
    or a
    jr z, .LabelD99
    cp a, SET_FADE_IN
    jr c, .LabelDB7
.LabelD99
    ld a, [wDoorAnimationFrameCounter]
    cp a, $1F
    jr c, .LabelDAC
    ld a, [wPaletteFadeCounter]
    cp a, SET_FADE_OUT
    jr nc, .LabelDAC
    ld a, SET_FADE_OUT
    ld [wPaletteFadeCounter], a
.LabelDAC
    ld a, [wDoorAnimationFrameCounter]
    cp a, $2F
    jr nc, .LabelDB7
    inc a
    ld [wDoorAnimationFrameCounter], a
.LabelDB7 ;play open door sound
    ld c, OPEN_DOOR_SFX
    ld a, [wCurrentSoundId]
    cp a, c
    jr z, .LabelDCA
    ld a, [wDoorAnimationFrameCounter]
    cp a, $04
    jr nz, .LabelDCA
    ld a, c
    call playSFX
.LabelDCA
    ld a, [wPaletteFadeCounter]
    cp a, FADE_OUT_FINISHED
    jp z, .LabelDEA
    or a
    jr nz, .LabelDE1
; check animation skip
    ld a, [wButtonPressId]
    and a, SELECT_INPUT
    jr z, .LabelDE1 ; skip door animation
    ld a, SET_FADE_OUT
    ld [wPaletteFadeCounter], a
.LabelDE1
    ld hl, doorsPalette
    call loadBgImagePalette
    jp loadDoubleDoorSprites
.LabelDEA
    ld a, CLOSE_DOOR_SFX
    jp playSFX ; play close door sound and end function
;
loadSingleDoorSprite:
    call haltCPU
    call haltCPU
    call hideOAM
    xor a
    ld [wDoorSpritesUsedCounter], a
    ld hl, doorsSpritesheet
    ld a, [wDoorSpriteId]
    and a, $07
    ld e, a
    add a
    add a, e
    add a, h
    ld h, a
    ldde 48, 4 ; sprite height (48px) and width ID (4: 12px) 
    ldbc 78, 64 ; sprite screen position YX (78, 64)
    ld a, [wDoorAnimationFrameCounter]
    cp a, $08
    jr c, .LabelE3D
    ld a, l
    add a, $80
    ld l, a
    ld a, h
    adc a, $01
    ld h, a
    ld e, $08
    ld a, [wDoorAnimationFrameCounter]
    cp a, $10
    jr c, .LabelE3D
    sub a, $10
    ld c, a
    ld a, c
    srl a
    add a, d
    ld d, a
    ld a, b
    ld b, a
    ld a, c
    srl a
    srl a
    srl a
    ld c, a
    ld a, $40
    sub a, c
    ld c, a
.LabelE3D
    ld a, l
    ld [wDoorSpriteFrameAddress], a
    ld a, h
    ld [wDoorSpriteFrameAddress+1], a
    ld a, d
    ld [wCurrentSpriteHeight], a
    ld a, e
    ld [wCurrentSpriteWidth], a
    ld a, b
    sub a, e
    ld [wDoorSpriteYPos], a
    ld a, c
    ld [wDoorSpriteXPos], a
    ld a, [wDoorPaletteId]
    ld [wDoorSpritesAttributes], a

    call loadAndScaleDoorSprites
    
    call enableHDMA
    call swapCurrentOAMBuffer
    ld a, [wPaletteFadeCounter]
    or a
    jr z, .LabelE6F
    cp a, SET_FADE_IN
    jr c, .LabelE8D
.LabelE6F
    ld a, [wDoorAnimationFrameCounter]
    cp a, $1F
    jr c, .LabelE82
    ld a, [wPaletteFadeCounter]
    cp a, SET_FADE_OUT
    jr nc, .LabelE82
    ld a, SET_FADE_OUT
    ld [wPaletteFadeCounter], a
.LabelE82
    ld a, [wDoorAnimationFrameCounter]
    cp a, $2F
    jr nc, .LabelE8D
    inc a
    ld [wDoorAnimationFrameCounter], a
.LabelE8D
    ld c, OPEN_DOOR_SFX
    ld a, [wCurrentSoundId]
    cp a, c
    jr z, .LabelEA0
    ld a, [wDoorAnimationFrameCounter]
    cp a, $04
    jr nz, .LabelEA0
    ld a, c
    call playSFX
.LabelEA0
    ld a, [wPaletteFadeCounter]
    cp a, FADE_OUT_FINISHED
    jp z, .LabelEC0
    or a
    jr nz, .LabelEB7
    ld a, [wButtonPressId]
    and a, SELECT_INPUT ; skip door animation
    jr z, .LabelEB7
    ld a, SET_FADE_OUT
    ld [wPaletteFadeCounter], a
.LabelEB7
    ld hl, doorsPalette
    call loadBgImagePalette
    jp loadSingleDoorSprite
.LabelEC0
    ld a, CLOSE_DOOR_SFX
    jp playSFX
