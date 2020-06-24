updateNumericPanelSprites: ;0F:5DCB
    ld hl, wSpriteTilesBuffer
    ld de, numericPanelKeysSprites
    ld bc, 320 ; sprites tiles bytes
.copyKeysSpritesDataLoop
    ld a, [de]
    ld [hli], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, .copyKeysSpritesDataLoop
    ld hl, wOAMBufferC9
    call getOamBufferAddress
    ld de, 4
    ld b, 40
.initPanelSpritesOAMLoop
    ld [hl], -64 ; hide sprites
    add hl, de
    dec b
    jr nz, .initPanelSpritesOAMLoop
.updateOam
    ld hl, wOAMBufferC9
    call getOamBufferAddress
    ld de, wNumPanelKey01PressedFlag
    ld b, 9 ; total keys
.updateKeysLightsSpritesLoop
    ld a, [de] ; get key value
    or a
    jr z, .keyLightIsOff
    inc de
    inc de
    inc de
    jr .Label3DE0E
; panel lights are on in the Bg, so to show a light turned off, we place an sprite above
.keyLightIsOff
    inc de
    ld a, [de]
    ld [hli], a ; y-pos
    inc de
    ld a, [de]
    ld [hli], a ; x-pos
    inc de
    ld a, 0
    ld [hli], a ; tile id
    ld a, 2
    ld [hli], a ; palette
.Label3DE0E
    dec b
    jr nz, .updateKeysLightsSpritesLoop
; load selected key sprite 
    ld de, numericPanelKeysPosition
    ld a, [wNumericPanelKeyId]
    add a
    add a, e
    ld e, a
    ld a, 0
    adc a, d
    ld d, a
    ld a, [de] ; get selected key position
    ld [hli], a ; y-pos
    inc de
    ld a, [de]
    ld [hli], a ; x-pos
    ld a, [wNumericPanelKeyId]
    inc a
    add a
    ld [hli], a ; tile id
    ld a, 3
    ld [hli], a ; palette
    ret
;5E2D

numericPanelKeysPosition: ;0F:5E2D
	db  94, 72 ; pos y, pos x
	db  94, 84
	db  94, 96
	db 106, 72
	db 106, 84
	db 106, 96
	db 118, 72
	db 118, 84
	db 118, 96


numericPanelKeysSprites: 	INCBIN "gfx/numeric_panel_keys.2bpp" ;0F:5E3F


checkNumericPanelInput: ;0F:5F7F
    ld a, [wButtonPressId]
    and a, LEFT_INPUT
    jp nz, numericPanelLeftKeyPress
    xor a
    ld [wPressingLeftKey], a
    ld a, [wButtonPressId]
    and a, RIGHT_INPUT
    jp nz, numericPanelRightKeyPress
    xor a
    ld [wPressingRightKey], a
    ld a, [wButtonPressId]
    and a, UP_INPUT
    jp nz, numericPanelUpKeyPress
    xor a
    ld [wPressingUpKey], a
    ld a, [wButtonPressId]
    and a, DOWN_INPUT
    jp nz, numericPanelDownKeyPress
    xor a
    ld [wPressingDownKey], a
    ld a, [wButtonPressId]
    and a, A_INPUT
    jp nz, numericPanelAKeyPress
    xor a
    ld [wPressingBButton], a
    ret
;5FBC

numericPanelAKeyPress: ;0F:5FBC
    ld a, [wPressingBButton]
    or a
    ret nz
    ld a, $FF
    ld [wPressingBButton], a
    ld a, CONFIRM_SFX
    call playSFX
    ld a, [wNumericPanelKeyId]
    or a ; 0  key 1
    jp z, numericPanelKey01Selected
    cp a, 1 ; key 2
    jp z, numericPanelKey02Selected
    cp a, 2 ; key 3
    jp z, numericPanelKey03Selected
    cp a, 3 ; key 4
    jp z, numericPanelKey04Selected
    cp a, 4 ; key 5
    jp z, numericPanelKey05Selected
    cp a, 5 ; key 6
    jp z, numericPanelKey06Selected
    cp a, 6 ; key 7
    jp z, numericPanelKey07Selected
    cp a, 7 ; key 8
    jp z, numericPanelKey08Selected
    ; else key 9
numericPanelKey09Selected:
    ld hl, wNumPanelKey06PressedFlag
    call switchKeyValue
    ld hl, wNumPanelKey08PressedFlag
    call switchKeyValue
    ld hl, wNumPanelKey09PressedFlag
    jp switchKeyValue

