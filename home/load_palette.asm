; load bg and obj palettes, and apply fade in/out to each color
;
; a:  palette bank
; hl: bg pal pointer
; de: obj pal pointer
loadPalette:: ;00:3297
    call bankSwitch
    push de ; store obj palette pointer
; load BG palette
    ld c, 0
    ld b, 32
.loadBgPalLoop
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld a, [wPaletteFadeCounter]
    and a, MAX_FADE_STEPS
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
    jr nz, .loadBgPalLoop
    pop hl
; load OBJ palette
    ld c, 0
    ld b, 32
.loadObjPalLoop
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
    jr nz, .loadObjPalLoop
    ld a, $01
    jp bankSwitch


; Change a color darkness by diff the fade value to each color BGR value.
; Darkness fade value range from 0 (original color) to $1F (darkest value or black color)
;
; a: fade value
; de: color value
changeColorDarkness:: ;00:32EF
    push bc
    push hl
.fadeRedValue
    ld l, a
    ld a, e
    and a, %00011111
    sub a, l
    jr nc, .fadeGreenValue
    xor a
.fadeGreenValue
    ld c, a
    ld a, e
    and a, %11100000
    srl a
    srl a
    srl a
    srl a
    srl a
    ld h, a
    ld a, d
    and a, %00000011
    add a
    add a
    add a
    or a, h
    sub a, l
    jr nc, .fadeBlueValue
    xor a
.fadeBlueValue
    ld h, a
    and a, %00000111
    add a
    add a
    add a
    add a
    add a
    or a, c
    ld c, a
    ld a, h
    and a, %00011000
    srl a
    srl a
    srl a
    ld b, a
    ld a, d
    and a, %01111100
    srl a
    srl a
    sub a, l
    jr nc, .updateColorValue
    xor a
.updateColorValue
    add a
    add a
    or a, b
    ld b, a
    ld e, c
    ld d, b
    pop hl
    pop bc
    ret
