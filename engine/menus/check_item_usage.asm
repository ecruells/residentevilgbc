; check if the selected item can be used. It can be a healing item or
; a room event item, in this case, it checks the current room and player position 
; to determine if the item can be used.
;
checkItemUsage:: ;;01:4D7D
; store player position in de (x) and bc (z)
    ld a, [wEntityPositionX]
    ld e, a
    ld a, [wEntityPositionX+1]
    ld d, a
    call div8Word
    ld c, e
    ld b, d
    ld a, [wEntityPositionZ]
    ld e, a
    ld a, [wEntityPositionZ+1]
    ld d, a
    call div8Word
; check selected item usage
    ld a, [wSelectedItemId]
    cp a, SHEET_MUSIC
    jp z, checkMusicSheetUsage
    cp a, F_AID_SPRAY
    jp z, checkFAidSprayUsage
    cp a, CHEMICAL
    jp z, checkHerbicideUsage
    cp a, GOLD_EMBLEM
    jp z, checkGoldEmblemUsage
    cp a, WOODEN_EMBLEM
    jp z, checkWoodEmblemUsage
    cp a, BLUE_JEWEL
    jp z, checkBlueJewelUsage
    cp a, RED_JEWEL
    jp z, checkRedJewelUsage
    cp a, GREEN_HERB
    jp z, checkGreenHerbUsage
    cp a, RED_HERB
    jp z, checkRedHerbUsage
    cp a, BLUE_HERB
    jp z, checkBlueHerbUsage
    cp a, STAR_CREST
    jp z, checkCrestUsage
    cp a, MOON_CREST
    jp z, checkCrestUsage
    cp a, SUN_CREST
    jp z, checkCrestUsage
    cp a, WIND_CREST
    jp z, checkCrestUsage
    cp a, SQUARE_CRANK
    jp z, checkSquareCrankUsage
    cp a, RED_BOOK
    jp z, checkRedbookUsage
    cp a, COURTYARD_BATTERY
    jp z, checkCourtyardBatteryUsage
    cp a, FLAMETHROWER
    jp z, checkFlameThrowerUsage
    cp a, HEX_CRANK
    jp z, checkHexCrankUsage
    cp a, MO_DISK_1
    jp z, checkMODiskUsage
    cp a, MO_DISK_2
    jp z, checkMODiskUsage
    cp a, MO_DISK_3
    jp z, checkMODiskUsage
    cp a, LAB_BATTERY
    jp z, checkLabBatteryUsage
    cp a, BROKEN_SHOTGUN
    jp z, checkBrokenShotgunUsage
    cp a, LIGHTER
    jp z, checkLighterUsage
    cp a, WOLF_MEDAL
    jp z, checkWolfMedalUsage
    cp a, EAGLE_MEDAL
    jp z, checkEagleMedalUsage
    cp a, SLIDES_2
    jp z, checkSlideUsage
    cp a, V_JOLT
    jp z, checkVJotlUsage
    ret

; hl: item slot
; bc: x-pos
; de: y-pos
checkVJotlUsage: ;01:4E2A
    ld a, [wRoomId]
    cp a, PLANT_42_ROOTS_ROOM
    ret nz
    positionEquX 39
    positionGteZ1AndLtZ2 -27, 9
    ld a, [wEntityFacing]
    cp a, FACING_SOUTH
    ret nc
    ld [hl], EMPTY
    ld a, $FF
    ld [wVJoltUsedOnPlant42Flag], a
    jp finishItemUsage

checkSlideUsage: ;4E56
    ld a, [wRoomId]
    cp a, VISUAL_DATA_ROOM
    ret nz
    positionGteX1AndLtX2 -6, 6
    positionLtZ -40
    positionGteZLow -44
    ld a, [wEntityFacing]
    cp a, FACING_WEST
    jr c, Label4E80
    cp a, FACING_EAST
    ret c
Label4E80
    ld [hl], EMPTY
    ld a, $FF
    ld [wProjectorSlidePlacedFlag], a
    jp finishItemUsage

