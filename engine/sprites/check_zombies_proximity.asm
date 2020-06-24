; check zombie proximity with player, if close, face the zombie to the player
checkZombiesProximity: ;FB:535F
    ld de, wNPCEntitiesDataStructs
    ld b, 7
checkZombieProximityLoop:
    push bc
    push de
    ld hl, wEntityState - wEntityStructData
    add hl, de
    ld a, [hl]
    and a, ENTITY_VISIBLE_FLAG
    jp z, checkNextZombie ; skip if not visible
    ld hl, wEntityId - wEntityStructData
    add hl, de
    ld a, [hl]
    cp a, ZOMBIE
    jp nz, checkNextZombie ; skip if not a zombie
    ld hl, wEntityAnimationId - wEntityStructData
    add hl, de
    ld a, [hl]
    cp a, DEAD_ANIM
    jp z, checkNextZombie ; skip if zombie is dead
;
; create a proximity collision box of 96x96 map units
    ld hl, wEntityPositionX - wEntityStructData
    add hl, de
    ld e, [hl]
    inc hl ; wEntityPositionX+1
    ld d, [hl]
    call div8WordFB
    ld hl, -48
    add hl, de
    ld a, l
    ld [wColliderRectRightX], a
    ld a, h
    ld [wColliderRectRightX+1], a
    ld de, 96
    add hl, de
    ld a, l
    ld [wColliderRectLeftX], a
    ld a, h
    ld [wColliderRectLeftX+1], a
    pop de
    push de
    ld hl, wEntityPositionZ - wEntityStructData
    add hl, de
    ld e, [hl]
    inc hl ; wEntityPositionZ+1
    ld d, [hl]
    call div8WordFB
    ld hl, -48
    add hl, de
    ld a, l
    ld [wColliderRectBottomY], a
    ld a, h
    ld [wColliderRectBottomY+1], a
    ld de, 96
    add hl, de
    ld a, l
    ld [wColliderRectTopY], a
    ld a, h
    ld [wColliderRectTopY+1], a
; store player position
    ld a, [wEntityPositionX]
    ld e, a
    ld a, [wEntityPositionX+1]
    ld d, a
    call div8WordFB
    push de
    ld a, [wEntityPositionZ]
    ld e, a
    ld a, [wEntityPositionZ+1]
    ld d, a
    call div8WordFB
    ld l, e
    ld h, d
    pop de
    call detectZombieProximityCollision
    or a
    jp z, checkNextZombie ; skip if zombie is not close
;
; if close, check zombie-player distance and set zombie facing to player
    pop de ; player x-pos
    push de 
    ld b, $80
    ld hl, wEntityPositionX - wEntityStructData
    add hl, de
    ld a, [wEntityPositionX]
    sub a, [hl]
    ld c, a
    inc hl ; wEntityPositionX+1
    ld a, [wEntityPositionX+1]
    sbc a, [hl] ; zombieX - playerX
    or a
    jr z, Label3ED413 ; if x-positions are iqual
    cp a, $FF
    jr z, .Label3ED40A ; if player x position is less than zombie's
    cp a, $80
    jr c, setWestFacing ; if player x position is greater than zombie's
    jr setEastFacing
.Label3ED40A
    ld a, c
    cp a, $C0
    jr nc, Label3ED41A
setEastFacing:
    ld b, FACING_EAST
    jr Label3ED41A
Label3ED413:
    ld a, c
    cp a, $40
    jr c, Label3ED41A
setWestFacing:
    ld b, FACING_WEST
Label3ED41A:
    ld hl, wEntityPositionZ - wEntityStructData
    add hl, de
    ld a, [wEntityPositionZ]
    sub a, [hl]
    ld c, a
    inc hl ; wEntityPositionZ+1
    ld a, [wEntityPositionZ+1]
    sbc a, [hl] ; zombieZ - playerZ
    or a
    jr z, Label3ED44F
    cp a, $FF
    jr z, .Label3ED435
    cp a, $80
    jr c, checkNOrNWFacing
    jr .Label3ED43A
.Label3ED435
    ld a, c
    cp a, $C0
    jr nc, updateZombieFacing
.Label3ED43A
    ld a, b
    and a, $7F
    jr z, .setSouthFacing
    cp a, $08
    jr z, .Label3ED44B
    ld b, FACING_SOUTH_EAST
    jr updateZombieFacing
.setSouthFacing
    ld b, FACING_SOUTH
    jr updateZombieFacing
.Label3ED44B
    ld b, FACING_SOUTH_WEST
    jr updateZombieFacing
Label3ED44F:
    ld a, c
    cp a, $40
    jr c, updateZombieFacing
checkNOrNWFacing:
    ld a, b
    and a, $7F
    jr z, .setNorthFacing
    cp a, $08
    jr z, .setNorthWestFacing
    ld b, FACING_NORTH_EAST
    jr updateZombieFacing
.setNorthFacing
    ld b, FACING_NORTH
    jr updateZombieFacing
.setNorthWestFacing
    ld b, FACING_NORTH_WEST

updateZombieFacing:
    ld hl, wEntityFacing - wEntityStructData
    add hl, de
    ld a, b
    and a, $80
    jr nz, checkNextZombie
    ld a, b
    and a, $1F
    ld [hl], a

checkNextZombie:
    pop de
    ld hl, $20
    add hl, de
    ld e, l
    ld d, h
    pop bc
    dec b
    jp nz, checkZombieProximityLoop
    ret
;5481
