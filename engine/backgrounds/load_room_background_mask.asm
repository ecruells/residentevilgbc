; check and a load a room screen bg mask area
loadRoomScreenBackgroundMask:: ;04:4CE7
    ld a, [wRoomId]
    cp a, DINNING_ROOM_1F
    jp z, DinningRoomMask
    cp a, PIANO_ROOM
    jp z, PianoRoomMask
    cp a, MANSION_BATHROOM
    jp z, MansionBathroomMask
    cp a, SHED_PASSAGE
    jp z, ChestPanelMask
    cp a, TIGER_STATUE_ROOM
    jp z, TigerStatueMask
    cp a, TREVORS_TOMB
    jp z, TombRoomMask
    cp a, HIDDEN_LIBRARY
    jp z, LibraryMODiskRoomMask
    cp a, COURTYARD_FLOODGATE
    jp z, CourtyardPoolMask
    cp a, UNDERGROUND_STATUE_ROOM
    jp z, EagleMedalRoomMask
    cp a, BOULDER_2_ROOM
    jp z, BoulderRoom2Mask
    cp a, UNDERGROUND_ENTRY
    jp z, CourtyardCascadeMask
    cp a, UNDERGROUND_WAREHOUSE
    jp z, SpiderwebMask
    cp a, DORM_001_BATHROOM
    jp z, DormBathroomMask
    cp a, AQUA_TANK_ROOM
    jp z, AquariumMask
    cp a, AQUA_TANK_ENTRANCE
    jp z, CorridorFloodMask
    cp a, AQUA_TANK_CONTROL_ROOM
    jp z, AquariumControlRoomMask
    cp a, PLANT_42_ROOTS_ROOM
    jp z, Plant42RootsRoomMask
    cp a, VISUAL_DATA_ROOM
    jp z, LabProjectorRoomMask
    cp a, LARGE_GALLERY
    jp z, PaintingsRoomMask
    ret

DinningRoomMask:: ;04:4D4A
    ld a, [wRoomCameraId]
    cp a, 1
    jr z, .Label10D5E
    cp a, 2
    jr z, .Label10D7D
    cp a, 3
    jr z, .Label10D9C
    cp a, 4
    jr z, .Label10DBB
    ret

.Label10D5E ;04:4D5E
    ld a, [wBrokenJewelStatueFlag]
    or a
    ret z
    ld a, $0D
    ld [wRoomBgTileTopY], a
    ld a, $10
    ld [wRoomBgTileBottomY], a
    ld a, $0C
    ld [wRoomBgTileLeftX], a
    ld a, $14
    ld [wRoomBgTileRightX], a
    ld hl, room01_01_broken_statue_mask
    jp loadRoomBackgroundArea
.Label10D7D
	ld a, [wBrokenJewelStatueFlag]
    or a
    ret z
    ld a, $0C
    ld [wRoomBgTileTopY], a
    ld a, $10
    ld [wRoomBgTileBottomY], a
    ld a, $00
    ld [wRoomBgTileLeftX], a
    ld a, $09
    ld [wRoomBgTileRightX], a
    ld hl, room01_02_broken_statue_mask
    jp loadRoomBackgroundArea
.Label10D9C
    ld a, [wSelectedCharacter]
    or a
    ret z
    ld a, $0B
    ld [wRoomBgTileTopY], a
    ld a, $0E
    ld [wRoomBgTileBottomY], a
    ld a, $06
    ld [wRoomBgTileLeftX], a
    ld a, $0A
    ld [wRoomBgTileRightX], a
    ld hl, room01_03_blood_on_floor_mask
    jp loadRoomBackgroundArea
.Label10DBB
    ld a, [wBrokenJewelStatueFlag]
    or a
    ret z
    ld a, $0B
    ld [wRoomBgTileTopY], a
    ld a, $10
    ld [wRoomBgTileBottomY], a
    ld a, $03
    ld [wRoomBgTileLeftX], a
    ld a, $0D
    ld [wRoomBgTileRightX], a
    ld hl, room01_04_broken_statue_mask
    jp loadRoomBackgroundArea

PianoRoomMask:: ;04:4DDA
    ld a, [wRoomCameraId]
    cp a, 1
    jr z, .Label10DE6
    cp a, 3
    jr z, .Label10E0F
    ret

