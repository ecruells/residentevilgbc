checkZombiesAttackCollision: ;FB:5211
    ld de, wNPCEntitiesDataStructs
    ld b, 7
checkZombiesAttackLoop:
    push bc
    push de
    ld hl, wEntityId - wEntityStructData
    add hl, de
    ld a, [hl]
    cp a, ZOMBIE
    jp z, .Label3ED225
    jp checkNextZombieAttack
.Label3ED225
    ld hl, wEntityAnimationId - wEntityStructData
    add hl, de
    ld a, [hl]
    cp a, ATTACK_ANIM
    jp z, checkNextZombieAttack ; skip if is already attacking
    cp a, DEAD_ANIM
    jp z, checkNextZombieAttack ; skip if dead
    ld hl, wEntityHealth - wEntityStructData
    add hl, de
    ld a, [hl]
    or a ; 0
    jp z, checkNextZombieAttack ; skip if dead
    ld hl, wEntityState - wEntityStructData
    add hl, de
    ld a, [hl]
    and a, ENTITY_VISIBLE_FLAG
    jp z, resetZombieAnimation ; reset animation and skip if not visible
;
; set attack collision box of 18x18 map units
    ld hl, wEntityPositionX - wEntityStructData
    add hl, de
    ld e, [hl]
    inc hl ; wEntityPositionX+1
    ld d, [hl]
    call div8WordFB
    ld hl, -9
    add hl, de
    ld a, l
    ld [wColliderRectRightX], a
    ld a, h
    ld [wColliderRectRightX+1], a
    ld de, 18
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
    ld hl, -9
    add hl, de
    ld a, l
    ld [wColliderRectBottomY], a
    ld a, h
    ld [wColliderRectBottomY+1], a
    ld de, 18
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
    jr z, .notAttackHitDetected ; if not collision detected
; if zombie attack hits
    pop de
    push de
    ld a, [wMoveInputBlockTimer]
    or a
    jr z, beginZombieAttack
    and a, $07
    jr nz, checkNextZombieAttack
    ld a, [wEntityAnimationId]
    cp a, GET_DAMAGED_ANIM
    jr nz, checkNextZombieAttack
    ld a, ZOMBIE_BYTE_SFX
    call playSFX
    jr checkNextZombieAttack
.notAttackHitDetected
    pop de
    push de
    ld hl, wEntityAnimationId - wEntityStructData
    add hl, de
    ld a, [hl]
    cp a, ATTACK_ANIM
    jr nz, checkNextZombieAttack ; skip if not attacking
; reset zombie animation
    ld [hl], IDLE_ANIM
    ld hl, wEntityAnimationFrameId - wEntityStructData
    add hl, de
    ld [hl], 0
    jr checkNextZombieAttack

beginZombieAttack:
    ld hl, wEntityAnimationId - wEntityStructData
    add hl, de
    ld [hl], ATTACK_ANIM
    ld hl, wEntityAnimationFrameId - wEntityStructData
    add hl, de
    ld [hl], 0
    ld a, 40 ; set attack duration
    ld [wMoveInputBlockTimer], a
    ld a, GET_DAMAGED_ANIM ; set player getting damage anim
    ld [wEntityAnimationId], a
    ld a, [wEntityHealth]
    or a ; 0
    jr z, checkNextZombieAttack ; skip if player is dead
    cp a, 9
    jr c, .setPlayerHealthZero ; if player health is below 9
; substract zombie bite damage from player health
    sub a, ZOMBIE_BITE_DAMAGE
    ld [wEntityHealth], a
    ld a, ZOMBIE_BYTE_SFX
    call playSFX
    jr checkNextZombieAttack
.setPlayerHealthZero
    xor a ; 0
    ld [wEntityHealth], a
    ld a, SET_FADE_OUT ; game over fade-out
    ld [wPaletteFadeCounter], a
    jr checkNextZombieAttack

resetZombieAnimation:
    ld hl, wEntityAnimationId - wEntityStructData
    add hl, de
    ld [hl], IDLE_ANIM
    ld hl, wEntityAnimationFrameId - wEntityStructData
    add hl, de
    ld [hl], $00

checkNextZombieAttack:
    pop de
    ld hl, $20
    add hl, de
    ld e, l
    ld d, h
    pop bc
    dec b
    jp nz, checkZombiesAttackLoop
    ret
;532C

detectZombieProximityCollision: ;FB:532C
    ld a, [wColliderRectRightX]
    sub a, e
    ld a, [wColliderRectRightX+1]
    sbc a, d
    cp a, $FF
    jr nz, notZombieAttackCollision
    ld a, [wColliderRectLeftX]
    sub a, e
    ld a, [wColliderRectLeftX+1]
    sbc a, d
    or a
    jr nz, notZombieAttackCollision
    ld a, [wColliderRectBottomY]
    sub a, l
    ld a, [wColliderRectBottomY+1]
    sbc a, h
    cp a, $FF
    jr nz, notZombieAttackCollision
    ld a, [wColliderRectTopY]
    sub a, l
    ld a, [wColliderRectTopY+1]
    sbc a, h
    or a
    jr nz, notZombieAttackCollision
    ld a, $FF
    ret
;535D

notZombieAttackCollision: ;FB:535D
    xor a
    ret
;535F