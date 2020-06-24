; check player position and change current room camera depending
; on position in room.
; Return true ($FF) if camera changed, otherwise, returns false ($00)
checkRoomCameraChange: ; C6:4000
    ld a, [wEntityPositionX]
    ld e, a
    ld a, [wEntityPositionX+1]
    ld d, a
    call div8WordC6
    ld l, e
    ld h, d ; hl: pos-x
    ld a, [wEntityPositionZ]
    ld e, a
    ld a, [wEntityPositionZ+1]
    ld d, a ; de: pos-z
    call div8WordC6
    ld c, 0
    ld a, [wRoomId]
    or a ; MAIN_HALL_1F
    jp z, checkMainMall1FCameraChange
    cp a, DINNING_ROOM_1F
    jp z, checkDinningRoom1FCameraChange
    cp a, WEST_STOREROOM
    jp z, checkWestStoreRoomCameraChange
    cp a, F_SHAPED_CORRIDOR
    jp z, checkFShapedCorridorCameraChange
    cp a, EXHIBITION_ROOM
    jp z, checkExhibitionRoomCameraChange
    cp a, REST_STOP_CORRIDOR
    jp z, checkRestStopCorridorCameraChange
    cp a, GREENHOUSE
    jp z, checkGreenhouseCameraChange
    cp a, PIANO_ROOM
    jp z, checkPianoRoomCameraChange
    cp a, WEST_STAIRCASE_1F
    jp z, checkWestStaircase1FCameraChange
    cp a, FIREARMS_ROOM
    jp z, checkFirearmsRoomCameraChange
    cp a, NORTH_EAST_CORRIDOR_1F
    jp z, checkNorthEastCorridor1FCameraChange
    cp a, BACK_ENTRANCE_CORRIDOR
    jp z, checkBackEntranceCorridorCameraChange
    cp a, L_SHAPED_CORRIDOR
    jp z, checkLShapedCorridorCameraChange
    cp a, EAST_STAIRS_CORRIDOR_1F
    jp z, checkEastStairsCorridor1FCameraChange
    cp a, KEEPERS_ROOM
    jp z, checkKeepersRoomCameraChange
    cp a, ELEVATOR_STAIRWAY
    jp z, checkElevatorStairwayCameraChange
    cp a, LARGE_ART_ROOM
    jp z, checkLargeArtRoomCameraChange
    cp a, MANSION_BATHROOM
    jp z, checkMansionBathroomCameraChange
    cp a, OUTDOOR_AREA
    jp z, checkOutdoorAreaCameraChange
    cp a, SHED_PASSAGE
    jp z, checkShedPassageCameraChange
    cp a, CLOSET_ROOM
    jp z, checkClosetRoomCameraChange
    cp a, SHED_ROOM
    jp z, checkShedRoomCameraChange
    cp a, MIRROR_ROOM
    jp z, checkMirrorRoomCameraChange
    cp a, LIVING_ROOM
    jp z, checkLivingRoomCameraChange
    cp a, FALLING_CIELING_ROOM
    jp z, checkFallingCielingRoomCameraChange
    cp a, UNDERGROUND_PASSAGE_1
    jp z, checkUndergroundPassage1CameraChange
    cp a, UNDERGROUND_PASSAGE_2
    jp z, checkUndergroundPassage2CameraChange
    cp a, DINNING_ROOM_2F
    jp z, checkDinningRoom2FCameraChange
    cp a, MAIN_HALL_2F
    jp z, checkMainHall2FCameraChange
    cp a, PILLAR_CORRIDOR
    jp z, checkPillarCorridorCameraChange
    cp a, LOUNGE_ROOM
    jp z, checkLoungeRoomCameraChange
    cp a, ELEVATOR_ROOM_2F
    jp z, checkElevatorRoom2FCameraChange
    cp a, HALLWAY_TO_EAST_TERRACE
    jp z, checkHallwayToEastTerraceCameraChange
    cp a, SMALL_DINNING_ROOM
    jp z, checkSmallDinningRoomCameraChange
    cp a, ARMORS_ROOM
    jp z, checkArmorsRoomCameraChange
    cp a, EAST_STAIRCASE_2F
    jp z, checkEastStaircase2FCameraChange
    cp a, WESTERN_CORRIDOR_2F
    jp z, checkWesternCorridor2FCameraChange
    cp a, MANSION_BEDROOM
    jp z, checkMansionBedroomCameraChange
    cp a, U_SHAPED_CORRIDOR
    jp z, checkUShapedCorridorCameraChange
    cp a, SMALL_LIBRARY
    jp z, checkSmallLibraryCameraChange
    cp a, RESEARCHERS_PRIVATE_ROOM
    jp z, checkResearchersPrivateRoomCameraChange
    cp a, TREVORS_TOMB
    jp z, checkTrevorsTombCameraChange
    cp a, LESSONS_ROOM
    jp z, checkLessonsRoomCameraChange
    cp a, ATTIC
    jp z, checkAtticCameraChange
    cp a, ATTIC_ENTRY
    jp z, checkAtticEntryCameraChange
    cp a, DEER_ROOM
    jp z, checkDeerRoomCameraChange
    cp a, EAST_TERRACE
    jp z, checkEastTerraceCameraChange
    cp a, TAXIDERMY_ROOM
    jp z, checkTaxidermyRoomCameraChange
    cp a, LIBRARY
    jp z, checkLibraryCameraChange
    cp a, HIDDEN_LIBRARY
    jp z, checkHiddenLibraryCameraChange
    cp a, MATERIALS_ROOM
    jp z, checkMaterialsRoomCameraChange
    cp a, HELIPAD_LOOKOUT_ROOM
    jp z, checkHelipadLookoutRoomCameraChange
    cp a, WEST_STAIRCASE_2F
    jp z, checkWestStaircase2FCameraChange
    cp a, COURTYARD_GARDEN
    jp z, checkCourtyardGardenCameraChange
    cp a, COURTYARD_FLOODGATE
    jp z, checkCourtyardFloodgateCameraChange
    cp a, WATERFALL_GARDEN
    jp z, checkWaterfallGardenCameraChange
    cp a, HELIPORT
    jp z, checkHeliportCameraChange
    cp a, WAY_TO_GUARDHOUSE
    jp z, checkWayToGuardhouseCameraChange
    cp a, UNDERGROUND_STATUE_ROOM
    jp z, checkUndergroundStatueRoomCameraChange
    cp a, UNDERGROUND_SOUTH_PASSAGE
    jp z, checkUndergroundSouthPassageCameraChange
    cp a, BOULDER_1_ROOM
    jp z, checkBoulder1RoomCameraChange
    cp a, BOULDER_2_ROOM
    jp z, checkBoulder2RoomCameraChange
    cp a, UNDERGROUND_ENTRY
    jp z, checkUndergroundEntryCameraChange
    cp a, UNDERGROUND_BREAK_ROOM
    jp z, checkUndergroundBreakRoomCameraChange
    cp a, FOUNTAIN
    jp z, checkFountainCameraChange
    cp a, FOUNTAIN_ELEVATOR
    jp z, checkFountainElevatorCameraChange
    cp a, UNDERGROUND_BRANCHED_PASSAGE
    jp z, checkUndergroundBranchedPassageCameraChange
    cp a, UNDERGROUND_GENERATOR_ROOM
    jp z, checkUndergroundGeneratorRoomCameraChange
    cp a, UNDERGROUND_WAREHOUSE
    jp z, checkUndergroundWarehouseCameraChange
    cp a, WAY_TO_BREAK_ROOM
    jp z, checkWayToBreakRoomCameraChange
    cp a, GUARDHOUSE_ENTRANCE
    jp z, checkGuardhouseEntranceCameraChange
    cp a, GUARDHOUSE_DORM_001
    jp z, checkGuardhouseDorm001CameraChange
    cp a, DORM_001_BATHROOM
    jp z, checkDorm001BathroomCameraChange
    cp a, GUARDHOUSE_BREAK_ROOM
    jp z, checkGuardhouseBreakRoomCameraChange
    cp a, AQUA_TANK_ROOM
    jp z, checkAquaTankRoomCameraChange
    cp a, AQUA_TANK_ENTRANCE
    jp z, checkAquaTankEntranceCameraChange
    cp a, AQUA_TANK_CONTROL_ROOM
    jp z, checkAquaTankControlRoomCameraChange
    cp a, GUARDHOUSE_BAR
    jp z, checkGuardhouseBarCameraChange
    cp a, DORMITORY_CORRIDOR
    jp z, checkDormitoryCorridorCameraChange
    cp a, GUARDHOUSE_DORM_002
    jp z, checkGuardhouseDorm002CameraChange
    cp a, DORM_002_BATHROOM
    jp z, checkDorm002BathroomCameraChange
    cp a, BEEHIVE_PASSAGE
    jp z, checkBeehivePassageCameraChange
    cp a, CHEMISTRY_ROOM
    jp z, checkChemistryRoomCameraChange
    cp a, GUARDHOUSE_DORM_003
    jp z, checkGuardhouseDorm003CameraChange
    cp a, DORM_003_BATHROOM
    jp z, checkDorm003BathroomCameraChange
    cp a, PLANT_42_ROOM
    jp z, checkPlant42RoomCameraChange
    cp a, AQUA_TANK_STOREROOM
    jp z, checkAquaTankStoreroomCameraChange
    cp a, PLANT_42_ROOTS_ROOM
    jp z, checkPlant42RootsRoomCameraChange
    cp a, EMERGENCY_TUNNEL
    jp z, checkEmergencyTunnelCameraChange
    cp a, LAB_ENTRANCE
    jp z, checkLabEntranceCameraChange
    cp a, LAB_LADDER_ROOM
    jp z, checkLabLadderRoomCameraChange
    cp a, LAB_B2F_STAIR_HALL
    jp z, checkLabB2FStairHallCameraChange
    cp a, VISUAL_DATA_ROOM
    jp z, checkVisualDataRoomCameraChange
    cp a, LAB_CENTRAL_CLOISTER
    jp z, checkLabCentralCloisterCameraChange
    cp a, SMALL_LAB
    jp z, checkSmallLabCameraChange
    cp a, OPERATING_MORGE_ROOM
    jp z, checkOperatingMorgeRoomCameraChange
    cp a, LAB_B3F_WEST_CORRIDOR
    jp z, checkLabB3FWestCorridorCameraChange
    cp a, LAB_RESEARCHER_ROOM
    jp z, checkLabResearcherRoomCameraChange
    cp a, XRAY_ROOM
    jp z, checkXrayRoomCameraChange
    cp a, DETENTION_ROOM_PASSAGE
    jp z, checkDetentionRoomPassageCameraChange
    cp a, LAB_ELEVATOR_ENTRY
    jp z, checkLabElevatorEntryCameraChange
    cp a, LAB_B3F_LOUNGE
    jp z, checkLabB3FLoungeCameraChange
    cp a, POWER_ROOM_PASSAGE_1
    jp z, checkPowerRoomPassage1CameraChange
    cp a, POWER_ROOM_PASSAGE_2
    jp z, checkPowerRoomPassage2CameraChange
    cp a, LAB_POWER_ROOM
    jp z, checkLabPowerRoomCameraChange
    cp a, MAIN_LAB_ENTRY
    jp z, checkMainLabEntryCameraChange
    cp a, DETENTION_ROOM
    jp z, checkDetentionRoomCameraChange
    cp a, MAIN_LABORATORY
    jp z, checkMainLaboratoryCameraChange
    cp a, LARGE_GALLERY
    jp z, checkLargeGalleryCameraChange
    cp a, EAST_STOREROOM
    jp z, checkEastStoreroomCameraChange
    cp a, COURTYARD_STUDY
    jp z, checkCourtyardStudyCameraChange
    cp a, MANSION_KITCHEN
    jp z, checkMansionKitchenCameraChange
    defaultCamera 0
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .Label31825B
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.Label31825B ;C6:425B
    xor a
    ret
