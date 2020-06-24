; load a room palette (bg and obj).
; The room palette is share for all the room Backgrounds, and obj palette differ between rooms 
;
; hl: palette pointer
loadRoomPalettes: ;03:7A80
    push de
    ld c, 0
    ld b, 32 ; pal colors counter
.updateBgPalettesLoop
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
	; check for dark rooms special palettes
    ld a, [wRoomId]
    cp a, SMALL_DINNING_ROOM
    jp z, .setCandleRoomDarkTone
    cp a, TAXIDERMY_ROOM
    jp z, .setRedJewelRoomDarkTone
    cp a, COURTYARD_STUDY
    jp z, .setWolfMedalRoomDarkTone
    cp a, XRAY_ROOM
    jp z, .setLabPaintingRoomDarkTone
; default palette
.LabelFAA0
    ld a, [wPaletteFadeCounter]
    and a, MAX_FADE_STEPS
    jr .setRoomPalette
.setCandleRoomDarkTone ;LabelFAA7
    ld a, [wSmallDinningRoomLittedCandleFlag]
    or a
    jp nz, .LabelFAA0 ; if candle room light is on, set default light
    ld a, [wPaletteFadeCounter]
    and a, MAX_FADE_STEPS
    push hl
    ld l, a
    srl a
    srl a
    ld h, a
    ld a, l
    sub a, h
    add a, $08
    pop hl
    jr .setRoomPalette
.setRedJewelRoomDarkTone ;LabelFAC1
    ld a, [wTaxidermyRoomLightsFlag]
    or a
    jp z, .LabelFAA0 ; if red jewel room light is on, set default light
    ld a, [wPaletteFadeCounter]
    and a, MAX_FADE_STEPS
    push hl
    ld l, a
    srl a
    srl a
    ld h, a
    ld a, l
    sub a, h
    add a, $08
    pop hl
    jr .setRoomPalette
.setWolfMedalRoomDarkTone ;LabelFADB
    ld a, [wCourtyardStudyLightsFlag]
    or a
    jp nz, .LabelFAA0 ; if wolf medal room light is on, set default light
    ld a, [wPaletteFadeCounter]
    and a, MAX_FADE_STEPS
    push hl
    ld l, a
    srl a
    srl a
    ld h, a
    ld a, l
    sub a, h
    add a, $08
    pop hl
    jr .setRoomPalette
.setLabPaintingRoomDarkTone ;LabelFAF5
    ld a, [wXRayRoomBlueLightsFlag]
    or a
    jp z, .LabelFB03
    ld a, [wXRayRoomBlueLightsFlag]
    or a
    jp nz, .LabelFAA0
.LabelFB03
    ld a, [wPaletteFadeCounter]
    and a, MAX_FADE_STEPS
    push hl
    ld l, a
    srl a
    srl a
    ld h, a
    ld a, l
    sub a, h
    add a, $08
    pop hl
    jr .setRoomPalette
.setRoomPalette
    call changeColorDarkness
    call vblankWait
    ld a, c
    ld [rBCPS], a ;bg color index
    ld a, e
    ld [rBCPD], a ;bg color data
    inc c
    call vblankWait
    ld a, c
    ld [rBCPS], a ;bg color index
    ld a, d
    ld [rBCPD], a ;bg color data
    inc c
    dec b
    jp nz, .updateBgPalettesLoop
    pop hl
    ld c, 0
    ld b, 32 ; obj palettes colors
.updateObjPalettesLoop
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld a, [wPaletteFadeCounter]
    and a, MAX_FADE_STEPS
    call changeColorDarkness
    call vblankWait
    ld a, c
    ld [rOCPS], a ;obj color index
    ld a, e
    ld [rOCPD], a ;obj color data
    inc c
    call vblankWait
    ld a, c
    ld [rOCPS], a ;obj color index
    ld a, d
    ld [rOCPD], a ;obj color data
    inc c
    dec b
    jr nz, .updateObjPalettesLoop
    ret
