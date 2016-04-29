
applyPlayerElevation:: ;0F:5BB0
    xor a
    ld [wSpritePositionYLow], a
    ld [wSpritePositionYHigh], a
    ld a, [wRoomId]
    cp a, EXHIBITION_ROOM
    jp z, .setMapStatueRoomEscalatorElevation
    cp a, ELEVATOR_STAIRWAY
    jp z, .setCorridor0FEscalatorElevation
    cp a, SHED_ROOM
    jp z, .setCrankRoomEscalatorElevation
    cp a, MAIN_HALL_2F
    jp z, .setMainHall2fEscalatorElevation
    cp a, EAST_STAIRCASE_2F
    jp z, .setCorridor24Elevation
    cp a, ATTIC_ENTRY
    jp z, .setCorridor2dElevation
    cp a, COURTYARD_FLOODGATE
    jp z, .setCourtyardPoolElevation
    cp a, OPERATING_MORGE_ROOM
    jp z, .setSurgeryMorgueRoomElevation
    ret

.setCourtyardPoolElevation ;0F:5BE3
    ld a, [wSpritePositionXLow]
    ld e, a
    ld a, [wSpritePositionXHigh]
    ld d, a
    call divideWord0FBy8
    ld a, d
    or a
    ret nz
    ld a, e
    cp a, $50
    ret c
    ld a, [wSpritePositionZLow]
    ld e, a
    ld a, [wSpritePositionZHigh]
    ld d, a
    call divideWord0FBy8
    ld a, d
    or a
    jr z, .Label3DC0A
    ld a, e
    cp a, $9E
    ret c
    jr .Label3DC0E
.Label3DC0A
    ld a, e
    cp a, $20
    ret nc
.Label3DC0E
    ld de, $FFE0
    ld a, e
    ld [wSpritePositionYLow], a
    ld a, d
    ld [wSpritePositionYHigh], a
    ret

.setCorridor2dElevation ;0F:5C1A
    ld a, [wRoomScreen]
    cp a, $01
    ret nz
    ld a, [wSpritePositionZLow]
    ld e, a
    ld a, [wSpritePositionZHigh]
    ld d, a
    call divideWord0FBy8
    ld hl, $14
    add hl, de
    ld e, l
    ld d, h
    ld a, d
    cp a, $FF
    ret nz
    ld a, $00
    sub a, e
    inc a
    cp a, $10
    jr c, .Label3DC3F
    ld a, $0F
.Label3DC3F
    ld e, a
    ld d, $00
    ld a, e
    ld [wSpritePositionYLow], a
    ld a, d
    ld [wSpritePositionYHigh], a
    ret

.setCorridor24Elevation ;0F:5C4B
    ld a, [wRoomScreen]
    or a
    ret nz
    ld a, [wSpritePositionXLow]
    ld e, a
    ld a, [wSpritePositionXHigh]
    ld d, a
    call divideWord0FBy8
    ld hl, $50
    add hl, de
    ld e, l
    ld d, h
    ld a, d
    cp a, $FF
    ret nz
    ld a, $00
    sub a, e
    inc a
    cp a, $2E
    jr c, .Label3DC6F
    ld a, $2D
.Label3DC6F
    ld e, a
    ld d, $00
    call reverseWordSign0F
    ld a, e
    ld [wSpritePositionYLow], a
    ld a, d
    ld [wSpritePositionYHigh], a
    ret

.setMainHall2fEscalatorElevation ;0F:5C7E
    ld a, [wRoomScreen]
    or a
    ret nz
    ld a, [wSpritePositionZLow]
    ld e, a
    ld a, [wSpritePositionZHigh]
    ld d, a
    call divideWord0FBy8
    ld a, d
    or a
    ret nz
    ld a, e
    cp a, $40
    ret c
    ld a, [wSpritePositionXLow]
    ld e, a
    ld a, [wSpritePositionXHigh]
    ld d, a
    call divideWord0FBy8
    ld a, d
    cp a, $FF
    jr z, .Label3DCC4
    or a
    ret nz
    ld a, e
    cp a, $44
    ret nc
    ld e, a
    ld a, $44
    sub a, e
    cp a, $28
    jr c, .Label3DCB5
    ld a, $27