;425D


; hl: pos x
; de: pos z
checkEmergencyTunnelCameraChange: ;C6:425D
    defaultCamera 0
    changeCamOnLtX 80, 1
    changeCamOnLtZ 95, 2
    changeCamOnLtZ -14, 3
    changeCamOnLtX -54, 4
    changeCamOnLtZ -94, 5
    changeCamOnLtX -102, 6
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, Label31830D
    ld a, c
    ld [wRoomCameraId], a
    ld a, [wSelectedCharacter]
    or a
    jr nz, Label3182ED ; if jill
; if chris
    ld a, [wChrisAndJillEscapingFromLabFlag]
    or a
    jr z, Label31830A
    ld a, [wLabEscapeRadioMessageReceivedFlag]
    or a
    jr nz, Label3182D4
    ld a, [wRoomCameraId]
    cp a, 2
    jr nz, Label31830A
    ld a, BRAD_RADIO_MESSAGE_IN_LAB_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wLabEscapeRadioMessageReceivedFlag], a
    jr Label31830A
Label3182D4
    ld a, [wBeforeHeliportElevatorSceneFlag]
    or a
    jr nz, Label31830A
    ld a, [wRoomCameraId]
    cp a, 5
    jr nz, Label31830A
    ld a, CHRIS_BEFORE_HELIPORT_ELEVATOR_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wBeforeHeliportElevatorSceneFlag], a
    jr Label31830A
Label3182ED
; if jill
    ld a, [wChrisAndJillEscapingFromLabFlag]
    or a
    jr z, Label31830A
    ld a, [wLabEscapeRadioMessageReceivedFlag]
    or a
    jr nz, Label31830A
    ld a, [wRoomCameraId]
    cp a, 2
    jr nz, Label31830A
    ld a, JILL_BRAD_RADIO_MESSAGE_3_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wLabEscapeRadioMessageReceivedFlag], a
Label31830A
    ld a, $FF
    ret
Label31830D: ;C6:430D
    xor a
    ret
;430F

checkLabEntranceCameraChange: ;C6:430F
    defaultCamera 2
    changeCamOnGteX -17, 1
    changeCamOnGteZ 54, 0
    changeCamOnLtXAndGteZ -28, 21, 3
.applyCameraChange
    xor a
    ld [wLabFountainEntranceOpenedFlag], a
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;4350

checkLabLadderRoomCameraChange: ;C6:4350
    defaultCamera 0
    changeCamOnZLtZero 1
    changeCamOnGteZAndGteX 25, -11, 2
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, Label3183BC
    ld a, c
    ld [wRoomCameraId], a
    ld a, [wSelectedCharacter]
    or a
    jr nz, Label31839C
; if chris
    ld a, [wRoomCameraId]
    cp a, 1
    jr nz, Label3183B9
    ld a, [wAfterJailEscapeSceneFlag]
    or a
    jr z, Label3183B9
    ld a, [wChrisAndJillEscapingFromLabFlag]
    or a
    jr nz, Label3183B9
    ld a, CHRIS_JILL_ESCAPING_LAB_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wChrisAndJillEscapingFromLabFlag], a
    jr Label3183B9
Label31839C
; if jill
    ld a, [wRoomCameraId]
    cp a, 1
    jr nz, Label3183B9
    ld a, [wAfterJailEscapeSceneFlag]
    or a
    jr z, Label3183B9
    ld a, [wChrisAndJillEscapingFromLabFlag]
    or a
    jr nz, Label3183B9
    ld a, JILL_CHRIS_ESCAPING_LAB_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wChrisAndJillEscapingFromLabFlag], a
Label3183B9:
    ld a, $FF
    ret
Label3183BC: ;C6:43BC
    xor a
    ret
;43BE

checkLabB2FStairHallCameraChange: ;C6:43BE
    defaultCamera 0
    changeCamOnLtX 34, 1
    changeCamOnLtZ 18, 2
    changeCamOnLtX -39, 3
    changeCamOnLtX -112, 5
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged: ;C6:43FB
    xor a
    ret
;43FD

checkVisualDataRoomCameraChange: ;C6:43FD
    defaultCamera 0
    changeCamOnZLtZero 1
    changeCamOnGteXAndGteZAndLtZ 21, -39, 40, 2
    changeCamOnLtXAndLtZ -20, -36, 3
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;4446

checkLabCentralCloisterCameraChange: ;C6:4446
    defaultCamera 0
    changeCamOnZGtZero 1
    changeCamOnGteX -78, 2
    changeCamOnGteX -34, 3
    changeCamOnGteX 22, 4
    changeCamOnGteXAndLtZ 95, 90, 5
    changeCamOnGteXAndLtZ 95, -43, 6
    changeCamOnLtZAndGteXAndLtX -70, -78, 95, 7
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, Label3184EB
    ld a, c
    ld [wRoomCameraId], a
    ld a, [wSelectedCharacter]
    or a
    jr nz, .changeCamera
; if chris
    ld a, [wTyrant1DefeatedFlag]
    or a
    jr z, .changeCamera
    ld a, [wLabAlertSceneWithChrisFlag]
    or a
    jr nz, .changeCamera
    ld a, [wRoomCameraId]
    cp a, $04
    jr nz, .changeCamera
    ld a, CHRIS_LAB_SELF_DESTRUC_ALERT_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wLabAlertSceneWithChrisFlag], a
.changeCamera
    ld a, $FF
    ret
Label3184EB: ;C6:44EB
    xor a
    ret
;44ED

checkSmallLabCameraChange: ;C6:44ED
    defaultCamera 0
    changeCamOnXLtZeroV2 1
    changeCamOnLtX -36, 2
    changeCamOnGteXAndLtZ 49, 8, 3
.applyCameraChange
    xor a
    ld [wDoorsLocksFlags+DOOR_6D], a ; lock door
    ld a, [wRoomCameraId]
    cp a, $5
    jr nz, Label318533
    ld a, [wEntityPositionY]
    cp a, 32
    jr c, Label318533
    ld a, [wRoomGasActivatedFlag]
    or a
    jr nz, Label318533
    ld a, $FF
    ld [wDoorsLocksFlags+DOOR_6D], a ; unlock door
Label318533
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged ;C6:4540
    xor a
    ret
;4542

checkOperatingMorgeRoomCameraChange: ;C6:4542
    defaultCamera 3
    changeCamOnGteX -99, 1
    changeCamOnGteX -68, 0
    changeCamOnGteZ -3, 2
    changeCam1OnGteXAndCam2OnLtZ 5, 4,   -2, 5
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged ;C6:458C
    xor a
    ret
;458E

checkLabB3FWestCorridorCameraChange: ;C6:458E
    defaultCamera 0
    changeCamOnGteX -55, 1
    changeCamOnGteX -5, 2
    changeCamOnGteX 63, 3
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, Label318603
    ld a, c
    ld [wRoomCameraId], a
    ld a, [wSelectedCharacter]
    or a
    jp nz, Label3185E3