checkWolfMedalUsage: ;4E8A
    ld a, [wRoomId]
    cp a, FOUNTAIN
    ret nz
    positionGteX1AndLtX2V2 126, 128
    positionGteZ1AndLtZ2V2 28, 36
    ld a, [wEntityFacing]
    cp a, FACING_SOUTH
    ret c
    ld [hl], EMPTY
    ld a, $FF
    ld [wWolfMedalPlacedFlag], a
    ld a, [wEagleMedalPlacedFlag]
    or a
    jp z, finishItemUsage
    ld a, $FF
    ld [wLabFountainEntranceOpenedFlag], a
    jp finishItemUsage

checkEagleMedalUsage:
    ld a, [wRoomId]
    cp a, FOUNTAIN
    ret nz
    positionLtX 3
    positionGteZ 41
    positionLtXLow 48
    ld a, [wEntityFacing]
    cp a, FACING_SOUTH
    ret nc
    ld [hl], EMPTY
    ld a, $FF
    ld [wEagleMedalPlacedFlag], a
    ld a, [wWolfMedalPlacedFlag]
    or a
    jp z, finishItemUsage
    ld a, $FF
    ld [wLabFountainEntranceOpenedFlag], a
    jp finishItemUsage

checkLighterUsage: ;4EF3
    ld a, [wRoomId]
    cp a, LOUNGE_ROOM
    jp z, checkLighterUsageOnMapFireplace
    cp a, SMALL_DINNING_ROOM
    jp z, checkLighterUsageOnCandle
    ret

checkLighterUsageOnMapFireplace: ;01:4F01
    positionGteX1AndLtX2 -12, 4
    positionLtZ -11
    ld a, [wEntityFacing]
    cp a, FACING_WEST
    ret c
    cp a, FACING_EAST
    ret nc
    ld a, [wLoungeFireplaceLittedFlag]
    or a
    ret nz
    ld a, $FF
    ld [wLoungeFireplaceLittedFlag], a
    ld [wRoomsItemsFlags+ROOM1F_MAP_2], a
    jp finishItemUsage

checkLighterUsageOnCandle:
    positionGteX -16
    positionGteZ -23
    positionLtZLow -16
    ld a, [wEntityFacing]
    cp a, FACING_EAST
    jr nc, .Label4F4E
    cp a, FACING_WEST
    ret nc
.Label4F4E
    ld a, [wSmallDinningRoomLittedCandleFlag]
    or a
    ret nz
    ld a, $FF
    ld [wSmallDinningRoomLittedCandleFlag], a
    ld [wRoomsItemsFlags+ROOM22_SHELLS], a
    ld [wRoomsItemsFlags+ROOM22_CLIP], a
    jp finishItemUsage

checkBrokenShotgunUsage: ;4F61
    ld a, [wRoomId]
    cp a, LIVING_ROOM
    ret nz
    positionGteX1AndLtX2 -16, 8
    positionGteZ 32
    ld a, [wEntityFacing]
    cp a, FACING_WEST
    jr c, .Label4F87
    cp a, FACING_EAST
    ret c
.Label4F87
    ld a, [wRoomsItemsFlags+ROOM18_SHOTGUN]
    or a
    ret nz
    ld [hl], EMPTY
    ld a, $FF
    ld [wRoomsItemsFlags+ROOM18_BROKEN_SHOTGUN], a
    ld a, [wSelectedCharacter]
    or a
    jr z, .brokenShotgunPlacedWithChris 
; broken shotgun placed with Jill
    ld a, $FF
    ld [wBrokenShotgunPlacedByJillFlag], a
    jp finishItemUsage
.brokenShotgunPlacedWithChris
    ld a, $FF
    ld [wBrokenShotgunPlacedByChrisFlag], a
    jp finishItemUsage

checkLabBatteryUsage: ;4FA9
    ld a, [wRoomId]
    cp a, EMERGENCY_TUNNEL
    jp z, Label4FB2
    ret
;4FB2
Label4FB2: ;01:4FB2
    positionGteX -118
    positionLtXLow 144
    positionGteZ -126
    positionLtZLow 138
    ld a, [wEntityFacing]
    cp a, FACING_WEST
    ret c
    cp a, FACING_EAST
    ret nc
    ld [hl], EMPTY
    ld a, $FF
    ld [wHeliportElevatorPoweredFlag], a
    call scrollDownScreen
    ld hl, text_pointer_4003 ; Something has happened!
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    call scrollUpScreen
    jp finishItemUsage

