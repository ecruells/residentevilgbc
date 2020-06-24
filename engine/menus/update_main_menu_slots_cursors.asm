; update main menu item slots and top option tiles.
;
; c: top options disabled flag ($00: enabled, $FF: disabled)
updateMainMenuSlotsCursors: ;FC:4DBA
    ld e, 0
    ld a, c
    or a
    jr z, .Label3F0DDC ; update all slots and top options
; update only item slots
    ld e, 4
    ld hl, chrisItemSlotsCursorsDataTable+8
    ld a, [wSelectedCharacter]
    or a
    jr z, .setTotalCursors
    ld hl, jillItemSlotsCursorsDataTable+8
; items slots with top options
.setTotalCursors
    ldbc 12, 12
    ld a, [wSelectedCharacter]
    or a
    jr nz, .Label3F0DDA ; if jill
; chris has 2 item slots less than jill
    ldbc 10, 10
.Label3F0DDA
    jr updateSlotsTilesLoop
.Label3F0DDC
    ld hl, chrisMainMenuCursorsDataTable+8
    ld a, [wSelectedCharacter]
    or a
    jr z, .Label3F0DE8 ; if chris
; if jill
    ld hl, jillMainMenuCursorsDataTable+8
.Label3F0DE8
    ldbc 12, 8
    ld a, [wSelectedCharacter]
    or a
    jr nz, updateSlotsTilesLoop
    ldbc 10, 6
updateSlotsTilesLoop:
    push de
    push bc
    push hl
    ld a, [wMainMenuSelectedCursorId]
    cp a, COMBINE_ITEM_MODE
    jr c, .getSelectedCursorTiles
    sub a, COMBINE_ITEM_MODE ; get item slot id
.getSelectedCursorTiles
    cp a, [hl] ; get loop cursor id
    jr nz, getUnselectedCursorTiles ; current loop cursor is not a selected cursor
    dec hl
    ld a, [hld]
    ld [wCursorTilesHeight], a ;cursor tiles height
    ld a, [hld]
    ld [wCursorTilesWidth], a ;cursor tiles width
    ld a, [hld]
    ld e, [hl]
    ld d, a ; de: selected cursor tiles address
    ld a, b ; loop index
    sub a, c
    cp a, $05
    jr nc, getCursorTilesMapAddressFromSelected ; is item slot
    or a
    jr z, getCursorTilesMapAddressFromSelected
; if top option
    ld c, a
    ld a, $05
    sub a, c
    ld c, a
    push hl ; store selected cursor tiles address pointer
    ld hl, wMainMenuSelectedCursorId
    add a, l
    ld l, a
    ld a, $00
    adc a, h
    ld h, a
    ld a, [hl] ; get option cursor flag value 
    pop hl ; restore selected cursor address pointer
    or a
    jr z, getCursorTilesMapAddressFromSelected ; if top option is disabled
    ld a, c ; option cursor id
    add a
    add a
    add a
    add a
    add a ; id * 32
    add a, e ; offset to corresponding selected option tiles (map, radio, file, exit)
    ld e, a
    ld a, $00
    adc a, d
    ld d, a
getCursorTilesMapAddressFromSelected:
    dec hl
    dec hl
    dec hl
    ld a, [hld]
    ld l, [hl]
    ld h, a  ; get cursor target tile map position address
    jr Label3F0E7B
getUnselectedCursorTiles:
    dec hl
    ld a, [hld]
    ld [wCursorTilesHeight], a ; cursor tile height
    ld a, [hld]
    ld [wCursorTilesWidth], a ; cursor tile width
    dec hl
    dec hl
    ld a, [hld] ;set unselected cursor tile addr
    ld e, [hl]
    ld d, a ; de: unselected cursor tiles address
    ld a, b ; loop index
    sub a, c
    cp a, $05
    jr nc, getCursorTilesMapAddressFromUnselected ; if item slot
    or a
    jr z, getCursorTilesMapAddressFromUnselected
; if top option
    ld c, a
    ld a, $05
    sub a, c
    ld c, a
    push hl
    ld hl, wMainMenuSelectedCursorId
    add a, l
    ld l, a
    ld a, $00
    adc a, h
    ld h, a
    ld a, [hl] ; get option cursor flag value 
    pop hl
    or a
    jr z, getCursorTilesMapAddressFromUnselected ; if top option is disabled
    ld a, c ; option cursor id
    add a
    add a
    add a
    add a
    add a ; id * 32
    add a, e ; offset to corresponding unselected option tiles (map, radio, file, exit)
    ld e, a
    ld a, $00
    adc a, d
    ld d, a
getCursorTilesMapAddressFromUnselected:
    dec hl
    ld a, [hld]
    ld l, [hl]
    ld h, a ; get cursor target tile map position address
Label3F0E7B:
    ld a, [wMainMenuSelectedCursorId]
    cp a, COMBINE_ITEM_MODE
    jr c, .Label3F0E86
; if combine cursor
    ld a, e
    sub a, 3
    ld e, a
.Label3F0E86
    call loadMenuSlotsTiles
    pop hl
    ld de, 9
    add hl, de
    pop bc
    dec b
    pop de
    ld a, b
    cp a, e
    jp nz, updateSlotsTilesLoop
    ret
;4E97

; de: source map address
; hl: target map address
loadMenuSlotsTiles: ;FC:4E97
    ld a, [wCursorTilesHeight]
    ld b, a
.tilesHeightLoop
    push de
    push hl
    ld a, [wCursorTilesWidth]
    ld c, a
.tilesWidthLoop
    call vblankWait
    ld a, [de]
    ld [hli], a
    inc de
    dec c
    jr nz, .tilesWidthLoop
    pop hl
    ld de, $20 ; add next tile line offset (32 tiles long)
    add hl, de
    pop de
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    dec b
    jr nz, .tilesHeightLoop
    ret
;4EBC