.Label3DCB5
    ld e, a
    ld d, $00
    call reverseWordSign0F
    ld a, e
    ld [wSpritePositionYLow], a
    ld a, d
    ld [wSpritePositionYHigh], a
    ret
.Label3DCC4 ;0F:5CC4
    ld a, $00
    sub a, e
    inc a
    cp a, $44
    ret nc
    ld e, a
    ld a, $44
    sub a, e
    cp a, $28
    jr c, .Label3DCD5
    ld a, $27
.Label3DCD5
    ld e, a
    ld d, $00
    call reverseWordSign0F
    ld a, e
    ld [wSpritePositionYLow], a
    ld a, d
    ld [wSpritePositionYHigh], a
    ret

.setCorridor0FEscalatorElevation ;0F:5CE4
    ld a, [wRoomScreen]
    cp a, $02
    jr nc, .Label3DD0D
    ld a, [wSpritePositionZLow]
    ld e, a
    ld a, [wSpritePositionZHigh]
    ld d, a
    call divideWord0FBy8
    ld a, d
    cp a, $80
    jr nc, .Label3DD0D
    ld a, e
    cp a, $30
    jr c, .Label3DD02
    ld e, $2F
.Label3DD02
    call reverseWordSign0F
    ld a, e
    ld [wSpritePositionYLow], a
    ld a, d
    ld [wSpritePositionYHigh], a
.Label3DD0D
    ret

.setMapStatueRoomEscalatorElevation ;0F:5D0E
    ld a, [wSpriteDataC31F]
    or a
    ret z
    ld a, [wSpritePositionZLow]
    ld e, a
    ld a, [wSpritePositionZHigh]
    ld d, a
    call divideWord0FBy8
    ld bc, $14
    ld a, c
    sub a, e
    ld c, a
    ld a, b
    sbc a, d
    ld b, a
    or a
    ret nz
    ld a, c
    cp a, $07
    jr c, .Label3DD30
    ld a, $07
.Label3DD30
    add a
    add a
    ld [wSpritePositionYLow], a
    xor a
    ld [wSpritePositionYHigh], a
    ret

.setCrankRoomEscalatorElevation ;0F:5D3A
    ld a, [wSpriteDataC31F]
    or a
    ret z
    ld a, [wSpritePositionXLow]
    ld e, a
    ld a, [wSpritePositionXHigh]
    ld d, a
    call divideWord0FBy8
    ld bc, $8
    ld a, e
    sub a, c
    ld c, a
    ld a, d
    sbc a, b
    ld b, a
    or a
    ret nz
    ld a, c
    cp a, $0C
    jr c, .Label3DD5C
    ld a, $0C
.Label3DD5C
    srl a
    srl a
    inc a
    add a
    add a
    cp a, $04
    jr nz, .Label3DD69
    ld a, $08
.Label3DD69
    ld [wSpritePositionYLow], a
    xor a
    ld [wSpritePositionYHigh], a
    ret

.setSurgeryMorgueRoomElevation ;0F:5D71
    ld a, [wSpriteDataC31F]
    or a
    ret z
    ld a, [wSpritePositionXLow]
    ld e, a
    ld a, [wSpritePositionXHigh]
    ld d, a
    call divideWord0FBy8
    ld bc, $1C
    ld a, c
    sub a, e
    ld c, a
    ld a, b
    sbc a, d
    ld b, a
    or a
    ret nz
    ld a, c
    cp a, $08
    jr c, .Label3DD93
    ld a, $08
.Label3DD93
    add a
    add a
    ld [wSpritePositionYLow], a
    xor a
    ld [wSpritePositionYHigh], a
    ret

divideWord0FBy8:: ;0F:5D9D
;divide a word by 8 in bank 0F
    ld a, d
    cp a, $80
    jr c, .Label3DDB5
    call reverseWordSign0F
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    call reverseWordSign0F
    ret
.Label3DDB5
	srl d
    rr e
    srl d
    rr e
    srl d
    rr e
	ret

reverseWordSign0F:: ;0F:5DC2
;reverse a word sign in bank 0F
    ld a, $00
    sub a, e
    ld e, a
    ld a, $00
    sbc a, d
    ld d, a
    ret
