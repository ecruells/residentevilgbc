calcSpriteSizeAndScreenPosition:: ;00:094A
    ld a, [wCameraType]
    or a
    jp z, calcFrontSpriteSizeAndScreenPosition


; This routine calculate overhead an entity sprite size and screen viewport 
; postion about the camera position.
; 
; de: sprite data struct pointer (C300)
calcOverheadSpriteSizeAndScreenPosition:
;
; get normalized sprite position vertex from map sprite position
;
; px = x / 8
    push de
    ld hl, wEntityPositionX - wEntityStructData
    add hl, de
    ld e, [hl]
    inc hl ;wEntityPositionX+1
    ld d, [hl]
    call div8Word
    ld a, e
    ld [wSpriteProjectedX], a
    ld a, d
    ld [wSpriteProjectedX+1], a
    pop de
    push de
; px = z / 8
    ld hl, wEntityPositionZ - wEntityStructData
    add hl, de
    ld e, [hl]
    inc hl ;wEntityPositionZ+1
    ld d, [hl]
    call div8Word
    ld a, e
    ld [wSpriteProjectedZ], a
    ld a, d
    ld [wSpriteProjectedZ+1], a
; py = 0 (no elevation)
    ld hl, 0
    ld a, l
    ld [wSpriteProjectedY], a
    ld a, h
    ld [wSpriteProjectedY+1], a
;
; calculate the rotation matrix and projection of the sprite position vertex (px, py, pz)
;
    call calcRotationMatrixAndProjection
;
; store resulting screen XY and ZOrder values
;
; store screen X
    pop de
    ld hl, wEntityScreenX - wEntityStructData
    add hl, de
    ld a, [wSpriteProjectedX]
    ld [hl], a
;
; store screen Y
    ld hl, wEntityScreenY - wEntityStructData
    add hl, de
    ld a, [wSpriteProjectedY]
    ld [hl], a
;
; store zOrder 
    ld hl, wEntityZOrder - wEntityStructData
    add hl, de
    ld a, [wSpriteProjectedZ]
    ld [hl], a
;
; check sprite visibility by zOrder
    ld a, [wSpriteProjectedZ+1]
    or a
    ret nz ; if (zOrder < 0 or zOrder > 255) then return
    ld a, [wSpriteProjectedZ]
    or a
    ret z ; if zOrder == 0 the return
    push de
;
; now, to calculate the sprite size, we must calculate a second sprite vertex by
; applying a "size" offset on the original sprite vertex about XZ plane, then calculate the rotation matrix and
; projection again and get the distance between the current projected screen X and the new one.
;
; get sprite size offset
    ld de, 22 ; size factor
    call getSpriteSizeOffset
;
; apply size factor on X axis
    pop de
    push de
    ld hl, wEntityPositionX - wEntityStructData
    add hl, de
    ld e, [hl]
    inc hl ; wEntityPositionX+1
    ld d, [hl]
    call div8Word
    ld a, [wSpriteXSizeOffset]
    ld l, a
    ld a, [wSpriteXSizeOffset+1]
    ld h, a
    add hl, de
    ld a, l
    ld [wSpriteProjectedX], a
    ld a, h
    ld [wSpriteProjectedX+1], a
;
; apply size factor on Z axis
    pop de
    push de
    ld hl, wEntityPositionZ - wEntityStructData
    add hl, de
    ld e, [hl]
    inc hl ;wEntityPositionZ+1
    ld d, [hl]
    call div8Word
    ld a, [wSpriteZSizeOffset]
    ld l, a
    ld a, [wSpriteZSizeOffset+1]
    ld h, a
    add hl, de
    ld a, l
    ld [wSpriteProjectedZ], a
    ld a, h
    ld [wSpriteProjectedZ+1], a
;
; set Y axis = 0
    ld hl, 0
    ld a, l
    ld [wSpriteProjectedY], a
    ld a, h
    ld [wSpriteProjectedY+1], a

;
; calculate again the rotation matrix and projection with the new offset position
;
    call calcRotationMatrixAndProjection

