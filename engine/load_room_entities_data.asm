; reset all non player entities data structs, then load all current room's entities data
loadRoomEntitiesData:: ;C5:6ADC
    ld hl, wNPCEntitiesDataStructs
    ld b, 7
.resetEntitiesLoop
    ld c, $20 ; entity data struct length
.resetDataLoop
    ld [hl], 0
    inc hl
    dec c
    jr nz, .resetDataLoop
    dec b
    jr nz, .resetEntitiesLoop
    xor a
    ld [wRoomGasActivatedFlag], a ; reset poison gas flag
; reset non player entities again (?). TODO: remove repeated code
    ld hl, wNPCEntitiesDataStructs
    ld b, 7
.resetEntitiesLoop2
    ld c, $20
.resetDataLoop2
    ld [hl], 0
    inc hl
    dec c
    jr nz, .resetDataLoop2
    dec b
    jr nz, .resetEntitiesLoop2
; get room actions data
    ld a, [wRoomId]
    ld l, a
    ld a, [wRoomIdHigh]
    ld h, a
    add hl, hl
    ld de, roomsActionsDatatable
    add hl, de
    ld a, [hl]
    inc hl
    ld h, [hl]
    ld l, a
loadRoomEntitiesLoop:
    ld a, [hl]
    cp a, $FF
    jr z, .allRoomEntitiesLoaded
    cp a, ZOMBIE
    jp z, loadRoomEntityData
    cp a, YAWN
    jp z, loadRoomEntityData
    cp a, REBECCA
    jp z, loadRoomEntityData
    cp a, OBJECTS
    jp nc, loadRoomObjectEntityData
    ld de, 11 ; next room entity data
    add hl, de
    jr loadRoomEntitiesLoop
.allRoomEntitiesLoaded
    ret

loadRoomEntityData: ;C5:6B31
    push hl
    ld c, l
    ld b, h
    call getFirstEmptyNPCDataSlot
    inc bc
    ld hl, wEnemiesAndObjectsFlags
    ld a, [bc]
    add a, l
    ld l, a
    ld a, 0
    adc a, h
    ld h, a
    ld a, [hl]
    or a
    jr nz, .loadEntityData
; enemy is death, load next entity
    pop hl
    ld de, 11
    add hl, de
    jr loadRoomEntitiesLoop
.loadEntityData
    dec bc
    ld hl, wEntityState - wEntityStructData
    add hl, de
    ld [hl], ENTITY_ENABLED_FLAG
    ld hl, wEntityId - wEntityStructData
    add hl, de
    ld a, [bc]
    ld [hl], a
    inc bc
    ld hl, wZombieAndObjectVarId - wEntityStructData
    add hl, de
    ld a, [bc]
    ld [hl], a
    inc hl ; wZombieAndObjectVarIdHigh
    inc bc
    ld a, [bc]
    ld [hl], a
    inc hl
    inc bc
    ld hl, wEntityPositionX - wEntityStructData
    add hl, de
    ld a, [bc]
    ld [hl], a
    inc hl ; wEntityPositionX+1
    inc bc
    ld a, [bc]
    ld [hl], a
    inc hl ; wEntityPositionZ
    inc bc
    ld a, [bc]
    ld [hl], a
    inc hl ; wEntityPositionZ+1
    inc bc
    ld a, [bc]
    ld [hl], a
    inc hl
    inc bc
    ld hl, wFiregunFramesId - wEntityStructData
    add hl, de
    ld [hl], 0
    ld hl, wBloodFramesId - wEntityStructData
    add hl, de
    ld [hl], 0
    ld hl, wEntityAnimationId - wEntityStructData
    add hl, de
    ld [hl], 0
    ld hl, wEntityAnimationFrameId - wEntityStructData
    add hl, de
    ld [hl], 0
    ld hl, wEntityDataC308 - wEntityStructData
    add hl, de
    ld [hl], 0
    ld hl, wEntityFacing - wEntityStructData
    add hl, de
    ld a, [bc]
    ld [hl], a
    inc bc
    ld hl, wWeaponBlockTimer - wEntityStructData 
    add hl, de
    ld [hl], 0
    ld hl, wEntityHealth - wEntityStructData
    add hl, de
    ld [hl], ZOMBIE_HP
    pop hl
    ld de, 11 ;structure length
    add hl, de
    jp loadRoomEntitiesLoop

loadRoomObjectEntityData: ;C5:6BB4
    push hl ; object sprite id
    ld c, l
    ld b, h
    call getFirstEmptyNPCDataSlot
    inc bc
    ld hl, wEnemiesAndObjectsFlags
    ld a, [bc] ; object var id
    add a, l
    ld l, a
    ld a, 0
    adc a, h
    ld h, a
    ld a, [hl] ; get object var data
    or a
    jr nz, .loadObjectEntityData
; object is disabled, jump to next entity data
    pop hl
    ld de, 11
    add hl, de
    jp loadRoomEntitiesLoop
.loadObjectEntityData
    dec bc
    ld hl, wEntityState - wEntityStructData
    add hl, de
    ld [hl], ENTITY_ENABLED_FLAG
    ld hl, wEntityId - wEntityStructData
    add hl, de
    ld a, [bc]
    ld [hl], a
    inc bc
    ld hl, wZombieAndObjectVarId - wEntityStructData
    add hl, de
    ld a, [bc]
    ld [hl], a
    inc hl
    inc bc
    ld a, [bc]
    ld [hl], a
    inc hl
    inc bc
    ld hl, wEntityPositionX - wEntityStructData
    add hl, de
    ld a, [bc]
    ld [hl], a
    inc hl ; wEntityPositionX+1
    inc bc
    ld a, [bc]
    ld [hl], a
    inc hl ; wEntityPositionZ
    inc bc
    ld a, [bc]
    ld [hl], a
    inc hl ; wEntityPositionZ+1
    inc bc
    ld a, [bc]
    ld [hl], a
    inc hl
    inc bc
    ld hl, wFiregunFramesId - wEntityStructData
    add hl, de
    ld [hl], 0
    ld hl, wBloodFramesId - wEntityStructData
    add hl, de
    ld [hl], 0
    ld hl, wEntityAnimationId - wEntityStructData
    add hl, de
    ld [hl], 0
    ld hl, wEntityAnimationFrameId - wEntityStructData
    add hl, de
    ld [hl], 0
    ld hl, wEntityDataC308 - wEntityStructData
    add hl, de
    ld [hl], 0
    ld hl, wEntityFacing - wEntityStructData
    add hl, de
    ld a, [bc]
    ld [hl], a
    ld hl, wWeaponBlockTimer - wEntityStructData
    add hl, de
    ld [hl], 0
    ld hl, wEntityHealth - wEntityStructData
    add hl, de
    ld [hl], 64
    ld hl, wZombieAndObjectVarId - wEntityStructData
    add hl, de
    ld a, [hl]
    cp a, DORM_002_CLOSET_VARID
    jp z, setDorm002ClosetPosition
loadObjectEntityEnd:
    pop hl
    ld de, 11 ; structure length
    add hl, de
    jp loadRoomEntitiesLoop

setDorm002ClosetPosition:
    ld a, [wDorm002ClosetMovedFlag]
    or a
    jp z, loadObjectEntityEnd
    ld hl, wEntityPositionZ - wEntityStructData
    add hl, de
    push bc
    ld bc, -64 ; sprite position
    ld [hl], c
    inc hl
    ld [hl], b
    pop bc
    jp loadObjectEntityEnd