.Label10DE6 ;04:4DE6
    ld a, [wPianoRoomSecretDoorOpenFlag]
    or a
    ret z
    ld a, [wRoomsItemsFlags+ROOM07_GOLD_EMBLEM]
    ld c, a
    ld a, [wRoomsItemsFlags+ROOM07_WOODEN_EMBLEM]
    add a, c
    or a
    ret z
    ld a, $00
    ld [wRoomBgTileTopY], a
    ld a, $07
    ld [wRoomBgTileBottomY], a
    ld a, $0E
    ld [wRoomBgTileLeftX], a
    ld a, $14
    ld [wRoomBgTileRightX], a
    ld hl, room07_01_secret_door_opened_mask
    jp loadRoomBackgroundArea
.Label10E0F
    ld a, [wPianoRoomSecretDoorOpenFlag]
    or a
    ret z
    ld a, [wRoomsItemsFlags+ROOM07_GOLD_EMBLEM]
    ld c, a
    ld a, [wRoomsItemsFlags+ROOM07_WOODEN_EMBLEM]
    add a, c
    or a
    ret z
    ld a, $00
    ld [wRoomBgTileTopY], a
    ld a, $0D
    ld [wRoomBgTileBottomY], a
    ld a, $07
    ld [wRoomBgTileLeftX], a
    ld a, $0D
    ld [wRoomBgTileRightX], a
    ld hl, room07_03_secret_door_opened_mask
    jp loadRoomBackgroundArea

MansionBathroomMask:: ;04:4E38
    ld a, [wMansionBathtubUnpluggedFlag]
    or a
    ret nz
    ld a, [wRoomCameraId]
    cp a, 1
    jr z, .Label10E49
    cp a, 3
    jr z, .Label10E63
    ret

.Label10E49 ;04:4E49
    ld a, $09
    ld [wRoomBgTileTopY], a
    ld a, $0B
    ld [wRoomBgTileBottomY], a
    ld a, $07
    ld [wRoomBgTileLeftX], a
    ld a, $0C
    ld [wRoomBgTileRightX], a
    ld hl, room11_01_full_bathtube_mask
    jp loadRoomBackgroundArea
.Label10E63
    ld a, $03
    ld [wRoomBgTileTopY], a
    ld a, $0F
    ld [wRoomBgTileBottomY], a
    ld a, $06
    ld [wRoomBgTileLeftX], a
    ld a, $12
    ld [wRoomBgTileRightX], a
    ld hl, room11_03_full_bathtube_mask
    jp loadRoomBackgroundArea


ChestPanelMask:: ;04:4E7D
    ld a, [wRoomCameraId]
    cp a, 4
    jr z, .Label10E85
    ret

.Label10E85 ;04:4E85
    ld a, [wMoonCrestPlacedFlag]
    or a
    call nz, showMoonCrestPlacedMask
    ld a, [wSunCrestPlacedFlag]
    or a
    call nz, showSunCrestPlacedMask
    ld a, [wStarCrestPlacedFlag]
    or a
    call nz, showStarCrestPlacedMask
    ld a, [wWindCrestPlacedFlag]
    or a
    call nz, showWindCrestPlacedMask
    ret

showMoonCrestPlacedMask:: ;04:4EA2
    ld a, $07
    ld [wRoomBgTileTopY], a
    ld a, $0A
    ld [wRoomBgTileBottomY], a
    ld a, $0A
    ld [wRoomBgTileLeftX], a
    ld a, $0D
    ld [wRoomBgTileRightX], a
    ld hl, room13_04_crest_panel_mask
    jp loadRoomBackgroundArea

showSunCrestPlacedMask::
    ld a, $03
    ld [wRoomBgTileTopY], a
    ld a, $07
    ld [wRoomBgTileBottomY], a
    ld a, $0A
    ld [wRoomBgTileLeftX], a
    ld a, $0D
    ld [wRoomBgTileRightX], a
    ld hl, room13_04_crest_panel_mask
    jp loadRoomBackgroundArea

showStarCrestPlacedMask::
    ld a, $09
    ld [wRoomBgTileTopY], a
    ld a, $0C
    ld [wRoomBgTileBottomY], a
    ld a, $07
    ld [wRoomBgTileLeftX], a
    ld a, $09
    ld [wRoomBgTileRightX], a
    ld hl, room13_04_crest_panel_mask
    jp loadRoomBackgroundArea

showWindCrestPlacedMask::
    ld a, $06
    ld [wRoomBgTileTopY], a
    ld a, $09
    ld [wRoomBgTileBottomY], a
    ld a, $0D
    ld [wRoomBgTileLeftX], a
    ld a, $0F
    ld [wRoomBgTileRightX], a
    ld hl, room13_04_crest_panel_mask
    jp loadRoomBackgroundArea

