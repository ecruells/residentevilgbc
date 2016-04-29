
calcSpritePos:: ;00:0EC5
;apply camera xpos to sprite xpos
    ld a, [wCameraXAxisLowByte]
    ld e, a
    ld a, [wCameraXAxisHighByte]
    ld d, a
    ld a, [wCalcSpriteScreenPosXLow]
    ld l, a
    ld a, [wCalcSpriteScreenPosXHigh]
    ld h, a
    add hl, de ;apply offset
    ld a, l
    ld [wCalcSpriteScreenPosXLow], a
    ld [wSpriteLowPosXCamX], a
    ld a, h
    ld [wCalcSpriteScreenPosXHigh], a
    ld [wSpriteHighPosXCamX], a
;apply camera zpos to sprite zpos
    ld a, [wCameraZAxisLowByte]
    ld e, a
    ld a, [wCameraZAxisHighByte]
    ld d, a
    ld a, [wCalcSpriteScreenPosYLow]
    ld l, a
    ld a, [wCalcSpriteScreenPosYHigh]
    ld h, a
    add hl, de ; apply offset
    ld e, l
    ld d, h
    call reverseDESign ;reverse posZ sign
    ld a, e
    ld [wCalcSpriteScreenPosYLow], a
    ld [wSpriteLowPosZcamZ], a
    ld a, d
    ld [wCalcSpriteScreenPosYHigh], a
    ld [wSpriteHighPosZcamZ], a
;apply camera ypos to sprite ypos
    ld a, [wCameraYAxisLowByte]
    ld e, a
    ld a, [wCameraYAxisHighByte]
    ld d, a
    ld a, [wCalcSpriteZOrderLow]
    ld l, a
    ld a, [wCalcSpriteZOrderHigh]
    ld h, a
    add hl, de ;apply offset
    ld a, l
    ld [wCalcSpriteZOrderLow], a
    ld [wSpriteLowPosYCamY], a
    ld a, h
    ld [wCalcSpriteZOrderHigh], a
    ld [wSpriteHighPosYCamY], a
;multiply camera yaw X with sprite xpos
    ld a, [wCalcSpriteScreenPosXLow]
    ld e, a
    ld a, [wCalcSpriteScreenPosXHigh]
    ld d, a
    ld a, [wCameraYawX]
    ld l, a
    ld h, $00
    call wordMultiply
    ld a, e
    ld [wMultiplyLastProductLow], a
    ld a, d
    ld [wMultiplyLastProductHigh], a
;multiply camera yaw Y with sprite ypos
    ld a, [wCalcSpriteZOrderLow]
    ld e, a
    ld a, [wCalcSpriteZOrderHigh]
    ld d, a
    ld a, [wCameraYawY]
    ld l, a
    ld h, $00
    call wordMultiply
;get difference between yaw x & y
    call multiplyProductsSub
    call div16SignedWord
    ld a, e
    ld [wSpritePosXYCamYawDiffLow], a
    ld a, d
    ld [wSpritePosXYCamYawDiffHigh], a
;store sprite posz copy
    ld a, [wCalcSpriteScreenPosYLow]
    ld [wCalcSpriteScreenPosYLow2], a
    ld a, [wCalcSpriteScreenPosYHigh]
    ld [wCalcSpriteScreenPosYHigh2], a
;(sprite x-pos * cam yaw y)
    ld a, [wCalcSpriteScreenPosXLow]
    ld e, a
    ld a, [wCalcSpriteScreenPosXHigh]
    ld d, a
    ld a, [wCameraYawY]
    ld l, a
    ld h, $00
    call wordMultiply
    ld a, e
    ld [wMultiplyLastProductLow], a
    ld a, d
    ld [wMultiplyLastProductHigh], a
;(sprite y-pos * cam yaw x)
    ld a, [wCalcSpriteZOrderLow]
    ld e, a
    ld a, [wCalcSpriteZOrderHigh]
    ld d, a
    ld a, [wCameraYawX]
    ld l, a
    ld h, $00
    call wordMultiply
;get cam yaw sum
    call multiplyProductsAdd
    call div64signedWord
    ld a, e
    ld [wSpritePosXYCamYawSumLow], a
    ld a, d
    ld [wSpritePosXYCamYawSumHigh], a
;update sprite pos x with cam yaw diff
    ld a, [wSpritePosXYCamYawDiffLow]
    ld [wCalcSpriteScreenPosXLow], a
    ld a, [wSpritePosXYCamYawDiffHigh]
    ld [wCalcSpriteScreenPosXHigh], a
