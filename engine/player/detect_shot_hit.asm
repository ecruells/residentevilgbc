detectEnemiesShotHit: ;FC:49B0
    ld de, wNPCEntitiesDataStructs
    ld b, 7
.detectShootHitLoop
    push bc
    push de
    ld hl, wEntityState - wEntityStructData
    add hl, de
    ld a, [hl]
    and a, ENTITY_VISIBLE_FLAG
    jr z, .checkNextEnemy ; skip if enemy is not visible
    ld hl, wEntityId - wEntityStructData
    add hl, de
    ld a, [hl]
    cp a, ZOMBIE
    jr z, .detectZombieShootHit
    jr .checkNextEnemy ; skip if not a zombie
.detectZombieShootHit
    ld hl, wEntityHealth - wEntityStructData
    add hl, de
    ld a, [hl]
    or a
    jr z, .checkNextEnemy ; skip if zombie is dead
    call detectShotHit
.checkNextEnemy 
    pop de
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop bc
    dec b
    jr nz, .detectShootHitLoop
    ret

detectShotHit: ;FC:49E4
    ld a, [wEntityFacing]
    cp a, FACING_SOUTH_WEST
    jp z, detectSouthWestShotHit
    cp a, FACING_SOUTH
    jp z, detectSouthShotHit
    cp a, FACING_SOUTH_EAST
    jp z, detectSouthEastShotHit
    cp a, FACING_EAST
    jp z, detectEastShotHit
    cp a, FACING_NORTH_EAST
    jp z, detectNorthEastShotHit
    or a ;FACING_NORTH
    jp z, detectNorthShotHit
    cp a, FACING_NORTH_WEST
    jp z, detectNorthWestShotHit
    cp a, FACING_WEST
    jp z, detectWestShotHit
    xor a
    ret

detectSouthEastShotHit: ;FC:4A10
    ld hl, wEntityPositionX - wEntityStructData
    add hl, de
    ld c, [hl]
    inc hl ; wEntityPositionX+1
    ld b, [hl]
    ld a, [wEntityPositionX]
    sub a, c
    ld c, a
    ld a, [wEntityPositionX+1]
    sbc a, b
    ld b, a ; bc = playerX - zombieX
    cp a, HIGH(512)
    jp nc, shotMissed
    ld hl, wEntityPositionZ - wEntityStructData
    add hl, de
    ld a, [hl]
    inc hl
    ld h, [hl]
    ld l, a
    ld a, [wEntityPositionZ]
    sub a, l 
    ld l, a
    ld a, [wEntityPositionZ+1]
    sbc a, h
    ld h, a ; hl = playerZ - zombieZ
    cp a, HIGH(512)
    jp nc, shotMissed
    ld a, l
    sub a, c
    ld c, a
    ld a, h
    sbc a, b
    ld b, a
    or a ;HIGH(64)
    jr z, .Label3F0A54
    cp a, HIGH(-64)
    jp nz, shotMissed
    ld a, c
    cp a, LOW(-64)
    jp c, shotMissed
    jp applyShotDamage
.Label3F0A54
    ld a, c
    cp a, LOW(64)
    jp nc, shotMissed
    jp applyShotDamage

detectNorthEastShotHit: ;FC:4A5D
    ld hl, wEntityPositionX - wEntityStructData
    add hl, de
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, [wEntityPositionX]
    sub a, c
    ld c, a
    ld a, [wEntityPositionX+1]
    sbc a, b
    ld b, a ; bc = playerX - zombieX
    cp a, HIGH(512)
    jp nc, shotMissed
    ld hl, wEntityPositionZ - wEntityStructData
    add hl, de
    ld a, [hl]
    inc hl
    ld h, [hl]
    ld l, a
    ld a, [wEntityPositionZ]
    sub a, l
    ld l, a
    ld a, [wEntityPositionZ+1]
    sbc a, h
    ld h, a ; hl = playerX - zombieX
    cp a, HIGH(-512)
    jp c, shotMissed
    ld a, $00
    sub a, l
    ld l, a
    ld a, $00
    sbc a, h
    ld h, a ; 0 - hl
    ld a, l
    sub a, c
    ld c, a
    ld a, h
    sbc a, b
    ld b, a ; bc = hl - bc
    or a ;HIGH(64)
    jr z, .Label3F0AA9
    cp a, HIGH(-64)
    jp nz, shotMissed
    ld a, c
    cp a, LOW(-64)
    jp c, shotMissed
    jp applyShotDamage
