; load a room bg area in vram, used to load a portion of a current
; room bg
;
; hl: room bg mask pointer
loadRoomBackgroundArea:: ;00:3073
    ld a, [wCurrentRomBank]
    push af
    ld a, $01
    call bankSwitch
    xor a ; no screen offset
    push hl
    jr label308D


; load a room screen background into vram
;
; room bg struct:
;   - tiles map: $0
;   - attributes map: $140 (320)
;   - tiles data: $280 (640)
;
; hl: room bg pointer
loadRoomScreenBackground:: ;00:3080
    ld a, [wCurrentRomBank]
    push af
    ld a, $01
    call bankSwitch
    push hl
    ld a, [wRoomCameraId]
label308D:
    ld l, a
    ld h, $00
    push hl
    add hl, hl
    pop de
    add hl, de
    pop de
    add hl, de
    ld c, [hl] ; get room bg bank
    inc hl
    ld e, [hl]
    inc hl
    ld d, [hl] ; get room bg address
    inc hl
    ld a, c
    ld [wBgCurrentPointerBankId], a
    call bankSwitch
    ld hl, 640 ; offset to tiles data
    add hl, de
    call checkBgBankOverflowInHLPointer
	; store tiles data pointer
    ld a, l
    ld [wRoomBgTilesDataPointerLo], a
    ld a, h
    ld [wRoomBgTilesDataPointerHi], a
    ld a, [wCurrentRomBank]
    ld [wBgStartBankId], a
    xor a ; reset vram tiles counter and tiles attributes
    ld [wVramTilesCounter], a
    ld [wVramTileAttributes], a
    ld bc, 16 * 20 ; 320 bg tiles
.loadBgTilesLoop
    push bc
    push de ; room bg pointer
; load tilemap and attributes
    ld a, [wBgCurrentPointerBankId]
    call bankSwitch
    ld a, [wVramTilesCounter]
    and a, $0F ; get vertical tile id
    inc a
    ld l, a
    ld a, [wRoomBgTileTopY]
    cp a, l
    jr nc, .loadBgTileData ; vertical tile id is less than top border
    ld a, [wRoomBgTileBottomY]
    cp a, l
    jr c, .loadBgTileData ; vertical tile id is greater than bottom border
; vertical tile is inside vertical area
    ld a, [wVramTilesCounter]
    ld l, a
    ld a, [wVramTileAttributes]
    ld h, a
    srl h
    rr l
    ld a, l
    srl a
    srl a
    srl a
    inc a
    ld l, a
    ld a, [wRoomBgTileLeftX]
    cp a, l
    jr nc, .loadBgTileData ; horizontal tile id is less than left border
    ld a, [wRoomBgTileRightX]
    cp a, l
    jr c, .loadBgTileData
    ld a, [wVramTilesCounter] ; horizontal tile id is greater than right border
; tile is inside bg or mask viewport
    and a, $0F
    ld l, a
    ld h, 0
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl ; get vertical tiles offset (hl * 32)
    ld a, h
    add a, $98 ; add vertical tile offset to Map address
    ld h, a
    ld a, [wVramTilesCounter]
    ld c, a
    ld a, [wVramTileAttributes]
    ld b, a
    srl b
    rr c
    srl b
    rr c
    srl b
    rr c
    srl b
    rr c
    add hl, bc ; add horizontal tile offset to get the tile map address
    push hl ; store tile map address
    ld hl, 320
    add hl, de ; offset to room bg attributes map
    call checkBgBankOverflowInHLPointer
    ld a, [hl] ; get tile attribute value
    pop hl
    and a, $F7 ; mask tile ID
    ld c, a ; reset tile vram bank Id
    call vblankWait
    ld a, [wVramTilesCounter]
    ld [hl], a ; set tile id in tile map address
    ld a, $01
    ld [rVBK], a ;vram bank select
    ld a, [wVramTileAttributes]
    add a
    add a
    add a
    or a, c
    ld [hl], a ; set tile attribute value in tile map address
    xor a
    ld [rVBK], a ;vram bank select
.loadBgTileData
    ld a, [wBgCurrentPointerBankId]
    call bankSwitch
    ld a, [wVramTilesCounter]
    and a, $0F
    inc a
    ld l, a
    ld a, [wRoomBgTileTopY]
    cp a, l
    jr nc, .Label31CF ; vertical tile id is less than top border
    ld a, [wRoomBgTileBottomY]
    cp a, l
    jr c, .Label31CF ; vertical tile id is greater than bottom border
    ld a, [wVramTilesCounter]
    ld l, a
    ld a, [wVramTileAttributes]
    ld h, a
    srl h
    rr l
    ld a, l
    srl a
    srl a
    srl a
    inc a
    ld l, a
    ld a, [wRoomBgTileLeftX]
    cp a, l
    jr nc, .Label31CF ; horizontal tile id is less than left border
    ld a, [wRoomBgTileRightX]
    cp a, l
    jr c, .Label31CF ; horizontal tile id is greater than right border
    ld a, [de] ; get bg tile index
    ld c, a
    ld hl, 320
    add hl, de ; offset to attributes map
    call checkBgBankOverflowInHLPointer
    ld a, [hl] ; get bg tile attribute value
    and a, $08 ; get tile vram bank id
    srl a
    srl a
    srl a
    ld h, a
    ld l, c ; hl: tile data address offset
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, [wBgStartBankId]
    call bankSwitch
    ld a, [wRoomBgTilesDataPointerLo]
    ld e, a
    ld a, [wRoomBgTilesDataPointerHi]
    ld d, a
    add hl, de
    ld e, l
    ld d, h ; de: tile data address
    call checkBgBankOverflowInDEPointer
    ld a, [wVramTilesCounter]
    add a, $80
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, h
    add a, $88
    ld h, a
    ld a, [wVramTileAttributes]
    ld [rVBK], a ; change to tile vram bank
    ld bc, 2 ; 2 * 8 bytes = 1 tile
    call copyTileDataInVram
    xor a
    ld [rVBK], a ;vram bank select
.Label31CF
    ld a, [wVramTilesCounter]
    add a, $01
    ld [wVramTilesCounter], a ; increment tile counter
    ld a, [wVramTileAttributes]
    adc a, $00
    ld [wVramTileAttributes], a ; change to vram bank 1 if tiles in vram bank 0 overflow
    pop de
    inc de
    call checkSwitchToNextBgBank
    pop bc
    dec bc
    ld a, b
    or a, c
    jp nz, .loadBgTilesLoop
    pop af
    jp bankSwitch

; check if the data read pointer of the current bg bank overflows the bank memory, 
; if so, then change to the next bank and point to the beginning the switched bank.
;
; de: data pointer
checkBgBankOverflowInDEPointer:: ;00:31EF
    ld a, d
    cp a, $80
    ret c
    sub a, $40
    ld d, a
    ld a, [wCurrentRomBank]
    inc a
    jp bankSwitch

; hl: data pointer
checkBgBankOverflowInHLPointer:: ;00:31FD
	ld a, h
    cp a, $80
    ret c
    sub a, $40
    ld h, a
    ld a, [wCurrentRomBank]
    inc a
    jp bankSwitch

; de: data pointer
checkSwitchToNextBgBank:: ;00:320B
    ld a, d
    cp a, $80
    ret c
    sub a, $40
    ld d, a
    ld a, [wBgCurrentPointerBankId]
    inc a
    ld [wBgCurrentPointerBankId], a
    jp bankSwitch
