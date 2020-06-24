; a: palette bank
; hl: palette pointer
loadBgPalette: ;00:353C
    call bankSwitch
    ld c, 0 ; color index
    ld b, 32 ; total colors
.loadBgPaletteLoop
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
    jr nz, .loadBgPaletteLoop
    ld a, $01
    jp bankSwitch