TigerStatueMask:: ;04:4F0A
    ld a, [wRoomCameraId]
    cp a, 1
    jr z, .Label10F3C
    ld a, [wTigerStatueRotateDirection]
    cp a, $03
    ret z
    ld a, $00
    ld [wRoomBgTileTopY], a
    ld a, $06
    ld [wRoomBgTileBottomY], a
    ld a, $07
    ld [wRoomBgTileLeftX], a
    ld a, $0D
    ld [wRoomBgTileRightX], a
    ld hl, lionStatueRotatedMasks
    ld a, [wTigerStatueRotateDirection]
    add a
    ld e, a
    ld d, $00
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
    jp loadRoomBackgroundArea

.Label10F3C ;04:4F3C
    ld a, [wTigerStatueRotateDirection]
    cp a, $03
    jr nz, .Label10F4F
    ld a, [wRoomsItemsFlags+ROOM01_BLUE_JEWEL]
    cp a, $FF
    ret z
    ld a, [wObjectEntitiesFlags+JEWEL_STATUE_VARID]
    cp a, $FF
    ret z
.Label10F4F
    ld a, $00
    ld [wRoomBgTileTopY], a
    ld a, $10
    ld [wRoomBgTileBottomY], a
    ld a, $03
    ld [wRoomBgTileLeftX], a
    ld a, $11
    ld [wRoomBgTileRightX], a
    ld hl, lionStatueAnimationMasks
    ld a, [wTigerStatueRotateDirection]
    add a
    ld e, a
    ld d, $00
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
    jp loadRoomBackgroundArea
;4F74

lionStatueAnimationMasks: ;4F74
	dw room14_01_lion_statue_rotating_masks
	dw room14_01_lion_statue_rotating_masks+3
	dw room14_01_lion_statue_rotating_masks+6
	dw room14_01_lion_statue_rotating_masks+18
	dw room14_01_lion_statue_rotating_masks+9
	dw room14_01_lion_statue_rotating_masks+12
	dw room14_01_lion_statue_rotating_masks+15
lionStatueRotatedMasks: ;4F82
	dw room14_00_lion_statue_rotated_right_mask
	dw room14_00_lion_statue_rotated_right_mask
	dw room14_00_lion_statue_rotated_right_mask
	dw 0
	dw room14_00_lion_statue_rotated_left_mask
	dw room14_00_lion_statue_rotated_left_mask
	dw room14_00_lion_statue_rotated_left_mask
;4F90

TombRoomMask:: ;04:4F90
    ld a, [wRoomCameraId]
    or a
    jr z, .Label10F9F
    cp a, 1
    jr z, .Label10FBE
    cp a, 2
    jr z, .Label10FFD
    ret

.Label10F9F ;04:4F9F
    ld a, [wShowRopeInTrevorsTombFlag]
    or a
    ret z
    ld a, $00
    ld [wRoomBgTileTopY], a
    ld a, $0D
    ld [wRoomBgTileBottomY], a
    ld a, $09
    ld [wRoomBgTileLeftX], a
    ld a, $0B
    ld [wRoomBgTileRightX], a
    ld hl, room2A_03_rope_mask
    jp loadRoomBackgroundArea

.Label10FBE
    ld a, [wShowRopeInTrevorsTombFlag]
    or a
    jr z, .Label10FDE
    ld a, $00
    ld [wRoomBgTileTopY], a
    ld a, $10
    ld [wRoomBgTileBottomY], a
    ld a, $12
    ld [wRoomBgTileLeftX], a
    ld a, $13
    ld [wRoomBgTileRightX], a
    ld hl, room2A_01_rope_mask
    call loadRoomBackgroundArea
.Label10FDE
    ld a, [wDoorsLocksFlags+DOOR_20]
    or a
    ret z
    ld a, $07
    ld [wRoomBgTileTopY], a
    ld a, $0D
    ld [wRoomBgTileBottomY], a
    ld a, $06
    ld [wRoomBgTileLeftX], a
    ld a, $0C
    ld [wRoomBgTileRightX], a
    ld hl, room2A_01_opened_tomb_mask
    jp loadRoomBackgroundArea
.Label10FFD
    ld a, [wDoorsLocksFlags+DOOR_20]
    or a
    ret z
    ld a, $07
    ld [wRoomBgTileTopY], a
    ld a, $10
    ld [wRoomBgTileBottomY], a
    ld a, $02
    ld [wRoomBgTileLeftX], a
    ld a, $0D
    ld [wRoomBgTileRightX], a
    ld hl, room2A_02_opening_tomb_masks+3
    jp loadRoomBackgroundArea