; if chris
    ld a, [wChrisOrJillSavedFromJailFlag]
    or a
    jr z, Label318600
    ld a, [wAfterJailEscapeSceneFlag]
    or a
    jr nz, Label318600
    ld a, [wRoomCameraId]
    cp a, 3
    jr nz, Label318600
    ld a, CHRIS_AFTER_SAVE_JILL_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wAfterJailEscapeSceneFlag], a
    jr Label318600
Label3185E3
; if jill
    ld a, [wChrisOrJillSavedFromJailFlag]
    or a
    jr z, Label318600
    ld a, [wAfterJailEscapeSceneFlag]
    or a
    jr nz, Label318600
    ld a, [wRoomCameraId]
    cp a, $03
    jr nz, Label318600
    ld a, JILL_AFTER_SAVE_CHRIS_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wAfterJailEscapeSceneFlag], a
Label318600
    ld a, $FF
    ret
Label318603: ;C6:4603
    xor a
    ret
;4605

checkLabResearcherRoomCameraChange: ;C6:4605
    defaultCamera 0
    changeCamOnLtZ -10, 1
    changeCam1OnGteXAndCam2OnLtZ -9, 2,  -10, 3
    changeCamOnGteZAndGteX 13, 27, 4
    changeCamOnLtXAndGteXAnfLtZ -12, -39,  -45, 5
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;4668

checkXrayRoomCameraChange: ;C6:4668
    defaultCamera 2
    changeCam1OnZGteZeroAndCam2OnXLtZero 0, 1
.applyCameraChange 
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;468A

checkDetentionRoomPassageCameraChange: ;C6:468A
    defaultCamera 0
    changeCamOnLtZ 52, 1
    changeCamOnGteX -26, 2
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, Label3186EE
    ld a, c
    ld [wRoomCameraId], a
    ld a, [wPlant42DefeatedFlag]
    or a
    jr z, Label3186EB
    ld a, [wSelectedCharacter]
    or a
    jr nz, Label3186D2
; if chris
    ld a, [wChrisOrJillFoundInJailFlag]
    or a
    jr nz, Label3186EB
    ld a, [wRoomCameraId]
    cp a, 2
    jr nz, Label3186EB
    ld a, CHRIS_FINDS_JILL_IN_JAIL_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wChrisOrJillFoundInJailFlag], a
    jr Label3186EB
Label3186D2
; if jill
    ld a, [wChrisOrJillFoundInJailFlag]
    or a
    jr nz, Label3186EB
    ld a, [wRoomCameraId]
    cp a, 2
    jr nz, Label3186EB
    ld a, JILL_FINDS_CHRIS_IN_JAIL_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wChrisOrJillFoundInJailFlag], a
    jr Label3186EB
Label3186EB
    ld a, $FF
    ret
Label3186EE: ;C6:46EE
    xor a
    ret
;46F0

checkLabElevatorEntryCameraChange: ;C6:46F0
    defaultCamera 0
    changeCamOnGteZ -87, 1
    changeCamOnGteZOrJump -27, 5, applyCameraChange31872D
    changeCamOnGteX -111, 4
    changeCamOnGteX -33, 2
    changeCamOnGteZ 7, 3
applyCameraChange31872D:
    ld a, [wRoomCameraId]
    cp a, c
    jr z, Label318792
    ld a, c
    ld [wRoomCameraId], a
    ld a, [wPlant42DefeatedFlag]
    or a
    jr z, Label31878F
    ld a, [wSelectedCharacter]
    or a
    jr nz, Label31876A
; if chris
    ld a, [wTyrant1DefeatedFlag]
    or a
    jr nz, Label318768
    ld a, [wLabElevatorUnlockedFlag]
    or a
    jr z, Label31878F
    ld a, [wBeforeTyrant1stBattleSceneFlag]
    or a
    jr nz, Label31878F
    ld a, [wRoomCameraId]
    cp a, 3
    jr nz, Label31878F
    ld a, CHRIS_FIRST_TYRANT_BATTLE_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wBeforeTyrant1stBattleSceneFlag], a
    jr Label31878F
Label318768
    jr Label31878F
Label31876A
; if jill
    ld a, [wTyrant1DefeatedFlag]
    or a
    jr nz, Label31878F
    ld a, [wLabElevatorUnlockedFlag]
    or a
    jr z, Label31878F
    ld a, [wBeforeTyrant1stBattleSceneFlag]
    or a
    jr nz, Label31878F
    ld a, [wRoomCameraId]
    cp a, 3
    jr nz, Label31878F
    ld a, JILL_BEFORE_TYRANT_1ST_BATTLE_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wBeforeTyrant1stBattleSceneFlag], a
    jr Label31878F
Label31878F:
    ld a, $FF
    ret
Label318792: ;C6:4792
    xor a
    ret
;4794

checkLabB3FLoungeCameraChange: ;C6:4794
    defaultCamera 1
    changeCamOnLtZ -6, 0
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;47B1

checkPowerRoomPassage1CameraChange: ;C6:47B1
    defaultCamera 0
    changeCamOnGteX 23, 3
    changeCamOnLtXAndGteZ -50, -66, 1
    changeCamOnLtXAndGteZ -77, -86, 2
    changeCamOnGteXAndGteZ 23, -66, 4
    changeCamOnGteXAndGteZ 23, 29, 5
    changeCamOnGteXAndGteZ 86, -66, 6
    changeCamOnGteXAndGteZ 50, 39, 7
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;484B

checkPowerRoomPassage2CameraChange: ;C6:484B
    defaultCamera 0
    changeCamOnGteZ 41, 1
    changeCamOnGteZ 73, 2
    changeCamOnLtXAndLtZ 103, 30, 3
    changeCamOnLtX -38, 4
    changeCamOnGteZAndLtX 46, 60, 6
    changeCamOnGteZAndXLtZero 46, 5
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;48B6

checkLabPowerRoomCameraChange: ;C6:48B6
    defaultCamera 5
    changeCamOnLtX 76, 0
    changeCamOnLtXAndGteZ -67, -22, 1
    changeCamOnGteZAndGteX 33, -88, 2
    changeCamOnGteZAndGteX 33, -39, 3
    changeCamOnGteZAndGteX -8, 85, 4
.applyCameraChange 
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;4927

checkMainLabEntryCameraChange: ;C6:4927
    defaultCamera 0
    changeCamOnLtX 3, 1
    changeCamOnGteZ -5, 2
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, Label318993
    ld a, c
    ld [wRoomCameraId], a
    ld a, [wSelectedCharacter]
    or a
    jr nz, Label318971
; if chris
    ld a, [wTyrant1DefeatedFlag]
    or a
    jr nz, Label318958
    jr Label318990
Label318958
    ld a, [wAfter1stTyrantSceneFlag]
    or a
    jr nz, Label318990
    ld a, [wRoomCameraId]
    cp a, $02
    jr nz, Label318990
    ld a, CHRIS_AFTER_FIRST_TYRANT_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wAfter1stTyrantSceneFlag], a
    jr Label318990
Label318971
; if jill
    ld a, [wTyrant1DefeatedFlag]
    or a
    jr nz, Label318979
    jr Label318990
Label318979
    ld a, [wAfter1stTyrantSceneFlag]
    or a
    jr nz, Label318990
    ld a, [wRoomCameraId]
    cp a, $02
    jr nz, Label318990
    ld a, JILL_LAB_SELF_DESTRUCT_ALERT_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wAfter1stTyrantSceneFlag], a
Label318990
    ld a, $FF
    ret
Label318993: ;C6:4993
    xor a
    ret
;4995

checkDetentionRoomCameraChange: ;C6:4995
    defaultCamera 0
    changeCamOnLtZ 8, 1
    changeCamOnGteZAndGteX 23, -13, 2
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, Label318A04
    ld a, c
    ld [wRoomCameraId], a
    ld a, [wSelectedCharacter]
    or a
    jr nz, Label3189E5
; if chris
    ld a, [wTyrant1DefeatedFlag]
    or a
    jr z, Label318A01
    ld a, [wChrisOrJillSavedFromJailFlag]
    or a
    jr nz, Label318A01
    ld a, [wRoomCameraId]
    or a
    jr nz, Label318A01
    ld a, CHRIS_SAVE_JILL_FROM_JAIL_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wChrisOrJillSavedFromJailFlag], a
    jr Label318A01
Label3189E5
; if jill
    ld a, [wTyrant1DefeatedFlag]
    or a
    jr z, Label318A01
    ld a, [wChrisOrJillSavedFromJailFlag]
    or a
    jr nz, Label318A01
    ld a, [wRoomCameraId]
    or a
    jr nz, Label318A01
    ld a, JILL_SAVES_CHRIS_FROM_JAIL_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wChrisOrJillSavedFromJailFlag], a
Label318A01
    ld a, $FF
    ret
Label318A04: ;C6:4A04
    xor a
    ret
;4A06

checkMainLaboratoryCameraChange: ;C6:4A06
    defaultCamera 0
    changeCamOnLtX -54, 1
    changeCamOnGteZ 63, 2
    changeCam1OnGteXAndCam2OnGteZ 26, 4,  9, 3
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;4A44