; now we can calculate the sprite size and final screen XY positions
;
; get width
;
    pop de
    ld a, [wSpriteProjectedX]
    ld c, a
    ld hl, wEntityScreenX - wEntityStructData
    add hl, de
    ld a, [hl] ; get current screenX
    sub a, c ; width = currentScreenX - newScreenX 
;
    ld hl, wEntityWidth - wEntityStructData
    add hl, de
    ld [hl], a ; update width
;
; validate max width
    cp a, 32
    jr c, .LabelA0F
; if width >= 32
    ld a, 31
    ld [hl], a ; update max width
.LabelA0F
    ld hl, wEntityWidth - wEntityStructData
    add hl, de
    ld a, [hl] ; get width
;
; get heigth
;
    ld c, a
    srl a
    add a, c ; height = (width / 2) + width
    ld hl, wEntityHeight - wEntityStructData
    add hl, de
    ld [hl], a ; update height
;
; get screen Y
;
; screenY = currentScreenY - (height / 2)
    srl a
    ld c, a ; height / 2
    ld hl, wEntityScreenY - wEntityStructData
    add hl, de
    ld a, [hl]
    sub a, c
    ld [hl], a ; update screenY
;
; get screen X
;
; screenX = currentScreenX - 16
    ld hl, wEntityScreenX - wEntityStructData
    add hl, de
    ld a, [hl]
    sub a, 16
    ld [hl], a ; update screenX
;
; set sprite visible
    ld a, ENTITY_ENABLED_FLAG | ENTITY_VISIBLE_FLAG
    ld [de], a
    ret


; This routine calculate Sprite size and screen viewport postion about the camera position.
; 
; de: sprite data struct pointer (C300)
calcFrontSpriteSizeAndScreenPosition:: ;00:0A33
;
; get normalized sprite position vertex from map sprite position
;
; px = x / 8
    push de
    ld hl, wEntityPositionX - wEntityStructData
    add hl, de
    ld e, [hl]
    inc hl ; wEntityPositionX+1
    ld d, [hl]
    call div8Word
    ld a, e
    ld [wSpriteProjectedX], a
    ld a, d
    ld [wSpriteProjectedX+1], a
    pop de
; pz = z / 8
    push de
    ld hl, wEntityPositionZ - wEntityStructData
    add hl, de
    ld e, [hl]
    inc hl ; wEntityPositionZ+1
    ld d, [hl]
    call div8Word
    ld a, e
    ld [wSpriteProjectedZ], a
    ld a, d
    ld [wSpriteProjectedZ+1], a
    pop de
; py = y
    push de
    ld hl, wEntityPositionY - wEntityStructData
    add hl, de
    ld a, [hli]
    ld [wSpriteProjectedY], a
    ld a, [hli]
    ld [wSpriteProjectedY+1], a

;
; calculate the rotation matrix and projection of the sprite position vertex (px, py, pz)
;
    call calcRotationMatrixAndProjection


; check sprite visibility based on projected screen X position
    pop de
    ld  a, [wSpriteProjectedX+1]
    or a
    jr z, .LabelA7D
    cp a, 255
    ret nz ; if screenX < -256 or screenX > 255 then return
; if negative
    ld a, [wSpriteProjectedX]
    cp a, -32
    ret c ; if screenX < -32 then return (sprite hide from left border)
    jr .LabelA83
.LabelA7D
    ld a, [wSpriteProjectedX]
    cp a, 168
    ret nc ; if screenX >= 168 then return (sprite hide from right border)
.LabelA83
;
; update screenX
    ld hl, wEntityScreenX - wEntityStructData
    add hl, de
    ld a, [wSpriteProjectedX]
    ld [hl], a


; check sprite visibility based on projected screen Y position
    ld a, [wSpriteProjectedY+1]
    or a
    ret nz ; if (screenY < 0 or screenY > 255) then return
;
; update screenY
    ld hl, wEntityScreenY - wEntityStructData
    add hl, de
    ld a, [wSpriteProjectedY]
    ld [hl], a

; update sprite z-order
    ld hl, wEntityZOrder - wEntityStructData
    add hl, de
    ld a, [wSpriteProjectedZ]
    ld [hl], a
    ld a, [wSpriteProjectedZ+1]
    or a
    ret nz ; if z-order < 0 or > 255 then return
    ld a, [wSpriteProjectedZ]
    or a
    ret z ; if z-order = 0 the return