;(sprite z-pos * cam pitch x)
    ld a, [wCalcSpriteScreenPosYLow2]
    ld e, a
    ld a, [wCalcSpriteScreenPosYHigh2]
    ld d, a
    ld a, [wCameraPitchX]
    ld l, a
    ld h, $00
    call wordMultiply
    ld a, e
    ld [wMultiplyLastProductLow], a
    ld a, d
    ld [wMultiplyLastProductHigh], a
;(spriteCamYawSum * cam pitch y)
    ld a, [wSpritePosXYCamYawSumLow]
    ld e, a
    ld a, [wSpritePosXYCamYawSumHigh]
    ld d, a
    ld a, [wCameraPitchY]
    ld l, a
    ld h, $00
    call wordMultiply
    call multiplyProductsSub
    call div64signedWord
;update sprite y-pos with cam yawn & z-pitch
    ld a, e
    ld [wCalcSpriteZOrderLow], a
    ld a, d
    ld [wCalcSpriteZOrderHigh], a
;(sprite z-pos * cam pitch y)
    ld a, [wCalcSpriteScreenPosYLow2]
    ld e, a
    ld a, [wCalcSpriteScreenPosYHigh2]
    ld d, a
    ld a, [wCameraPitchY]
    ld l, a
    ld h, $00
    call wordMultiply
    ld a, e
    ld [wMultiplyLastProductLow], a
    ld a, d
    ld [wMultiplyLastProductHigh], a
;(spriteCamYawSum * cam pitch x)
    ld a, [wSpritePosXYCamYawSumLow]
    ld e, a
    ld a, [wSpritePosXYCamYawSumHigh]
    ld d, a
    ld a, [wCameraPitchX]
    ld l, a
    ld h, $00
    call wordMultiply
    call multiplyProductsAdd
    call div16SignedWord
    ld a, e
    ld [wCalcSpriteScreenPosYLow], a
    ld a, d
    ld [wCalcSpriteScreenPosYHigh], a
;--------------------
;add camera x padding
    ld a, [wCameraXPaddingLowByte]
    ld l, a
    ld a, [wCameraXPaddingHighByte]
    ld h, a
    ld a, [wCalcSpriteScreenPosXLow]
    ld e, a
    ld a, [wCalcSpriteScreenPosXHigh]
    ld d, a
    add hl, de
    ld a, l
    ld [wCalcSpriteScreenPosXLow], a
    ld a, h
    ld [wCalcSpriteScreenPosXHigh], a
;add camerra z padding
    ld a, [wCameraZPaddingLowByte]
    ld l, a
    ld a, [wCameraZPaddingHighByte]
    ld h, a
    ld a, [wCalcSpriteScreenPosYLow]
    ld e, a
    ld a, [wCalcSpriteScreenPosYHigh]
    ld d, a
    add hl, de
    ld a, l
    ld [wCalcSpriteScreenPosYLow], a
    ld a, h
    ld [wCalcSpriteScreenPosYHigh], a
;add camerra y padding
    ld a, [wCameraYPaddingLowByte]
    ld l, a
    ld a, [wCameraYPaddingHighByte]
    ld h, a
    ld a, [wCalcSpriteZOrderLow]
    ld e, a
    ld a, [wCalcSpriteZOrderHigh]
    ld d, a
    add hl, de
    ld a, l
    ld [wCalcSpriteZOrderLow], a
    ld a, h
    ld [wCalcSpriteZOrderHigh], a
;div sprite x-pos by 4
    ld hl, wCalcSpriteScreenPosXLow
    call div4WordVariable
;div sprite z-pos by 4
    ld hl, wCalcSpriteScreenPosYLow
    call div4WordVariable
;add base sprite y scale
    ld a, [wCalcSpriteZOrderLow]
    ld e, a
    ld a, [wCalcSpriteZOrderHigh]
    ld d, a
    ld a, [wSpriteBaseYScaleLow]
    ld l, a
    ld a, [wSpriteBaseYScaleHigh]
    ld h, a
    call wordMultiply
    call div128signedWord
    ld a, e
    ld [wCalcSpriteZOrderLow], a
    ld a, d
    ld [wCalcSpriteZOrderHigh], a
