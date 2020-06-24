
applyPlayerElevation:: ;0F:5BB0
    xor a
    ld [wEntityPositionY], a
    ld [wEntityPositionY+1], a
    ld a, [wRoomId]
    cp a, EXHIBITION_ROOM
    jp z, .seExhibitionRoomLadderElevation
    cp a, ELEVATOR_STAIRWAY
    jp z, .setElevatorStairwayStairsElevation
    cp a, SHED_ROOM
    jp z, .setShedRoomLadderElevation
    cp a, MAIN_HALL_2F
    jp z, .setMainHall2fEscalatorElevation
    cp a, EAST_STAIRCASE_2F
    jp z, .setEastStaircase2FStairsElevation
    cp a, ATTIC_ENTRY
    jp z, .setAtticEntryStairsElevation
    cp a, COURTYARD_FLOODGATE
    jp z, .setCourtyardFloodgatePoolElevation
    cp a, OPERATING_MORGE_ROOM
    jp z, .seOperatingMorgeRoomLadderElevation
    ret

.setCourtyardFloodgatePoolElevation ;0F:5BE3
    ld a, [wEntityPositionX]
    ld e, a
    ld a, [wEntityPositionX+1]
    ld d, a
    call div8Word0F
    positionDEGte 80
    ld a, [wEntityPositionZ]
    ld e, a
    ld a, [wEntityPositionZ+1]
    ld d, a
    call div8Word0F
    positionDeLt1AndGte2 32, -98
    ld de, -32
    ld a, e
    ld [wEntityPositionY], a
    ld a, d
    ld [wEntityPositionY+1], a
    ret

.setAtticEntryStairsElevation ;0F:5C1A
    ld a, [wRoomCameraId]
    cp a, 1
    ret nz
    ld a, [wEntityPositionZ]
    ld e, a
    ld a, [wEntityPositionZ+1]
    ld d, a
    call div8Word0F
    ld hl, 20
    add hl, de
    ld e, l
    ld d, h
    positionDeLtZero
    ld a, 0
    sub a, e
    inc a ; turn e value positive
    cp a, 16
    jr c, .Label3DC3F ; posZ > 16
    ld a, 15
.Label3DC3F
    ld e, a
    ld d, 0
    ld a, e
    ld [wEntityPositionY], a
    ld a, d
    ld [wEntityPositionY+1], a
    ret

.setEastStaircase2FStairsElevation ;0F:5C4B
    ld a, [wRoomCameraId]
    or a
    ret nz
    ld a, [wEntityPositionX]
    ld e, a
    ld a, [wEntityPositionX+1]
    ld d, a
    call div8Word0F
    ld hl, 80
    add hl, de
    ld e, l
    ld d, h
    positionDeLtZero
    ld a, 0
    sub a, e
    inc a ; turn e value positive
    cp a, 46
    jr c, .Label3DC6F
    ld a, 45
.Label3DC6F
    ld e, a
    ld d, 0
    call reverseWordSign0F
    ld a, e
    ld [wEntityPositionY], a
    ld a, d
    ld [wEntityPositionY+1], a
    ret

.setMainHall2fEscalatorElevation ;0F:5C7E
    ld a, [wRoomCameraId]
    or a
    ret nz
    ld a, [wEntityPositionZ]
    ld e, a
    ld a, [wEntityPositionZ+1]
    ld d, a
    call div8Word0F
    positionDEGte 64
    ld a, [wEntityPositionX]
    ld e, a
    ld a, [wEntityPositionX+1]
    ld d, a
    call div8Word0F
    positionDeGteZeroOrJump .Label3DCC4
    positionDeLt 68
    ld e, a
    ld a, 68
    sub a, e ; 68 - e
    cp a, 40
    jr c, .Label3DCB5
    ld a, 39
.Label3DCB5
    ld e, a
    ld d, 0
    call reverseWordSign0F
    ld a, e
    ld [wEntityPositionY], a
    ld a, d
    ld [wEntityPositionY+1], a
    ret
.Label3DCC4
    ld a, 0
    sub a, e
    inc a
    positionDeLtZLow 68
    ld e, a
    ld a, 68
    sub a, e ; 68 - e
    cp a, 40
    jr c, .Label3DCD5
    ld a, 39
.Label3DCD5
    ld e, a
    ld d, 0
    call reverseWordSign0F
    ld a, e
    ld [wEntityPositionY], a
    ld a, d
    ld [wEntityPositionY+1], a
    ret

.setElevatorStairwayStairsElevation ;0F:5CE4
    ld a, [wRoomCameraId]
    cp a, 2
    jr nc, .Label3DD0D
    ld a, [wEntityPositionZ]
    ld e, a
    ld a, [wEntityPositionZ+1]
    ld d, a
    call div8Word0F
    positionDeGteZeroOrJumpV2 .Label3DD0D
    ld a, e
    cp a, 48
    jr c, .Label3DD02
    ld e, 47
.Label3DD02
    call reverseWordSign0F
    ld a, e
    ld [wEntityPositionY], a
    ld a, d
    ld [wEntityPositionY+1], a
.Label3DD0D
    ret

.seExhibitionRoomLadderElevation ;0F:5D0E
    ld a, [wStepLadderElevationMode]
    or a
    ret z
    ld a, [wEntityPositionZ]
    ld e, a
    ld a, [wEntityPositionZ+1]
    ld d, a
    call div8Word0F
    ld bc, 20
    ld a, c
    sub a, e
    ld c, a
    ld a, b
    sbc a, d
    ld b, a
    or a
    ret nz
    ld a, c
    cp a, 7
    jr c, .Label3DD30
    ld a, 7
.Label3DD30
    add a
    add a
    ld [wEntityPositionY], a
    xor a
    ld [wEntityPositionY+1], a
    ret

.setShedRoomLadderElevation ;0F:5D3A
    ld a, [wStepLadderElevationMode]
    or a
    ret z
    ld a, [wEntityPositionX]
    ld e, a
    ld a, [wEntityPositionX+1]
    ld d, a
    call div8Word0F
    ld bc, 8
    ld a, e
    sub a, c
    ld c, a
    ld a, d
    sbc a, b
    ld b, a
    or a
    ret nz
    ld a, c
    cp a, 12
    jr c, .Label3DD5C
    ld a, 12
.Label3DD5C
    srl a
    srl a
    inc a
    add a
    add a
    cp a, 4
    jr nz, .Label3DD69
    ld a, 8
.Label3DD69
    ld [wEntityPositionY], a
    xor a
    ld [wEntityPositionY+1], a
    ret

.seOperatingMorgeRoomLadderElevation ;0F:5D71
    ld a, [wStepLadderElevationMode]
    or a
    ret z
    ld a, [wEntityPositionX]
    ld e, a
    ld a, [wEntityPositionX+1]
    ld d, a
    call div8Word0F
    ld bc, 28
    ld a, c
    sub a, e
    ld c, a
    ld a, b
    sbc a, d
    ld b, a
    or a
    ret nz
    ld a, c
    cp a, 8
    jr c, .Label3DD93
    ld a, 8
.Label3DD93
    add a
    add a
    ld [wEntityPositionY], a
    xor a
    ld [wEntityPositionY+1], a
    ret


;divide a word by 8 in bank 0F
;
; de: 16bit value
div8Word0F:: ;0F:5D9D
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

;reverse a word sign in bank 0F
;
; de: 16bit value
reverseWordSign0F:: ;0F:5DC2
    ld a, 0
    sub a, e
    ld e, a
    ld a, 0
    sbc a, d
    ld d, a
    ret
