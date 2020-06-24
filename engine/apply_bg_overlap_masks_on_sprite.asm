; apply room background overlap masks on sprite
applyBgOverlapMaskOnSprite:: ;08:4000
    ld a, [wRoomId]
    cp a, DINNING_ROOM_1F
    jp z, ApplyDinningRoomOverlap
    cp a, EXHIBITION_ROOM
    jp z, ApplyMapStatueRoomOverlap
    cp a, REST_STOP_CORRIDOR
    jp z, applyCorridor05RoomOverlap
    cp a, WEST_STAIRCASE_1F
    jp z, applyCorridor08RoomOverlap
    cp a, KEEPERS_ROOM
    jp z, ApplyZombieClosetRoomOverlap
    cp a, LARGE_ART_ROOM
    jp z, ApplyRoom10Overlap
    cp a, SMALL_DINNING_ROOM
    jp z, ApplyCandleRoomOverlap
    cp a, EAST_STAIRCASE_2F
    jp z, ApplyCorridor24Overlap
    cp a, RESEARCHERS_PRIVATE_ROOM
    jp z, ApplyInsectsRoomOverlap
    cp a, ATTIC
    jp z, ApplyYawn1RoomOverlap
    cp a, AQUA_TANK_ENTRANCE
    jp z, ApplyCorridor4CRoomOverlap
    cp a, GUARDHOUSE_DORM_003
    jp z, ApplyDorm003RoomOverlap
    ret

ApplyDinningRoomOverlap: ;08:4040
    ld a, [wRoomCameraId]
    or a ; 0
    jr z, .Label2004B
    cp a, 2
    jr z, .Label20057
    ret
.Label2004B
    ld de, Room01_00_overlapMaskA
    call ApplyRoomOverlapMask
    ld de, Room01_00_overlapMaskB
    jp ApplyRoomOverlapMask
.Label20057
    ld de, Room01_02_overlapMaskA
    call ApplyRoomOverlapMask
    ld de, Room01_02_overlapMaskB
    jp ApplyRoomOverlapMask

ApplyMapStatueRoomOverlap: ;08:4063
    ld de, Room04_00_overlapMaskA
    ld a, [wRoomCameraId]
    or a ; 0
    jp z, ApplyRoomOverlapMask
    ld de, Room04_01_overlapMaskA
    cp a, 1
    jp z, ApplyRoomOverlapMask
    ld de, Room04_02_overlapMaskA
    cp a, 2
    jp z, ApplyRoomOverlapMask
    ret

applyCorridor05RoomOverlap: ;08:407E
    ld a, [wRoomCameraId]
    cp a, 1
    ret nz
    ld de, Room05_01_overlapMaskA
    jp ApplyRoomOverlapMask

applyCorridor08RoomOverlap: ;08:408A
    ld a, [wRoomCameraId]
    cp a, 2
    jr z, .Label20096
    cp a, 4
    jr z, .Label2009C
    ret
.Label20096 ;08:4096
    ld de, Room08_02_overlapMaskA
    jp ApplyRoomOverlapMask
.Label2009C
    ld de, Room08_04_overlapMaskA
    jp ApplyRoomOverlapMask

ApplyZombieClosetRoomOverlap: ;08:40A2
    ld de, Room0E_00_overlapMaskA
    ld a, [wRoomCameraId]
    or a ; 0
    jp z, ApplyRoomOverlapMask
    ld de, Room0E_01_overlapMaskA
    cp a,  1
    jp z, ApplyRoomOverlapMask
	; screen 2
    ld de, Room0E_02_overlapMaskA
    jp ApplyRoomOverlapMask

ApplyRoom10Overlap: ;08:40BA
    ld a, [wRoomCameraId]
    or a ; 0
    jr z, .Label200C9
    cp a, 1
    jr z, .Label200CF
    cp a, 2
    jr z, .Label200DB
    ret
.Label200C9 ;08:40C9
    ld de, Room10_00_overlapMaskA
    jp ApplyRoomOverlapMask
.Label200CF
    ld de, Room10_01_overlapMaskA
    call ApplyRoomOverlapMask
    ld de, Room10_01_overlapMaskB
    jp ApplyRoomOverlapMask
.Label200DB
    ld de, Room10_02_overlapMaskA
    jp ApplyRoomOverlapMask

ApplyCandleRoomOverlap: ;08:40E1
    ld a, [wRoomCameraId]
    or a ; 0
    jr z, .Label200EC
    cp a, 1
    jr z, .Label200F2
    ret
.Label200EC ;08:40EC
    ld de, Room22_00_overlapMaskA
    jp ApplyRoomOverlapMask