checkMODiskUsage: ;4FED
    ld a, [wRoomId]
    cp a, OPERATING_MORGE_ROOM
    jp z, checkMODiskUsageOnMorgue
    cp a, POWER_ROOM_PASSAGE_2
    jp z, checkMODiskUsageOnPowerRoomPassage
    cp a, LAB_RESEARCHER_ROOM
    jp z, checkMODiskUsageOnResearcherRoom
    ret
;5000
checkMODiskUsageOnMorgue: ;01:5000
    positionGteX -110
    positionLtXLow 154
    positionGteZ -24
    positionLtZLow -16
    ld a, [wEntityFacing]
    cp a, FACING_WEST
    jp c, .Label5021
    cp a, FACING_EAST
    ret c
.Label5021
    ld a, [wMoDiskPasscode01FiledFlag]
    or a
    ret nz
    ld [hl], EMPTY
    call scrollDownScreen
    ld hl, text_pointer_411A ; PASS CODE 01 has been filed.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld a, $FF
    ld [wMoDiskPasscode01FiledFlag], a
    call scrollUpScreen
    jp finishItemUsage

checkMODiskUsageOnPowerRoomPassage:
    positionGteX 87
    positionLtXLow 95
    positionGteZ 77
    positionLtZLow 85
    ld a, [wEntityFacing]
    cp a, FACING_WEST
    jp c, .Label5061
    cp a, FACING_SOUTH_EAST ; should be FACING_EAST for easy usage. TODO: fix facing
    ret c
.Label5061
    ld a, [wMoDiskPasscode02FiledFlag]
    or a
    ret nz
    ld [hl], EMPTY
    call scrollDownScreen
    ld hl, text_pointer_411D ; PASS CODE 02 has been filed.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld a, $FF
    ld [wMoDiskPasscode02FiledFlag], a
    call scrollUpScreen
    jp finishItemUsage

checkMODiskUsageOnResearcherRoom:
    positionGteX 41
    positionLtXLow 49
    positionGteZ 11
    positionLtZLow 19
    ld a, [wEntityFacing]
    cp a, FACING_WEST
    jp c, Label50A1
    cp a, FACING_EAST
    ret c
Label50A1
    ld a, [wMoDiskPasscode03FiledFlag]
    or a
    ret nz
    ld [hl], EMPTY
    call scrollDownScreen
    ld hl, text_pointer_4120 ; PASS CODE 03 has been filed.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld a, $FF
    ld [wMoDiskPasscode03FiledFlag], a
    call scrollUpScreen
    jp finishItemUsage

checkHexCrankUsage: ;50C2
    ld a, [wRoomId]
    cp a, UNDERGROUND_STATUE_ROOM
    jp z, HexCrankUsageOnUndergndStatue
    cp a, BOULDER_2_ROOM
    jp z, HexCrankUsageOnBoulder2Floor
    cp a, UNDERGROUND_ENTRY
    jr z, HexCrankUsageOnUndergndEntranceFloor
    ret
;50D4
HexCrankUsageOnUndergndEntranceFloor: ;01:50D4
    positionGteX -40
    positionLtXLow -36
    positionGteZ -25
    positionLtZLow -12
    ld a, [wEntityFacing]
    cp a, FACING_SOUTH
    ret nc
    ld a, [wRotateFloor1AnimId]
    or a
    ret nz
    ld a, 5
    ld [wRoomCameraId], a
    push hl
    call haltCPU
    call resetPalettes
    call loadRoomScreenCameraAndBgData
    call updateSceneBgAndAllSprites
    ld a, UPDATE_BG_PALETTE
    ld [wPaletteFadeCounter], a
    call updateRoomPalette
    pop hl
    ld b, $30
    call routineDelay
    ld b, 4
rotateEntranceFloorLoop
    push bc
    push hl
    call haltCPU
    ld hl, wRotateFloor1AnimId
    inc [hl]
    call loadRoomScreenBackgroundMaskCaller
    ld b, $30
    call routineDelay
    pop hl
    pop bc
    dec b
    jr nz, rotateEntranceFloorLoop
    jp finishItemUsage

