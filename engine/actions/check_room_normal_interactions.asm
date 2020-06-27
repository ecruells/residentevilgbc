; check rooms normal interactions triggered by action button like examination messages and puzzles.
checkRoomNormalInteraction:
    ld a, [wRoomId]
    cp a, DINNING_ROOM_1F
    jp z, dinningRoom1FActions
    cp a, WEST_STOREROOM
    jp z, westStoreroomActions
    cp a, EXHIBITION_ROOM
    jp z, exhibitionRoomActions
    cp a, REST_STOP_CORRIDOR
    jp z, restStopCorridorActions
    cp a, FIREARMS_ROOM
    jp z, firearmsRoomActions
    cp a, L_SHAPED_CORRIDOR
    jp z, lShapedCorridorActions
    cp a, EAST_STAIRS_CORRIDOR_1F
    jp z, eastStairsCorridor1FActions
    cp a, KEEPERS_ROOM
    jp z, keepersRoomActions
    cp a, MANSION_BATHROOM
    jp z, mansionBathroomActions
    cp a, SHED_PASSAGE
    jp z, shedPassageActions
    cp a, TIGER_STATUE_ROOM
    jp z, tigerStatueRoomActions
    cp a, SHED_ROOM
    jp z, shedRoomActions
    cp a, LIVING_ROOM
    jp z, livingRoomActions
    cp a, HALLWAY_TO_EAST_TERRACE
    jp z, hallwayToEastTerraceActions
    cp a, SMALL_DINNING_ROOM
    jp z, smallDinningRoomActions
    cp a, ARMORS_ROOM
    jp z, armorsRoomActions
    cp a, SMALL_LIBRARY
    jp z, smallLibraryActions
    cp a, RESEARCHERS_PRIVATE_ROOM
    jp z, researchersPrivateRoomActions
    cp a, TAXIDERMY_ROOM
    jp z, taxidermyRoomActions
    cp a, HIDDEN_LIBRARY
    jp z, hiddenLibraryActions
    cp a, COURTYARD_FLOODGATE
    jp z, courtyardFloodgateActions
    cp a, WATERFALL_GARDEN
    jp z, waterfallGardenActions
    cp a, DORM_001_BATHROOM
    jp z, dorm001BathroomActions
    cp a, AQUA_TANK_CONTROL_ROOM
    jp z, aquaTankControlRoomActions
    cp a, GUARDHOUSE_DORM_002
    jp z, guardhouseDorm002Actions
    cp a, DORM_002_BATHROOM
    jp z, dorm002BathroomActions
    cp a, CHEMISTRY_ROOM
    jp z, chemistryRoomActions
    cp a, GUARDHOUSE_DORM_003
    jp z, guardhouseDorm003Actions
    cp a, AQUA_TANK_STOREROOM
    jp z, aquaTankStoreroomActions
    cp a, VISUAL_DATA_ROOM
    jp z, visualDataRoomActions
    cp a, SMALL_LAB
    jp z, smallLabActions
    cp a, LAB_B3F_WEST_CORRIDOR
    jp z, labB3fWestCorridorActions
    cp a, XRAY_ROOM
    jp z, xRayRoomActions
    cp a, LAB_ELEVATOR_ENTRY
    jp z, labElevatorEntryActions
    cp a, POWER_ROOM_PASSAGE_1
    jp z, powerRoomPassage1Actions
    cp a, LAB_POWER_ROOM
    jp z, labPowerRoomActions
    cp a, MAIN_LABORATORY
    jp z, MainLaboratoryActions
    cp a, LARGE_GALLERY
    jp z, largeGalleryActions
    cp a, COURTYARD_STUDY
    jp z, courtyardStudyActions
    ret
; 5C82

dinningRoom1FActions: ; 01:5C82
    ld a, [wRoomInteractionID]
    cp a, $F0
    jr z, Label5C9A
    cp a, $F1
    jr z, Label5CA0
    cp a, $F2
    jr z, Label5CA6
    cp a, $F3
    jr z, Label5CAC
    cp a, $F4
    jr z, Label5CB2
    ret
Label5C9A: ; 01:5C9A
    ld hl, text_pointer_401B ; A grandfather clock is ticking.
    jp displayActionMessage
Label5CA0
    ld hl, text_pointer_402D ; There's nothing inside.
    jp displayActionMessage
Label5CA6
    ld hl, text_pointer_4021 ; It's dark outside and as silent as death.
    jp displayActionMessage
Label5CAC
    ld hl, text_pointer_4018 ; A picture of beautiful scenery.
    jp displayActionMessage
Label5CB2
    ld hl, text_pointer_4015 ; A picture of a woman.
    jp displayActionMessage

westStoreroomActions:
    ld a, [wRoomInteractionID]
    cp a, $F0
    jr z, Label5CC0
    ret
Label5CC0: ; 01:5CC0
    ld hl, text_pointer_4006 ; Vitamins and serums.
    jp displayActionMessage

exhibitionRoomActions:
    ld a, [wRoomInteractionID]
    cp a, $F0
    jr z, Label5CE6
    cp a, $F1
    jr z, Label5CEC
    cp a, $F2
    jr z, Label5CF2
    cp a, $F3
    jr z, Label5CF8
    cp a, $F4
    jr z, Label5CFE
    cp a, $F5
    jr z, Label5D04
    cp a, $F6
    jr z, Label5D0A
    ret
