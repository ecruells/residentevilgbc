calcSpriteSizeAndPosition:: ;00:094A
    ld a, [wCameraType]
    or a
    jp z, calcNormalCameraSpriteSizeAndPosition

calcOverheadCameraSpriteSizeAndPosition:
;de: sprite data struct pointer (C300)
    push de
;store sprite pos x to screen pos x
    ld hl, wSpritePositionXLow - wCharSpritesData ;$11
    add hl, de
    ld e, [hl]
    inc hl ;wSpritePositionXHigh
    ld d, [hl]
    call div8SignedWord
    ld a, e
    ld [wCalcSpriteScreenPosXLow], a
    ld a, d
    ld [wCalcSpriteScreenPosXHigh], a
    pop de
    push de
;store sprite pos z to screen pos z
    ld hl, wSpritePositionZLow - wCharSpritesData ;$13
    add hl, de
    ld e, [hl]
    inc hl ;wSpritePositionZHigh
    ld d, [hl]
    call div8SignedWord
    ld a, e
    ld [wCalcSpriteZOrderLow], a
    ld a, d
    ld [wCalcSpriteZOrderHigh], a
;reset sprite pos Y (no elevation)
    ld hl, $0000
    ld a, l
    ld [wCalcSpriteScreenPosYLow], a
    ld a, h
    ld [wCalcSpriteScreenPosYHigh], a
;calc size & position
    call calcSpritePos
    pop de
;update scrn pos X
    ld hl, wSpriteScreenPosX - wCharSpritesData ;$0002
    add hl, de
    ld a, [wCalcSpriteScreenPosXLow]
    ld [hl], a
;update scrn pos Y
    ld hl, wSpriteScreenPosY - wCharSpritesData ;$3
    add hl, de
    ld a, [wCalcSpriteScreenPosYLow]
    ld [hl], a
;update z-order value
    ld hl, wSpriteZOrder - wCharSpritesData ;$1
    add hl, de
    ld a, [wCalcSpriteZOrderLow]
    ld [hl], a
    ld a, [wCalcSpriteZOrderHigh]
    or a
    ret nz ;return if z-order < 0 or > 255
    ld a, [wCalcSpriteZOrderLow]
    or a
    ret z ;return if z-order is zero
    push de
;set overhead sprite base size
    ld de, $16
    call setSpriteBaseSize
;-----------------------------
    pop de
    push de
    ld hl, wSpritePositionXLow - wCharSpritesData ;$11
    add hl, de
    ld e, [hl]
    inc hl ;wSpritePositionXHigh
    ld d, [hl]
    call div8SignedWord
    ld a, [wSpritePosXYCamYawDiffLow]
    ld l, a
    ld a, [wSpritePosXYCamYawDiffHigh]
    ld h, a
    add hl, de
    ld a, l
    ld [wCalcSpriteScreenPosXLow], a
    ld a, h
    ld [wCalcSpriteScreenPosXHigh], a
    pop de
    push de
    ld hl, wSpritePositionZLow - wCharSpritesData ;$13
    add hl, de
    ld e, [hl]
    inc hl ;wSpritePositionZHigh
    ld d, [hl]
    call div8SignedWord
    ld a, [wSpritePosXYCamYawSumLow]
    ld l, a
    ld a, [wSpritePosXYCamYawSumHigh]
    ld h, a
    add hl, de
    ld a, l
    ld [wCalcSpriteZOrderLow], a
    ld a, h
    ld [wCalcSpriteZOrderHigh], a
    ld hl, $0000 ;reset screen pos Y
    ld a, l
    ld [wCalcSpriteScreenPosYLow], a
    ld a, h
    ld [wCalcSpriteScreenPosYHigh], a
;recalculate size & pos
    call calcSpritePos
    pop de
    ld a, [wCalcSpriteScreenPosXLow]
    ld c, a
    ld hl, wSpriteScreenPosX - wCharSpritesData ;$2
    add hl, de
    ld a, [hl] ;get current scrn pos X
;get current sprite pos x and size pos x diff
    sub a, c
    ld hl, wSpriteWidth - wCharSpritesData ;$4
    add hl, de
    ld [hl], a ;set sprite width
    cp a, $20
    jr c, .LabelA0F
    ld a, $1F
    ld [hl], a ;set max width
.LabelA0F
    ld hl, wSpriteWidth - wCharSpritesData ;$4
    add hl, de
    ld a, [hl] ;get width
    ld c, a
    srl a
    add a, c ;height = (width / 2) + width
    ld hl, wSpriteHeight - wCharSpritesData ;$5
    add hl, de
    ld [hl], a ;set height
    srl a
    ld c, a ;height / 2
    ld hl, wSpriteScreenPosY - wCharSpritesData ;$3
    add hl, de
    ld a, [hl]
    sub a, c
    ld [hl], a ;posY = posY - (height / 2)
    ld hl, wSpriteScreenPosX - wCharSpritesData ;$2
    add hl, de
    ld a, [hl]
    sub a, $10
    ld [hl], a ;substract $10 to final pos X
    ld a, %11000000 ;$C0
    ld [de], a ;return enable & visible sprite bits
    ret

