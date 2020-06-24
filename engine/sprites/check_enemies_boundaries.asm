checkEnemyBoundaries: ;FC:41E4
    ld de, wNPCEntitiesDataStructs
    ld b, 7
checkEnemyLoop:
    push bc
    push de
    ld hl, wEntityId - wEntityStructData
    add hl, de
    ld a, [hl]
    cp a, ZOMBIE
    jp c, checkNextEnemy ; is not enemy
    cp a, NON_ENEMIES_CHARS
    jp nc, checkNextEnemy ; is not enemy
; entity is zombie or yawn
    ld hl, wEntityState - wEntityStructData
    add hl, de
    ld a, [hl]
    and a, ENTITY_VISIBLE_FLAG
    jp z, checkNextEnemy ; skip if not visible
    ld hl, wEntityAnimationId - wEntityStructData
    add hl, de
    ld a, [hl]
    cp a, DEAD_ANIM
    jp z, checkNextEnemy ; skip if enemy is dead
    ld hl, wZombieAndObjectVarId - wEntityStructData
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
    add hl, hl
    ld bc, enemyBoundariesTable
    add hl, bc
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld c, e ; de to bc
    ld b, d
    ld a, c
    add a, wEntityPositionX - wEntityStructData
    ld c, a
    ld a, b
    adc a, $00
    ld b, a
    ld a, [bc]
    sub a, [hl] ; enemyPosX - limitPosX
    inc hl ; limitPosXHigh
    inc bc ; wEntityPositionX+1
    ld a, [bc]
    sbc a, [hl]
    cp a, 192
    jr c, .Label3F0238 ; jump if distance < 192
    dec hl ; limitPosXLow
    dec bc ; wEntityPositionX
    ld a, [hli] ; limitPosXHigh
    ld [bc], a ; set enemyPosX = limitPosX
    inc bc ; wEntityPositionX+1
    ld a, [hl]
    ld [bc], a
.Label3F0238
    dec bc ; wEntityPositionX
    inc hl ; next limitPosX (low)
    ld a, [bc]
    sub a, [hl] ;enemyPosX - limitPosX
    inc hl ;limitPosX (high)
    inc bc ;wEntityPositionX+1
    ld a, [bc]
    sbc a, [hl]
    cp a, 64
    jr nc, .Label3F0259 ; jump if distance > 64
    dec hl ; limit X low
    dec bc ; wEntityPositionX
    ld a, [hli]
    ld [bc], a ; set limit X low to enemy pos X low
    inc bc ; wEntityPositionX+1
    ld a, [hl]
    ld [bc], a ; set limit X high to enemy pos X high
    push hl
    ld hl, wEntityAnimationId - wEntityStructData
    add hl, de
    ld [hl], IDLE_ANIM
    ld hl, wEntityAnimationFrameId - wEntityStructData
    add hl, de
    ld [hl], 0
    pop hl
.Label3F0259
    inc hl ; wEntityPositionZ
    inc bc ; limit Z low
    ld a, [bc]
    sub a, [hl] ; enemyPosZ - limitPosZ
    inc hl ; limit Z high
    inc bc ; wEntityPositionZ+1
    ld a, [bc]
    sbc a, [hl]
    cp a, 192
    jr c, .Label3F027A ; jump if z-distance < 192
    dec hl ;limit Z low
    dec bc ; wEntityPositionZ
    ld a, [hli]
    ld [bc], a ; set limit Z low to enemy pos Z low
    inc bc
    ld a, [hl]
    ld [bc], a ;set limit Z high to enemy pos Z high
    push hl
    ld hl, wEntityAnimationId - wEntityStructData
    add hl, de
    ld [hl], IDLE_ANIM
    ld hl, wEntityAnimationFrameId - wEntityStructData
    add hl, de
    ld [hl], 0
    pop hl
.Label3F027A
    dec bc  ;wEntityPositionZ
    inc hl ; next limitPosZ (low)
    ld a, [bc]
    sub a, [hl] ; enemyPosZ - limitPosZ
    inc hl ; limitPosZ high
    inc bc ; wEntityPositionZ+1
    ld a, [bc]
    sbc a, [hl]
    cp a, 64
    jr nc, checkNextEnemy ; jump if Z-distance > 64
    dec hl
    dec bc
    ld a, [hli]
    ld [bc], a ; set limit Z low to enemy pos Z low
    inc bc
    ld a, [hl]
    ld [bc], a ; set limit Z high to enemy pos Z high
    push hl
    ld hl, wEntityAnimationId - wEntityStructData
    add hl, de
    ld [hl], IDLE_ANIM
    ld hl, wEntityAnimationFrameId - wEntityStructData
    add hl, de
    ld [hl], 0
    pop hl
checkNextEnemy:
    pop de
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop bc
    dec b
    jp nz, checkEnemyLoop
    ret
;42AA