Label5CE6: ; 01:5CE6
    ld hl, text_pointer_4036 ; A picture of a fat woman.
    jp displayActionMessage
Label5CEC
    ld hl, text_pointer_400F ; Nothing unusual.
    jp displayActionMessage
Label5CF2
    ld hl, text_pointer_4030 ; A picture of a beautiful woman.
    jp displayActionMessage
Label5CF8
    ld hl, text_pointer_4033 ; A picture of steep scenery.
    jp displayActionMessage
Label5CFE
    ld hl, text_pointer_4039 ; Nothing special about this picture.
    jp displayActionMessage
Label5D04
    ld hl, text_pointer_403C ; A beautiful picture. That's all.
    jp displayActionMessage
Label5D0A
    ld hl, text_pointer_403F ; Incoherent pictures.
    jp displayActionMessage

restStopCorridorActions:
    ld a, [wRoomInteractionID]
    cp a, $F0
    jr z, Label5D18
    ret
Label5D18: ; 01:5D18
    ld hl, text_pointer_4012 ; It's ominously quiet outside.
    jp displayActionMessage

firearmsRoomActions:
    ld a, [wRoomsItemsFlags+ROOM09_SHELLS]
    or a
    ret z
    ld a, [wFirearmsRoomDeskUnlocked]
    or a
    jr nz, Label5D75 ; jump is desk is unlocked
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4177 ; The desk is locked.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    call searchSmallKeyInInventory
    or a
    jp z, scrollUpScreen ; return if small key isn't found
    push hl ; store item slot id
    ld hl, text_pointer_417A ; Will you use the SMALL KEY Yes No
    call displayMessage
    pop hl
.Label5D4A
    push hl
    call printChoiceArrow
    pop hl ; restore item slot id
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, .Label5D4A
    call clearMessageBox
    ld a, [wChoiceId]
    or a
    jp nz, scrollUpScreen
	; remove small key
    ld [hl], EMPTY
    ld a, $FF
    ld [wFirearmsRoomDeskUnlocked], a
    ld hl, text_pointer_4174 ; You unlocked it.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    jr getFirearmsRoomDeskItem
Label5D75
    call scrollDownScreen
getFirearmsRoomDeskItem
    ld a, FIREARMS_ROOM_DESK_SCREEN
    ld [wRoomCameraId], a
    call loadEventRoomScreen
    ld hl, applyBgOverlapMaskOnSprite
    call displayMessage
.choiceLoop
    push hl
    call printChoiceArrow
    pop hl
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, .choiceLoop
    push hl
    call clearMessageBox
    pop hl
    ld a, [wChoiceId]
    or a
    jp nz, scrollUpScreen
    xor a
    ld [wRoomsItemsFlags+ROOM09_SHELLS], a ; does not include shells: TODO fix
    jp scrollUpScreen

lShapedCorridorActions:
    ld a, [wRoomInteractionID]
    cp a, $F0
    jr z, .Label5DB5
    cp a, $F1
    jr z, .Label5DB5
    cp a, $F2
    jr z, .Label5DB5
    ret
.Label5DB5
    ld hl, text_pointer_4042 ; Creepy stuff.
    jp displayActionMessage
    
eastStairsCorridor1FActions:
    ld a, [wRoomInteractionID]
    cp a, $F0
    jr z, .Label5DC3
    ret
.Label5DC3: ; 01:5DC3
    ld hl, text_pointer_4045 ; I wish I had time to enjoy these pictures...
    jp displayActionMessage

keepersRoomActions:
    ld a, [wRoomInteractionID]
    cp a, $F0
    jr z, .Label5DD5
    cp a, $F1
    jr z, .Label5DDB
    ret
.Label5DD5 ; 01:5DD5
    ld hl, text_pointer_404B ; None of them looks useful.
    jp displayActionMessage
.Label5DDB
    ld hl, text_pointer_400F ; Nothing unusual.
    jp displayActionMessage

mansionBathroomActions:
    ld a, [wRoomInteractionID]
    cp a, $F0
    jr z, .Label5DE9
    ret
.Label5DE9 ; 01:5DE9
    ld hl, text_pointer_400F ; Nothing unusual.
    jp displayActionMessage

shedPassageActions:
    ld a, CREST_PANEL_SCREEN
    ld [wRoomCameraId], a
    call loadEventRoomScreen
    ld a, [wMoonCrestPlacedFlag]
    or a
    jr z, .crestsNotPlaced
    ld a, [wSunCrestPlacedFlag]
    or a
    jr z, .crestsNotPlaced
    ld a, [wStarCrestPlacedFlag]
    or a
    jr z, .crestsNotPlaced
    ld a, [wWindCrestPlacedFlag]
    or a
    jr z, .crestsNotPlaced
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_407E ; Crests are placed in all the hollows.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    jp scrollUpScreen
.crestsNotPlaced
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4078 ; The sun sets in the  west, the moon rises in the east
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld hl, text_pointer_407B ; And when the stars begin to appear in the sky...
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    jp scrollUpScreen

tigerStatueRoomActions:
    ld a, TIGER_STATUE_SCREEN
    ld [wRoomCameraId], a
    call loadEventRoomScreen
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4048 ; It reads 'A tiger has red light and blue light.'
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    jp scrollUpScreen

shedRoomActions:
    ld a, [wRoomInteractionID]
    cp a, $F2
    jr c, .Label5E6C
    jr z, .Label5E72
    ret
