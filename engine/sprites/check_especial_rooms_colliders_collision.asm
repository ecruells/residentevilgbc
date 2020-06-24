checkEspecialRoomCollidersCollision: ;C4:64FB
    ld a, [wRoomId]
    cp a, EXHIBITION_ROOM
    jp z, mapStepLadderElevationCollider
    cp a, GREENHOUSE
    jp z, checkGreenhousePlantCollider
    cp a, PIANO_ROOM
    jp z, checkPianoRoomSecretDoorCollider
    cp a, HIDDEN_LIBRARY
    jp z, checkLibrarySecretDoorCollider
    cp a, COURTYARD_FLOODGATE
    jp z, checkCourtyardPoolCollider
    cp a, WATERFALL_GARDEN
    jp z, checkWaterfallGardenCascadeCollider
    cp a, UNDERGROUND_STATUE_ROOM
    jp z, checkUndergroundStatueWallCollider
    cp a, BOULDER_2_ROOM
    jp z, checkBoulderRotateFloorCollider
    cp a, UNDERGROUND_ENTRY
    jp z, checkEntranceRotateFloorCollider
    cp a, AQUA_TANK_ENTRANCE
    jp z, checkAquariumWoodenBoxCollider
    cp a, PLANT_42_ROOTS_ROOM
    jp z, checkPlant42RootsCollider
    cp a, VISUAL_DATA_ROOM
    jp z, checkVisualDataRoomPillarCollider
    ret
;653B
mapStepLadderElevationCollider: ;C4:653B
    ld a, [wStepLadderElevationMode]
    or a
    ret z
; collide with step ladder if player is not stepping it up
    ld hl, mapStepLadderElevCollider1
    call detectEspecialRoomCollision
    ld hl, mapStepLadderElevCollider2
    jp detectEspecialRoomCollision

checkGreenhousePlantCollider:
    ld a, [wHerbicideUsedFlag]
    or a
    ret nz
    ld hl, greenhousePlantCollider
    jp detectEspecialRoomCollision

checkPianoRoomSecretDoorCollider:
    ld a, [wPianoRoomSecretDoorOpenFlag]
    or a
    jr z, .Label312567
    ld a, [wRoomsItemsFlags+ROOM07_GOLD_EMBLEM]
    ld c, a
    ld a, [wRoomsItemsFlags+ROOM07_WOODEN_EMBLEM]
    add a, c
    or a
    ret nz
.Label312567
    ld hl, pianoRoomSecretDoorCollider
    jp detectEspecialRoomCollision

checkLibrarySecretDoorCollider:
    ld a, [wLibrarySecretDoorOpenedFlag]
    or a
    ret nz
    ld hl, librarySecretDoorCollider
    jp detectEspecialRoomCollision

checkCourtyardPoolCollider:
    ld a, [wCourtyardFloodgateClosedFlag]
    or a
    ret nz
    ld hl, courtyardPoolCollider
    jp detectEspecialRoomCollision

checkWaterfallGardenCascadeCollider:
    ld a, [wCourtyardFloodgateClosedFlag]
    or a
    ret z
    ld hl, waterfallGardenCascadeCollider
    jp detectEspecialRoomCollision

checkUndergroundStatueWallCollider:
    ld a, [wCatacombCrankWallStatueFlag]
    or a
    ret z
    ld hl, undergroundStatueWallCollider
    jp detectEspecialRoomCollision

checkBoulderRotateFloorCollider:
    ld a, [wRotateFloor2AnimId]
    cp a, $02
    ret z
    ld hl, boulderRotateFloorCollider
    jp detectEspecialRoomCollision

checkEntranceRotateFloorCollider:
    ld a, [wRotateFloor1AnimId]
    cp a, $04
    ret z
    ld hl, entranceRotateFloorCollider
    jp detectEspecialRoomCollision

checkAquariumWoodenBoxCollider:
    ld a, [wAquariumWoodenBoxSunken]
    or a
    ret nz
    ld hl, aquariumWoodenBoxCollider
    jp detectEspecialRoomCollision

checkPlant42RootsCollider:
    ld a, [wVJoltUsedOnPlant42Flag]
    or a
    ret nz
    ld hl, plant42RootsCollider
    jp detectEspecialRoomCollision

checkVisualDataRoomPillarCollider:
    ld hl, visualDataRoomPillarCollider1
    ld a, [wVisualDataRoomPillarMovedFlag]
    or a
    jr z, .Label3125D3
    ld hl, visualDataRoomPillarCollider2
.Label3125D3
    jp detectEspecialRoomCollision