checkLargeGalleryCameraChange: ;C6:4A44
    defaultCamera 0
    changeCamOnGteX -31, 1
    changeCamOnGteX 9, 2
    changeCamOnGteZOrJump -2, 3, applyCameraChange318A80
    changeCamOnLtX 16, 4
    changeCamOnLtX -57, 5
applyCameraChange318A80:
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;4A8F


checkEastStoreroomCameraChange: ;C6:4A8F
    defaultCamera 0
    changeCamOnZLtZeroV2 1
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;4AA7

checkCourtyardStudyCameraChange: ;C6:4AA7
    defaultCamera 0
    changeCamOnLtZ 4, 1
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;4AC3

checkMansionKitchenCameraChange: ;C6:4AC3
    defaultCamera 1
    changeCamOnLtZ -23, 0
    changeCamOnGteX -3, 2
    changeCamOnGteX 83, 3
    changeCamOnLtZAndGteX 15, 83, 4
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ld [wDoorsLocksFlags+DOOR_1B], a ; unlock door
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;4B10

checkGuardhouseEntranceCameraChange: ;C6:4B10
    defaultCamera 1
    changeCamOnGteZ -82, 0
    changeCamOnGteX -96, 2
    changeCamOnGteX -36, 3
    ld a, h
    or a
    jr nz, applyCameraChange318B52
    changeCamOnGteZ -56, 5
    changeCamOnGteZ -19, 4
applyCameraChange318B52:
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;4B61

checkGuardhouseDorm001CameraChange: ;C6:4B61
    defaultCamera 1
    changeCamOnGteZ 37, 0
    changeCamOnLtX 20, 2
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;4B88

checkDorm001BathroomCameraChange: ;C6:4B88
    defaultCamera 0
    changeCamOnXEqZeroAndZLtZero 1
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;4BA8

checkGuardhouseBreakRoomCameraChange: ;C6:4BA8
    defaultCamera 0
    changeCamOnZGtZero 1
    changeCamOnGteZAndLtZAndGteX -3, 35,  21, 2
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;4BDD

checkAquaTankRoomCameraChange: ;C6:4BDD
    defaultCamera 0
    changeCamOnLtZ -19, 1
    changeCamOnLtXOrJump 36, 3, applyCameraChange318C19
    changeCamOnLtX -30, 2
    changeCamOnLtX -94, 4
    changeCamOnGteZ 71, 5
applyCameraChange318C19:
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;4C28

checkAquaTankEntranceCameraChange: ;C6:4C28
    defaultCamera 0
    changeCamOnGteZ -78, 1
    changeCamOnGteX -96, 2
    changeCamOnGteX -22, 3
    changeCamOnGteX 77, 4
    changeCamOnGteZ -28, 5
    changeCam1OnGteZAndCam2OnLtX 131, 6,    39, 7
.applyCameraChange
    ld a, $FF
    ld [wDorm002ClosetMovedFlag], a
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;4C8F

checkAquaTankControlRoomCameraChange: ;C6:4C8F
    defaultCamera 0
    changeCamOnLtZ 4, 1
    changeCamOnGteXAndLtZ 6, -19, 2
    changeCamOnLtXAndLtZ -13, -10, 3
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;4CD6

checkGuardhouseBarCameraChange: ;C6:4CD6
    defaultCamera 5
    changeCamOnLtZ -52, 4
    changeCamOnGteX -62, 3
    changeCamOnGteXAndGteZ -62, -49, 2
    changeCamOnGteZ 19, 0
    changeCamOnLtXAndGteZ -49, 55, 1
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;4D35

checkDormitoryCorridorCameraChange: ;C6:4D35
    defaultCamera 0
    changeCamOnGteX -49, 1
    changeCamOnGteX 4, 2
    changeCamOnGteX 41, 7
    changeCamOnGteX 70,3
    changeCamOnLtZ 37, 4
    changeCamOnLtZAndGteX -69, 90, 5
    changeCamOnLtZ -91, 6
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, Label318DC9
    ld a, c
    ld [wRoomCameraId], a
    cp a, 3
    jr nz, Label318DC6
    ld a, [wPlant42DefeatedFlag]
    or a
    jr z, Label318DC6
    ld a, [wTalkWithWeskerInWarehouseFlag]
    or a
    jr nz, Label318DC6
    ld a, [wSelectedCharacter]
    or a
    jr z, Label318DBC
; if jill
    ld a, JILL_WESKER_TALK_IN_WAREHOUSE_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wTalkWithWeskerInWarehouseFlag], a
    jr Label318DC6
Label318DBC
; if chris
    ld a, CHRIS_WESKER_TALK_IN_WAREHOUSE_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wTalkWithWeskerInWarehouseFlag], a
Label318DC6
    ld a, $FF
    ret
Label318DC9: ;C6:4DC9
    xor a
    ret
;4DCB

checkGuardhouseDorm002CameraChange: ;C6:4DCB
    defaultCamera 4
    changeCamOnGteZ -6, 2
    changeCamOnGteZ 62, 1
    changeCamOnLtX 8, 3
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, Label318E19
    ld a, c
    ld [wRoomCameraId], a
    ld a, [wSelectedCharacter]
    or a
    jr z, Label318E16
; if jill
    ld a, [wRoomCameraId]
    cp a, $02
    jr nz, Label318E16
    ld a, [wTalkWithBarryInWarehouseRoomFlag]
    or a
    jr nz, Label318E16
    ld a, JILL_BARRY_TALK_IN_WAREHOUSE_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wTalkWithBarryInWarehouseRoomFlag], a
Label318E16
; if chris
    ld a, $FF
    ret
Label318E19: ;C6:4E19
    xor a
    ret
;4E1B

checkDorm002BathroomCameraChange: ;C6:4E1B
    defaultCamera 1
    changeCamOnLtZ -5, 0
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged: ;C6:4E36
    xor a
    ret
;4E38

checkBeehivePassageCameraChange: ;C6:4E38
    defaultCamera 0
    changeCamOnGteX -38, 1
    changeCamOnGteX 24, 7
    changeCamOnGteX 71, 2
    changeCamOnLtZ 26, 4
    changeCamOnLtZ -27, 3
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;4E82

checkChemistryRoomCameraChange: ;C6:4E82
    defaultCamera 1
    changeCamOnGteX -5, 2
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;4E9F

checkGuardhouseDorm003CameraChange: ;C6:4E9F
    defaultCamera 0
    changeCamOnLtZ 25, 1
    changeCamOnLtZ -16, 2
    changeCamOnLtZAndLtX -47, 40, 5
    changeCamOnLtX 7, 3
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;4EE7

checkDorm003BathroomCameraChange: ;C6:4EE7
    defaultCamera 0
    changeCamOnXGtZero 1
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;4F02

checkPlant42RoomCameraChange: ;C6:4F02
    defaultCamera 2
    changeCamOnGteZ 57, 0
    changeCamOnGteXAndLtZ -55, -35, 1
    changeCamOnGteZAndXGtZero -35, 0
    changeCamOnGteZAndXGtZero 36, 6
    changeCamOnLtXAndLtZ -30, -30, 5
    changeCamOnLtZAndXGteZero 2, 4 
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    xor a
    ld [wUnusedRedBookPlacedFlag], a
    ld a, $FF
    ld [wDoorsLocksFlags+DOOR_5F], a ; unlock door
    ld [wPlant42DefeatedFlag], a
    ld a, $FF
    ret
.cameraUnchanged: ;C6:4F8E
    xor a
    ret
;4F90

checkAquaTankStoreroomCameraChange: ;C6:4F90
    defaultCamera 0
    changeCamOnXLtZero 1
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;4FA7

checkPlant42RootsRoomCameraChange: ;C6:4FA7
    defaultCamera 0
    changeCamOnGteX -6, 1
    changeCamOnGteX 36, 2
    changeCamOnLtXAndGteZ -28, 16, 3
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;4FE4

checkCourtyardGardenCameraChange: ;C6:4FE4
    defaultCamera 4
    changeCamOnLtX 70, 5
    changeCamOnGteZ -63, 3
    changeCamOnGteZ 41, 0
    changeCamOnLtXAndGteZ 70, 41, 1
    changeCamOnLtX -60, 2
.applyCameraChange 
    ld a, [wRoomCameraId]
    cp a, c
    jr z, Label319050
    ld a, c
    ld [wRoomCameraId], a
    cp a, 1
    jr nz, Label31904D
    ld a, [wEntityId]
    cp a, CHRIS
    jr z, Label31904D
; if jill
    ld a, [wBradRadioMsgInCourtyardFlag]
    or a
    jr nz, Label31904D
    ld a, JILL_BRAD_RADIO_MESSAGE_1_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wBradRadioMsgInCourtyardFlag], a
Label31904D
    ld a, $FF
    ret
Label319050: ;C6:5050
    xor a
    ret
;5052

checkCourtyardFloodgateCameraChange: ;C6:5052
    defaultCamera 0
    changeCamOnLtZAndGteX 85, 101, 1
    changeCamOnGteZAndLtXV2 32, 101, 2
    changeCamOnLtZAndGteX 10, 51, 4
    changeCamOnLtZ -98, 5
    changeCamOnLtZAndLtX -50, 39, 6
    changeCamOnLtX -69, 7
.applyCameraChange 
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;50CC