LibraryMODiskRoomMask:: ;04:501C
    ld a, [wLibrarySecretDoorOpenedFlag]
    or a
    ret nz
    ld a, [wRoomCameraId]
    cp a, 4
    jr z, .Label1102B
    cp a, 7
    ret nz
.Label1102B
    ld a, $00
    ld [wRoomBgTileTopY], a
    ld a, $09
    ld [wRoomBgTileBottomY], a
    ld a, $0E
    ld [wRoomBgTileLeftX], a
    ld a, $14
    ld [wRoomBgTileRightX], a
    ld hl, librarySecretDoorMask ; invalid mask address. TODO: fix
    jp loadRoomBackgroundArea

CourtyardPoolMask:: ;04:5045
    ld a, [wCourtyardFloodgateClosedFlag]
    or a
    ret nz
    ld a, [wRoomCameraId]
    or a ;0
    jr z, .Label11059
    cp a, 1
    jr z, .Label11073
    cp a, 2
    jr z, .Label1108D
    ret

.Label11059 ;04:5059
    ld a, $09
    ld [wRoomBgTileTopY], a
    ld a, $10
    ld [wRoomBgTileBottomY], a
    ld a, $00
    ld [wRoomBgTileLeftX], a
    ld a, $14
    ld [wRoomBgTileRightX], a
    ld hl, room37_00_full_pool_mask
    jp loadRoomBackgroundArea
.Label11073
    ld a, $00
    ld [wRoomBgTileTopY], a
    ld a, $09
    ld [wRoomBgTileBottomY], a
    ld a, $00
    ld [wRoomBgTileLeftX], a
    ld a, $14
    ld [wRoomBgTileRightX], a
    ld hl, room37_01_full_pool_mask
    jp loadRoomBackgroundArea
.Label1108D
    ld a, $08
    ld [wRoomBgTileTopY], a
    ld a, $10
    ld [wRoomBgTileBottomY], a
    ld a, $00
    ld [wRoomBgTileLeftX], a
    ld a, $14
    ld [wRoomBgTileRightX], a
    ld hl, room37_02_full_pool_mask
    jp loadRoomBackgroundArea

EagleMedalRoomMask:: ;04:50A7
    ld a, [wRoomCameraId]
    or a
    jr z, .Label110BA
    cp a, 1
    jr z, .Label110F7
    cp a, 2
    jr z, .Label11116
    cp a, 3
    jr z, .Label11135
    ret

.Label110BA ;04:50BA
    ld a, $06
    ld [wRoomBgTileTopY], a
    ld a, $0C
    ld [wRoomBgTileBottomY], a
    ld a, $03
    ld [wRoomBgTileLeftX], a
    ld a, $08
    ld [wRoomBgTileRightX], a
    ld hl, undergroundStatueWallMasks ; invalid mask. TODO: fix
    ld a, [wCatacombCrankWallStatueFlag]
    or a
    call nz, loadRoomBackgroundArea
    ld a, [wUndergroundStatuePlacedFlag]
    or a
    ret z
    ld a, $06
    ld [wRoomBgTileTopY], a
    ld a, $08
    ld [wRoomBgTileBottomY], a
    ld a, $0E
    ld [wRoomBgTileLeftX], a
    ld a, $10
    ld [wRoomBgTileRightX], a
    ld hl, undergroundStatueWallMasks
    jp loadRoomBackgroundArea
.Label110F7
    ld a, [wCatacombCrankWallStatueFlag]
    or a
    ret z
    ld a, $06
    ld [wRoomBgTileTopY], a
    ld a, $0E
    ld [wRoomBgTileBottomY], a
    ld a, $05
    ld [wRoomBgTileLeftX], a
    ld a, $0A
    ld [wRoomBgTileRightX], a
    ld hl, undergroundStatueWallMasks+3
    jp loadRoomBackgroundArea
.Label11116
    ld a, [wUndergroundStatuePlacedFlag]
    or a
    ret z
    ld a, $04
    ld [wRoomBgTileTopY], a
    ld a, $07
    ld [wRoomBgTileBottomY], a
    ld a, $07
    ld [wRoomBgTileLeftX], a
    ld a, $0A
    ld [wRoomBgTileRightX], a
    ld hl, undergroundStatueWallMasks+6
    jp loadRoomBackgroundArea
.Label11135
    ld a, [wCatacombCrankWallStatueFlag]
    or a
    ret z
    ld a, $08
    ld [wRoomBgTileTopY], a
    ld a, $0F
    ld [wRoomBgTileBottomY], a
    ld a, $12
    ld [wRoomBgTileLeftX], a
    ld a, $14
    ld [wRoomBgTileRightX], a
    ld hl, undergroundStatueWallMasks+9
    jp loadRoomBackgroundArea