.Label5E6C ; 01:5E6C
    ld hl, text_pointer_4081 ; An old barrel.
    jp displayActionMessage
.Label5E72
    ld hl, text_pointer_400F ; Nothing unusual.
    jp displayActionMessage

livingRoomActions:
    ld a, [wRoomInteractionID]
    cp a, $F0
    jr z, .Label5E84
    cp a, $F1
    jr z, .Label5E8A
    ret
.Label5E84: ; 01:5E84
    ld hl, text_pointer_404E ; A tapestry.
    jp displayActionMessage
.Label5E8A
    ld hl, text_pointer_4054 ; An urn with a beautiful picture on it.
    jp displayActionMessage

hallwayToEastTerraceActions:
    ld a, [wRoomInteractionID]
    cp a, $F0
    jr z, .Label5E98
    ret
.Label5E98
    ld a, PICK_ITEM_ANIM
    ld [wEntityAnimationId], a
    xor a
    ld [wEntityAnimationFrameId], a
    call updateSceneBgAndAllSprites
    ld b, $80
    call routineDelay
    ld hl, text_pointer_409C ; I hope this blood isn't from my teammates...
    call displayActionMessage
    ld a, IDLE_ANIM
    ld [wEntityAnimationId], a
    ret
; 5EB5

smallDinningRoomActions: ; 01:5EB5
    ld a, [wRoomInteractionID]
    cp a, $F8
    jr z, .Label5EBD
    ret
.Label5EBD
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4096 ; A candle.
    ld a, [wSmallDinningRoomLittedCandleFlag]
    or a
    jr z, .Label5ECF ; candle not litted
    ld hl, text_pointer_4099 ; The candle is lit.
.Label5ECF
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    jp scrollUpScreen

armorsRoomActions:
    ld a, [wRoomInteractionID]
    cp a, $FE
    jr z, .checkGasButton
; show message
    ld hl, text_pointer_4087 ; Heavy-looking suits of armor.
    jp displayActionMessage
.checkGasButton
    ld a, [wArmorsRoomGasButtonPushedFlag]
    or a
    ret nz
    ld a, ARMORS_ROOM_BUTTON_SCREEN
    ld [wRoomCameraId], a
    call loadEventRoomScreen
    ld b, $40
    call routineDelay
    call clearMessageBox
    call scrollDownScreen
    call showSwitchBelowChoice
    or a
    jp nz, scrollUpScreen ; button not pushed
; if button pushed, check both statues position
    ld c, ARMORS_ROOM_STATUE_1
    call findNpcEntity
    or a
    jp z, scrollUpScreen ; return if statue not found
; statue 1 found and check its x position, if xPos !== -272 then activate gas
    ld hl, wEntityPositionX - wEntityStructData
    add hl, de
    ld a, [hli]
    cp a, LOW(-272)
    jp nz, activateArmorsRoomPoisonGas
    ld a, [hl]
    cp a, HIGH(-272)
    jp nz, activateArmorsRoomPoisonGas
; find and check statue 2 position
    ld c, ARMORS_ROOM_STATUE_2
    call findNpcEntity
    or a
    jp z, scrollUpScreen ; return if statue not found
; statue 2 found and check its x position, if xPos !== 0 then activate gas
    ld hl, wEntityPositionZ - wEntityStructData ; $13
    add hl, de
    ld a, [hli]
    or a ; 0
    jp nz, activateArmorsRoomPoisonGas
    ld a, [hl]
    or a ; 0
    jp nz, activateArmorsRoomPoisonGas
    jr sunCrestShowcaseOpened

activateArmorsRoomPoisonGas:
    ld a, $FF
    ld [wRoomGasActivatedFlag], a
    ld a, UPDATE_BG_PALETTE
    ld [wPaletteFadeCounter], a
    ld hl, text_pointer_4003 ; Something has happened!
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    jp scrollUpScreen

sunCrestShowcaseOpened:
    ld hl, text_pointer_4003 ; Something has happened!
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld a, $FF
    ld [wArmorsRoomGasButtonPushedFlag], a
    ld [wRoomsItemsFlags+ROOM23_SUN_CREST], a
    jp scrollUpScreen

smallLibraryActions:
    ld a, [wRoomInteractionID]
    cp a, $F0
    jr z, .Label5F7D
    cp a, $F1
    jr z, .Label5F83
    cp a, $F2
    jr z, .Label5F89
    cp a, $F2
    jr z, .Label5F89
    ret
.Label5F7D ; 01:5F7D
    ld hl, text_pointer_400F ; Nothing unusual.
    jp displayActionMessage
.Label5F83
    ld hl, text_pointer_400F ; Nothing unusual.
    jp displayActionMessage
.Label5F89
    ld hl, text_pointer_408D ; It's well arranged.
    jp displayActionMessage

researchersPrivateRoomActions:
    ld a, [wRoomInteractionID]
    cp a, $F0
    jr z, .Label5F9B
    cp a, $F8
    jr z, .checkBugCollectionButton
    ret
.Label5F9B
    ld hl, text_pointer_408D ; It's well arranged.
    jp displayActionMessage
.checkBugCollectionButton
    ld a, [wBugCollectionButtonPushedFlag]
    or a
    ret nz
    ld a, BUG_COLLECTION_SCREEN
    ld [wRoomCameraId], a
    call loadEventRoomScreen
    ld b, $80
    call routineDelay
    call clearMessageBox
    call scrollDownScreen
    call showSwitchChoice
    or a
    jp nz, scrollUpScreen ; switch not pushed
    ld a, $FF
    ld [wBugCollectionButtonPushedFlag], a