numericPanelKey08Selected:
    ld hl, wNumPanelKey05PressedFlag
    call switchKeyValue
    ld hl, wNumPanelKey07PressedFlag
    call switchKeyValue
    ld hl, wNumPanelKey08PressedFlag
    call switchKeyValue
    ld hl, wNumPanelKey09PressedFlag
    jp switchKeyValue

numericPanelKey07Selected:
    ld hl, wNumPanelKey04PressedFlag
    call switchKeyValue
    ld hl, wNumPanelKey07PressedFlag
    call switchKeyValue
    ld hl, wNumPanelKey08PressedFlag
    jp switchKeyValue

numericPanelKey06Selected:
    ld hl, wNumPanelKey03PressedFlag
    call switchKeyValue
    ld hl, wNumPanelKey05PressedFlag
    call switchKeyValue
    ld hl, wNumPanelKey06PressedFlag
    call switchKeyValue
    ld hl, wNumPanelKey09PressedFlag
    jp switchKeyValue

numericPanelKey05Selected:
    ld hl, wNumPanelKey02PressedFlag
    call switchKeyValue
    ld hl, wNumPanelKey04PressedFlag
    call switchKeyValue
    ld hl, wNumPanelKey05PressedFlag
    call switchKeyValue
    ld hl, wNumPanelKey06PressedFlag
    call switchKeyValue
    ld hl, wNumPanelKey08PressedFlag
    jp switchKeyValue

numericPanelKey04Selected:
    ld hl, wNumPanelKey01PressedFlag
    call switchKeyValue
    ld hl, wNumPanelKey04PressedFlag
    call switchKeyValue
    ld hl, wNumPanelKey05PressedFlag
    call switchKeyValue
    ld hl, wNumPanelKey07PressedFlag
    jp switchKeyValue

numericPanelKey03Selected:
    ld hl, wNumPanelKey02PressedFlag
    call switchKeyValue
    ld hl, wNumPanelKey03PressedFlag
    call switchKeyValue
    ld hl, wNumPanelKey06PressedFlag
    jp switchKeyValue

numericPanelKey02Selected:
    ld hl, wNumPanelKey01PressedFlag
    call switchKeyValue
    ld hl, wNumPanelKey02PressedFlag
    call switchKeyValue
    ld hl, wNumPanelKey03PressedFlag
    call switchKeyValue
    ld hl, wNumPanelKey05PressedFlag
    jp switchKeyValue

numericPanelKey01Selected:
    ld hl, wNumPanelKey01PressedFlag
    call switchKeyValue
    ld hl, wNumPanelKey02PressedFlag
    call switchKeyValue
    ld hl, wNumPanelKey04PressedFlag
    jp switchKeyValue

switchKeyValue:
    ld a, [hl]
    xor a, $FF
    ld [hl], a
    ret
;60C0

numericPanelLeftKeyPress: ;0F:60C0
    ld a, [wPressingLeftKey]
    or a
    ret nz
    ld a, $FF
    ld [wPressingLeftKey], a
    ld a, [wNumericPanelKeyId]
    or a ; 0 key 1
    ret z
    cp a, 3 ; key 4
    ret z
    cp a, 6 ; key 7
    ret z
    dec a
    ld [wNumericPanelKeyId], a
    ld a, CURSOR_SFX
    jp playSFX

numericPanelRightKeyPress:
    ld a, [wPressingRightKey]
    or a
    ret nz
    ld a, $FF
    ld [wPressingRightKey], a
    ld a, [wNumericPanelKeyId]
    cp a, 2 ; key 3
    ret z
    cp a, 5 ; key 6
    ret z
    cp a, 8 ; key 9
    ret z
    inc a
    ld [wNumericPanelKeyId], a
    ld a, CURSOR_SFX
    jp playSFX

numericPanelUpKeyPress:
    ld a, [wPressingUpKey]
    or a
    ret nz
    ld a, $FF
    ld [wPressingUpKey], a
    ld a, [wNumericPanelKeyId]
    cp a, 3
    ret c ; if key < 4
    sub a, 3
    ld [wNumericPanelKeyId], a
    ld a, CURSOR_SFX
    jp playSFX

numericPanelDownKeyPress:
    ld a, [wPressingDownKey]
    or a
    ret nz
    ld a, $FF
    ld [wPressingDownKey], a
    ld a, [wNumericPanelKeyId]
    cp a, 6
    ret nc ; if key >= 7
    add a, 3
    ld [wNumericPanelKeyId], a
    ld a, CURSOR_SFX
    jp playSFX