BoulderRoom2Mask:: ;04:5154
    ld a, [wRoomCameraId]
    cp a, 5
    jr z, .Label1115C
    ret

.Label1115C ;04:515C
    ld a, $02
    ld [wRoomBgTileTopY], a
    ld a, $0E
    ld [wRoomBgTileBottomY], a
    ld a, $04
    ld [wRoomBgTileLeftX], a
    ld a, $12
    ld [wRoomBgTileRightX], a
    ld hl, room3E_05_underground_moving_walls_masks
    ld a, [wRotateFloor2AnimId]
    ld c, a
    add a
    add a, c
    ld c, a
    ld b, $00
    add hl, bc
    jp loadRoomBackgroundArea

CourtyardCascadeMask:: ;04:5180
    ld a, [wRoomCameraId]
    cp a, 5
    jr z, .Label11188
    ret

.Label11188 ;04:5188
    ld a, $04
    ld [wRoomBgTileTopY], a
    ld a, $0D
    ld [wRoomBgTileBottomY], a
    ld a, $05
    ld [wRoomBgTileLeftX], a
    ld a, $0E
    ld [wRoomBgTileRightX], a
    ld hl, room3F_05_underground_moving_walls_masks
    ld a, [wRotateFloor1AnimId]
    ld c, a
    add a
    add a, c
    ld c, a
    ld b, $00
    add hl, bc
    jp loadRoomBackgroundArea

SpiderwebMask:: ;04:51AC
    ld a, [wSpiderwebKnifeCutsCounter]
    cp a, 3
    ret nc
    ld a, [wRoomCameraId]
    cp a, $00
    jr z, .Label111C6
    cp a, $01
    jr z, .Label111F2
    cp a, $02
    jr z, .Label1120C
    cp a, $03
    jr z, .Label11238
    ret

.Label111C6 ;04:51C6
    ld a, $04
    ld [wRoomBgTileTopY], a
    ld a, $0B
    ld [wRoomBgTileBottomY], a
    ld a, $10
    ld [wRoomBgTileLeftX], a
    ld a, $13
    ld [wRoomBgTileRightX], a
    ld hl, room45_00_spiderweb_masks
    ld a, [wSpiderwebKnifeCutsCounter]
    or a
    jp z, loadRoomBackgroundArea
    ld hl, room45_00_spiderweb_masks+3
    cp a, $01
    jp z, loadRoomBackgroundArea
    ld hl, room45_00_spiderweb_masks+6
    jp loadRoomBackgroundArea
.Label111F2
    ld a, $0D
    ld [wRoomBgTileTopY], a
    ld a, $10
    ld [wRoomBgTileBottomY], a
    ld a, $11
    ld [wRoomBgTileLeftX], a
    ld a, $14
    ld [wRoomBgTileRightX], a
    ld hl, room45_01_spiderweb_mask
    jp loadRoomBackgroundArea
.Label1120C
    ld a, $04
    ld [wRoomBgTileTopY], a
    ld a, $0A
    ld [wRoomBgTileBottomY], a
    ld a, $00
    ld [wRoomBgTileLeftX], a
    ld a, $02
    ld [wRoomBgTileRightX], a
    ld hl, room45_02_spiderweb_masks
    ld a, [wSpiderwebKnifeCutsCounter]
    or a
    jp z, loadRoomBackgroundArea
    ld hl, room45_02_spiderweb_masks+3
    cp a, $01
    jp z, loadRoomBackgroundArea
    ld hl, room45_02_spiderweb_masks+6
    jp loadRoomBackgroundArea
.Label11238
    ld a, $00
    ld [wRoomBgTileTopY], a
    ld a, $0B
    ld [wRoomBgTileBottomY], a
    ld a, $05
    ld [wRoomBgTileLeftX], a
    ld a, $0F
    ld [wRoomBgTileRightX], a
    ld hl, room45_03_spiderweb_masks
    ld a, [wSpiderwebKnifeCutsCounter]
    or a
    jp z, loadRoomBackgroundArea
    ld hl, room45_03_spiderweb_masks+3
    cp a, $01
    jp z, loadRoomBackgroundArea
    ld hl, room45_03_spiderweb_masks+6
    jp loadRoomBackgroundArea

DormBathroomMask:: ;04:5264
    ld a, [wDorm001BathroomTubUnplug]
    or a
    ret nz
    ld a, [wRoomCameraId]
    cp a, 0
    jr z, .Label11275
    cp a, 1
    jr z, .Label1128F
    ret

