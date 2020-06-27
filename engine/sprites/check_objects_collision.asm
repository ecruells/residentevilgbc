checkObjectCollision:
    ld hl, wEntityId - wEntityStructData
    add hl, de
    ld a, [hl]
    cp a, WOODEN_BOX
    jr nz, getObjectColliderBox
    ld hl, wEntityPositionY+1 - wEntityStructData
    add hl, de
; check collision if woodenBox is not sunken
    ld a, [hld]
    cp a, HIGH(-19)
    jr nz, getObjectColliderBox ; check collision if woodenBox is not sunken (ypos >= -19)
    ld a, [hl]
    cp a, LOW(-19)
    jp c, checkNextSpriteCollision ; if wooden box is sunken, check next objects
getObjectColliderBox
    ld hl, wEntityId - wEntityStructData
    add hl, de
    ld a, [hl]
    ld [wCurrentSpriteCharId], a ; store sprite Id
    sub a, OBJECTS ; get object id
    ld l, a
    ld h, 0
    add hl, hl
    add hl, hl
    add hl, hl
    ld bc, objectEntitiesCollidersTable
    add hl, bc
    ld c, l
    ld b, h ; set collider position to bc
    ld hl, wEntityPositionX - wEntityStructData
    add hl, de
    ld e, [hl]
    inc hl ; wEntityPositionX+1
    ld d, [hl] ; de: x-pos
    call div8WordFB
    ld a, [bc]
    ld l, a
    inc bc
    ld a, [bc]
    ld h, a ; hl: obj collider right border offset
    inc bc
    add hl, de ; obj pos x + collider right offset
    ld a, l
    ld [wColliderRectRightX], a
    ld a, h
    ld [wColliderRectRightX+1], a
    ld a, [bc]
    ld l, a
    inc bc
    ld a, [bc]
    ld h, a ; obj collider left border offset
    inc bc
    add hl, de ; obj pos x + collider right offset
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
    ld a, [bc]
    ld l, a
    inc bc
    ld a, [bc]
    ld h, a
    inc bc
    add hl, de ; obj pos z + collider bottom offset
    ld a, l
    ld [wColliderRectBottomY], a
    ld a, h
    ld [wColliderRectBottomY+1], a
    ld a, [bc]
    ld l, a
    inc bc
    ld a, [bc]
    ld h, a
    inc bc
    add hl, de ; obj pos z + collider top offset
    ld a, l
    ld [wColliderRectTopY], a
    ld a, h
    ld [wColliderRectTopY+1], a
; detect collision with player
    ld a, [wEntityPositionX]
    ld e, a
    ld a, [wEntityPositionX+1]
    ld d, a
    call div8WordFB
    push de ; store player sprite x position
    ld a, [wEntityPositionZ]
    ld e, a
    ld a, [wEntityPositionZ+1]
    ld d, a
    call div8WordFB
    ld l, e
    ld h, d
    pop de
    call detectObjectCollision
    or a
    jp z, checkNextSpriteCollision ; if not collision
; if object collision detected, check if it's a movable object, and move it.
    pop de
    push de
    ld hl, wEntityId - wEntityStructData
    add hl, de
    ld a, [hl]
    cp a, MAP_STEP_LADDER
    jr z, moveCollidingObject
    cp a, JEWEL_STATUE
    jr z, moveCollidingObject
    cp a, GUARDHOUSE_STATUE
    jr z, moveCollidingObject
    cp a, ARMORS_ROOM_STATUE_1
    jr z, moveCollidingObject
    cp a, ARMORS_ROOM_STATUE_2
    jr z, moveCollidingObject
    cp a, WOODEN_RACK
    jr z, moveCollidingObject
    cp a, UNDERGROUND_STATUE
    jr z, moveCollidingObject
    cp a, DORM_002_CLOSET
    jr z, moveCollidingObject
    cp a, XRAY_ROOM_SHELF
    jr z, moveCollidingObject
    cp a, HIDDEN_LIBRARY_STATUE
    jr z, moveCollidingObject
    cp a, WOODEN_BOX
    jr z, moveCollidingObject
    cp a, OPERATING_ROOM_LADDER
    jr z, moveCollidingObject
    cp a, OPERATING_ROOM_BOX
    jr z, moveCollidingObject
    jp checkNextSpriteCollision
moveCollidingObject:
    ld hl, wEntityFacing - wEntityStructData
    add hl, de
    ld a, [wEntityFacing]
    add a, $10 ; reverse facing
    and a, $1F ; set limit
    cp a, [hl]
    jp nz, checkNextSpriteCollision ; if player is not facing object
    ld bc, objectMoveTable
    ld a, [hl]
    and a, $1C
    add a, c
    ld c, a
    ld a, 0
    adc a, b
    ld b, a
    push bc ; store movement offset
; add move offset to object position
    ld hl, wEntityPositionX - wEntityStructData
    add hl, de
    ld a, [bc]
    add a, [hl]
    ld [hl], a
    inc hl ; wEntityPositionX+1
    inc bc
    ld a, [bc]
    adc a, [hl]
    ld [hl], a
    inc hl ; wEntityPositionZ
    inc bc
    ld a, [bc]
    add a, [hl]
    ld [hl], a
    inc hl ; wEntityPositionZ+1
    inc bc
    ld a, [bc]
    adc a, [hl]
    ld [hl], a
    inc hl
    inc bc
