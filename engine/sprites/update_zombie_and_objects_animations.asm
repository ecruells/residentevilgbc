updateZombieAndObjectsAnimation: ;FC:42AA
    ld de, wNPCEntitiesDataStructs
    ld b, 7
updateAnimationLoop:
    push bc
    push de
    ld hl, wEntityState - wEntityStructData
    add hl, de
    ld a, [hl]
    and a, ENTITY_VISIBLE_FLAG
    jr z, nextObjectNPC ; next NPC if sprite is not visible
    ld hl, wEntityId - wEntityStructData
    add hl, de
    ld a, [hl]
    cp a, ZOMBIE
    jp z, updateZombieAnimation
    cp a, OBJECTS
    jr nc, updateObjectSpriteFrame
nextObjectNPC:
    pop de
    pop bc
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    dec b
    jr nz, updateAnimationLoop
    ret
;42D6

objectsSpritesFramesId: ;42D6
	db $00, $20, $10, $10, $30, $00, $40, $50, $50, $60
	db $70, $70, $80, $90, $A0, $B0, $C0, $D0, $E0, $F0

updateObjectSpriteFrame: ;FC:42EA
    ld hl, wEntityId - wEntityStructData
    add hl, de
    ld a, [hl]
    sub a, OBJECTS ; get object Id
    ld c, a
    ld b, 0
    ld hl, objectsSpritesFramesId
    add hl, bc
    ld a, [hli]
    ld hl, wEntityAnimationFrameId - wEntityStructData
    add hl, de
    ld [hl], a ; set frameId
    ld hl, wEntityAnimationId - wEntityStructData
    add hl, de
    ld [hl], IDLE_ANIM
    ld hl, wEntityId - wEntityStructData
    add hl, de
    ld a, [hl]
    cp a, DINNING_ROOM_CLOCK
    jr z, setDinningRoomClockFrame
    cp a, GUARDHOUSE_STATUE
    jr z, updateGuardHouseStatuePosition
    cp a, RESEARCHER_ROOM_SHELF
    jr z, setBookcase1Frame
    cp a, SHED_STEP_LADDER
    jr z, setCrankStepLadderFrame
    cp a, WOODEN_BOX
    jr z, updateWoodenBoxPosition
    cp a, OPERATING_ROOM_LADDER
    jp z, updateOperatingRoomLadderPosition
    jp nextObjectNPC

setDinningRoomClockFrame: ;FC:4325
    ld a, [wRoomCameraId]
    cp a, 5
    jp z, nextObjectNPC
    ld hl, wEntityAnimationFrameId - wEntityStructData
    add hl, de
    ld a, [hl]
    add a, 8
    ld [hl], a ; set next frame
    jp nextObjectNPC

updateGuardHouseStatuePosition: ;FC:4338
    ld a, [wDoorsLocksFlags+DOOR_51]
    or a
    jp z, nextObjectNPC
    ld hl, wEntityPositionZ - wEntityStructData
    add hl, de
    loadPositionZ -233
    jp nextObjectNPC

setBookcase1Frame: ;FC:434B
    ld a, [wRoomCameraId]
    or a ; 0
    jp z, nextObjectNPC
    ld hl, wEntityAnimationFrameId - wEntityStructData
    add hl, de
    ld a, [hl]
    add a, $08
    ld [hl], a ; set next frame
    jp nextObjectNPC

setCrankStepLadderFrame: ;FC:435D
    ld a, [wRoomCameraId]
    cp a, 1
    jp z, nextObjectNPC
    ld hl, wEntityAnimationFrameId - wEntityStructData
    add hl, de
    ld a, [hl]
    add a, $08
    ld [hl], a ; set next frame
    jp nextObjectNPC

updateWoodenBoxPosition: ;FC:4370
    ld a, [wAquariumWoodenBoxSunken]
    or a
    jr nz, .setSunkenBoxPosition
    ld hl, wEntityPositionZ+1 - wEntityStructData
    add hl, de
    ld a, [hld] ; wEntityPositionZ
    or a ; 
    jp nz, nextObjectNPC
    ld a, [hl]
    cp a, 136
    jp c, nextObjectNPC
    ld hl, wEntityPositionY+1 - wEntityStructData
    add hl, de
    ld [hl], HIGH(-20)
    dec hl
    dec [hl]
    ld a, [hl]
    cp a, LOW(-20)
    jp nc, nextObjectNPC
    ld [hl], LOW(-20)
    ld a, $FF
    ld [wAquariumWoodenBoxSunken], a
    jp nextObjectNPC
.setSunkenBoxPosition
    ld hl, wEntityPositionZ - wEntityStructData
    add hl, de
    loadPositionZ 136
    ld hl, wEntityPositionY - wEntityStructData
    add hl, de
    loadPositionY -20
    jp nextObjectNPC