HexCrankUsageOnBoulder2Floor: ;5130
    positionGteX 12
    positionLtXLow 20
    positionGteZ -64
    positionLtZLow -56
    ld a, [wEntityFacing]
    cp a, FACING_WEST
    jp c, Label5150
    cp a, FACING_EAST
    ret c
Label5150
    ld a, [wRotateFloor2AnimId]
    or a
    ret nz
    ld a, 5
    ld [wRoomCameraId], a
    push hl
    call haltCPU
    call resetPalettes
    call loadRoomScreenCameraAndBgData
    call updateSceneBgAndAllSprites
    ld a, UPDATE_BG_PALETTE
    ld [wPaletteFadeCounter], a
    call updateRoomPalette
    pop hl
    ld b, $30
    call routineDelay
    ld b, 2
rotateBoulder2FloorLoop
    push bc
    push hl
    call haltCPU
    ld hl, wRotateFloor2AnimId
    inc [hl]
    call loadRoomScreenBackgroundMaskCaller
    ld b, $30
    call routineDelay
    pop hl
    pop bc
    dec b
    jr nz, rotateBoulder2FloorLoop
    jp finishItemUsage

HexCrankUsageOnUndergndStatue: ;5190
; revert flag value
    ld a, [wCatacombCrankWallStatueFlag]
    xor a, $FF
    ld [wCatacombCrankWallStatueFlag], a
    cp a, $FF
    jp nz, finishItemUsage
    ld de, wNPCEntitiesDataStructs
    ld b, 7
.pushStatueLoop
    ld hl, wEntityId - wEntityStructData
    add hl, de
    ld a, [hl]
    cp a, UNDERGROUND_STATUE
    jr z, statueFound
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    dec b
    jr nz, .pushStatueLoop
.statueNotFound ;infinite loop
    jr .statueNotFound
statueFound:
;move statue
    ld hl, wEntityPositionX+1 - wEntityStructData
    add hl, de
    ld a, [hld]
    cp a, LOW(-128)
    jp c, finishItemUsage
    cp a, HIGH(-184)
    jr c, .Label51CC
    ld a, [hl]
    cp a, LOW(-184)
    jp nc, finishItemUsage
.Label51CC
    ld bc, -72 ; set statue new x position
    ld [hl], c
    inc hl
    ld [hl], b
    jp finishItemUsage

checkFlameThrowerUsage: ;51D5
    ld a, [wRoomId]
    cp a, WAY_TO_BREAK_ROOM
    jp z, flamethrowerUsage1
    cp a, BOULDER_1_ROOM
    jp z, flamethrowerUsage2
    ret
;51E3
flamethrowerUsage1: ;01:51E3
    positionGteX 101
    positionLtXLow 109
    positionGteZ 12
    ld a, [wEntityFacing]
    cp a, FACING_WEST
    jp c, Label51FF
    cp a, FACING_EAST
    ret c
Label51FF
    ld a, $FF
    ld [wRoomsItemsFlags+ROOM46_FLAMETHROWER], a
    ld [wBoulderPassage1DoorUnlockFlag], a
    xor a
    ld [wBoulderPassage2DoorUnlockFlag], a
    ld [hl], EMPTY ; remove flamethrower
    jp finishItemUsage

flamethrowerUsage2:
    positionLtX 16
    positionGteZ -62
    positionLtZLowV2 -54
    ld a, [wEntityFacing]
    cp a, FACING_SOUTH
    ret c
    ld a, $FF
    ld [wRoomsItemsFlags+ROOM3D_FLAMETHROWER], a
    ld [wBoulderPassage2DoorUnlockFlag], a
    xor a
    ld [wBoulderPassage1DoorUnlockFlag], a
    ld [hl], EMPTY ; remove flamethrower
    jp finishItemUsage

checkCourtyardBatteryUsage: ;523A
    ld a, [wRoomId]
    cp a, WATERFALL_GARDEN
    ret nz
    positionGteX 19
    positionLtXLow 26
    positionGteZ $58
    ld a, [wEntityFacing]
    cp a, FACING_EAST
    jr nc, Label525B
    cp a, FACING_WEST
    ret nc