.Label11275 ;04:5275
    ld a, $0B
    ld [wRoomBgTileTopY], a
    ld a, $10
    ld [wRoomBgTileBottomY], a
    ld a, $0E
    ld [wRoomBgTileLeftX], a
    ld a, $14
    ld [wRoomBgTileRightX], a
    ld hl, room49_00_full_bathtube_mask
    jp loadRoomBackgroundArea
.Label1128F
    ld a, $0A
    ld [wRoomBgTileTopY], a
    ld a, $0D
    ld [wRoomBgTileBottomY], a
    ld a, $02
    ld [wRoomBgTileLeftX], a
    ld a, $09
    ld [wRoomBgTileRightX], a
    ld hl, room49_01_full_bathtube_mask
    jp loadRoomBackgroundArea

AquariumMask:: ;04:52A9
    ld a, [wFloodedRoomsDrainedWaterFlag]
    or a
    ret nz
    ld a, [wRoomCameraId]
    cp a, 0
    jr z, .Label112CC
    cp a, 1
    jr z, .Label112E6
    cp a, 2
    jr z, .Label11300
    cp a, 3
    jr z, .Label1131A
    cp a, 4
    jp z, .Label11334
    cp a, 5
    jp z, .Label1134E
    ret

.Label112CC ;04:52CC
    ld a, $06
    ld [wRoomBgTileTopY], a
    ld a, $10
    ld [wRoomBgTileBottomY], a
    ld a, $00
    ld [wRoomBgTileLeftX], a
    ld a, $14
    ld [wRoomBgTileRightX], a
    ld hl, room4B_00_aqua_tank_flood_mask
    jp loadRoomBackgroundArea
.Label112E6
    ld a, $08
    ld [wRoomBgTileTopY], a
    ld a, $10
    ld [wRoomBgTileBottomY], a
    ld a, $00
    ld [wRoomBgTileLeftX], a
    ld a, $14
    ld [wRoomBgTileRightX], a
    ld hl, room4B_01_aqua_tank_flood_mask
    jp loadRoomBackgroundArea
.Label11300
    ld a, $04
    ld [wRoomBgTileTopY], a
    ld a, $10
    ld [wRoomBgTileBottomY], a
    ld a, $00
    ld [wRoomBgTileLeftX], a
    ld a, $14
    ld [wRoomBgTileRightX], a
    ld hl, room4B_02_aqua_tank_flood_mask
    jp loadRoomBackgroundArea
.Label1131A
    ld a, $05
    ld [wRoomBgTileTopY], a
    ld a, $10
    ld [wRoomBgTileBottomY], a
    ld a, $00
    ld [wRoomBgTileLeftX], a
    ld a, $14
    ld [wRoomBgTileRightX], a
    ld hl, room4B_03_aqua_tank_flood_mask
    jp loadRoomBackgroundArea
.Label11334
    ld a, $06
    ld [wRoomBgTileTopY], a
    ld a, $10
    ld [wRoomBgTileBottomY], a
    ld a, $00
    ld [wRoomBgTileLeftX], a
    ld a, $14
    ld [wRoomBgTileRightX], a
    ld hl, room4B_04_aqua_tank_flood_mask
    jp loadRoomBackgroundArea
.Label1134E
    ld a, $07
    ld [wRoomBgTileTopY], a
    ld a, $10
    ld [wRoomBgTileBottomY], a
    ld a, $00
    ld [wRoomBgTileLeftX], a
    ld a, $14
    ld [wRoomBgTileRightX], a
    ld hl, room4B_05_aqua_tank_flood_mask
    jp loadRoomBackgroundArea

CorridorFloodMask:: ;04:5368
    ld a, [wRoomCameraId]
    cp a, 5
    jr z, .Label11370
    ret

.Label11370 ;04:5370
    ld a, $05
    ld [wRoomBgTileTopY], a
    ld a, $09
    ld [wRoomBgTileBottomY], a
    ld a, $00
    ld [wRoomBgTileLeftX], a
    ld a, $14
    ld [wRoomBgTileRightX], a
    ld hl, room4C_05_corridor_flood_mask
    jp loadRoomBackgroundArea


AquariumControlRoomMask:: ;04:538A
    ld a, [wFloodedRoomsDrainedWaterFlag]
    or a
    ret nz
    ld a, [wRoomCameraId]
    cp a, 0
    jr z, .Label113A7
    cp a, 1
    jr z, .Label113C1
    cp a, 2
    jr z, .Label113DB
    cp a, 3
    jr z, .Label113F5
    cp a, 4
    jr z, .Label1140F
    ret

