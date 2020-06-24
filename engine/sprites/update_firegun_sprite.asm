; hl: firegun frame id
; de: entity (who fired the gun) struct pointer ($c3x0)
updateFiregunSprites: ;00:11B3
    push bc
    push de
    push hl
    ld a, [wLastSpriteInSortedSpritesList]
    ld l, a
    ld a, [wLastSpriteInSortedSpritesList+1]
    ld h, a
    inc de ; sprite z-order value
    ld a, [de]
    ld [hl], a ; set firegun z-order the same as entity sprite's
    inc hl
    inc de
    push de
    ld de, loadFiregunSpriteTilesOAM
    ld [hl], e
    inc hl
    ld [hl], d
    inc hl
    pop de ; C3x2
    ld a, [de]
    ld [hl], a ; sprite screen x pos
    inc hl
    inc de ; C3x3
    ld a, [de]
    ld [hl], a ; sprite screen y pos
    inc hl
    inc de ; C3x4
    ld a, 8
    ld [hl], a ; firegun width
    inc hl
    inc de ; C3x5
    ld a, 16
    ld [hl], a ; firegun height
    inc hl
    ld a, e
    add a, 4 ; offset to sprite facing
    ld e, a
    ld a, d
    adc a, 0
    ld d, a
    ld a, [de] ; C3x9
    ld [hl], a ; set sprite facing
    ld c, a ; store facing in c
    inc hl
    ld a, e
    add a, 3 ; offset to firegun frame id
    ld e, a
    ld a, d
    adc a, 0
    ld d, a
    ld a, [de]
    ld [hl], a ; firegun frame id
    inc hl
    ld [hl], 0 ; firegun animation id
    inc hl
    ld [hl], 0 ; disable last sprite in sorted list
    ld a, l
    ld [wLastSpriteInSortedSpritesList], a
    ld a, h
    ld [wLastSpriteInSortedSpritesList+1], a
    pop hl ; firegun frame id
    pop de ; entity struct pointer $C3x0
    push hl
    ld hl, handgunFiregunOffsetValues
    ld a, [wEntityAnimationId]
    cp a, GUN_AIM_ANIM
    jr z, .calcFiregunFacing
; is firing the shotgun
    ld hl, shotgunFiregunOffsetValues
.calcFiregunFacing
    ld a, [wCameraFacing]
    ld b, a
    ld a, c ; firegun facing id
; get normalized firegun facing, so that when sprite facing is directly in
; front to the camera, the facing value is always north ($00)
    add a, b
    and a, $1F
    srl a
    srl a
    add a
    add a  ; ((camF + sprtF) & $1F) / 4 * 4
    add a, l ; apply facing offset
    ld l, a
    ld a, 0
    adc a, h
    ld h, a
    ld c, [hl]
    inc hl
    ld b, [hl] ; bc: firegun xpos offset
    inc hl
; calculate firegun x offset in proportion with the entity sprite width
    push hl
    push de
    ld hl, wEntityWidth - wEntityStructData
    add hl, de
    ld l, [hl] ; get entity sprite width
    ld h, $00
    ld e, c
    ld d, b
    call wordAndByteMultiply
    ld bc, 32
    call wordDivision ; (xPosOffset * width) / 32
    ld c, e
    pop de
    ld hl, wEntityScreenX - wEntityStructData
    add hl, de
    ld a, [hl]
    add a, 12
    add a, c ; scrnX + 12 + offset
    ld c, a
    ld a, [wLastSpriteInSortedSpritesList]
    sub a, 7
    ld l, a
    ld a, [wLastSpriteInSortedSpritesList+1]
    sbc a, 0
    ld h, a
    ld [hl], c ; update firegun screen x
;
; update firegun z-order
    pop hl
    ld c, [hl] ; get z-order offset (0: in front, -1: behind)
    ld a, [wLastSpriteInSortedSpritesList]
    sub a, 10
    ld l, a
    ld a, [wLastSpriteInSortedSpritesList+1]
    sbc a, $00
    ld h, a
    ld a, [hl]
    add a, c
    ld [hl], a ; update firegun z-order value
; check aim height position (if entity is aiming down, front or up) and update
; firegun screen Y position
    push de
    ld hl, wEntityHeight - wEntityStructData
    add hl, de
    ld l, [hl]
    ld h, 0
    ld a, [wEntityAnimationId]
    cp a, GUN_AIM_ANIM
    jr z, .checkHandgunAimYOffset
; check shotgun aim y-offset
    ld de, 12 ; front aim y-offset
    ld a, [wButtonPressId]
    and a, UP_INPUT
    jr nz, .calcFiregunYOffset
    ld de, 19 ; up aim y-offset
    ld a, [wButtonPressId]
    and a, DOWN_INPUT
    jr z, .calcFiregunYOffset
    ld de, 29 ; down aim y-offset
    jr .calcFiregunYOffset
.checkHandgunAimYOffset
    ld de, 0 ; front aim y-offset
    ld a, [wButtonPressId]
    and a, UP_INPUT
    jr nz, .calcFiregunYOffset
    ld de, 10 ; up aim y-offset
    ld a, [wButtonPressId]
    and a, DOWN_INPUT
    jr z, .calcFiregunYOffset
    ld de, 19 ; down aim y-offset
.calcFiregunYOffset
; calculate firegun Y offset in proportion with the entity sprite height
    call wordAndByteMultiply
    ld bc, 48
    call wordDivision
    ld c, e ; (yOffset * height) / 48
    pop de
    ld hl, wEntityScreenY - wEntityStructData
    add hl, de
    ld a, [hl]
    sub a, 8
    add a, c ; scrnY + 8 + offset
    ld c, a
    ld a, [wLastSpriteInSortedSpritesList]
    sub a, 6
    ld l, a
    ld a, [wLastSpriteInSortedSpritesList+1]
    sbc a, 0
    ld h, a
    ld [hl], c ; update firegun screen y
    pop hl
    pop bc
    ret
;12C9

handgunFiregunOffsetValues: ;12C9
; x-offset, z-order offset
	dw  -7, -1   ; north
	dw   7, -1   ; north-west
	dw  12,  0   ; west
	dw  12,  1   ; south-west
	dw   7,  1   ; south
	dw -10,  1   ; south-east
	dw -13,  0   ; east
	dw -14, -1   ; north-east

shotgunFiregunOffsetValues: ;12E9
	dw  -7, -1
	dw  11, -1
	dw  14,  0
	dw  12,  1
	dw   7,  1
	dw -10,  1
	dw -16,  0
	dw -14, -1
;1309