Label525B
    ld [hl], EMPTY
    ld a, $FF
    ld [wCourtyardElevatorPoweredFlag], a
    call scrollDownScreen
    ld hl, text_pointer_4003 ; Something has happened!
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    call scrollUpScreen
    jp finishItemUsage

checkSquareCrankUsage: ;5277
    ld a, [wRoomId]
    cp a, COURTYARD_FLOODGATE
    ret nz
    positionLtX 26
    positionGteZ -26
    positionLtZLow -16
    ld a, [wEntityFacing]
    cp a, FACING_WEST
    ret c
    cp a, FACING_SOUTH_EAST+1 ; TODO: fix facing ?
    ret nc
    ld a, 3
    ld [wRoomCameraId], a
    call loadEventRoomScreen
    ld a, [wCourtyardFloodgateClosedFlag]
    or a
    jr z, Label52BF
    call scrollDownScreen
    xor a
    ld [wCourtyardFloodgateClosedFlag], a
    ld hl, text_pointer_40A2 ; There's a square hole.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    call scrollUpScreen
    jp finishItemUsage
Label52BF
    call scrollDownScreen
    ld a, $FF
    ld [wCourtyardFloodgateClosedFlag], a
    ld hl, text_pointer_40A8 ; The water is running down the opposite side.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    call scrollUpScreen
    jp finishItemUsage

checkCrestUsage: ;52D9
    ld a, [wRoomId]
    cp a, SHED_PASSAGE
    ret nz
    positionLtX 16
    positionLtZ -120
    ld a, [wEntityFacing]
    cp a, FACING_WEST
    ret c
    cp a, FACING_SOUTH_EAST+1
    ret nc
    ld a, [wSelectedItemId]
    cp a, STAR_CREST
    jr z, .putStarCrest
    cp a, MOON_CREST
    jr z, .putMoonCrest
    cp a, SUN_CREST
    jr z, .putSunCrest
.putWindCrest
    ld a, $FF
    ld [wWindCrestPlacedFlag], a
    ld [hl], EMPTY
    jp checkAllCrestsPlaced
.putStarCrest
    ld a, $FF
    ld [wStarCrestPlacedFlag], a
    ld [hl], EMPTY
    jp checkAllCrestsPlaced
.putSunCrest
    ld a, $FF
    ld [wSunCrestPlacedFlag], a
    ld [hl], EMPTY
    jp checkAllCrestsPlaced
.putMoonCrest
    ld a, $FF
    ld [wMoonCrestPlacedFlag], a
    ld [hl], EMPTY

checkAllCrestsPlaced:
    ld a, [wMoonCrestPlacedFlag]
    cp a, $FF
    jr nz, .allCrestNotPlaced
    ld a, [wSunCrestPlacedFlag]
    cp a, $FF
    jr nz, .allCrestNotPlaced
    ld a, [wStarCrestPlacedFlag]
    cp a, $FF
    jr nz, .allCrestNotPlaced
    ld a, [wWindCrestPlacedFlag]
    cp a, $FF
    jr nz, .allCrestNotPlaced
    ld a, $FF
    ld [wShedDoorLock], a
    ld a, CREST_PANEL_SCREEN
    ld [wRoomCameraId], a
    call loadEventRoomScreen
    ld hl, text_pointer_4078 ; The sun sets in the west, the moon rises in the east
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld hl, text_pointer_4003 ; Something has happened!
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    jp finishItemUsage
.allCrestNotPlaced
    ld a, CREST_PANEL_SCREEN
    ld [wRoomCameraId], a
    call loadEventRoomScreen
    call waitMessageForPlayerInput
    jp finishItemUsage

; incomplete redbook usage, it never calls the check and flag set routine, so the door to plant 42 is never unlocked
; TODO: fix this
checkRedbookUsage: ;537D
    ld a, [wDorm003WhiteBookRemovedFlag]
    or a
    ret
;5382