; check if the moved object new position triggers an action
    pop bc
    ld hl, wZombieAndObjectVarId - wEntityStructData
    add hl, de
    ld a, [hl]
    cp a, MAP_STEP_LADDER_VARID
    jr z, checkMapStepLadderPlaced
    cp a, JEWEL_STATUE_VARID
    jr z, checkJewelStatueThrownOut
    cp a, GUARDHOUSE_STATUE_VARID
    jp z, guardhouseStatuePlaced
    cp a, ARMORS_ROOM_STATUE_1_VARID
    jr z, armorsRoomStatue1Placed
    cp a, ARMORS_ROOM_STATUE_2_VARID
    jr z, armorsRoomStatue2Placed
    cp a, WOODEN_RACK_VARID
    jp z, woodenRackPlaced
    cp a, UNDERGROUND_STATUE_VARID
    jp z, undergroundStatuePlaced
    cp a, DORM_002_CLOSET_VARID
    jp z, dorm002ClosetMoved
    cp a, HIDDEN_LIBRARY_STATUE_VARID
    jp z, hiddenLibraryStatuePlaced
    cp a, WOODEN_BOX_VARID
    jp z, woodenBoxPlaced
    cp a, OPERATING_ROOM_LADDER_VARID
    jp z, operatingRoomLadderPlaced
    cp a, OPERATING_ROOM_BOX_VARID
    jp z, operatingRoomBoxPlaced
    jp checkNextSpriteCollision
    
checkMapStepLadderPlaced:
    ld hl, wEntityPositionZ+1 - wEntityStructData
    add hl, de
    positionVarLt 2, checkNextSpriteCollision
    ld [hl], 2
    ld a, $FF
    ld [wMansion1FMapStepLadderPushed], a
    jp checkNextSpriteCollision

checkJewelStatueThrownOut:
    ld hl, wEntityPositionZ+1 - wEntityStructData
    add hl, de
    positionVarGte -246, checkNextSpriteCollision
    ld a, FALLING_STATUE_SCENE
    ld [wEventSceneId], a
    jp checkNextSpriteCollision

armorsRoomStatue1Placed:
    ld hl, wEntityPositionX+1 - wEntityStructData
    add hl, de
    positionVarLt -272, checkNextSpriteCollision
    ld [hl], LOW(-272)
    jp checkNextSpriteCollision

armorsRoomStatue2Placed:
    ld hl, wEntityPositionZ+1 - wEntityStructData
    add hl, de
    ld a, [hld]
    or a ; 0
    jp nz, checkNextSpriteCollision
    ld [hl], 0
    jp checkNextSpriteCollision

woodenRackPlaced:
    ld hl, wEntityPositionZ+1 - wEntityStructData
    add hl, de
    ld a, [hld]
    or a
    jp nz, checkNextSpriteCollision
    ld [hl], 0
    jp checkNextSpriteCollision

undergroundStatuePlaced:
    ld hl, wEntityPositionX+1 - wEntityStructData
    add hl, de
    positionVarGte 192, checkNextSpriteCollision
    ld [hl], 192
    ld a, [wUndergroundStatuePlacedFlag]
    or a
    jp nz, checkNextSpriteCollision
    ld a, $FF
    ld [wUndergroundStatuePlacedFlag], a
    ld [wRoomsItemsFlags+ROOM3B_DOOM_BOOK_1], a ; enable doom book pick
    jp checkNextSpriteCollision

dorm002ClosetMoved:
    ld hl, wEntityPositionZ+1 - wEntityStructData
    add hl, de
    positionVarGte -64, checkNextSpriteCollision
    ld [hl], LOW(-64)
    ld a, $FF
    ld [wDorm002ClosetMovedFlag], a
    jp checkNextSpriteCollision

hiddenLibraryStatuePlaced:
    ld hl, wEntityPositionZ+1 - wEntityStructData
    add hl, de
    positionVarLt -560, checkNextSpriteCollision
    ld [hl], LOW(-560)
    ld a, $FF
    ld [wLibrarySecretDoorOpenedFlag], a
    jp checkNextSpriteCollision
woodenBoxPlaced:
    ld hl, wEntityPositionZ+1 - wEntityStructData
    add hl, de
    positionVarGte -120, checkNextSpriteCollision
    ld [hl], LOW(-120)
    jp checkNextSpriteCollision

operatingRoomLadderPlaced:
    ld hl, wEntityPositionX+1 - wEntityStructData
    add hl, de
    positionVarLt 128, checkNextSpriteCollision
    ld [hl], LOW(128)
    ld a, $FF
    ld [wLabStepLadderPlacedFlag], a
; save current NPC data
    push bc
    push de
    push hl
; check if box is placed above gas outlet, if not, activate the room gas
    ld c, OPERATING_ROOM_BOX
    call searchNPC
    or a
    jr z, .restoreCurrentNPCData
    ld hl, 18
    add hl, de
    positionVarLtV2 400, .activateSurgeryRoomGas
.restoreCurrentNPCData
    pop hl
    pop de
    pop bc
    jp checkNextSpriteCollision
.activateSurgeryRoomGas
    pop hl ; restore current NPC data
    pop de
    pop bc
    ld a, $FF
    ld [wRoomGasActivatedFlag], a
    jp checkNextSpriteCollision

operatingRoomBoxPlaced:
    ld hl, wEntityPositionX+1 - wEntityStructData
    add hl, de
    positionVarLt 352, checkNextSpriteCollision
    ld [hl], LOW(352)
    jp checkNextSpriteCollision

guardhouseStatuePlaced:
    ld hl, wEntityPositionZ+1 - wEntityStructData
    add hl, de
    positionVarGte -232, checkNextSpriteCollision
    ld [hl], LOW(-233)
    ld a, $FF
    ld [wDoorsLocksFlags+DOOR_51], a
    jp checkNextSpriteCollision