; find shelf entity and movie it
    ld de, wNPCEntitiesDataStructs
    ld b, 7
.findShelfLoop
    ld hl, wEntityId - wEntityStructData
    add hl, de
    ld a, [hl]
    cp a, RESEARCHER_ROOM_SHELF
    jr z, .shelfFound
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld e, a
    dec b
    jr nz, .findShelfLoop
; if shelf is not found, the game gets stuck in an infinite loop
.shelfNotFoundLoop ; 
    jr @
; move shelf if found
.shelfFound
    ld hl, wEntityPositionZ - wEntityStructData
    add hl, de
    ld bc, -160 ; new zpos
    ld [hl], c
    inc hl
    ld [hl], b
    xor a
    ld [wObjectEntitiesFlags+RESEARCHER_ROOM_SHELF_P1_VARID], a
    ld a, $FF
    ld [wObjectEntitiesFlags+RESEARCHER_ROOM_SHELF_P2_VARID], a
    ret
; 5FF4

taxidermyRoomActions: ; 01:5FF4
    ld a, [wRoomInteractionID]
    cp a, $F8
    jr z, .Label5FFC
    ret
.Label5FFC ; 01:5FFC
    call clearMessageBox
    call scrollDownScreen
    call showSwitchChoice
    or a
    jp nz, scrollUpScreen
; switch room lights flag
    ld a, [wTaxidermyRoomLightsFlag]
    xor a, $FF
    ld [wTaxidermyRoomLightsFlag], a
    ld a, UPDATE_BG_PALETTE
    ld [wPaletteFadeCounter], a
    jp scrollUpScreen


hiddenLibraryActions:
    ld a, [wRoomInteractionID]
    cp a, $F8
    jr z, .Label6021
    ret
.Label6021
    call clearMessageBox
    call scrollDownScreen
    call showSwitchChoice
    or a
    jp nz, scrollUpScreen
; switch statue lights flag
    ld a, [wHiddenLibraryStatueLightsFlag]
    xor a, $FF
    ld [wHiddenLibraryStatueLightsFlag], a
    jp scrollUpScreen

courtyardFloodgateActions:
    ld a, [wRoomCameraId]
    cp a, 1
    jr z, .Label604E
    ld a, 3
    ld [wRoomCameraId], a
    call loadEventRoomScreen
    ld hl, text_pointer_40A2 ; There's a square hole.
    jp displayActionMessage
.Label604E
    ld a, [wCourtyardFloodgateClosedFlag]
    or a
    ret nz
    ld hl, text_pointer_40A5 ; A water passage. There's a ladder here.
    jp displayActionMessage

waterfallGardenActions:
    ld a, [wRoomInteractionID]
    cp a, $F9
    jr z, .checkBattery
.checkWaterfall
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_40AB ; The water is running from the upper water passage.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld hl, text_pointer_40AE ; There's something at the back.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    jp scrollUpScreen
.checkBattery
    ld hl, text_pointer_40B1 ; The battery is pulled out.
    jp displayActionMessage

dorm001BathroomActions:
    ld a, [wRoomInteractionID]
    cp a, $F0
    jr z, .Label608F
    ret
.Label608F
    ld hl, text_pointer_400F ; Nothing unusual.
    jp displayActionMessage

aquaTankControlRoomActions:
    ld a, [wRoomInteractionID]
    cp a, $F0
    jr z, .Label60A7
    cp a, $F8
    jp z, checkControlRoomWaterLever
    cp a, $F9
    jp z, checkStoreroomDoorSwitch
    ret
.Label60A7
    ld hl, text_pointer_400F ; Nothing unusual.
    jp displayActionMessage

checkControlRoomWaterLever:
    ld a, [wFloodedRoomsDrainedWaterFlag]
    or a
    ret nz
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_40EA ; There's a lever. Will you move it?  Yes No
    call displayMessage
.choiceLoop
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, .choiceLoop
    call clearMessageBox
    ld a, [wChoiceId]
    or a
    jp nz, scrollUpScreen
    ld a, $FF
    ld [wFloodedRoomsDrainedWaterFlag], a
    call loadEventRoomScreen
    jp scrollUpScreen

checkStoreroomDoorSwitch:
    ld a, [wFloodedRoomsDrainedWaterFlag]
    or a
    ret z
    ld a, [wDoorsLocksFlags+DOOR_58]
    or a
    ret nz
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_40ED ; There's a button. Will you push it?  Yes No
    call displayMessage
.choiceLoop
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, .choiceLoop
    call clearMessageBox
    ld a, [wChoiceId]
    or a
    jp nz, scrollUpScreen
    ld hl, text_pointer_40F0 ; There was a sound from the room netxt door.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld a, $FF
    ld [wDoorsLocksFlags+DOOR_58], a
    jp scrollUpScreen

guardhouseDorm002Actions:
    ld hl, text_pointer_4075 ; It's too dark to see anything.
    jp displayActionMessage

dorm002BathroomActions:
    ld a, [wRoomInteractionID]
    cp a, $F0
    jr z, .Label612D
    cp a, $F1
    jr z, .Label6133
    ret
.Label612D
    ld hl, text_pointer_400F ; Nothing unusual.
    jp displayActionMessage
.Label6133
    ld hl, text_pointer_40BD ; No water is left.
    jp displayActionMessage

