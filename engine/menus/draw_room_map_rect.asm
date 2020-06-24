; hl: room map rect pointer
drawRoomMapRect: ;05:603D
    ld a, [hli]
    ld [wRoomMapRectX], a
    ld a, [hli]
    ld [wRoomMapRectY], a
    ld a, [hli]
    ld [wRoomMapRectWidth], a
    ld a, [hli]
    ld [wRoomMapRectHeight], a
    ld a, [hli]
    ld [wRoomMapRectId], a
    ld a, [hli]
    ld [wRoomMapRectIdHigh], a
    push hl
drawRoomMapRectLoop
    ld a, [wRoomMapRectHeight]
    ld [wRoomMapHeightCounter], a
    call drawRoomMapRectVerticalLine
    ld a, [wRoomMapRectX]
    inc a
    ld [wRoomMapRectX], a
    ld a, [wRoomMapRectWidth]
    dec a
    ld [wRoomMapRectWidth], a
    jr nz, drawRoomMapRectLoop
    pop hl
    ret
;6071

drawRoomMapRectVerticalLine: ;05:6071
    ld a, [wRoomMapRectX]
    srl a
    srl a
    srl a
    ld l, a
    ld h, 0
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld de, _VRAM+$1000
    add hl, de ; convert x position to vram tile position
; add y pos offset
    ld a, [wRoomMapRectY]
    add a
    add a, l
    ld l, a
    ld a, 0
    adc a, h
    ld h, a
; 
    ld de, visitedRoomMapRectPixelData
    ld a, [wRoomMapRectId]
    ld c, a
    ld a, [wRoomMapRectIdHigh]
    ld b, a ; bc: room rect id
    ld a, [wRoomId]
    cp a, c ; compare with current room id
    jr nz, checkVisitedRoom ; room map rect not current room
    ld a, [wRoomIdHigh]
    cp a, b
    jr nz, checkVisitedRoom ; room map rect not current room
; room rect to draw is current room
    ld de, currentRoomMapRectPixelData
checkVisitedRoom
    ld bc, wVisitedRoomsFlags
    ld a, [wRoomMapRectId]
    add a, c
    ld c, a
    ld a, [wRoomMapRectIdHigh]
    adc a, b
    ld b, a
    ld a, [bc] ; get visited flag
    or a
    jr nz, getRoomMapPixelData ; room visited
; room not visited
    ld de, unvisitedRoomMapRectPixelData ;$600D
getRoomMapPixelData
    ld a, [wRoomMapRectX]
    and a, $07 ; convert rect x position to h-tile pixel index
    ld b, a
    add a
    add a, b
    add a, e
    ld e, a
    ld a, 0
    adc a, d
    ld d, a
drawMapVerticalLineLoop
    ld a, $01
    ld [rVBK], a ; switch to vram bank 1
    ld a, [de] ; get rect pixel bitplane pixel bitplane
    ld c, a
    inc de
    call vblankWait
    ld a, [hl] ; get tile bitplane 0
    and a, c ; mask bitplane with rect
    ld b, a
    ld a, [de] ; get pixel palette bitmask 0
    or a, b ; mask pixel pal bitmask
    ld [hli], a
    inc de
    ld a, [hl] ; get tile bitplane 1
    and a, c ; mask bitplane with rect pixel bitplane
    ld b, a
    ld a, [de] ; get pixel palette bitmask 1
    or a, b ; mask pixel pal bitmask
    ld [hli], a
    dec de
    dec de
    xor a
    ld [rVBK], a ;vram bank select
    ld a, [wRoomMapHeightCounter]
    dec a
    ld [wRoomMapHeightCounter], a
    jr nz, drawMapVerticalLineLoop
    ret
;60F4
