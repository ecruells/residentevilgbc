; hl: palette pointer
loadBgImagePalette:: ;01:44A7
    ld a, [wPaletteFadeCounter]
    or a
    ret z ; return if palette is not fading
    cp a, 96
    ret nc
    cp a, SET_FADE_OUT
    jr nc, .fadeOutPalette
.fadeInPalette
    dec a
    jr .Label44B7
.fadeOutPalette
    inc a
.Label44B7
    ld [wPaletteFadeCounter], a
    cp a, FADE_OUT_FINISHED
    jp nc, resetPalettes
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld a, [hl]
    push bc
    pop hl
    jp loadPalette

; update the room palette when the fade in/out counter is set
updateRoomPalette:: ;01:44CD
    ld a, [wPaletteFadeCounter]
    or a
    ret z ; return if palette is not fading
    cp a, 96
    ret nc
    cp a, SET_FADE_OUT
    jr nc, .Label44DC
    dec a ; fade-in
    jr .Label44DD
.Label44DC
    inc a ;fade-out
.Label44DD
    ld [wPaletteFadeCounter], a
    cp a, FADE_OUT_FINISHED
    jp nc, resetPalettes ; max fade-out value reached, so, reset all palettes
    ld a, [wRoomId]
    ld l, a
    ld a, [wRoomIdHigh]
    ld h, a
    add hl, hl
    add hl, hl
    ld de, roomsBgLookupTable+2
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld a, [wRoomId]
    cp a, ARMORS_ROOM
    jr z, .Label450A
.loop44FD
    ld e, l
    ld d, h
    ld a, e
    add a, $40
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    jp loadRoomPalettesCaller
.Label450A
    ld a, [wRoomGasActivatedFlag]
    or a
    jr z, .loop44FD
    ld hl, room_23_gas_palette
    jr .loop44FD


; reset bg and obj palette
resetPalettes:: ;01:4515
    ld c, 0
    ld b, 64
.loop4519
    call vblankWait
    ld a, c
    ld [rBCPS], a ;bg color index
    xor a
    ld [rBCPD], a ;bg color data
    inc c
    dec b
    jr nz, .loop4519
    ld c, 0
    ld b, 64
.loop452A
    call vblankWait
    ld a, c
    ld [rOCPS], a ;obj color index
    xor a
    ld [rOCPD], a ;obj color data
    inc c
    dec b
    jr nz, .loop452A
    ret
;4538