checkWaterfallGardenCameraChange: ;C6:50CC
    defaultCamera 1
    changeCamOnLtZAndGteX -78, 59, 0
    changeCamOnLtX 32, 2
    changeCamOnLtX -8, 5
    changeCamOnZGtZero 4
    changeCamOnGteZ 69, 6
    changeCamOnGteZAndGteX 61, 23, 7
    changeCamLtZAndLtX1AndLtX2 -73, -15, 16, 3
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;5151

checkHeliportCameraChange: ;C6:5151
    defaultCamera 1
    changeCamOnGteX 56, 4
    changeCamOnZLtZero 3
    changeCamOnXLtZeroAndGteZAndLtZ -63, 64, 2
    changeCamOnGteZ 88, 1
    changeCamOnLtXAndLtZ -63, -60, 6
    changeCamOnLtXAndGteZ -38, 63, 0
    changeCamOnLtXAndGteZ -67, 90, 7
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;51D5

checkWayToGuardhouseCameraChange: ;C6:51D5
    defaultCamera 1
    changeCamOnGteZ 101, 0
    changeCamOnLtX 86, 2
    changeCamOnLtX -70, 3
    changeCamOnLtZ -10, 4
    changeCamOnLtZ -100, 5
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, Label319241
    ld a, c
    ld [wRoomCameraId], a
    ld a, [wSelectedCharacter]
    or a
    jr z, Label31923E
; if jill
    ld a, [wPlant42DefeatedFlag]
    or a
    jr z, Label31923E
    ld a, [wBradRadioMsgAfterWarehouseFlag]
    or a
    jr nz, Label31923E
    ld a, [wRoomCameraId]
    cp a, 4
    jr nz, Label31923E
    ld a, JILL_BRAD_RADIO_MESSAGE_2_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wBradRadioMsgAfterWarehouseFlag], a
Label31923E
    ld a, $FF
    ret
Label319241: ;C6:5241
    xor a
    ret
;5243

checkUndergroundStatueRoomCameraChange: ;C6:5243
    defaultCamera 3
    changeCamOnLtZ 8, 0
    changeCamOnLtZAndLtX 8, -17, 1
    changeCamOnLtZAndGteX -16, 11, 2
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;5289

checkUndergroundSouthPassageCameraChange: ;C6:5289
    defaultCamera 0
    changeCamOnGteZ -4, 1
    changeCamOnGteXOrJump -22, 2, applyCameraChange3192B9
    changeCamOnLtZ 53, 3
    changeCamOnLtZ 16, 4
applyCameraChange3192B9:
    ld a, [wRoomCameraId]
    cp a, c
    jr z, Label3192F8
    ld a, c
    ld [wRoomCameraId], a
    cp a, 3
    jr nz, Label3192F5
    ld a, [wSelectedCharacter]
    or a
    jr z, Label3192E2
; if jill
    ld a, [wMeetEnricoFlag]
    or a
    jr nz, Label3192F5
    ld a, JILL_MEETS_ENRICO_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wMeetEnricoFlag], a
    ld [wRoomsItemsFlags+ROOM3C_HEX_CRANK], a
    jr Label3192F5
Label3192E2
; if chris
    ld a, [wMeetEnricoFlag]
    or a
    jr nz, Label3192F5
    ld a, CHRIS_MEETS_ENRICO_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wMeetEnricoFlag], a
    ld [wRoomsItemsFlags+ROOM3C_HEX_CRANK], a
Label3192F5
    ld a, $FF
    ret
Label3192F8: ;C6:52F8
    xor a
    ret
;52FA

checkBoulder1RoomCameraChange: ;C6:52FA
    defaultCamera 6
    changeCamOnLtZ -4, 7
    changeCamOnLtZ -41, 0
    changeCamOnLtX 20, 2
    changeCamOnLtX -60, 3
    changeCamOnLtX -100, 4
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged: ;C6:5344
    xor a
    ret
;5346

checkBoulder2RoomCameraChange: ;C6:5346
    defaultCamera 1
    changeCamOnLtZ 32, 0
    changeCamOnLtZ -10, 2
    changeCamOnLtZ -58, 4
    changeCamOnLtZAndLtX -58, 66, 3
    changeCamOnLtX 18, 5
    changeCamOnGteZAndLtX -59, 15, 6
    changeCamOnLtX -85, 7
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;53BB

checkUndergroundEntryCameraChange: ;C6:53BB
    defaultCamera 0
    changeCamOnLtZ 62, 1
    changeCamOnLtZ -5, 2
    changeCamOnLtXOrJump 34, 3, applyCameraChange319402
    changeCamOnGteZ -59, 4
    changeCamOnGteZ -17, 5
    changeCamOnGteZ 61, 6
applyCameraChange319402:
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;5411

checkUndergroundBreakRoomCameraChange: ;C6:5411
    defaultCamera 0
    changeCamOnZLtZero 1
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;5428

checkFountainCameraChange: ;C6:5428
    defaultCamera 0
    changeCamOnGteX -37, 1
    changeCamOnGteXAndGteZ -23, -63, 2
    changeCamOnGteXAndGteZ 43, 33, 3
    changeCamOnGteXAndLtZ 51, 78, 4
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;5483

checkFountainElevatorCameraChange: ;C6:5483
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;5492

checkUndergroundBranchedPassageCameraChange: ;C6:5492
    defaultCamera 0
    changeCamOnGteXOrJump 6, 1, applyCameraChange3194D5
    changeCamOnLtZ -66, 2
    changeCamOnLtZAndGteX -94, 31, 3
    changeCamOnZGtZero 4
    changeCamOnGteZ 59, 5
applyCameraChange3194D5:
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;54E4

checkUndergroundGeneratorRoomCameraChange: ;C6:54E4
    defaultCamera 0
    changeCamOnGteX -54, 1
    changeCamOnLtZ 55, 2
    changeCamOnLtZAndGteX -19, -44, 3
    changeCamOnLtZ -89, 4
    changeCamOnLtXAndLtZ -44, -19, 5
    changeCamOnGteX 18, 6
    changeCamOnGteX 77, 7
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;555A

checkUndergroundWarehouseCameraChange: ;C6:555A
    defaultCamera 0
    changeCamOnLtZ -42, 1
    changeCamOnZGtZero 2
    changeCamOnGteZOrLtZAndGteX -15, 20, 26, 3
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;559D

checkWayToBreakRoomCameraChange: ;C6:559D
    defaultCamera 0
    changeCamOnXLtZero 2
    changeCamOnGteX 76, 1
    changeCamOnLtX -56, 3
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;55CB

checkWestStaircase2FCameraChange: ;C6:55CB
    defaultCamera 1
    changeCam1OnLtZAndCam2OnLtX -76, 3,    -22, 4
    changeCamOnGteX 64, 2
    changeCamOnGteZAndXGteZero -52, 0
    changeCamOnGteZV2 -9, 5
    changeCamOnGteZ 66, 6
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;5626

checkHelipadLookoutRoomCameraChange: ;C6:5626
    defaultCamera 0
    changeCamOnZLtZeroV2 1
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;563E

checkMaterialsRoomCameraChange: ;C6:563E
    defaultCamera 0
    changeCamOnZLtZeroV2 1
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;5656


checkHiddenLibraryCameraChange: ;C6:5656
    changeCamOnGteXOrJump 24, 0, setCam1_31966F
    changeCamOnLtZOrJump -11, 3, Label319685
    jr Label319685
setCam1_31966F
    setCamera 1
    changeCamOnLtZOrJump -11, 2, Label319685
    changeCamOnActiveFlagVar wHiddenLibraryStatueLightsFlag, 6
Label319685
    continueOnLtZOrJump -36, applyCamChange3196B3
    changeCamOnLtXOrJumpV2  33, 4, Label3196A3
    changeCamOnActiveFlagVar wHiddenLibraryStatueLightsFlag, 7
Label3196A3
    continueOnLtZOrJumpV4 -50, applyCamChange3196B3
    changeCamOnGteXOrJump 30, 5, applyCamChange3196B3
applyCamChange3196B3
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;56C2

checkLibraryCameraChange: ;C6:56C2
    defaultCamera 0
    changeCamOnZGteZero 1
    changeCamOnGteX 28, 4
    changeCam1OnGteZGteX1orCam2OnGteZGteX2 31,  28, 2,  52, 3
    changeCamOnLtZAndGteX -61, 28, 5
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;5715

checkTaxidermyRoomCameraChange: ;C6:5715
    defaultCamera 1
    changeCamOnLtZ 6, 2
    changeCamOnGteXAndGteZ 13, 13, 0
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;5745

checkEastTerraceCameraChange: ;C6:5745
    defaultCamera 0
    changeCam1OnZLtZeroAndCam2OnGteX 1,  -1, 2
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, Label319781
    ld a, c
    ld [wRoomCameraId], a
    cp a, 0
    jr nz, Label31977E
    ld a, [wEntityId]
    cp a, CHRIS
    jr z, Label31977E
; if jill
    ld a, [wFindForestCorpseFlag]
    or a
    jr nz, Label31977E
    ld a,JILL_BARRY_FIND_FOREST_CORPSE_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wFindForestCorpseFlag], a
Label31977E
    ld a, $FF
    ret
Label319781: ;C6:5781
    xor a
    ret
;5783

checkDeerRoomCameraChange: ;C6:5783
    defaultCamera 0
    changeCamOnLtZ -18, 1
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;57A0

