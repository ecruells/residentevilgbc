; load all room's screen background data (camera data, display background, load palettes, etc)
loadRoomScreenCameraAndBgData:: ;00:0741
    ld a, BANK(roomsBgCamerasLookupTable)
    call bankSwitch
    ld a, [wRoomId]
    ld l, a
    ld a, [wRoomIdHigh]
    ld h, a
    add hl, hl
    ld de, roomsBgCamerasLookupTable
;Label752
    add hl, de
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc de
    ld a, [wRoomCameraId]
    ld l, a
    ld h, $00
    add hl, hl
    push hl
    add hl, hl
    add hl, hl
    add hl, hl
    pop bc
    add hl, bc
    add hl, de
    ld a, [hli]
    ld [wCameraPositionX], a
    ld a, [hli]
    ld [wCameraPositionX+1], a
    ld a, [hli]
    ld [wCameraPositionY], a
    ld a, [hli]
    ld [wCameraPositionY+1], a
    ld a, [hli]
    ld [wCameraPositionZ], a
    ld a, [hli]
    ld [wCameraPositionZ+1], a
    ld a, [hli]
    ld [wCameraYawAngle], a
    ld a, [hli]
    ld [wCameraYawAngle+1], a
    ld a, [hli]
    ld [wCameraPitchAngle], a
    ld a, [hli]
    ld [wCameraPitchAngle+1], a
    ld a, [hli]
    ld [wCameraPositionTX], a
    ld a, [hli]
    ld [wCameraPositionTX+1], a
    ld a, [hli]
    ld [wCameraPositionTY], a
    ld a, [hli]
    ld [wCameraPositionTY+1], a
    ld a, [hli]
    ld [wCameraPositionTZ], a
    ld a, [hli]
    ld [wCameraPositionTZ+1], a
    ld a, [hli]
    ld [wCameraFacing], a
    ld a, [hl]
    and a, %00111111
    ld [wCameraC16F], a ; unused camera value
    ld a, [hl]
    and a, %01000000 ; get camera type
    ld [wCameraType], a
    ld a, $01
    call bankSwitch
    call getCameraAnglesSinCosValues
    call applyPlayerElevationCaller
    ld a, [wRoomId]
    ld l, a
    ld a, [wRoomIdHigh]
    ld h, a
    add hl, hl
    add hl, hl
    ld de, roomsBgLookupTable
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
;
; load room screen bg
    call loadRoomScreenBackgroundCaller
;
; load main font tiles
    ld a, $01
    ld [rVBK], a ;vram bank select
    ld a, BANK(mainFont)
    call bankSwitch
    ld de, mainFont
    ld hl, _VRAM+$800 ; fonts vram
    ld bc, 2048 ; bytes number to load
    call copyDataIntoVram
    ld a, $01
    call bankSwitch
    xor a
    ld [rVBK], a ;vram bank select
    ld a, BANK(firegunAndBloodTiles)
    call bankSwitch
    ld de, firegunAndBloodTiles
    ld hl, _VRAM+$740 ; sprites tiles vram
    ld bc, 192 ; bytes number to load
    call copyDataIntoVram
;
; display bottom black frame
    ld a, $01
    call bankSwitch
    ld hl, _SCRN0+$200 ; bottom black frame tilemap
    ld b, 128
.loop80C
    xor a
    ld [rVBK], a ;vram bank select
    call vblankWait
    ld [hl], $80 ; black tile from font tileset
    ld a, $01
    ld [rVBK], a ;vram bank select
    ld [hl], OAMF_VRAM1 | 1
    inc hl
    dec b
    jr nz, .loop80C
    xor a
    ld [rVBK], a ;vram bank select
;
; special room bg overlap
    ld hl, setPriorityFlagsOnSpecialRoomScreenTiles
    ld a, BANK(setPriorityFlagsOnSpecialRoomScreenTiles)
    jp jumpToHLRoutineA