chemistryRoomActions:
    ld a, [wRoomInteractionID]
    cp a, $F8
    jp z, checkChemicalUMB2
    cp a, $F9
    jp z, checkChemicalUMB4
    cp a, $FA
    jp z, checkWaterSink
    cp a, $FB
    jp z, checkWallFormula
    ret

checkWallFormula: ; 01:6151
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_40D2 ; Something is written on the wall.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld hl, text_pointer_40D5 ; Water=1 Red=2 Purple=3 Green=4
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld hl, text_pointer_40D8 ; 1+2=3, 3+4=7, 2+4=6 6+7=13, 13+3=16
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    jp scrollUpScreen

checkWaterSink:
    call findEmptyBottle
    or a
    jp z, emptyBottleNotFound
    push hl
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_40C6 ; Will you put WATER to the empty bottle?  Yes No
    call displayMessage
.choiceLoop
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, .choiceLoop
    pop hl
    ld a, [wChoiceId]
    or a
    jp nz, scrollUpScreen
    ld [hl], WATER_BOTTLE
    call clearMessageBox
    jp scrollUpScreen

checkChemicalUMB2:
    call findEmptyBottle
    or a
    jp z, emptyBottleNotFound
    push hl
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_40C9 ; Will you put UMB2 to the empty bottle?  Yes No
    call displayMessage
.choiceLoop
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, .choiceLoop
    pop hl
    ld a, [wChoiceId]
    or a
    jp nz, scrollUpScreen
    ld [hl], UMB_NO2
    call clearMessageBox
    jp scrollUpScreen

checkChemicalUMB4:
    call findEmptyBottle
    or a
    jp z, emptyBottleNotFound
    push hl
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_40CC ; Will you put UMB4 to the empty bottle?  Yes No
    call displayMessage
.choiceLoop
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, .choiceLoop
    pop hl
    ld a, [wChoiceId]
    or a
    jp nz, scrollUpScreen
    ld [hl], UMB_NO4
    call clearMessageBox
    jp scrollUpScreen

emptyBottleNotFound:
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_40CF ; You need a container to obtain it.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    jp scrollUpScreen

findEmptyBottle: ; 01:621D
    ld hl, wItemIdSlot1
    ld b, CHRIS_MAX_SLOTS
    ld a, [wSelectedCharacter]
    or a
    jr z, .findEmptyBottleLoop 
    ld b, JILL_MAX_SLOTS
.findEmptyBottleLoop
    ld a, [hl]
    cp a, EMPTY_BOTTLE
    jr z, .emptyBottleFound
    inc hl
    dec b
    jr nz, .findEmptyBottleLoop
.emptyBottleNotFound
    xor a
    ret
.emptyBottleFound
    ld a, $FF
    ret
; 6238

guardhouseDorm003Actions: ; 01:6238
    ld a, [wRoomInteractionID]
    cp a, $F8
    jr z, .checkMissingBook
    ret
.checkMissingBook
    ld a, [wDorm003WhiteBookRemovedFlag]
    or a
    jr z, takeWhitebook
    ld a, [wRedBookPlacedFlag]
    or a
    ret nz
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_40E4 ; I wonder where the missing book is...
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    jp scrollUpScreen

takeWhitebook:
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_40DB ; A row of red books.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld hl, text_pointer_40DE ; There's one white book. Will you take it?  Yes No
    call displayMessage
.choiceLoop
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, .choiceLoop
    call clearMessageBox
    ld a, [wChoiceId]
    or a
    jp nz, scrollUpScreen
    ld a, $FF
    ld [wDorm003WhiteBookRemovedFlag], a
    ld hl, text_pointer_40E1 ; Now a book is missing.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    jp scrollUpScreen

aquaTankStoreroomActions:
    ld hl, text_pointer_40E7 ; They are all wet and useless.
    jp displayActionMessage

visualDataRoomActions:
    ld a, [wRoomInteractionID]
    cp a, $F8
    jp z, checkPilarPushButton
    cp a, $F9
    jp z, checkProjector
    cp a, $FA
    jp z, checkWhiteboard
    ret
; 62B9

checkPilarPushButton: ; 01:62B9
    ld a, [wVisualDataRoomPanelButtonOpened]
    or a
    jr nz, .Label62EA
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_40F3 ; There's a panel. Will you open it?  Yes No
    call displayMessage
.choiceLoop
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, .choiceLoop
    call clearMessageBox
    ld a, [wChoiceId]
    or a
    jp nz, scrollUpScreen
    ld a, $FF
    ld [wVisualDataRoomPanelButtonOpened], a
    call updateSceneBgAndAllSprites ; it should be reload room bg? %fix
    jp scrollUpScreen
.Label62EA
    ld a, [wVisualDataRoomPillarMovedFlag]
    or a
    ret nz
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_40F6 ; There's a switch. Will you push it?  Yes No
    call displayMessage
.choiceLoop2
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, .choiceLoop2
    call clearMessageBox
    ld a, [wChoiceId]
    or a
    jp nz, scrollUpScreen
    ld a, $FF
    ld [wVisualDataRoomPillarMovedFlag], a
    ld [wRoomsItemsFlags+ROOM5D_LAB_KEY], a
    call updateSceneBgAndAllSprites
    jp scrollUpScreen

checkProjector:
    ld a, [wProjectorSlidePlacedFlag]
    or a
    jr z, .Label633D
    ld a, WHITEBOARD_SCREEN
    ld [wRoomCameraId], a
    call loadEventRoomScreen