; detect player collision with a collision box, if a collision is detected, the player position
; is limited by the collision box borders.
;
; hl: collision box pointer
detectEspecialRoomCollision:
; set up collision box vars
    ld a, [hli]
    ld [wColliderRectRightX], a
    ld c, a
    ld a, [hli]
    ld [wColliderRectRightX+1], a
    ld b, a
    inc hl
    inc hl
    ld a, [hli]
    add a, c
    ld [wColliderRectLeftX], a
    ld a, [hld]
    adc a, b
    ld [wColliderRectLeftX+1], a
    dec hl
    dec hl
    ld a, [hli]
    ld [wColliderRectBottomY], a
    ld c, a
    ld a, [hli]
    ld [wColliderRectBottomY+1], a
    ld b, a
    inc hl
    inc hl
    ld a, [hli]
    add a, c
    ld [wColliderRectTopY], a
    ld a, [hli]
    adc a, b
    ld [wColliderRectTopY+1], a
; get player position
    ld a, [wEntityPositionX]
    ld e, a
    ld a, [wEntityPositionX+1]
    ld d, a
    call div8WordC4
    push de
    ld a, [wEntityPositionZ]
    ld e, a
    ld a, [wEntityPositionZ+1]
    ld d, a
    call div8WordC4
    ld l, e
    ld h, d
    pop de
    jp .Label312621
.Label312621
; fast collision detection
    ld a, [wColliderRectRightX]
    sub a, e
    ld a, [wColliderRectRightX+1]
    sbc a, d
    cp a, $FF
    ret nz
    ld a, [wColliderRectLeftX]
    sub a, e
    ld a, [wColliderRectLeftX+1]
    sbc a, d
    or a
    ret nz
    ld a, [wColliderRectBottomY]
    sub a, l
    ld a, [wColliderRectBottomY+1]
    sbc a, h
    cp a, $FF
    ret nz
    ld a, [wColliderRectTopY]
    sub a, l
    ld a, [wColliderRectTopY+1]
    sbc a, h
    or a
    ret nz
; collision detected with some border, now check every collider border
    push de
    push hl
    ld a, [wEntityRoomPositionX]
    ld e, a
    ld a, [wEntityRoomPositionX+1]
    ld d, a
    ld a, [wEntityRoomPositionZ]
    ld l, a
    ld a, [wEntityRoomPositionZ+1]
    ld h, a
; detectEspecialColliderBottomBorderCollision
    ld a, [wColliderRectBottomY]
    sub a, l
    ld a, [wColliderRectBottomY+1]
    sbc a, h
    or a
    jr nz, detectEspecialColliderTopBorderCollision
    ld a, [wColliderRectBottomY]
    ld e, a
    ld a, [wColliderRectBottomY+1]
    ld d, a
    call multiply8SignedWordC4
    ld a, e
    sub a, $01
    ld [wEntityPositionZ], a
    ld a, d
    sbc a, $00
    ld [wEntityPositionZ+1], a
    pop hl
    pop de
    ret

detectEspecialColliderTopBorderCollision: ;C4:6682
    ld a, [wColliderRectTopY]
    sub a, l
    ld a, [wColliderRectTopY+1]
    sbc a, h
    cp a, $FF
    jr nz, detectEspecialColliderRightBorderCollision
    ld a, [wColliderRectTopY]
    ld e, a
    ld a, [wColliderRectTopY+1]
    ld d, a
    call multiply8SignedWordC4
    ld a, e
    add a, $08
    ld [wEntityPositionZ], a
    ld a, d
    adc a, $00
    ld [wEntityPositionZ+1], a
    pop hl
    pop de
    ret
detectEspecialColliderRightBorderCollision: ;C4:66A8
    ld a, [wColliderRectRightX]
    sub a, e
    ld a, [wColliderRectRightX+1]
    sbc a, d
    or a
    jr nz, detectEspecialColliderLeftBorderCollision
    ld a, [wColliderRectRightX]
    ld e, a
    ld a, [wColliderRectRightX+1]
    ld d, a
    call multiply8SignedWordC4
    ld a, e
    sub a, $01
    ld [wEntityPositionX], a
    ld a, d
    sbc a, $00
    ld [wEntityPositionX+1], a
    pop hl
    pop de
    ret
detectEspecialColliderLeftBorderCollision: ;C4:66CD
    ld a, [wColliderRectLeftX]
    ld e, a
    ld a, [wColliderRectLeftX+1]
    ld d, a
    call multiply8SignedWordC4
    ld a, e
    add a, $08
    ld [wEntityPositionX], a
    ld a, d
    adc a, $00
    ld [wEntityPositionX+1], a
    pop hl
    pop de
    ret
;66E7