.Label200F2
    ld de, Room22_01_overlapMaskA
    jp ApplyRoomOverlapMask

ApplyCorridor24Overlap ;08:40F8
    ld a, [wRoomCameraId]
    or a ; 0
    jr z, .Label20103
    cp a, 4
    jr z, .Label20115
    ret
.Label20103 ;08:4103
    ld de, Room24_00_overlapMaskA
    call ApplyRoomOverlapMask
    ld de, Room24_00_overlapMaskB
    call ApplyRoomOverlapMask
    ld de, Room24_00_overlapMaskC
    jp ApplyRoomOverlapMask
.Label20115
    ld de, Room24_04_overlapMaskA
    call ApplyRoomOverlapMask
    ld de, Room24_04_overlapMaskB
    call ApplyRoomOverlapMask
    ld de, Room24_04_overlapMaskC
    jp ApplyRoomOverlapMask

ApplyInsectsRoomOverlap: ;08:4127
    ld a, [wRoomCameraId]
    or a
    ret nz
	;screen 0
    ld de, Room29_00_overlapMaskA
    jp ApplyRoomOverlapMask

ApplyYawn1RoomOverlap: ;08:4132
    ld a, [wRoomCameraId]
    cp a, 1
    jr z, .Label2013E
    cp a, 2
    jr z, .Label20150
    ret
.Label2013E ;08:413E
    ld de, Room2C_01_overlapMaskA
    call ApplyRoomOverlapMask
    ld de, Room2C_01_overlapMaskB
    call ApplyRoomOverlapMask
    ld de, Room2C_01_overlapMaskC
    jp ApplyRoomOverlapMask
.Label20150
    ld de, Room2C_02_overlapMaskA
    call ApplyRoomOverlapMask
    ld de, Room2C_02_overlapMaskB
    call ApplyRoomOverlapMask
    ld de, Room2C_02_overlapMaskC
    jp ApplyRoomOverlapMask

ApplyCorridor4CRoomOverlap: ;08:4162
    ld a, [wCurrentSpriteCharId]
    cp a, WOODEN_BOX
    ret nz ; apply only to wooden box
    ld a, [wRoomCameraId]
    cp a, 5
    jr z, .Label20170
    ret
.Label20170 ;08:4170
    ld de, Room4C_05_overlapMaskA
    jp ApplyRoomOverlapMask

ApplyDorm003RoomOverlap: ;08:4176
	ld a, [wRoomCameraId]
    cp a, 1
    jr z, .Label2018A
    cp a, 2
    jr z, .Label20196
    cp a, 3
    jr z, .Label201A8
    cp a, 5
    jr z, .Label201AE
    ret
.Label2018A ;08:418A
    ld de, Room54_01_overlapMaskA
    call ApplyRoomOverlapMask
    ld de, Room54_01_overlapMaskB
    jp ApplyRoomOverlapMask
.Label20196
    ld de, Room54_02_overlapMaskA
    call ApplyRoomOverlapMask
    ld de, Room54_02_overlapMaskB
    call ApplyRoomOverlapMask
    ld de, Room54_02_overlapMaskC
    jp ApplyRoomOverlapMask
.Label201A8
    ld de, Room54_03_overlapMaskA
    jp ApplyRoomOverlapMask
.Label201AE
    ld de, Room54_05_overlapMaskA
    jp ApplyRoomOverlapMask


; hl: sprite tiles buffer address
ApplyRoomOverlapMask:: ;08:41B4
    ld a, [de] ; mask y-sort value
    ld c, a
    ld a, [wCurrentSpriteZOrder]
    cp a, c
    jp c, doNotApplyOverlap ; if sprite is over mask
    inc de
    inc de
    inc de
    ld a, [de] ; mask y axis
    ld c, a 
    ld a, [wCurrentSpriteScreenY]
    sub a, c ; get distance (player-y - mask-y)
    cp a, $80
    jp c, Label201ED ; jump if distance is positive
; if negative, set it positive
    xor a, $FF
    inc a
    ld [wMaskOnSpriteOffset], a
    ld b, a
    ld a, [wCurrentSpriteHeight]
    sub a, b ; spriteHeigth - MaskDistance
    cp a, 128
    jp nc, doNotApplyOverlap ; return if intersect is negative
    or a
    jp z, doNotApplyOverlap ; return if intersect is zero
    ld [wMaskIntersectHeight], a
    xor a
    ld [wMaskOffsetLow], a
    ld [wMaskOffsetHigh], a
    inc de
    inc de ; masks count
    jr Label20229