calcNormalCameraSpriteSizeAndPosition:: ;00:0A33 normal camera scaling
;de: sprite data struct pointer (C300)
    push de
;get sprite x position
    ld hl, wSpritePositionXLow - wCharSpritesData ;$11
    add hl, de
    ld e, [hl]
    inc hl ;wSpritePositionXHigh
    ld d, [hl]
    call div8SignedWord
    ld a, e
    ld [wCalcSpriteScreenPosXLow], a
    ld a, d
    ld [wCalcSpriteScreenPosXHigh], a
    pop de
;get sprite y position
    push de
    ld hl, wSpritePositionZLow - wCharSpritesData ;$13
    add hl, de
    ld e, [hl]
    inc hl ;wSpritePositionZHigh
    ld d, [hl]
    call div8SignedWord
    ld a, e
    ld [wCalcSpriteZOrderLow], a
    ld a, d
    ld [wCalcSpriteZOrderHigh], a
    pop de
;get sprite z position
    push de
    ld hl, wSpritePositionYLow - wCharSpritesData ;$19
    add hl, de
    ld a, [hli]
    ld [wCalcSpriteScreenPosYLow], a
    ld a, [hli]
    ld [wCalcSpriteScreenPosYHigh], a
;calc sprite camera position
    call calcSpritePos
    pop de
    ld a, [wCalcSpriteScreenPosXHigh]
    or a
    jr z, .LabelA7D ;
    cp a, $FF
    ret nz ;return if posX < -256 or > 255
;if negative
    ld a, [wCalcSpriteScreenPosXLow]
    cp a, $E0
    ret c ;return if pos < -32 (sprite hide from left border)
    jr .LabelA83
.LabelA7D
    ld a, [wCalcSpriteScreenPosXLow]
    cp a, $A8
    ret nc ;return if posX >= 168 (sprite hide from right border)
.LabelA83
    ld hl, wSpriteScreenPosX - wCharSpritesData ;$2
    add hl, de
    ld a, [wCalcSpriteScreenPosXLow]
    ld [hl], a ;update sprite screen pos x
;----------------
    ld a, [wCalcSpriteScreenPosYHigh]
    or a
    ret nz ;return if screen pos Y < 0 or > 255
    ld hl, wSpriteScreenPosY - wCharSpritesData ;$3
    add hl, de
    ld a, [wCalcSpriteScreenPosYLow]
    ld [hl], a ;update sprite screen pos y
;----------------
    ld hl, wSpriteZOrder - wCharSpritesData ;$1
    add hl, de
    ld a, [wCalcSpriteZOrderLow]
    ld [hl], a ;update sprite z order
    ld a, [wCalcSpriteZOrderHigh]
    or a
    ret nz ;return if z-order < 0 or > 255
    ld a, [wCalcSpriteZOrderLow]
    or a
    ret z ;return if z-order = 0
    ld a, [wSpriteIdBuffer]
    cp a, RESEARCHER_ROOM_SHELF ;$E6
    jr z, setSpriteBigSize
    cp a, ARMORS_ROOM_STATUE_1 ;$E7
    jr z, setSpriteLittleSize
    cp a, ARMORS_ROOM_STATUE_2
    jr z, setSpriteLittleSize
    cp a, DORM_003_CLOSET_F1 ;$EA
    jr z, setSpriteBigSize
    cp a, UNDERGROUND_STATUE ;$ED
    jr z, setSpriteLittleSize
    jr setSpriteNormalSize
setSpriteBigSize
    push de
    ld de, $0098
    call setSpriteBaseSize
    pop de
    jr LabelADF
setSpriteLittleSize
    push de
    ld de, $0060
    call setSpriteBaseSize
    pop de
    jr LabelADF
setSpriteNormalSize
    push de
    ld de, $0080
    call setSpriteBaseSize
    pop de
LabelADF
    push de
    ld hl, wSpritePositionXLow - wCharSpritesData ;$0011
    add hl, de
    ld e, [hl]
    inc hl ; wSpritePositionXHigh
    ld d, [hl]
    call div8SignedWord
    ld a, [wSpritePosXYCamYawDiffLow]
    ld l, a
    ld a, [wSpritePosXYCamYawDiffHigh]
    ld h, a
    add hl, de ;sprite posX + SpritePosXYCamYawDiff
    ld a, l
    ld [wCalcSpriteScreenPosXLow], a ;apply sprite size x
    ld a, h
    ld [wCalcSpriteScreenPosXHigh], a
    pop de
    push de
    ld hl, wSpritePositionZLow - wCharSpritesData ;$13
    add hl, de
    ld e, [hl]
    inc hl ;wSpritePositionZHigh
    ld d, [hl]
    call div8SignedWord
    ld a, [wSpritePosXYCamYawSumLow]
    ld l, a
    ld a, [wSpritePosXYCamYawSumHigh]
    ld h, a
    add hl, de ;sprite posY + SpritePosXYCamYawSum
    ld a, l
    ld [wCalcSpriteZOrderLow], a ;apply sprite size y
    ld a, h
    ld [wCalcSpriteZOrderHigh], a
    ld hl, $0000
    ld a, l
    ld [wCalcSpriteScreenPosYLow], a
    ld a, h
    ld [wCalcSpriteScreenPosYHigh], a
