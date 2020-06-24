updateRoomGasDamage: ;04:4C34
    ld a, [wRoomId]
    cp a, OPERATING_MORGE_ROOM
    jr z, .Label10C40
    cp a, ARMORS_ROOM
    jr z, .Label10C40
    ret
.Label10C40
    ld a, [wRoomGasActivatedFlag]
    or a
    ret z
    ld a, [wTicksCounter]
    and a, 3 ; decrease player health every 3 ticks
    ret nz
    ld a, [wEntityHealth]
    or a
    ret z ; return if player health is zero
    dec a
    ld [wEntityHealth], a  ;decrease player health by 1
    or a
    ret nz
    ld a, SET_FADE_OUT
    ld [wPaletteFadeCounter], a ; fade-out if player is dead by gas
    ret
;4C5C
