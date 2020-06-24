; compare player collision box with objects or zombies.
; if objects, evaluate objects push and step ladders elevation
; if zombies, evaluate zombie facing toward player and attack collision
checkSpritesCollision:: ;FB:4C94
    ld de, wNPCEntitiesDataStructs
    ld b, 7
checkSpriteCollisionLoop:
    push bc
    push de
    ld hl, wEntityState - wEntityStructData
    add hl, de
    ld a, [hl]
    and a, ENTITY_VISIBLE_FLAG
    jp z, checkNextSpriteCollision ; if sprite is not visible
    ld hl, wEntityId - wEntityStructData
    add hl, de
    ld a, [hl]
    cp a, ZOMBIE
    jp z, checkZombieCollision
    cp a, OBJECTS
    jp nc, checkObjectCollision
    jp checkNextSpriteCollision