updateOperatingRoomLadderPosition: ;FC:43B2
    ld a, [wDoorsLocksFlags+DOOR_51] ; reused var
    or a
    jp z, nextObjectNPC
    ld hl, wEntityPositionZ - wEntityStructData
    add hl, de
    loadPositionZ -233
    jp nextObjectNPC
;43C5


updateZombieAnimation: ;FC:43C5
    ld a, [wPaletteFadeCounter]
    or a
    jp nz, nextObjectNPC ; skip if fading bg palette
    ld hl, wZombieAndObjectVarId - wEntityStructData
    add hl, de
    ld a, [hl]
    call checkFirstZombieFlag
    or a
    jp z, nextObjectNPC ; next if zombie is disabled (dead)
    ld hl, wEntityAnimationId - wEntityStructData
    add hl, de
    ld a, [hl]
    cp a, DEAD_ANIM
    jp z, nextObjectNPC ; next if zombie is dead
    ld hl, wZombieRecoilTimer - wEntityStructData
    add hl, de
    ld a, [hl]
    or a
    jp nz, updateZombieRecoilAnimation
    ld hl, wEntityAnimationId - wEntityStructData
    add hl, de
    ld a, [hl]
    cp a, ATTACK_ANIM
    jp z, updateZombieAttackAnimation
.setWalkAnimation
    ld hl, wEntityAnimationId - wEntityStructData
    add hl, de
    ld [hl], WALK_ANIM
    ld hl, wEntityAnimationFrameId - wEntityStructData
    add hl, de
    ld a, [hl]
    add a, 2
    and a, $3F ; limit max frame
    ld [hl], a
    ld hl, wEntityFacing - wEntityStructData
    add hl, de
    ld a, [hl]
    and a, $1C ; limit facing
    ld c, a
    ld b, 0
.moveZombie
    ld hl, zombieMoveTable
    add hl, bc
    ld c, l
    ld b, h
    ld hl, wEntityPositionX - wEntityStructData
    add hl, de
    ld a, [bc]
    add a, [hl]
    ld [hli], a
    inc bc ;wEntityPositionX+1
    ld a, [bc]
    adc a, [hl]
    ld [hli], a
    inc bc ;wEntityPositionZ
    ld a, [bc]
    add a, [hl]
    ld [hli], a
    inc bc ;wEntityPositionZ+1
    ld a, [bc]
    adc a, [hl]
    ld [hli], a
    inc bc
    jp nextObjectNPC

updateZombieAttackAnimation:
    ld a, [wMoveInputBlockTimer]
    cp a, $08
    jp nc, nextObjectNPC ; zombie is still attacking
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jp z, nextObjectNPC
; zombie was pushed after attack by pressing A or B button
    ld hl, wZombieRecoilTimer - wEntityStructData
    add hl, de
    ld a, [hl]
    or a
    jp nz, nextObjectNPC ; zombie is still recoiling after attack
    ld [hl], 12 ; recoil timer
    ld a, PUSH_ZOMBIE_SFX
    call playSFX
    jp nextObjectNPC

updateZombieRecoilAnimation:
    ld hl, wZombieRecoilTimer - wEntityStructData
    add hl, de
    dec [hl] ; decrease recoil time
    ld hl, wEntityAnimationId - wEntityStructData
    add hl, de
    ld [hl], WALK_ANIM
    ld hl, wEntityAnimationFrameId - wEntityStructData
    add hl, de
    ld [hl], 0
    ld hl, wEntityFacing - wEntityStructData
    add hl, de
    ld a, [hl]
    add a, $10 ; reverse facing
    and a, $1C
    ld c, a
    ld b, 0
    ld hl, zombieMoveBackwardTable
    add hl, bc
    ld c, l
    ld b, h
    ld hl, wEntityPositionX - wEntityStructData
    add hl, de
    ld a, [bc]
    add a, [hl]
    ld [hli], a
    inc bc ;wEntityPositionX+1
    ld a, [bc]
    adc a, [hl]
    ld [hli], a
    inc bc ;wEntityPositionZ
    ld a, [bc]
    add a, [hl]
    ld [hli], a
    inc bc ;wEntityPositionZ+1
    ld a, [bc]
    adc a, [hl]
    ld [hli], a
    inc bc
    jp nextObjectNPC


INCLUDE "data/entities/zombie_move_table.asm" ;4489


; check if the zombie to update is the first zombie, if it is, return true ($FF)
; if was already seen, otherwise, return false ($00).
; If other zombie, return true.
;
; a: zombie id
checkFirstZombieFlag: ;FC:44C9
    cp a, $04
    jr z, .isFirstZombie
    ld a, $FF
    ret
.isFirstZombie ;FC:44D0
    ld a, [wFirstZombieEventFlag]
    or a
    jr z, .firstZombieInactive
    ld a, $FF
    ret
.firstZombieInactive ;FC:44D9
    xor a
    ret
;44DB