;recalculate
    call calcSpritePos
    pop de
    ld a, [wCalcSpriteScreenPosXLow]
    ld c, a
    ld a, [wCalcSpriteScreenPosXHigh]
    ld b, a
    ld hl, wSpriteScreenPosX - wCharSpritesData ;$0002
    add hl, de
    ld a, [hl]
;get current sprite pos x and size pos x diff
    sub a, c
    ld c, a
    ld a, $00
    sbc a, b
    ld b, a
;div pos x diff by 4
    srl b
    rr c
    srl b
    rr c
    ld a, c ;get height
;div height by 2
    srl a
    ld hl, wSpriteWidth - wCharSpritesData ;$0004
    add hl, de
    ld [hl], a ;set sprite width
    cp a, $20
    jr c, LabelB51
    ld a, $1F
    ld [hl], a ;set max width
LabelB51
    ld a, c
    cp a, $60
    jr c, LabelB58
    ld a, $5F ;set max height
LabelB58
    ld hl, wSpriteHeight - wCharSpritesData ;$0005
    add hl, de
    ld [hl], a ;set sprite height
    ld c, a
    ld hl, wSpriteScreenPosY - wCharSpritesData ;$0003
    add hl, de
    ld a, [hl]
    inc a
    sub a, c ;(posy + 1) - height
    ld [hl], a ;set final screen pos y
    ld hl, wSpriteScreenPosX - wCharSpritesData ;$0002
    add hl, de
    ld a, [hl]
    sub a, $10
    ld [hl], a ;substract $10 to final pos X
    ld a, %11000000 ;$C0
    ld [de], a ;return enable & visible sprite bits
    ret
;00:0B72



calcSpritesSizeAndPosition: ;00:0B72
    ld de, wCharSpritesData
    ld b, $08 ;sprites count
loadSpritesDataLoop
    push bc
    push de
    ld a, [de]
    and a, %10000000 ;$80 hide sprite
    ld [de], a
    jr z, continueNextSprite ;jump to next if sprite is disabled
    ld hl, wSpriteId - wCharSpritesData ;$000B
    add hl, de
    ld a, [hl]
    cp a, ZOMBIE
    jr c, calcCharsSizeAndPosition ; jump if main chars
    cp a, $A8
    jr c, calcFoesSizeAndPosition ; jump if chars is a zombie or yawn
    cp a, OBJECTS
    jp nc, calcObjectsSizeAndPosition ; jump is a movable object
continueNextSprite: ;0B91
    pop de
    pop bc
    ld a, e
    add a, $20 ; next sprite offset
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    dec b
    jr nz, loadSpritesDataLoop
    ret

calcCharsSizeAndPosition: ;00:0B9F
    ld [wSpriteIdBuffer], a
    push de
    call calcSpriteSizeAndPosition
    pop de
    ld a, [de] ;get sprite enable bits
    and a, %01000000 ;$40 ;mask with sprite visible bit
    jr z, continueNextSprite ;skip if sprite is disabled or not visible
    push de
    call goToLoadSprtPriorityData
    pop de
    ld hl, wFiregunFramesId - wCharSpritesData ;$C
    add hl, de
    ld a, [hl]
    and a, %10000000 ;$80
    call nz, LabelBFE ;call if sprite enabled
    jr continueNextSprite

calcFoesSizeAndPosition: ;00:0BBD
    ld [wSpriteIdBuffer], a
    call goToCheckZombieVisibility ;0933
    or a
    jr z, continueNextSprite ; jump if $00
    call checkBloodFramesIdValue
    push de
    call calcSpriteSizeAndPosition
    pop de
    ld a, [de] ;C3x0
    and a, %01000000 ;$40 check if hidden
    jr z, continueNextSprite ;to next sprt if char is hidden
    push de
    call goToLoadSprtPriorityData ;0839
    pop de
    ld hl, wBloodFramesId - wCharSpritesData ;$D
    add hl, de
    ld a, [hl]
    and a, $80
    call nz, LabelC04
    jr continueNextSprite

calcObjectsSizeAndPosition: ;0BE4
    ld [wSpriteIdBuffer], a
    call goToCheckObjVisibility
    or a
    jr z, continueNextSprite ;next sprite if $00 (not visible)
    push de
    call calcSpriteSizeAndPosition
    pop de
    ld a, [de]
    and a, %01000000 ;$40
    jr z, continueNextSprite
    push de
    call goToLoadSprtPriorityData
    pop de
    jr continueNextSprite

LabelBFE: ;00:0BFE
    push de
    call loadFiregunSprite ;11B3
    pop de
    ret

LabelC04: ;00:0C04
    push de
    call goToLoadEnemyBloodSprt
    pop de
    ret

;0C0A