NotUsedRedBookUsageEvent: ;01:5382
    ld a, [wRoomId]
    cp a, GUARDHOUSE_DORM_003
    ret nz
    positionLtX -22
    positionGteZ -32
    ld a, [wEntityFacing]
    cp a, FACING_SOUTH
    ret c
    ld [hl], EMPTY
    ld a, $FF
    ld [wRedBookPlacedFlag], a
    ld [wUnusedRedBookPlacedFlag], a
    call scrollDownScreen
    ld hl, text_pointer_4003 ; Something has happened!
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    call scrollUpScreen
; find closet NPC
    ld de, wNPCEntitiesDataStructs
    ld b, 7
.findClosetLoop
    ld hl, wEntityId - wEntityStructData
    add hl, de
    ld a, [hl]
    cp a, DORM_003_CLOSET_F1
    jr z, closetFound
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld e, a
    dec b
    jr nz, .findClosetLoop
.closetNotFound
    jr .closetNotFound
closetFound:
; move the closet
    ld hl, wEntityPositionX - wEntityStructData
    add hl, de
    ld bc, 336
    ld [hl], c
    inc hl
    ld [hl], b
    xor a
    ld [wUnusedDorm003MovedClosetFlag1], a
    ld a, $FF
    ld [wUnusedDorm003MovedClosetFlag2], a
    jp finishItemUsage

checkBlueJewelUsage: ;53EB
    ld a, [wRoomId]
    cp a, TIGER_STATUE_ROOM
    ret nz
    positionGteX1AndLtX2 -16, 16
    positionGteZ 8
    ld a, [wEntityFacing]
    cp a, FACING_WEST
    jp c, .Label5412
    cp a, FACING_EAST
    ret c
.Label5412
    ld a, EMPTY
    ld [hl], a
    ld a, TIGER_STATUE_BLUE_JEWEL_OPEN_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wRoomsItemsFlags+ROOM14_WIND_CREST], a
    jp finishItemUsage

checkRedJewelUsage: ;5422
    ld a, [wRoomId]
    cp a, TIGER_STATUE_ROOM
    ret nz
    positionGteX1AndLtX2 -16, 16
    positionGteZ 8
    ld a, [wEntityFacing]
    cp a, FACING_WEST
    jp c, .Label5449
    cp a, FACING_EAST
    ret c
.Label5449
    ld a, EMPTY
    ld [hl], a
    ld a, TIGER_STATUE_BLUE_JEWEL_CLOSE_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wRoomsItemsFlags+ROOM14_COLT_PYTHON], a
    jp finishItemUsage

checkGoldEmblemUsage: ;5459
    ld a, [wRoomId]
    cp a, DINNING_ROOM_1F
    jr z, checkGoldEmblemUsageInDinningRoom
;check golden embled place in secret room
    cp a, PIANO_ROOM
    ret nz
    positionLtX -124
    positionLtZ1AndGteZ2 8, -8
    ld a, [wEntityFacing]
    cp a, FACING_SOUTH
    ret c
    ld a, [wRoomsItemsFlags+ROOM07_WOODEN_EMBLEM]
    or a
    ret nz
    ld a, $FF
    ld [wRoomsItemsFlags+ROOM07_GOLD_EMBLEM], a
    ld a, EMPTY
    ld [hl], a
    jp finishItemUsage

checkGoldEmblemUsageInDinningRoom
    positionGteX 112
    positionLtZ1AndGteZ2 8, -8
    ld a, [wEntityFacing]
    cp a, FACING_SOUTH
    ret nc
    ld a, [wRoomsItemsFlags+ROOM01_WOODEN_EMBLEM]
    or a
    ret nz
    ld a, $FF
    ld [wRoomsItemsFlags+ROOM01_GOLD_EMBLEM], a
    ld a, EMPTY
    ld [hl], a
; find Clock entity
    ld de, wNPCEntitiesDataStructs
    ld b, 7
.findClockLoop
    ld hl, wEntityId - wEntityStructData
    add hl, de
    ld a, [hl]
    cp a, DINNING_ROOM_CLOCK
    jr z, clockFound
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld e, a
    dec b
    jr nz, .findClockLoop
.clockNotFound ; game stuck in infite loop
    jr .clockNotFound
