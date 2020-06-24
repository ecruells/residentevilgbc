
; substract last two multiply products
;
; de: current multiply result
subMultiplyProducts: ;00:10E9
    push hl
    ld a, [wPrevMultProduct]
    ld l, a
    ld a, [wPrevMultProduct+1]
    ld h, a
    call reverseDESign
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ret

; add last two multiply products
;
; de: current multiply result
addMultiplyProducts: ;00:10FA
    push hl
    ld a, [wPrevMultProduct]
    ld l, a
    ld a, [wPrevMultProduct+1]
    ld h, a
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ret

; Get the sprite XZ position "size" offset, by multiply the size factor by 
; the camera reverse yaw angle, this way, any camera rotation is negated, maintaining
; the offset position distance about the original always the same, only affected by camera distance
; (the closer the camera, the bigger the distance, this way, the sprite height value can be calculated.)
;
; de: sprite size factor
getSpriteSizeOffset:: ;00:1108
    push de
    call getReverseYawSinCosValue
    pop de
    push de
    ld a, [wCameraReverseYawCos]
    ld l, a
    ld h, 0
    call wordAndByteMultiply
    call div64Word ; (spriteSize * cameraYawX) / 64 (fix scale)
    ld a, e
    ld [wSpriteXSizeOffset], a
    ld a, d
    ld [wSpriteXSizeOffset+1], a
    pop de
    ld a, [wCameraReverseYawSin]
    ld l, a
    ld h, 0
    call wordAndByteMultiply
    call div64Word ; (spriteSize * cameraYawY) / 64 (fix scale)
    ld a, e
    ld [wSpriteZSizeOffset], a
    ld a, d
    ld [wSpriteZSizeOffset+1], a
    ret

; get the sin/cos values of camera pitch and yaw values, then get axes scale factors
;
getCameraAnglesSinCosValues:: ;00:1138
    ld a, BANK(sineLookUpTable)
    call bankSwitch
    ld de, sineLookUpTable
; 0000 pitchSin
; 1024 pitchCos
; 2048 yawSin
; 3072 yawCos
;
; get camera yaw sin/cos
    ld a, [wCameraYawAngle]
    ld l, a
    ld a, [wCameraYawAngle+1]
; for some reason, yaw angles are offset by 2048 degrees before get sin/cos values
    add a, $08 ; 2048 steps offset
    and a, $0F
    add a, d
    ld h, a
    ld a, [hl] ; sin(yaw+2048)
    ld [wCameraYawSin], a
    ld a, h
    sub a, d ; reset offset
    add a, $04 ; 1024 steps offset to get cos values from 2048 (3072)
    and a, $0F
    add a, d
    ld h, a
    ld a, [hl] ; cos(yaw+2048)
    ld [wCameraYawCos], a
;
; get camera pitch sin/cos
    ld a, [wCameraPitchAngle]
    ld l, a
    ld a, [wCameraPitchAngle+1]
    add a, d
    ld h, a
    ld a, [hl] ; sin(pitch)
    ld [wCameraPitchSine], a
    ld a, h
    sub a, d
    add a, $04 ; 1024 steps offset to get cos values
    and a, $0F
    add a, d
    ld h, a
    ld a, [hl] ; cos(pitch) 
    ld [wCameraPitchCos], a
    ld a, $01
    call bankSwitch
; get axes scale factors
    jp getAxesScaleFactors


getReverseYawSinCosValue:: ;00:117E
    ld a, [wCameraYawAngle]
    ld e, a
    ld a, [wCameraYawAngle+1]
    ld d, a
    call reverseDESign ; revert yaw angle sign
    ld l, e
    ld h, d
    ld a, BANK(sineLookUpTable)
    call bankSwitch
    ld de, sineLookUpTable
    ld a, h
    and a, $0F ; mask address
    add a, d ; add offset
    ld h, a
    ld a, [hl] ; sin(-yaw)
    ld [wCameraReverseYawSin], a
    ld a, h
    sub a, d
    add a, $04 ; 1024 steps offset to get cos values
    and a, $0F
    add a, d
    ld h, a
    ld a, [hl] ; cos(-yaw)
    ld [wCameraReverseYawCos], a
    ld a, $01
    jp bankSwitch