.Label3F0AA9
    ld a, c
    cp a, LOW(64)
    jp nc, shotMissed
    jp applyShotDamage

detectSouthWestShotHit: ;FC:4AB2
    ld hl, wEntityPositionX - wEntityStructData
    add hl, de
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, [wEntityPositionX]
    sub a, c
    ld c, a
    ld a, [wEntityPositionX+1]
    sbc a, b
    ld b, a ; bc = playerX - zombieX
    cp a, HIGH(-512)
    jp c, shotMissed
    ld a, $00
    sub a, c
    ld c, a
    ld a, $00
    sbc a, b
    ld b, a ; bc = 0 - zombieX
    ld hl, wEntityPositionZ - wEntityStructData
    add hl, de
    ld a, [hl]
    inc hl
    ld h, [hl]
    ld l, a
    ld a, [wEntityPositionZ]
    sub a, l
    ld l, a
    ld a, [wEntityPositionZ+1]
    sbc a, h
    ld h, a ; hl = playerZ - zombieZ
    cp a, HIGH(512)
    jp nc, shotMissed
    ld a, l
    sub a, c
    ld c, a
    ld a, h
    sbc a, b
    ld b, a ; bc = hl - bc
    or a ; HIGH(64)
    jr z, .Label3F0AFE ; diff < 256 ($100)
    cp a, HIGH(-64)
    jp nz, shotMissed
    ld a, c
    cp a, LOW(-64)
    jp c, shotMissed
    jp applyShotDamage
.Label3F0AFE
    ld a, c
    cp a, LOW(64)
    jp nc, shotMissed
    jp applyShotDamage

detectNorthWestShotHit: ;FC:4B07
    ld hl, wEntityPositionX - wEntityStructData
    add hl, de
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, [wEntityPositionX]
    sub a, c
    ld c, a
    ld a, [wEntityPositionX+1]
    sbc a, b
    ld b, a ; bc = playerX - zombieX
    cp a, HIGH(-512)
    jp c, shotMissed
    ld a, 0
    sub a, c
    ld c, a
    ld a, 0
    sbc a, b
    ld b, a ; bc = 0 - bc
    ld hl, wEntityPositionZ - wEntityStructData
    add hl, de
    ld a, [hl]
    inc hl
    ld h, [hl]
    ld l, a
    ld a, [wEntityPositionZ]
    sub a, l
    ld l, a
    ld a, [wEntityPositionZ+1]
    sbc a, h
    ld h, a ; hl = playerZ - zombieZ
    cp a, HIGH(-512)
    jp c, shotMissed
    ld a, 0
    sub a, l
    ld l, a
    ld a, 0
    sbc a, h
    ld h, a ; 0 - zombieZ
    ld a, l
    sub a, c
    ld c, a
    ld a, h
    sbc a, b
    ld b, a ; 
    or a ;HIGH(64)
    jr z, .Label3F0B5B
    cp a, HIGH(-64)
    jp nz, shotMissed
    ld a, c
    cp a, LOW(-64)
    jp c, shotMissed
    jp applyShotDamage
.Label3F0B5B
    ld a, c
    cp a, LOW(64)
    jp nc, shotMissed
    jp applyShotDamage

detectSouthShotHit: ;FC:4B64
    ld hl, wEntityPositionX - wEntityStructData
    add hl, de
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, [wEntityPositionX]
    sub a, c
    ld c, a
    ld a, [wEntityPositionX+1]
    sbc a, b
    ld b, a ; bc = playerX - zombieX
    or a ;HIGH(96)
    jr z, .Label3F0B85
    cp a, HIGH(-96)
    jp nz, shotMissed
    ld a, c
    cp a, LOW(-96)
    jp c, shotMissed
    jr .Label3F0B8B
.Label3F0B85
    ld a, c
    cp a, LOW(96)
    jp nc, shotMissed
.Label3F0B8B
    ld hl, wEntityPositionZ - wEntityStructData
    add hl, de
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, [wEntityPositionZ]
    sub a, c
    ld c, a
    ld a, [wEntityPositionZ+1]
    sbc a, b
    ld b, a ; bc = playerZ - zombieZ
    cp a, HIGH(512)
    jp nc, shotMissed
    jp applyShotDamage