; show projector slides. unfinished
    call showLabProjectorSlide1
    call showLabProjectorSlide2
    call showLabProjectorSlide3
    call showLabProjectorSlide4
    call showLabProjectorSlide5
	; research staff slide ?
    jp updateSceneBgAndAllSprites
.Label633D
    ld hl, text_pointer_40F9 ; A projector.
    jp displayActionMessage

checkWhiteboard:
    ld a, WHITEBOARD_SCREEN
    ld [wRoomCameraId], a
    call loadEventRoomScreen
    ld hl, text_pointer_40FC ; A screen.
    jp displayActionMessage

smallLabActions:
    ld a, [wRoomInteractionID]
    cp a, $F8
    jp z, .Label635A
    ret
.Label635A: ; 01:635A
    ld a, LAB_COMPUTER_SCREEN
    ld [wRoomCameraId], a
    call loadEventRoomScreen
    ld b, $50
    call routineDelay
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_40FF ; This computer is used to unlock the electronic key.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld hl, text_pointer_4102 ; Will you turn it on?  Yes No
    call displayMessage
.choiceLoop
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, .choiceLoop
    call clearMessageBox
    ld a, [wChoiceId]
    or a
    jp nz, scrollUpScreen
    call scrollUpScreen
    ld a, COMPUTER_STARTUP_SFX
    call playSFX
    ld b, $0A
    call routineDelay
    call displayLabComputerStartupBgMask
    ld b, $50
    call routineDelay
    jp checkComputerLogin

labB3fWestCorridorActions:
    ld a, [wRoomInteractionID]
    cp a, $F8
    jp z, .checkPasscode01
    ret
.checkPasscode01 ; 01:63B4
    ld a, [wMoDiskPasscode01FiledFlag]
    or a
    jr z, .checkPasscode02
    ld a, [wPasscode01CheckedFlag]
    or a
    jr nz, .checkPasscode02
    ld a, $FF
    ld [wPasscode01CheckedFlag], a
    jr .showPasscodeEnteredMsg
.checkPasscode02
    ld a, [wMoDiskPasscode02FiledFlag]
    or a
    jr z, .checkPasscode03
    ld a, [wPasscode02CheckedFlag]
    or a
    jr nz, .checkPasscode03
    ld a, $FF
    ld [wPasscode02CheckedFlag], a
    jr .showPasscodeEnteredMsg
.checkPasscode03
    ld a, [wMoDiskPasscode03FiledFlag]
    or a
    ret z
    ld a, [wPasscode03CheckedFlag]
    or a
    ret nz
    ld a, $FF
    ld [wPasscode03CheckedFlag], a
.showPasscodeEnteredMsg
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_410E ; You've entered the pass code.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    call scrollUpScreen
; verify all passcodes
    ld a, [wPasscode01CheckedFlag]
    or a
    ret z
    ld a, [wPasscode02CheckedFlag]
    or a
    ret z
    ld a, [wPasscode03CheckedFlag]
    or a
    ret z
; unlock detention chamber passage door
    ld a, $FF
    ld [wDoorsLocksFlags+DOOR_70], a
    ret
; 6413

xRayRoomActions: ; 01:6413
    ld a, [wRoomInteractionID]
    cp a, $F8
    jr z, checkBlueLightSwitch
    cp a, $F9
    jr z, checkNormalLightSwitch
    cp a, $FA
    jr z, checkXrayRoomPainting
    ret

checkBlueLightSwitch: ; 01:6423
    ld a, [wXRayRoomBlueLightsFlag]
    or a
    ret nz ; ret if blue light is on
    call clearMessageBox
    call scrollDownScreen
    call showSwitchChoice
    or a
    jp nz, scrollUpScreen
	; turn on blue light
    ld a, $FF
    ld [wXRayRoomBlueLightsFlag], a
    ld a, UPDATE_BG_PALETTE
    ld [wPaletteFadeCounter], a
    jp scrollUpScreen

checkNormalLightSwitch:
    ld a, [wXRayRoomNormalLightsFlag]
    or a
    ret nz ; ret if normal light is on
    call clearMessageBox
    call scrollDownScreen
    call showSwitchChoice
    or a
    jp nz, scrollUpScreen
	; turn on normal light
    ld a, $FF
    ld [wXRayRoomNormalLightsFlag], a
    ld a, UPDATE_BG_PALETTE
    ld [wPaletteFadeCounter], a
    jp scrollUpScreen

checkXrayRoomPainting:
    ld c, XRAY_ROOM_PAINTING_DECODED_SCREEN
    ld a, [wXRayRoomBlueLightsFlag]
    or a
    jr z, .showXrayRoomPainting
    ld a, [wXRayRoomNormalLightsFlag]
    or a
    jr z, .showXrayRoomPainting
    ld c, XRAY_ROOM_PAINTING_SCREEN
.showXrayRoomPainting
    ld a, c
    ld [wRoomCameraId], a
    call loadEventRoomScreen
    jp waitMessageForPlayerInput

labElevatorEntryActions:
    ld a, [wRoomInteractionID]
    cp a, $F8
    jp z, .Label6484
    ret