Label201ED:
    push hl ; # optimization
    ld l, a ; mask distance
    ld h, 0
    ld a, l
    ld [wMaskOffsetLow], a
    ld a, h
    ld [wMaskOffsetHigh], a
    pop hl
    ld a, [wCurrentSpriteHeight]
    ld [wMaskIntersectHeight], a
    xor a
    ld [wMaskOnSpriteOffset], a
    ld a, [de] ; mask y-axis
    ld c, a
    inc de
    ld a, [de]  ; mask height
    add a, c
    ld c, a
    ld a, [wCurrentSpriteScreenY]
    ld b, a
    ld a, [wCurrentSpriteHeight]
    add a, b
    sub a, c ; (sprtY + sprtHeight) - (maskY + maskHeight)
    cp a, $80
    jr nc, .Label20228
    ld c, a
    ld a, [wMaskIntersectHeight]
    sub a, c
    ld [wMaskIntersectHeight], a
    cp a, 128
    jp nc, doNotApplyOverlap ; return if intersect is negative
    or a
    jp z, doNotApplyOverlap ; return if intersect is zero
.Label20228
    inc de
; apply mask on sprite loop
Label20229:
    ld a, [de] ; masks count
    ld b, a
    inc de
applyMaskLoop: ;08:422C
    push bc
    push de
    push hl
    ld a, [de] ; mask x-axis
    ld c, a
    inc de
    ld a, [de]
    ld [wMaskAddressLow], a
    inc de
    ld a, [de]
    ld [wMaskAddressHigh], a
    push de
; apply mask offset (mask adress + mask offset)
    ld a, [wMaskOffsetLow]
    ld e, a
    ld a, [wMaskOffsetHigh]
    ld d, a
    ld a, [wMaskAddressLow]
    add a, e
    ld [wMaskAddressLow], a
    ld a, [wMaskAddressHigh]
    adc a, d
    ld [wMaskAddressHigh], a
    pop de
    ; get mask x-offset
    ; (spriteX - maskX)
    ld a, [wCurrentSpriteScreenX]
    sub a, c
    cp a, $00
    jr z, .Label20275 ; if x-offset is zero
    cp a, $80
    jr c, .Label2026C ; if x-offset is positive
    ld c, a
    cp a, -31
    jp c, continueNextMask ; if x-offset < -31
    cp a, -23
    jp c, ApplyMaskOnRightHalfSprite ; if x-offset < -23
    jr .Label20278
.Label2026C
    ld c, a
    cp a, 8
    jp nc, continueNextMask ; if x-offset => 8
    jp applyMaskSingleSpriteColumn
.Label20275
    ld c, a
    jr .Label20278
; when x-offset is => -23 <= 0, 
.Label20278
    ld a, c
    xor a, $FF
    inc a
    ld c, a ; change to positive
    and a, $1F
    srl a
    srl a 
    srl a ; ( (mask x-offset) & $1F ) / 8
    ld b, a
    ld a, [wCurrentSpriteHeight]
    and a, $F0
    ld e, a ; round down sprite height in multiples of 16
    ld a, [wCurrentSpriteHeight]
    and a, $0F
    jr z, .Label20297 ; if sprite height if exact multiple of 16
    ld a, e
    add a, 16 ; round up height
    ld e, a
.Label20297
; e: sprite height in multiples of 16
    sla e ; sprite height x 2 (number of sprite height tiles)
    ld d, 0
    ld a, b ; number of sprite vertical sections to be apply
    or a
    jr z, .Label202A3
.loop2029F
    add hl, de ; offset sprite tiles address
    dec b
    jr nz, .loop2029F
.Label202A3
    ld a, c ; x-offset
    and a, 7
    ld c, a
    call ApplyMaskOffsetOnSpriteAddr
    ld a, [wMaskIntersectHeight]
    ld b, a
.applyMaskIntersectLoop
    push bc ; b: maskIntersectHeight, c: x-offset
    push de ; sprite height tiles number
    push hl ; sprite tiles addr
    ld a, [wMaskAddressLow]
    ld l, a
    ld a, [wMaskAddressHigh]
    ld h, a
    ld e, [hl] ; get mask byte
    ld d, $FF
    inc hl
    ld a, l
    ld [wMaskAddressLow], a
    ld a, h
    ld [wMaskAddressHigh], a
    pop hl ; get sprite tiles address
    ld a, c ; get x-offset
    or a
    jr z, .Label202D5
; 16-bit rotate right mask tile by x-offset times
.loop202CA
    srl e
    rr d
    ld a, e
    or a, %10000000
    ld e, a
    dec c
    jr nz, .loop202CA