.Label113A7 ;04:53A7
    ld a, $05
    ld [wRoomBgTileTopY], a
    ld a, $10
    ld [wRoomBgTileBottomY], a
    ld a, $00
    ld [wRoomBgTileLeftX], a
    ld a, $14
    ld [wRoomBgTileRightX], a
    ld hl, room4D_00_flood_mask
    jp loadRoomBackgroundArea
.Label113C1
    ld a, $05
    ld [wRoomBgTileTopY], a
    ld a, $10
    ld [wRoomBgTileBottomY], a
    ld a, $00
    ld [wRoomBgTileLeftX], a
    ld a, $14
    ld [wRoomBgTileRightX], a
    ld hl, room4D_01_flood_mask
    jp loadRoomBackgroundArea
.Label113DB
    ld a, $0C
    ld [wRoomBgTileTopY], a
    ld a, $10
    ld [wRoomBgTileBottomY], a
    ld a, $00
    ld [wRoomBgTileLeftX], a
    ld a, $14
    ld [wRoomBgTileRightX], a
    ld hl, room4D_02_flood_mask
    jp loadRoomBackgroundArea
.Label113F5
    ld a, $06
    ld [wRoomBgTileTopY], a
    ld a, $10
    ld [wRoomBgTileBottomY], a
    ld a, $00
    ld [wRoomBgTileLeftX], a
    ld a, $14
    ld [wRoomBgTileRightX], a
    ld hl, room4D_03_water_switch_masks
    jp loadRoomBackgroundArea
.Label1140F
    ld a, $06
    ld [wRoomBgTileTopY], a
    ld a, $10
    ld [wRoomBgTileBottomY], a
    ld a, $00
    ld [wRoomBgTileLeftX], a
    ld a, $14
    ld [wRoomBgTileRightX], a
    ld hl, room4D_03_water_switch_masks+3
    jp loadRoomBackgroundArea

Plant42RootsRoomMask:: ;04:5429
    ld a, [wRoomCameraId]
    or a
    jr z, .Label11443
    cp a, 1
    jr z, .Label11462
    cp a, 2
    jp z, .Label1149F
    cp a, 3
    jp z, .Label114DC
    cp a, 4
    jp z, .Label114FB
    ret

.Label11443 ;04:5443
    ld a, [wFloodedRoomsDrainedWaterFlag]
    or a
    ret nz
    ld a, $06
    ld [wRoomBgTileTopY], a
    ld a, $10
    ld [wRoomBgTileBottomY], a
    ld a, $00
    ld [wRoomBgTileLeftX], a
    ld a, $14
    ld [wRoomBgTileRightX], a
    ld hl, room58_00_flooded_roots_mask
    jp loadRoomBackgroundArea
.Label11462
    ld a, $02
    ld [wRoomBgTileTopY], a
    ld a, $09
    ld [wRoomBgTileBottomY], a
    ld a, $03
    ld [wRoomBgTileLeftX], a
    ld a, $0A
    ld [wRoomBgTileRightX], a
    ld hl, room58_01_plant42_roots_mask
    ld a, [wVJoltUsedOnPlant42Flag]
    or a
    call z, loadRoomBackgroundArea
    ld a, [wFloodedRoomsDrainedWaterFlag]
    or a
    ret nz
    ld a, $07
    ld [wRoomBgTileTopY], a
    ld a, $10
    ld [wRoomBgTileBottomY], a
    ld a, $00
    ld [wRoomBgTileLeftX], a
    ld a, $14
    ld [wRoomBgTileRightX], a
    ld hl, room58_01_flooded_roots_mask
    jp loadRoomBackgroundArea
.Label1149F
    ld a, $02
    ld [wRoomBgTileTopY], a
    ld a, $0D
    ld [wRoomBgTileBottomY], a
    ld a, $04
    ld [wRoomBgTileLeftX], a
    ld a, $10
    ld [wRoomBgTileRightX], a
    ld hl, room58_02_plant42_roots_mask
    ld a, [wVJoltUsedOnPlant42Flag]
    or a
    call z, loadRoomBackgroundArea
    ld a, [wFloodedRoomsDrainedWaterFlag]
    or a
    ret nz
    ld a, $08
    ld [wRoomBgTileTopY], a
    ld a, $10
    ld [wRoomBgTileBottomY], a
    ld a, $00
    ld [wRoomBgTileLeftX], a
    ld a, $14
    ld [wRoomBgTileRightX], a
    ld hl, room58_02_flooded_roots_mask
    jp loadRoomBackgroundArea