.Label6484: ; 01:6484
    ld a, [wDoorsLocksFlags+DOOR_72]
    or a
    ret nz
    call clearMessageBox
    call scrollDownScreen
    call showSwitchChoice
    or a
    jp nz, scrollUpScreen
    ld a, [wBlackOutAreasPoweredFlag]
    or a
    jr z, .labElevatorNotPowered
    ld a, [wLabElevatorPoweredUpFlag]
    or a
    jr z, .labElevatorNotPowered
    ld hl, text_pointer_4003 ; Something has happened!
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld a, $FF
    ld [wDoorsLocksFlags+DOOR_72], a
    jp scrollUpScreen
.labElevatorNotPowered
    ld hl, text_pointer_4111 ; There's no reaction. It has no power.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    jp scrollUpScreen

powerRoomPassage1Actions:
    ld a, [wRoomInteractionID]
    cp a, $F8
    jp z, .Label64CE
    ret
; 64CE
.Label64CE ; 01:64CE
    ld a, [wBlackOutAreasPoweredFlag]
    or a
    jr nz, .Label650B
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4123 ; A power panel. Some areas do not get power.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld hl, text_pointer_4126 ; Will you activate the blacked-out areas? Yes No
    call displayMessage
.choiceLoop
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, .choiceLoop
    call clearMessageBox
    ld a, [wChoiceId]
    or a
    jp nz, scrollUpScreen
    ld a, $FF
    ld [wBlackOutAreasPoweredFlag], a
    call updateSceneBgAndAllSprites
    jp scrollUpScreen
.Label650B
    ld hl, text_pointer_4129
    jp displayActionMessage

labPowerRoomActions:
    ld a, [wRoomInteractionID]
    cp a, $F8
    jp z, showSystemActivatorMsg
    cp a, $F9
    jp z, checkElevatorPowerSwitch
    ret

checkElevatorPowerSwitch: ; 01:651F
    call clearMessageBox
    call scrollDownScreen
    ld a, [wLabElevatorPoweredUpFlag]
    or a
    jr nz, .Label6556
    ld hl, text_pointer_4132 ; A power connection switch. The elevator power is off.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld hl, text_pointer_4135 ; Will you connect it?  Yes No
    call displayMessage
.choiceLoop
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, .choiceLoop
    call clearMessageBox
    ld a, [wChoiceId]
    or a
    jp nz, scrollUpScreen
    ld a, $FF
    ld [wLabElevatorPoweredUpFlag], a
.Label6556
    ld hl, text_pointer_4138 ; The power to the elevator is on.
    jp displayActionMessage

showSystemActivatorMsg:
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_412C ; It's a triggering system activator.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld hl, text_pointer_412F ; It's quite big.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    jp scrollUpScreen

MainLaboratoryActions:
    ld a, [wRoomInteractionID]
    cp a, $F8
    jp z, .Label6586
    ret
.Label6586: ; 01:6586
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_413E ; It looks like the control device for this room.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld a, [wDoorsLocksFlags+DOOR_7E] ; C47E
    or a
    jp nz, scrollUpScreen
    ld hl, text_pointer_4144 ; A door lock device. Will you unlock it?  Yes No
    call displayMessage
.choiceLoop
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, .choiceLoop
    call clearMessageBox
    ld a, [wChoiceId]
    or a
    jp nz, scrollUpScreen
    ld hl, text_pointer_4003 ; Something has happened!
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld a, $FF
    ld [wTyrant1DefeatedFlag], a
    ld [wDoorsLocksFlags+DOOR_7E], a
    jp scrollUpScreen
; unused message action
Label65D0:
    ld a, [wDoorsLocksFlags+DOOR_7E]
    or a
    jp nz, scrollUpScreen
    ld hl, text_pointer_4141  ; But there's no time to operate it!
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    jp scrollUpScreen

largeGalleryActions:
    ld a, [wRoomInteractionID]
    cp a, $F8
    jr z, CheckTitlePainting
    cp a, $F9
    jr z, checkMidleAgeManPainting
    cp a, $FA
    jr z, checkNewbornBabyPainting
    cp a, $FB
    jr z, checkYoungManPainting
    cp a, $FC
    jp z, checkInfantPainting
    cp a, $FD
    jp z, checkLivelyBoyPainting
    cp a, $FE
    jp z, checkOldManPainting
    cp a, $F7
    jp z, checkFinalPainting
    ret

CheckTitlePainting: ; 01:660E
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4057 ; The title is 'Give me peaceful sleep'.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    jp scrollUpScreen

checkMidleAgeManPainting:
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_405A ; A picture of a tired middle-aged man.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld hl, text_pointer_4072 ; There's a switch below. Will you push it?  Yes/No
    call displayMessage
    call checkPaintingSwitch
    call clearMessageBox
    jp scrollUpScreen

checkNewbornBabyPainting:
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_405D ; A picture of a newborn baby.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld hl, text_pointer_4072 ; There's a switch below. Will you push it?  Yes/No
    call displayMessage
    call checkPaintingSwitch
    call clearMessageBox
    jp scrollUpScreen

checkYoungManPainting:
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4060  ; A picture of a young man.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld hl, text_pointer_4072 ; There's a switch below. Will you push it?  Yes/No
    call displayMessage
    call checkPaintingSwitch
    call clearMessageBox
    jp scrollUpScreen

checkInfantPainting:
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4063 ; A picture of an infant.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld hl, text_pointer_4072 ; There's a switch below. Will you push it?  Yes/No
    call displayMessage
    call checkPaintingSwitch
    call clearMessageBox
    jp scrollUpScreen

