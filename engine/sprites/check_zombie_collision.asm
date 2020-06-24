; check for zombie collision with player.
; set a collision box of 12x12 map units
checkZombieCollision:
    ld hl, wEntityPositionX - wEntityStructData ;$11
    add hl, de
    ld e, [hl]
    inc hl ;wEntityPositionX+1
    ld d, [hl]
    call div8WordFB
    ld hl, -6
    add hl, de
    ld a, l
    ld [wColliderRectRightX], a
    ld a, h
    ld [wColliderRectRightX+1], a
    ld de, 12
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
    ld hl, -6
    add hl, de
    ld a, l
    ld [wColliderRectBottomY], a
    ld a, h
    ld [wColliderRectBottomY+1], a
    ld de, 12
    add hl, de
    ld a, l
    ld [wColliderRectTopY], a
    ld a, h
    ld [wColliderRectTopY+1], a
    ld a, [wEntityPositionX]
    ld e, a
    ld a, [wEntityPositionX+1]
    ld d, a
    call div8WordFB
    push de ; store player x-pos into DE
    ld a, [wEntityPositionZ]
    ld e, a
    ld a, [wEntityPositionZ+1]
    ld d, a
    call div8WordFB
    ld l, e
    ld h, d ; store player z-pos into HL
    pop de
    call detectZombieCollision
checkNextSpriteCollision:
    pop de
    ld hl, $20
    add hl, de
    ld e, l
    ld d, h
    pop bc
    dec b
    jp nz, checkSpriteCollisionLoop
    call checkZombiesProximity
    jp checkZombiesAttackCollision
;4FBD