.Label202D5
    ; each mask is 8 pixels wide, so it can mask across two sprite columns (16px)
    ld c, e ; c: mask tile byte
    ld b, d ; b: rotated mask tile bits
    ld a, [hl] ; get sprite tile subpixel 1
    and a, c ; mask subpixels line 1 column 1
    ld [hli], a ; update sprite subpixel
    ld a, [hl] ; get sprite tile subpixel 2
    and a, c ;  mask subpixels line 2 column 1
    ldd [hl], a
    pop de ; sprite height tiles number
    add hl, de ; offset to next sprite column tiles
    ld a, [hl]
    and a, b ; mask subpixels line 1 column 2
    ld [hli], a
    ld a, [hl]
    and a, b ; mask subpixels line 2 column 2
    ld [hli], a
    ; hl - de (back to next sprite tile)
    ld a, l
    sub a, e
    ld l, a
    ld a, h
    sbc a, d
    ld h, a
    pop bc
    dec b
    jr nz, .applyMaskIntersectLoop
    jp continueNextMask
applyMaskSingleSpriteColumn:
    ld a, c
    and a, 7
    ld c, a
    call ApplyMaskOffsetOnSpriteAddr
    ld a, [wMaskIntersectHeight]
    ld b, a
.applyMaskIntersectLoop2
    push bc ; b: maskIntersectHeight, c: x-offset
    push hl ; sprite tiles addr
    ld a, [wMaskAddressLow]
    ld l, a
    ld a, [wMaskAddressHigh]
    ld h, a
    ld e, [hl] ; get mask tile
    inc hl
    ld a, l
    ld [wMaskAddressLow], a
    ld a, h
    ld [wMaskAddressHigh], a
    pop hl
    ld a, c
    or a
    jr z, .Label2031F
; left shift mask by x-offset times
.loop20316
    sla e
    ld a, e
    or a, 1
    ld e, a
    dec c
    jr nz, .loop20316
.Label2031F
    ld a, [hl]
    and a, e ; mask sprite subpixels line 1
    ld [hli], a
    ld a, [hl]
    and a, e ; mask sprite subpixels line 2
    ld [hli], a
    pop bc
    dec b
    jr nz, .applyMaskIntersectLoop2
    jp continueNextMask
; when x-offset < -23
ApplyMaskOnRightHalfSprite:
; c: x-offset
    ld a, [wCurrentSpriteHeight]
    and a, $F0
    ld e, a
    ld a, [wCurrentSpriteHeight]
    and a, $0F
    jr z, .Label2033D ; if sprite height if multiple of 16
    ld a, e
    add a, 16 ; roun up height to multiple of 16
    ld e, a
.Label2033D
    sla e ; get sprite height tiles number
    ld d, $00
    add hl, de
    add hl, de
    add hl, de ; go to last sprite column
    ld a, c
    xor a, $FF ; set x-offset to positive
    inc a
    and a, $07
    ld c, a
    call ApplyMaskOffsetOnSpriteAddr
    ld a, [wMaskIntersectHeight]
    ld b, a
.applyMaskLastSpriteColumnLoop
    push bc ; b: maskIntersectHeight, c: x-offset
    push hl ; sprite tiles addr
    ld a, [wMaskAddressLow]
    ld l, a
    ld a, [wMaskAddressHigh]
    ld h, a
    ld e, [hl] ; get mask tile byte
    ld d, $FF
    inc hl
    ld a, l
    ld [wMaskAddressLow], a
    ld a, h
    ld [wMaskAddressHigh], a
    pop hl
    ld a, c
    or a
    jr z, .Label20378
; right rotate mask tile
.loop2036D
    srl e
    rr d
    ld a, e
    or a, $80
    ld e, a
    dec c
    jr nz, .loop2036D
.Label20378
    ld c, e
    ld b, d
    ld a, [hl]
    and a, c ; mask sprite subpixels line 1
    ld [hli], a
    ld a, [hl]
    and a, c ; mask sprite subpixels line 2
    ld [hli], a
    pop bc
    dec b
    jr nz, .applyMaskLastSpriteColumnLoop
    jp continueNextMask
continueNextMask:
    pop hl
    pop de
    inc de
    inc de
    inc de
    pop bc
    dec b
    jp nz, applyMaskLoop
    ret
doNotApplyOverlap: ;08:4392
	ret

; hl: sprite tiles buffer address
ApplyMaskOffsetOnSpriteAddr:: ;08:4393
    push de
    ld a, [wMaskOnSpriteOffset]
    add a
    ld e, a
    ld d, $00
    add hl, de
    pop de
    ret

;08:439E