; now, to calculate the sprite height, we must calculate a second sprite vertex by
; applying a "size" offset on the original sprite vertex about XZ plane, then calculate the rotation matrix and
; projection again and get the distance between the current projected screen X and the new one.
;
;
; check for special sprite sizes factor first, bigger factor means bigger sprite
    ld a, [wCurrentSpriteCharId]
    cp a, RESEARCHER_ROOM_SHELF
    jr z, .setSpriteBigSize
    cp a, ARMORS_ROOM_STATUE_1
    jr z, .setSpriteLittleSize
    cp a, ARMORS_ROOM_STATUE_2
    jr z, .setSpriteLittleSize
    cp a, DORM_003_CLOSET_F1
    jr z, .setSpriteBigSize
    cp a, UNDERGROUND_STATUE
    jr z, .setSpriteLittleSize
    jr .setSpriteNormalSize
.setSpriteBigSize
    push de
    ld de, 152
    call getSpriteSizeOffset
    pop de
    jr .LabelADF
.setSpriteLittleSize
    push de
    ld de, 96
    call getSpriteSizeOffset
    pop de
    jr .LabelADF
.setSpriteNormalSize
    push de
    ld de, 128
    call getSpriteSizeOffset
    pop de
.LabelADF

; get normalized sprite position vertex again, but adding "size" offset to xz plane
;
; px = (x / 8) + XsizeOffset
    push de
    ld hl, wEntityPositionX - wEntityStructData
    add hl, de
    ld e, [hl]
    inc hl ; wEntityPositionX+1
    ld d, [hl]
    call div8Word
    ld a, [wSpriteXSizeOffset]
    ld l, a
    ld a, [wSpriteXSizeOffset+1]
    ld h, a
    add hl, de
    ld a, l
    ld [wSpriteProjectedX], a
    ld a, h
    ld [wSpriteProjectedX+1], a

; pz = (z / 8) + ZsizeOffset 
    pop de
    push de
    ld hl, wEntityPositionZ - wEntityStructData
    add hl, de
    ld e, [hl]
    inc hl ; wEntityPositionZ+1
    ld d, [hl]
    call div8Word
    ld a, [wSpriteZSizeOffset]
    ld l, a
    ld a, [wSpriteZSizeOffset+1]
    ld h, a
    add hl, de
    ld a, l
    ld [wSpriteProjectedZ], a
    ld a, h
    ld [wSpriteProjectedZ+1], a

; py = 0
    ld hl, 0
    ld a, l
    ld [wSpriteProjectedY], a
    ld a, h
    ld [wSpriteProjectedY+1], a

;
; calculate again the rotation matrix and projection with the new offset position
;
    call calcRotationMatrixAndProjection

; now we can calculate the sprite size and final screen XY positions
;
; height = (screenX - newScreenX) / 4
    pop de
    ld a, [wSpriteProjectedX]
    ld c, a
    ld a, [wSpriteProjectedX+1]
    ld b, a
    ld hl, wEntityScreenX - wEntityStructData
    add hl, de
    ld a, [hl] ; get the first screenX calculated
; get the distance between the first screenX and the new one, then divide by 4
    sub a, c
    ld c, a
    ld a, 0
    sbc a, b
    ld b, a
; distance / 4
    srl b
    rr c
    srl b
    rr c
    ld a, c ; height
;
; width = height / 2
    srl a
    ld hl, wEntityWidth - wEntityStructData
    add hl, de
    ld [hl], a ; store sprite width
;
; check max width
;
; if (width >= 32) then width = 31
    cp a, 32
    jr c, .LabelB51
    ld a, 31
    ld [hl], a ;set max width 
;
; check max height
;
; if (height >= 96) then height = 95
.LabelB51
    ld a, c
    cp a, 96
    jr c, .LabelB58
    ld a, 95 ; set max height
.LabelB58
    ld hl, wEntityHeight - wEntityStructData
    add hl, de
    ld [hl], a ; store sprite height