checkAtticEntryCameraChange: ;C6:57A0
    defaultCamera 0
    changeCamOnLtZ -14, 1
    changeCamOnLtX 4, 2
    changeCamOnLtX -49, 3
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;57D4

checkAtticCameraChange: ;C6:57D4
    defaultCamera 1
    changeCamOnZLtZeroOrJump 2, .bp3197EA
    changeCamOnLtZLowOrJump -42, 6, .bp3197EA
    changeCamOnLtZLowOrJump -72, 4, .bp3197EA
.bp3197EA
    changeCamOnLtXAndGteZ -6, 37, 0
    changeCamOnLtXAndGteZAndLtZ -18,  -56, -10, 3
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;5828

checkLessonsRoomCameraChange: ;C6:5828
    defaultCamera 0
    changeCamOnLtZ 36, 1
    changeCam1OnLtZOrCam2OnLtZGteX -24, 2,  -40, 23, 3
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, Label319878
    ld a, c
    ld [wRoomCameraId], a
    cp a, $02
    jr nz, Label319875
    ld a, [wSelectedCharacter]
    or a
    jr z, Label319875
; if jill
    ld a, [wJawnDeathSceneFLag]
    or a
    jr nz, Label319875
    ld a, JILL_AFTER_YAWNS_DEATH_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wJawnDeathSceneFLag], a
Label319875
    ld a, $FF
    ret
Label319878
    xor a
    ret
;587A

checkTrevorsTombCameraChange: ;C6:587A
    defaultCamera 1
    changeCam1OnGteZAndLtZOrCam2 -7, 21, 2,  0
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, Label3198CC
    ld a, c
    ld [wRoomCameraId], a
    ld a, [wSelectedCharacter]
    or a
    jr z, Label3198C9
; if jill
    ld a, [wRoomCameraId]
    or a ;0
    jr z, .Label3198B3
    cp a, 2
    jr z, .Label3198AC
.Label3198AC
    ld a, $FF
    ld [wTriggerTrevorTombSceneFlag], a
    jr Label3198C9
.Label3198B3
    ld a, [wTriggerTrevorTombSceneFlag]
    or a
    jr z, Label3198C9
    ld a, [wMansionPasscodeFiledFlag]
    or a
    jr nz, Label3198C9
    ld a, JILL_BARRY_RETURNS_TO_TOMB_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wMansionPasscodeFiledFlag], a
Label3198C9:
    ld a, $FF
    ret
Label3198CC:
    xor a
    ret
;58CE

checkResearchersPrivateRoomCameraChange: ;C6:58CE
    defaultCamera 0
    changeCamOnZLtZero 1
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, Label3198FE
    ld a, c
    ld [wRoomCameraId], a
    cp a, $01
    jr nz, Label3198FB
    ld a, [wEntityId]
    cp a, CHRIS
    jr z, Label3198FB
; if jill
    ld a, [wJillBarryTalkInResearcherRoomFlag]
    or a
    jr nz, Label3198FB
    ld a, JILL_BARRY_TALK_IN_RESEARCHERS_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wJillBarryTalkInResearcherRoomFlag], a
Label3198FB
    ld a, $FF
    ret
Label3198FE
    xor a
    ret
;5900

checkSmallLibraryCameraChange: ;C6:5900
    defaultCamera 0
    changeCamOnGteX 9, 1
    changeCamOnLtZOrJump 8, 2, .applyCameraChange
    changeCamOnXGteZero 3
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;592D

checkUShapedCorridorCameraChange: ;C6:592D
    defaultCamera 0
    changeCamOnGteXV2  -7, 1
	changeCamOnGteX 71, 2
    changeCam1OnLtZAndCam2OnLtX -68, 3,  -20, 4
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged: ;C6:596A
    xor a
    ret
;596C

checkMansionBedroomCameraChange: ;C6:596C
	defaultCamera 0
	changeCamOnLtZ 20, 1
    continueOnXGteZeroOrJump .applyCameraChange
    changeCamOnGteZ 19, 2
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;5997

checkWesternCorridor2FCameraChange: ;C6:5997
	defaultCamera 0
    changeCamOnLtXOrJump -4, 1, bp3199BC
    changeCam1OnLtZ1AndGteZ2OrCam2OnLtZ2 49, -25, 2, 3
bp3199BC:
    changeCamOnLtX -18, 4
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;59D7

checkEastStaircase2FCameraChange: ;C6:59D7
	defaultCamera 4
    changeCamOnGteXV2 -33, 5
    changeCam1OnLtZ1AndGteZ2OrCam2OnLtZ2 64, 19, 1, 2
    changeCamOnLtZOrJump -71, 6, .bp319A12
    changeCamOnGteX -41, 3
.bp319A12
    changeCamOnLtX -62, 0
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;5A2D

checkArmorsRoomCameraChange: ;C6:5A2D
	defaultCamera 0
    changeCam1OnLtX1AndGteX2OrCam2OnLtX2 16, -20, 1, 2
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;5A53

checkSmallDinningRoomCameraChange: ;C6:5A53
	defaultCamera 0
    changeCamOnGteX -9, 1
    changeCamOnGteZ 43, 2
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;5A7B

checkHallwayToEastTerraceCameraChange: ;C6:5A7B
	defaultCamera 0
    changeCam1OnGteX1AndLtX2OrCam2OnGteX2 -10, 33, 1, 2
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;5AA1

checkElevatorRoom2FCameraChange: ;C6:5AA1
	defaultCamera 0
    changeCamOnLtXOrJump 55, 4, bp319AD3
	changeCamOnLtZ 17, 5
    changeCamOnLtZ -50, 2
    changeCamOnLtXOrJump -17, 6, applyCameraChange319AE6
    jr applyCameraChange319AE6
bp319AD3:
    changeCam1OnGteZ1AndLtZ2OrCam2OnGteZ2 -89, -39, 1, 3
applyCameraChange319AE6:
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;5AF5

checkLoungeRoomCameraChange: ;C6:5AF5
	defaultCamera 0
    changeCamOnZposLtZeroOrJump 1, .applyCameraChange
    changeCamOnLtXAndGteX -9, -16, 2
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;5B1D

checkPillarCorridorCameraChange: ;C6:5B1D
	defaultCamera 0
    changeCamOnXGteZeroOrJump 1, applyCameraChange319B50
	changeCamOnLtZ 40, 2
    continueOnGteXOrJump 47, .bp319B44
	changeCamOnLtZ 20, 3
.bp319B44
    changeCamOnLtZ -28, 4
applyCameraChange319B50:
    ld a, [wRoomCameraId]
    cp a, c
    jr z, Label319B7B
    ld a, c
    ld [wRoomCameraId], a
    cp a, 1
    jr nz, endCamChange319B78
    ld a, [wEntityId]
    cp a, CHRIS
    jr z, endCamChange319B78
; if jill
    ld a, [wRichardFoundFlag]
    or a
    jr nz, giveRichardSerum
    ld a, JILL_FINDS_RICHARD_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wRichardFoundFlag], a
    ld [wRoomsItemsFlags+ROOM02_SERUM], a
endCamChange319B78:
    ld a, $FF
    ret
Label319B7B: ;C6:5B7B
    xor a
    ret

giveRichardSerum: ;C6:5B7D
    ld a, [wRichardDiesFlag]
    or a
    jr nz, endCamChange319B78
    ld hl, wItemIdSlot1
    ld b, JILL_MAX_SLOTS
.findHeldItemLoop
    ld a, [hl]
    cp a, SERUM
    jr z, .serumFound
    inc hl
    dec b
    jr nz, .findHeldItemLoop
    jr endCamChange319B78
.serumFound
    ld [hl], EMPTY
    ld a, JILL_RICHARDS_DEATH_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wRichardDiesFlag], a
    jr endCamChange319B78



checkMainHall2FCameraChange:
    defaultCamera 3
    changeCam1OnLtX1AndGteX2OrCam2OnGteX1 71, -69, 0, 1
    changeCam1OnLtZOrCam2OnXLtZero -16, 2,  4
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;5BD8

checkDinningRoom2FCameraChange: ;C6:5BD8
	defaultCamera 2
    ; this conditions does not check z axis, so screen 5 is shown on the other side of the room too
    ; TODO: add a new condition
    changeCam1OnLtX1OrCam2OnGteX1LtX2OrCam3OnGteX2LtX3 -70, -30, 88, 0, 5, 1
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;5C07

checkUndergroundPassage1CameraChange: ;C6:5C07
	defaultCamera 5
    changeCam1OnGteX1LtX2OrCam2OnGteX2LtX3OrCam3OnGteX3 -79, -27, 15, 4, 1, 0
    changeCamOnLtZOrJump 25, 2, .applyCameraChange
	changeCamOnGteX 9, 3
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;5C4A

checkUndergroundPassage2CameraChange: ;C6:5C4A
	defaultCamera 5
    changeCamOnLtX 74, 2
    changeCamOnLtX -6, 3
    changeCamOnLtX -96, 4
    changeCamOnLtZOrJump 22, 1, .applyCameraChange
	changeCamOnGteX 55, 0
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;5C94

checkFallingCielingRoomCameraChange: ;C6:5C94
	defaultCamera 2
    changeCamOnZGteZero 0
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, Label319CCF
    ld a, c
    ld [wRoomCameraId], a
    ld a, [wSelectedCharacter]
    or a
    jr z, Label319CCC
