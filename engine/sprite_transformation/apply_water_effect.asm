; apply a dittering effect on the bottom half of the sprite to simulate a
; submerged in water effect for flooded rooms
applyWaterEffectOnSprite: ;04:4A33
    ld a, [wFloodedRoomsDrainedWaterFlag]
    or a
    ret nz ; return if flooded rooms water was drained
; check if room is a flooded one
    ld a, [wRoomId]
    cp a, AQUA_TANK_ROOM
    jr z, .Label10A48
    cp a, AQUA_TANK_CONTROL_ROOM
    jr z, .Label10A48
    cp a, PLANT_42_ROOTS_ROOM
    jr z, .Label10A48
    ret
.Label10A48
    ld a, [wCurrentSpriteHeight]
    srl a
    ld b, a ; height / 2
    ld a, [wCurrentSpriteHeight]
    sub a, b
    add a
    add a, l
    ld l, a
    ld a, 0
    adc a, h
    ld h, a
    ld c, 4
.loop10A5B
    push bc
    push hl
    ld a, [wCurrentSpriteHeight]
    srl a
    ld b, a
    ld c, $AA
.loop10A65
    ld a, [hl]
    and a, c
    ld [hli], a
    ld a, [hl]
    and a, c
    ld [hli], a
    ld a, c
    xor a, $FF
    ld c, a
    dec b
    jr nz, .loop10A65
    pop hl
    ld a, [wCurrentSpriteHeight]
    and a, $F0
    ld c, a
    ld a, [wCurrentSpriteHeight]
    and a, $0F
    jr z, .Label10A84
    ld a, c
    add a, 16
    ld c, a
.Label10A84
    sla c
    ld b, 0
    add hl, bc
    pop bc
    dec c
    jr nz, .loop10A5B
    ret
;4A8E