.Label114DC
    ld a, [wFloodedRoomsDrainedWaterFlag]
    or a
    ret nz
    ld a, $05
    ld [wRoomBgTileTopY], a
    ld a, $10
    ld [wRoomBgTileBottomY], a
    ld a, $00
    ld [wRoomBgTileLeftX], a
    ld a, $14
    ld [wRoomBgTileRightX], a
    ld hl, room58_03_flooded_roots_mask
    jp loadRoomBackgroundArea
.Label114FB
    ld a, [wFloodedRoomsDrainedWaterFlag]
    or a
    ret nz
    ld a, $02
    ld [wRoomBgTileTopY], a
    ld a, $10
    ld [wRoomBgTileBottomY], a
    ld a, $00
    ld [wRoomBgTileLeftX], a
    ld a, $14
    ld [wRoomBgTileRightX], a
    ld hl, room58_04_flooded_roots_mask
    jp loadRoomBackgroundArea

LabProjectorRoomMask:: ;04:551A
	ld a, [wRoomCameraId]
    or a
    jr z, .Label1152D
    cp a, 1
    jr z, .Label11551
    cp a, 2
    jr z, .Label11575
    cp a, 3
    jr z, .Label11599
    ret

.Label1152D ;04:552D
    ld a, $00
    ld [wRoomBgTileTopY], a
    ld a, $0B
    ld [wRoomBgTileBottomY], a
    ld a, $00
    ld [wRoomBgTileLeftX], a
    ld a, $04
    ld [wRoomBgTileRightX], a
    ld hl, room5D_00_wall_pillar_masks
    ld a, [wVisualDataRoomPillarMovedFlag]
    or a
    jp z, loadRoomBackgroundArea
    ld hl, room5D_00_wall_pillar_masks+3
    jp loadRoomBackgroundArea
.Label11551
    ld a, $02
    ld [wRoomBgTileTopY], a
    ld a, $0C
    ld [wRoomBgTileBottomY], a
    ld a, $0F
    ld [wRoomBgTileLeftX], a
    ld a, $14
    ld [wRoomBgTileRightX], a
    ld hl, room5D_01_wall_pillar_masks
    ld a, [wVisualDataRoomPillarMovedFlag]
    or a
    jp z, loadRoomBackgroundArea
    ld hl, room5D_01_wall_pillar_masks+3
    jp loadRoomBackgroundArea
.Label11575
    ld a, $00
    ld [wRoomBgTileTopY], a
    ld a, $0D
    ld [wRoomBgTileBottomY], a
    ld a, $05
    ld [wRoomBgTileLeftX], a
    ld a, $0B
    ld [wRoomBgTileRightX], a
    ld hl, room5D_02_wall_pillar_masks+3
    ld a, [wVisualDataRoomPillarMovedFlag]
    or a
    jp z, loadRoomBackgroundArea
    ld hl, room5D_02_wall_pillar_masks
    jp loadRoomBackgroundArea
.Label11599
    ld a, [wVisualDataRoomPanelButtonOpened]
    or a
    ret nz
    ld a, $04
    ld [wRoomBgTileTopY], a
    ld a, $08
    ld [wRoomBgTileBottomY], a
    ld a, $0A
    ld [wRoomBgTileLeftX], a
    ld a, $0C
    ld [wRoomBgTileRightX], a
    ld hl, room5D_03_button_panel_mask
    jp loadRoomBackgroundArea

PaintingsRoomMask:: ;04:55B8
    ld a, [wPaintingsPuzzleSolvedFlag]
    or a
    ret nz
    ld a, [wRoomCameraId]
    cp a, 4
    jr z, .Label115C9
    cp a, 5
    jr z, .Label115E3
    ret

.Label115C9 ;04:55C9
    ld a, $03
    ld [wRoomBgTileTopY], a
    ld a, $06
    ld [wRoomBgTileBottomY], a
    ld a, $06
    ld [wRoomBgTileLeftX], a
    ld a, $08
    ld [wRoomBgTileRightX], a
    ld hl, room6F_04_painting_mask
    jp loadRoomBackgroundArea
.Label115E3
    ld a, $02
    ld [wRoomBgTileTopY], a
    ld a, $06
    ld [wRoomBgTileBottomY], a
    ld a, $05
    ld [wRoomBgTileLeftX], a
    ld a, $09
    ld [wRoomBgTileRightX], a
    ld hl, room6F_05_painting_mask
    jp loadRoomBackgroundArea