;add base sprite x scale
    ld a, [wCalcSpriteScreenPosXLow]
    ld e, a
    ld a, [wCalcSpriteScreenPosXHigh]
    ld d, a
    ld a, [wSpriteBaseXScaleLow]
    ld l, a
    ld a, [wSpriteBaseXScaleHigh]
    ld h, a
    call wordMultiply ;spriteposX * spritebaseXscale
    ld a, [wCalcSpriteZOrderLow]
    ld c, a
    ld a, [wCalcSpriteZOrderHigh]
    ld b, a
    call wordDivision ;(spriteposX * spritebaseXscale) / spriteposY
    ld a, e
    add a, $58
    ld [wCalcSpriteScreenPosXLow], a
    ld a, d
    adc a, $00
    ld [wCalcSpriteScreenPosXHigh], a
;add base sprite z scale
    ld a, [wCalcSpriteScreenPosYLow]
    ld e, a
    ld a, [wCalcSpriteScreenPosYHigh]
    ld d, a
    ld a, [wSpriteBaseZScaleLow]
    ld l, a
    ld a, [wSpriteBaseZScaleHigh]
    ld h, a
    call wordMultiply  ;spriteposZ * spritebaseZscale
    ld a, [wCalcSpriteZOrderLow]
    ld c, a
    ld a, [wCalcSpriteZOrderHigh]
    ld b, a
    call wordDivision ;(spriteposZ * spritebaseZscale) / spriteposY
    ld a, e
    add a, $50
    ld [wCalcSpriteScreenPosYLow], a
    ld a, d
    adc a, $00
    ld [wCalcSpriteScreenPosYHigh], a
    ret

multiplyProductsSub: ;00:10E9
;substract last two multiply products
;hl: last multiply product
;de: current multiply product
    push hl
    ld a, [wMultiplyLastProductLow]
    ld l, a
    ld a, [wMultiplyLastProductHigh]
    ld h, a
    call reverseDESign
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ret

multiplyProductsAdd: ;00:10FA
;add last two multiply products
;hl: last multiply product
;de: current multiply product
    push hl
    ld a, [wMultiplyLastProductLow]
    ld l, a
    ld a, [wMultiplyLastProductHigh]
    ld h, a
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ret

setSpriteBaseSize:: ;00:1108
;de: sprite size value
    push de
    call getSpriteScaleData
    pop de
    push de
    ld a, [wSpriteScaleValueB]
    ld l, a
    ld h, $00
    call wordMultiply
    call div64signedWord ;(spriteSize * cameraYawX) / 64
    ld a, e
    ld [wSpritePosXYCamYawDiffLow], a
    ld a, d
    ld [wSpritePosXYCamYawDiffHigh], a
    pop de
    ld a, [wSpriteScaleValueA]
    ld l, a
    ld h, $00
    call wordMultiply
    call div64signedWord ;(spriteSize * cameraYawY) / 64
    ld a, e
    ld [wSpritePosXYCamYawSumLow], a
    ld a, d
    ld [wSpritePosXYCamYawSumHigh], a
    ret

getCameraPitchYaw:: ;00:1138
    ld a, BANK(cameraPitchYawTable) ;$0B
    call BankSwitch
    ld de, cameraPitchYawTable ;$4000
;get camera yaw
    ld a, [wCameraYawAddrLow]
    ld l, a
    ld a, [wCameraYawAddrHigh]
    add a, $08
    and a, $0F
    add a, d
    ld h, a
    ld a, [hl]
    ld [wCameraYawY], a
    ld a, h
    sub a, d
    add a, $04
    and a, $0F
    add a, d
    ld h, a
    ld a, [hl]
    ld [wCameraYawX], a
;get camera pitch
    ld a, [wCameraPitchAddrLow]
    ld l, a
    ld a, [wCameraPitchAddrHigh]
    add a, d
    ld h, a
    ld a, [hl]
    ld [wCameraPitchY], a
    ld a, h
    sub a, d
    add a, $04
    and a, $0F
    add a, d
    ld h, a
    ld a, [hl]
    ld [wCameraPitchX], a
    ld a, $01
    call BankSwitch
    jp initSpecialCameraAngles

getSpriteScaleData:: ;00:117E
    ld a, [wCameraYawAddrLow]
    ld e, a
    ld a, [wCameraYawAddrHigh]
    ld d, a
    call reverseDESign
    ld l, e
    ld h, d
    ld a, BANK(cameraPitchYawTable) ;$0B
    call BankSwitch
    ld de, cameraPitchYawTable ;$4000
    ld a, h
    and a, $0F ;mask address
    add a, d ;add offset
    ld h, a
    ld a, [hl] ;get yaw value y
    ld [wSpriteScaleValueA], a
    ld a, h
    sub a, d
    add a, $04
    and a, $0F
    add a, d
    ld h, a
    ld a, [hl] ;get yaw value x
    ld [wSpriteScaleValueB], a
    ld a, $01
    jp BankSwitch