detectEastShotHit: ;FC:4BA4
    ld hl, wEntityPositionZ - wEntityStructData
    add hl, de
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, [wEntityPositionZ]
    sub a, c
    ld c, a
    ld a, [wEntityPositionZ+1]
    sbc a, b
    ld b, a ; bc = playerZ - zombieZ
    or a ;HIGH(96)
    jr z, .Label3F0BC5
    cp a, HIGH(-96)
    jp nz, shotMissed
    ld a, c
    cp a, LOW(-96)
    jp c, shotMissed
    jr .Label3F0BCB
.Label3F0BC5
    ld a, c
    cp a, LOW(96)
    jp nc, shotMissed
.Label3F0BCB
    ld hl, wEntityPositionX - wEntityStructData
    add hl, de
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, [wEntityPositionX]
    sub a, c
    ld c, a
    ld a, [wEntityPositionX+1]
    sbc a, b
    ld b, a ; bc = playerX - zombieX
    cp a, HIGH(512)
    jp nc, shotMissed
    jr applyShotDamage

detectNorthShotHit: ;FC:4BE3
    ld hl, wEntityPositionX - wEntityStructData
    add hl, de
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, [wEntityPositionX]
    sub a, c
    ld c, a
    ld a, [wEntityPositionX+1]
    sbc a, b
    ld b, a ; bc = playerX - zombieX
    or a ;HIGH(96)
    jr z, .Label3F0C04
    cp a, HIGH(-96)
    jp nz, shotMissed
    ld a, c
    cp a, LOW(-96)
    jp c, shotMissed
    jr .Label3F0C0A
.Label3F0C04
    ld a, c
    cp a, LOW(96)
    jp nc, shotMissed
.Label3F0C0A
    ld hl, wEntityPositionZ - wEntityStructData
    add hl, de
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, [wEntityPositionZ]
    sub a, c
    ld c, a
    ld a, [wEntityPositionZ+1]
    sbc a, b
    ld b, a ; bc = playerZ - zombieZ
    cp a, HIGH(-512)
    jp c, shotMissed
    jr applyShotDamage

detectWestShotHit: ;FC:4C22
    ld hl, wEntityPositionZ - wEntityStructData
    add hl, de
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, [wEntityPositionZ]
    sub a, c
    ld c, a
    ld a, [wEntityPositionZ+1]
    sbc a, b
    ld b, a ; bc = playerZ - zombieZ
    or a ;HIGH(96)
    jr z, .Label3F0C43
    cp a, HIGH(-96)
    jp nz, shotMissed
    ld a, c
    cp a, LOW(-96)
    jp c, shotMissed
    jr .Label3F0C49
.Label3F0C43
    ld a, c
    cp a, LOW(96)
    jp nc, shotMissed
.Label3F0C49
    ld hl, wEntityPositionX - wEntityStructData
    add hl, de
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, [wEntityPositionX]
    sub a, c
    ld c, a
    ld a, [wEntityPositionX+1]
    sbc a, b
    ld b, a ; bc = playerX - zombieX
    cp a, HIGH(-512)
    jp c, shotMissed
    jr applyShotDamage

applyShotDamage:
    ld c, BERRETTA_DAMAGE
    ld a, [wEquippedItemId]
    cp a, BERRETTA
    jr z, .Label3F0C6C
; if shotgun
    ld c, SHOTGUN_DAMAGE
.Label3F0C6C
    ld hl, wEntityHealth - wEntityStructData
    add hl, de
    ld a, [hl]
    or a
    jp z, shotMissed ; if zombie is already dead
; set blood frames counter
    ld hl, wBloodFramesId - wEntityStructData
    add hl, de
    ld [hl], $80
; decrease enemy health
    ld hl, wEntityHealth - wEntityStructData
    add hl, de
    ld a, [hl]
    sub a, c
    ld [hl], a
    jp nc, shotMissed ; applied shot does not kill the enemy
; shot kills enemy
    ld [hl], 0
; update animations
    ld hl, wEntityAnimationId - wEntityStructData
    add hl, de
    ld [hl], DEAD_ANIM
    ld hl, wEntityAnimationFrameId - wEntityStructData
    add hl, de
    ld [hl], 0
    ld hl, wZombieAndObjectVarId - wEntityStructData
    add hl, de
    ld c, [hl]
    ld b, 0
    ld hl, wEnemiesAndObjectsFlags
    add hl, bc
    ld [hl], 0  ; set enemy dead
    ld a, ZOMBIE_DEATH_SFX
    call playSFX
    ld a, $FF
    ret
;4CA8

shotMissed: ;FC:4CA8
    xor a
    ret
;4CAA