checkLivelyBoyPainting:
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4066 ; A picture of a lively boy.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld hl, text_pointer_4072 ; There's a switch below. Will you push it?  Yes/No
    call displayMessage
    call checkPaintingSwitch
    call clearMessageBox
    jp scrollUpScreen

checkOldManPainting:
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4069 ; A picture of a bold-looking old man.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld hl, text_pointer_4072 ; There's a switch below. Will you push it?  Yes/No
    call displayMessage
    call checkPaintingSwitch
    call clearMessageBox
    jp scrollUpScreen

checkFinalPainting:
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_406C ; There's a message.
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld hl, text_pointer_406F ; 'Give me the peace of death, and I'll give you the joy of life...'
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    ld hl, text_pointer_4072 ; There's a switch below. Will you push it?  Yes/No
    call displayMessage
    call checkPaintingSwitch
    call clearMessageBox
    jp scrollUpScreen

checkPaintingSwitch:
    call haltCPU
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, checkPaintingSwitch
    ld a, [wChoiceId]
    or a
    ret nz
    ld a, [wRoomInteractionID]
    cp a, $F9
    jp z, midleAgeManPaintingSwitchOn
    cp a, $FA
    jp z, newBornPaintingSwitchOn
    cp a, $FB
    jp z, youngManPaintingSwitchOn
    cp a, $FC
    jp z, infantPaintingSwitchOn
    cp a, $FD
    jp z, livelyBoyPaintingSwitchOn
    cp a, $FE
    jp z, oldManPaintingSwitchOn
    cp a, $F7
    jp z, finalPaintingSwitchOn
    ret
; 674F

midleAgeManPaintingSwitchOn: ; 01:674F
    ld a, $FF
    ld [wMidleAgeManPaintingSwitch], a
    ld a, SWITCH_SFX
    jp playSFX

newBornPaintingSwitchOn:
    ld a, $FF
    ld [wNewBornBabyPaintingSwitch], a
    ld a, SWITCH_SFX
    jp playSFX

youngManPaintingSwitchOn:
    ld a, $FF
    ld [wYoungManPaintingSwitch], a
    ld a, SWITCH_SFX
    jp playSFX

infantPaintingSwitchOn:
    ld a, $FF
    ld [wInfantPaintingSwitch], a
    ld a, SWITCH_SFX
    jp playSFX

livelyBoyPaintingSwitchOn:
    ld a, $FF
    ld [wLivelyBoyPaintingSwitch], a
    ld a, SWITCH_SFX
    jp playSFX

oldManPaintingSwitchOn:
    ld a, $FF
    ld [wOldManPaintingSwitch], a
    ld a, SWITCH_SFX
    jp playSFX

finalPaintingSwitchOn:
    ld a, [wPaintingsPuzzleSolvedFlag]
    or a
    ret nz
; this "puzzle" only check all painting switches on, there's no order checking
    ld a, [wMidleAgeManPaintingSwitch]
    cp a, $FF
    jr nz, resetPaintingsSwitches
    ld a, [wNewBornBabyPaintingSwitch]
    cp a, $FF
    jr nz, resetPaintingsSwitches
    ld a, [wYoungManPaintingSwitch]
    cp a, $FF
    jr nz, resetPaintingsSwitches
    ld a, [wInfantPaintingSwitch]
    cp a, $FF
    jr nz, resetPaintingsSwitches
    ld a, [wLivelyBoyPaintingSwitch]
    cp a, $FF
    jr nz, resetPaintingsSwitches
    ld a, [wOldManPaintingSwitch]
    cp a, $FF
    jr nz, resetPaintingsSwitches
    ld a, $FF
    ld [wPaintingsPuzzleSolvedFlag], a
    ld a, $FF
    ld [wRoomsItemsFlags+ROOM6F_STAR_CREST], a
; show painting removed bg mask
    ld a, [wRoomId]
    ld l, a
    ld a, [wRoomIdHigh]
    ld h, a
    add hl, hl
    add hl, hl
    ld de, roomsBgLookupTable
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
    xor a ; 0
    ld [wRoomBgTileTopY], a
    ld a, $10
    ld [wRoomBgTileBottomY], a
    xor a ; 0
    ld [wRoomBgTileLeftX], a
    ld a, $14
    ld [wRoomBgTileRightX], a
    jp loadRoomScreenBackground

resetPaintingsSwitches:
    xor a
    ld [wMidleAgeManPaintingSwitch], a
    ld [wNewBornBabyPaintingSwitch], a
    ld [wYoungManPaintingSwitch], a
    ld [wInfantPaintingSwitch], a
    ld [wLivelyBoyPaintingSwitch], a
    ld [wOldManPaintingSwitch], a
    ret
; 67FE

courtyardStudyActions: ; 01:67FE
    ld a, [wRoomInteractionID]
    cp a, $F8
    jr z, .Label6806
    ret
.Label6806: ; 01:6806
    ld a, [wCourtyardStudyLightsFlag]
    or a
    ret nz
    call clearMessageBox
    call scrollDownScreen
    call showSwitchChoice
    or a
    jp nz, scrollUpScreen
    ld a, $FF
    ld [wCourtyardStudyLightsFlag], a
; enable these items
    ld [wRoomsItemsFlags+ROOM71_MAGNUM_ROUNDS], a
    ld [wRoomsItemsFlags+ROOM71_DOOM_BOOK_2], a
    ld a, UPDATE_BG_PALETTE
    ld [wPaletteFadeCounter], a
    jp scrollUpScreen