; if jill
    ld a, [wBrokenShotgunPlacedByJillFlag]
    or a
    jr nz, Label319CCC
    ld a, [wBrokenShotgunFallCeilingFlag]
    or a
    jr nz, Label319CCC
    ld a, [wRoomCameraId]
    cp a, $02
    jr nz, Label319CCC
    ld a, JILL_SANDWISH_SCENE_1
    ld [wEventSceneId], a
    ld a, $FF
    ld [wBrokenShotgunFallCeilingFlag], a
    ld [wBrokenShotgunPlacedByJillFlag], a
Label319CCC
    ld a, $FF
    ret
Label319CCF
    xor a
    ret
;5CD1

checkLivingRoomCameraChange: ;C6:5CD1
	defaultCamera 0
    changeCamOnZGteZero 1
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, Label319D02
    ld a, c
    ld [wRoomCameraId], a
    ld a, [wRoomsItemsFlags+ROOM18_BROKEN_SHOTGUN]
    or a
    jr nz, Label319CFF
    ld a, [wRoomsItemsFlags+ROOM18_SHOTGUN]
    or a
    jr nz, Label319CFF
    ld a, [wSelectedCharacter]
    or a
    jr z, Label319CFB
; if jill
    xor a
    ld [wBrokenShotgunPlacedByJillFlag], a
    jr Label319CFF
Label319CFB
    xor a
    ld [wBrokenShotgunPlacedByChrisFlag], a
Label319CFF
    ld a, $FF
    ret
Label319D02
    xor a
    ret
;5D04

checkMirrorRoomCameraChange: ;C6:5D04
	defaultCamera 0
    changeCamOnZLtZeroV2 1
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;5D1C

checkShedRoomCameraChange: ;C6:5D1C
	defaultCamera 0
    changeCamOnZLtZeroV2 1
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;5D34

checkClosetRoomCameraChange: ;C6:5D34
	defaultCamera 0
    changeCam1OnXGteZeroLtX1OrCam2GteX1 -20, 1, 2
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;5D55

checkShedPassageCameraChange: ;C6:5D55
	defaultCamera 0
    changeCamOnLtZV2  64, 1
    changeCamOnLtZ -8, 2
    changeCamOnGteX -13, 3
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, Label319DAB
    ld a, c
    ld [wRoomCameraId], a
    ld a, [wPlant42DefeatedFlag]
    or a
    jr z, Label319DA8
    ld a, [wChrisFoundRadioFlag]
    or a
    jr nz, Label319DA8
    ld a, [wSelectedCharacter]
    or a
    jr nz, Label319DA8
; if chris
    ld a, [wRoomCameraId]
    cp a, $01
    jr nz, Label319DA8
    ld a, CHRIS_FIND_RADIO_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wChrisFoundRadioFlag], a
Label319DA8
    ld a, $FF
    ret
Label319DAB
    xor a
    ret
;5DAD

checkOutdoorAreaCameraChange: ;C6:5DAD
	defaultCamera 0
    changeCamOnGteZ 41, 1
    changeCamOnGteXAndJump 56, 2, applyCameraChange319DE0
    changeCam1OnGteX1LtX2OrCam2OnGteX2 -7, 29, 2, 3
applyCameraChange319DE0:
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;5DEF

checkMansionBathroomCameraChange: ;C6:5DEF
	defaultCamera 0
	changeCamOnLtZ 16, 1
	changeCamOnGteX 19, 2
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;5E16

checkLargeArtRoomCameraChange: ;C6:5E16
	defaultCamera 2
    continueOnLtXOrJump -40, .bp319E2F
    changeCamOnGteZAndJump 58, 4, .applyCameraChange319E3E
.bp319E2F
    changeCam1OnGteZOrCam1OnLtZ 64, 0, 1
.applyCameraChange319E3E
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;5E4D

checkElevatorStairwayCameraChange: ;C6:5E4D
	defaultCamera 0
    changeCamOnXLtZeroOrJump 2, .bp319E6E
    changeCamOnGteZOrJump -8, 1, applyCameraChange319E7E
    changeCamOnGteZAndJump 32, 0, applyCameraChange319E7E
.bp319E6E
    setCamera 3
    changeCamOnGteZAndJump -8, 4, applyCameraChange319E7E
applyCameraChange319E7E:
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;5E8D

checkKeepersRoomCameraChange: ;C6:5E8D
	defaultCamera 0
    changeCam1OnXGteZeroAndLtX1OrCam2GteX1 40, 1, 2
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;5EAB

checkEastStairsCorridor1FCameraChange: ;C6:5EAB
	defaultCamera 2
    changeCamOnLtZ -10, 3
    changeCam1OnGteX1LtX2OrCam2OnGteX2V2 27, 70, 1, 0
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;5EDB

checkLShapedCorridorCameraChange: ;C6:5EDB
	defaultCamera 1
    changeCamOnLtX -9, 0
    continueOnLtZOrJump 57, .bp319EFC
	changeCamOnGteX 47, 2
.bp319EFC
    changeCamOnLtZ -28, 3
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;5F17

checkBackEntranceCorridorCameraChange: ;C6:5F17
	defaultCamera 0
    changeCam2GteX1OrCam1OnXGteZeroLtX1 38, 1, 2
    changeCam1OnGteZ1AndLtZ2OrCam2OnGteZ2 13, 32, 3, 4
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, Label319F6B
    ld a, c
    ld [wRoomCameraId], a
    ld a, [wPlant42DefeatedFlag]
    or a
    jr z, Label319F68
    ld a, [wFirstHunterKilledFlag]
    or a
    jr nz, Label319F68
    ld a, [wSelectedCharacter]
    or a
    jr nz, Label319F68
; if chris
    ld a, [wRoomCameraId]
    cp a, 2
    jr nz, Label319F68
    ld a, CHRIS_KILLS_FIRST_HUNTER_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wFirstHunterKilledFlag], a
Label319F68
    ld a, $FF
    ret
Label319F6B
    xor a
    ret
;5F6D

checkNorthEastCorridor1FCameraChange: ;C6:5F6D
	defaultCamera 1
    continueOnLtXOrJump -76, .bp319F84
    changeCamOnGteZ 141, 0
.bp319F84
    changeCamOnLtZV2 116, 2
    changeCamOnLtZV2 96, 3
	changeCamOnGteX 51, 4
    changeCamOnLtZ -16, 5
    continueOnLtXOrJumpV2 20, .applyCameraChange
    changeCamOnLtZ -28, 6
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;5FD8

checkFirearmsRoomCameraChange: ;C6:5FD8
	defaultCamera 0
    changeCamOnGteZ 17, 2
    changeCamOnZLtZeroV2 1
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;5FFB

checkWestStaircase1FCameraChange: ;C6:5FFB
	defaultCamera 0
    changeCamOnLtXAndZLtZero 78, 1
    continueOnXLtZeroOrJump .bp31A025
    changeCamOnGteZAndLtZ -61, 64, 2
.bp31A025
    changeCamOnGteZ 63, 3
    changeCamOnXGteZeroAndXGteZero 4
    continueOnGteXOrJump 57, .applyCameraChange
    changeCamOnGteZ $59, $05
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, Label31A07E
    ld a, c
    ld [wRoomCameraId], a
    ld a, [wPlant42DefeatedFlag]
    or a
    jr z, Label31A07B
    ld a, [wRebeccaSavedFromDeathFlag]
    or a
    jr nz, Label31A07B
    ld a, [wSelectedCharacter]
    or a
    jr nz, Label31A07B
; if chris
    ld a, [wRoomCameraId]
    cp a, 5
    jr nz, Label31A07B
    ld a, CHRIS_SAVES_REBECCA_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wRebeccaSavedFromDeathFlag], a
Label31A07B
    ld a, $FF
    ret
Label31A07E: ;C6:607E
    xor a
    ret
;6080

checkGreenhouseCameraChange: ;C6:6080
	defaultCamera 1
    continueOnLtXOrJump -48, .bp31A092
    changeCamOnZGteZeroOrJump 0, .bp31A092
.bp31A092
    changeCamOnGteX -12, 2
	changeCamOnGteX 21, 3
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;60B8

checkWestStoreRoomCameraChange: ;C6:60B8
	defaultCamera 0
    changeCamOnLtZ -8, 1
    continueOnLtZOrJumpV2 -8, .applyCameraChange
    changeCamOnLtX -16, 5
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jr z, Label31A106
    ld a, c
    ld [wRoomCameraId], a
    or a
    jr nz, Label31A103
    ld a, [wSelectedCharacter]
    or a
    jr z, Label31A0F1
    jr Label31A103
Label31A0F1
; if chris
    ld a, [wChrisMeetRebeccaFlag]
    or a
    jr nz, Label31A103
    ld a, CHRIS_MEETS_REBECCA_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wChrisMeetRebeccaFlag], a
    jr Label31A103
Label31A103
    ld a, $FF
    ret
Label31A106: ;C6:6106
    xor a
    ret
;6108

checkPianoRoomCameraChange: ;C6:6108
	defaultCamera 1
    continueOnGteXOrJump 25, .bp31A121
    changeCamOnLtZAndJump -32, 0, applyCameraChange31A14F
.bp31A121
    changeCamOnLtXAndLtZ -32, -64, 2
    changeCamOnLtX -64, 3
    changeCamOnLtX -96, 4