clockFound:
; move clock sprite
    ld hl, wEntityPositionX - wEntityStructData
    add hl, de
    ld bc, 216
    ld [hl], c
    inc hl
    ld [hl], b
    inc hl ; wEntityPositionZ
    ld bc, 336
    ld [hl], c
    inc hl
    ld [hl], b
    xor a
    ld [wUnsedClockNotMovedFlag], a
    ld a, $FF
    ld [wUnsedClockMovedFlag], a
    jp finishItemUsage

checkWoodEmblemUsage: ;54F1
    ld a, [wRoomId]
    cp a, DINNING_ROOM_1F
    jr z, checkWoodEmblemUsageInDinningRoom
    cp a, PIANO_ROOM
    ret nz
    positionLtX -124
    positionLtZ1AndGteZ2 8, -8
    ld a, [wEntityFacing]
    cp a, FACING_SOUTH
    ret c
    ld a, [wRoomsItemsFlags+ROOM07_GOLD_EMBLEM]
    or a
    ret nz
    ld a, $FF
    ld [wRoomsItemsFlags+ROOM07_WOODEN_EMBLEM], a
    ld a, EMPTY
    ld [hl], a
    jp finishItemUsage

checkWoodEmblemUsageInDinningRoom
    positionGteX 112
    positionLtZ1AndGteZ2 8, -8
    ld a, [wEntityFacing]
    cp a, FACING_SOUTH
    ret nc
    ld a, [wRoomsItemsFlags+ROOM01_GOLD_EMBLEM]
    or a
    ret nz
    ld a, $FF
    ld [wRoomsItemsFlags+ROOM01_WOODEN_EMBLEM], a
    ld a, EMPTY
    ld [hl], a
    jp finishItemUsage

checkMusicSheetUsage: ;5554
    ld a, [wRoomId]
    cp a, PIANO_ROOM
    ret nz
    positionGteX -32
    positionLtXLow -8
    positionLtZ 5
    ld a, [wEntityFacing]
    cp a, FACING_SOUTH_EAST+1
    ret nc
    cp a, FACING_SOUTH_WEST
    ret c
    ld a, [wEntityId]
    cp a, CHRIS
    jr z, checkChrisPianoEvent
; jill piano event
    ld a, EMPTY
    ld [hl], a
    ld a, $FF
    ld [wPianoRoomSecretDoorOpenFlag], a ; no piano interpretation event. TODO: implement piano event
    jp finishItemUsage
checkChrisPianoEvent
    ld a, CHRIS_REBECCA_PIANO_1_SCENE
    ld [wEventSceneId], a
    ld a, EMPTY
    ld [hl], a
    ld a, $FF
    ld [wBackToMainHallAsJillEventFlag], a
    jp finishItemUsage


INCLUDE "engine/menus/check_heal_item_usage.asm"


checkHerbicideUsage: ;01:55D3
    ld a, [wRoomId]
    cp a, GREENHOUSE
    ret nz
    positionLtX -74
    positionLtZ 5
    ld a, [wEntityFacing]
    cp a, FACING_EAST
    jp nc, Label55F3
    cp a, FACING_WEST+1
    ret nc
Label55F3
    push hl
    ld a, 4
    ld [wRoomCameraId], a
    call loadEventRoomScreen
    call scrollDownScreen
    ld hl, text_pointer_4003 ; Something has happened!
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    call scrollUpScreen
    pop hl
    ld a, EMPTY
    ld [hl], a
    ld a, $FF
    ld [wHerbicideUsedFlag], a
    ld [wRoomsItemsFlags+ROOM70_F_AID_SPRAY], a
    ld [wRoomsItemsFlags+ROOM70_SHELLS], a
    ld [wRoomsItemsFlags+ROOM70_CLIP], a
    jp finishItemUsage

finishItemUsage:
    pop hl
    pop hl
    pop hl
    call resetPalettes
    call hideSprites
    ld a, UPDATE_BG_PALETTE
    ld [wPaletteFadeCounter], a
    jp gameLoopWithEventCheck

finishHealItemUsage:
    ld a, 4
    ld [wMainMenuSelectedCursorId], a ; return to item grid
    call clearItemDetailWindowBgMap
    call loadMainMenuPalette
    call clearItemDetailWindowTiles
    call loadEquippedItemSpriteCaller
    ld b, $10
    jp routineDelay
;564A