;
; screenY = (newScreenY + 1) - height
    ld c, a
    ld hl, wEntityScreenY - wEntityStructData
    add hl, de
    ld a, [hl]
    inc a
    sub a, c
    ld [hl], a ; store screen Y position
;
; screen X = screenX - 16
    ld hl, wEntityScreenX - wEntityStructData
    add hl, de
    ld a, [hl]
    sub a, 16
    ld [hl], a ; store screen X position
;
; finally, set sprite visible
    ld a, ENTITY_ENABLED_FLAG | ENTITY_VISIBLE_FLAG
    ld [de], a
    ret
;00:0B72


calcAllSpritesSizeAndScreenPosition: ;00:0B72
    ld de, wEntityStructData
    ld b, 8 ; max sprites
loadSpritesDataLoop:
    push bc
    push de
    ld a, [de]
    and a, ENTITY_ENABLED_FLAG
    ld [de], a
    jr z, continueNextSprite ; jump to next if sprite is disabled
    ld hl, wEntityId - wEntityStructData
    add hl, de
    ld a, [hl]
    cp a, ZOMBIE
    jr c, calcCharsSizeAndPosition ; jump if main chars
    cp a, NON_ENEMIES_CHARS
    jr c, calcEnemySizeAndPosition ; jump if chars is a zombie or yawn
    cp a, OBJECTS
    jp nc, calcObjectsSizeAndPosition ; jump is an object
continueNextSprite: ;0B91
    pop de
    pop bc
    ld a, e
    add a, 32 ; next sprite offset
    ld e, a
    ld a, d
    adc a, 00
    ld d, a
    dec b
    jr nz, loadSpritesDataLoop
    ret

calcCharsSizeAndPosition: ;00:0B9F
    ld [wCurrentSpriteCharId], a
    push de
    call calcSpriteSizeAndScreenPosition
    pop de
    ld a, [de]
    and a, ENTITY_VISIBLE_FLAG
    jr z, continueNextSprite ; skip if sprite is not visible
    push de
    call pushSpriteDrawDataInSortedSpritesListCaller
    pop de
; load firegun sprites if enabled
    ld hl, wFiregunFramesId - wEntityStructData
    add hl, de
    ld a, [hl] 
    and a, ENTITY_ENABLED_FLAG ; check firegun enabled flag
    call nz, updateFiregunSpritesCaller
    jr continueNextSprite


calcEnemySizeAndPosition: ;00:0BBD
    ld [wCurrentSpriteCharId], a
    call checkEnemyOnRoomScreenVisibilityCaller
    or a
    jr z, continueNextSprite ; skip to next if enemy is not visible
    call checkBloodFramesIdValue
    push de
    call calcSpriteSizeAndScreenPosition
    pop de
    ld a, [de] ;C3X0
    and a, ENTITY_VISIBLE_FLAG
    jr z, continueNextSprite ; skip to next if enemy is not visible
    push de
    call pushSpriteDrawDataInSortedSpritesListCaller ;0839
    pop de
; load enemy damage blood if enabled
    ld hl, wBloodFramesId - wEntityStructData
    add hl, de
    ld a, [hl]
    and a, ENTITY_ENABLED_FLAG ; check enemy blood enabled flag
    call nz, updateEnemyBloodSpriteCallerCaller
    jr continueNextSprite

calcObjectsSizeAndPosition: ;0BE4
    ld [wCurrentSpriteCharId], a
    call checkObjectOnRoomScreenVisibilityCaller
    or a
    jr z, continueNextSprite ; skip to next if object is not visible
    push de
    call calcSpriteSizeAndScreenPosition
    pop de
    ld a, [de]
    and a, ENTITY_VISIBLE_FLAG
    jr z, continueNextSprite ; skip if not visible
    push de
    call pushSpriteDrawDataInSortedSpritesListCaller
    pop de
    jr continueNextSprite

updateFiregunSpritesCaller: ;00:0BFE
    push de
    call updateFiregunSprites
    pop de
    ret

updateEnemyBloodSpriteCallerCaller: ;00:0C04
    push de
    call updateEnemyBloodSpritesCaller
    pop de
    ret

;0C0A