applyCameraChange31A14F:
    ld a, [wRoomCameraId]
    cp a, c
    jr z, Label31A17C
    ld a, c
    ld [wRoomCameraId], a
    or a
    jr nz, Label31A179
    ld a, [wEntityId]
    cp a, CHRIS
    jr nz, Label31A179
; if chris
    ld a, [wFindForestCorpseFlag]
    or a
    jr z, Label31A179
    ld a, [wPianoRoomSecretDoorOpenFlag]
    or a
    jr nz, Label31A179
    ld a, CHRIS_REBECCA_PIANO_2_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wPianoRoomSecretDoorOpenFlag], a
Label31A179
    ld a, $FF
    ret
Label31A17C: ;C6:617C
    xor a
    ret
;617E

checkRestStopCorridorCameraChange: ;C6:617E
	defaultCamera 4
    changeCamOnLtZOrJumpV2 12, 1, applyCameraChange31A1AD
    changeCam1OnLtX1GteX2OrCam2OnLtX2GteX3OrCam3LtX3 72, 16, -100, 0, 2, 3
applyCameraChange31A1AD:
    ld a, [wRoomCameraId]
    cp a, c
    jr z, Label31A1F1
    ld a, c
    ld [wRoomCameraId], a
    cp a, 4
    jr nz, Label31A1EE
    ld a, [wEntityId]
    cp a, CHRIS
    jr z, Label31A1D4
; if jill
    ld a, [wFirstZombieEventFlag]
    or a
    jr nz, Label31A1EE
    ld a, FIRST_ZOMBIE_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wFirstZombieEventFlag], a
    jr Label31A1EE
Label31A1D4
; if chris
    ld a, [wFirstZombieEventFlag]
    or a
    jr nz, Label31A1EE
    ld a, FIRST_ZOMBIE_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wFirstZombieEventFlag], a
    ld a, $FF
    ld [wEventMsgAtMainHallDoor], a
    ld a, $FF
    ld [wRoomsItemsFlags+ROOM00_BERRETTA], a
Label31A1EE
    ld a, $FF
    ret
Label31A1F1: ;C6:61F1
    xor a
    ret
;61F3

checkExhibitionRoomCameraChange: ;C6:61F3
	defaultCamera 0
    jump1OnGteZOrJump2OnLtZOrContinue -16, setCam1, applyCamChange31A244
    continueOnZGteZeroOrJump applyCamChange31A244
    jp1OnLtZ1OrJp2OnLtZ2OrJp3OnGteZ3 7, setCam1, 72, setCam2, 101, bp31A22F
    changeCamOnGteXOrJumpV2 49, 5, setCam7
    jr applyCamChange31A244
setCam7:
    setCameraAndJump 7, applyCamChange31A244
setCam1:
    setCameraAndJump 1, applyCamChange31A244
setCam2:
    setCameraAndJump 2, applyCamChange31A244
bp31A22F:
    changeCam1OnLtXOrCam2OnGteX 49, 3, 4
applyCamChange31A244
    ld a, [wRoomCameraId]
    cp a, c
    jp z, Label31A252
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
;6252

Label31A252: ;C6:6252
    xor a
    ret
;6254

checkFShapedCorridorCameraChange: ;C6:6254
	defaultCamera 0
    changeCamOnLtXAndLtZAndGteZ -92, -96, 24, 1
    changeCamOnGteXAndLtZV2 -92, 24, 2
    changeCamOnLtXAndLtZ -11, -81, 4
    changeCamOnLtXAndLtZ -67, -81, 3
    changeCamOnGteX -12, 5
    changeCamOnGteXAndGteZ 96, -80, 6
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jp z, .cameraUnchanged
    ld a, c
    ld [wRoomCameraId], a
    ld a, $FF
    ret
.cameraUnchanged
    xor a
    ret
;62E9

checkDinningRoom1FCameraChange: ;C6:62E9
	defaultCamera 0
    changeCamOnGteX -55, 1
	changeCamOnGteX 32, 2
    changeCamOnGteZAndGteXAndLtX 25, -20, 28, 5
    changeCamOnLtZAndGteXAndLtXV2 -24, -20, 64, 4
    changeCamOnGteXAndGteZAndLtZV2 105, -16, 16, 3
.applyCameraChange
    ld a, [wRoomCameraId]
    cp a, c
    jp z, Label31A3D3
    ld a, c
    ld [wRoomCameraId], a
    ld a, [wEntityId]
    cp a, JILL
    jr z, Label31A378
    jp Label31A3D0
Label31A378
; if jill
    ld a, [wRoomCameraId]
    or a ; 0
    jr z, Label31A384
    cp a, 2
    jr z, Label31A39A
    jr Label31A3D0
Label31A384
    ld a, [wADinningRoomEventFlag]
    or a
    jr nz, Label31A3D0
    ld a, JILL_BARRY_DINING_ROOM_SCENE_1
    ld [wEventSceneId], a
    ld a, $FF
    ld [wADinningRoomEventFlag], a
    xor a
    ld [wEventMsgAtMainHallDoor], a
    jr Label31A3D0
Label31A39A
    ld a, [wChrisMeetRebeccaFlag]
    or a
    jr nz, Label31A3AC
    ld a, JILL_BARRY_DINING_ROOM_SCENE_2
    ld [wEventSceneId], a
    ld a, $FF
    ld [wChrisMeetRebeccaFlag], a
    jr Label31A3D0
Label31A3AC
    ld a, [wFirstZombieEventFlag]
    or a
    jr z, Label31A3D0
    ld a, [wDiningRoomZombieSceneFlag]
    or a
    jr nz, Label31A3D0
    ld a, JILL_DINING_ROOM_ZOMBIE_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wDiningRoomZombieSceneFlag], a
    xor a
    ld [wBlockDoorToFirstZombie], a
    ld [wEnemiesFlags+4], a ; disable first zombie active flag
    ld a, $FF
    ld [wEventMsgAtMainHallDoor], a
    jr Label31A3D0
Label31A3D0
    ld a, $FF
    ret
Label31A3D3: ;C6:63D3
    xor a
    ret
;63D5

checkMainMall1FCameraChange: ;C6:63D5
    changeCam1OnXLtZeroOrCam2OnXGteZero 1, 6
    continueOnLtZOrJumpV3 -96, checkCam3_4_31A402
    changeCamOnLtX1GteX2OrJump 32, -32, 0, checkCam3_4_31A402
    jr applyCamChange31A474
checkCam3_4_31A402:
    continueOnGteZOrJump 88, checkCam2_31A418
    changeCam1OnXGteZeroOrCam2OnLtZeroThenJump 3, 4, applyCamChange31A474
checkCam2_31A418:
    continueOnGteZOrJump -48, checkCam5_31A418
    continueOnLtXOrJump -32, checkCam5_31A418
    setCameraAndJump 2, applyCamChange31A474
checkCam5_31A418
    continueOnGteZOrJump -44, cam1To6SpecialCondition
    continueOnGteXOrJump 32, cam1To6SpecialCondition
    setCameraAndJump 5, applyCamChange31A474
    
cam1To6SpecialCondition:
    ld a, c
    cp a, 1
    jr nz, .bp31A45E
    continueOnGteXOrJump -32, .bp31A45E
    ld a, [wRoomCameraId]
    cp a, 4
    jp z, cameraUnchanged31A4DF
.bp31A45E
    ld a, c
    cp a, 6
    jr nz, applyCamChange31A474
    continueOnLtXOrJump 32, applyCamChange31A474
    ld a, [wRoomCameraId]
    cp a, 1
    jp z, cameraUnchanged31A4DF

applyCamChange31A474:
    ld a, [wEntityId]
    cp a, CHRIS
    jr nz, Label31A487 ; if jill
    xor a
    ld a, [wBackToMainHallAsJillEventFlag]
    or a
    jr z, Label31A487
    ld a, $FF
    ld [wFindForestCorpseFlag], a
Label31A487
    ld a, [wRoomCameraId]
    cp a, c
    jp z, cameraUnchanged31A4DF
    ld a, c
    ld [wRoomCameraId], a
    cp a, 5
    jr nz, Label31A4DC
; check event when back to main hall before first zombie scene
    ld a, [wEntityId]
    cp a, CHRIS
    jr z, Label31A4BB
; if jill
    ld a, [wFirstZombieEventFlag]
    or a
    jr z, Label31A4DC
    ld a, [wBackToMainHallAsJillEventFlag]
    or a
    jr nz, Label31A4DC
    ld a, JILL_BARRY_RETURN_MHALL_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wBackToMainHallAsJillEventFlag], a
    ld [wEventMsgAtMainHallDoor], a
    ld [wBlockDoorToFirstZombie], a
    jr Label31A4DC
Label31A4BB
; if chris
    ld a, [wFirstZombieEventFlag]
    or a
    jr nz, Label31A4CC
    ld a, CHRIS_RETURNS_EARLY_TO_MHALL_SCENE
    ld [wEventSceneId], a
    xor a
    ld [wEventMsgAtMainHallDoor], a
    jr Label31A4DC
Label31A4CC
    ld a, [wADinningRoomEventFlag]
    or a
    jr nz, Label31A4DC
    ld a, CHRIS_RETURNS_TO_MHALL_SCENE
    ld [wEventSceneId], a
    ld a, $FF
    ld [wADinningRoomEventFlag], a
Label31A4DC
    ld a, $FF
    ret
cameraUnchanged31A4DF: ;C6:64DF
    xor a
    ret
;64E1
