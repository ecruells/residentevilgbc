
applyRoomBgMask:: ;04:4CE7
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
    cp a, UNDGRND_STATUE_ROOM
    jp z, EagleMedalRoomMask
    cp a, BOULDER_ROOM_2 ; crank moving floor
    jp z, BoulderRoom2Mask
    cp a, UNDERGROUND_ENTRY ; courtyard cascade
    jp z, CourtyardCascadeMask
    cp a, UNDERGROUND_WAREHOUSE ;spiderwebs
    jp z, SpiderwebMask
    cp a, DORM_001_BATHROOM
    jp z, DormBathroomMask
    cp a, AQUA_TANK_ROOM
    jp z, AquariumMask
    cp a, AQUA_TANK_ENTRANCE ;to aquarium
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
    ld a, [wRoomScreen]
    cp a, $01
    jr z, .Label10D5E
    cp a, $02
    jr z, .Label10D7D
    cp a, $03
    jr z, .Label10D9C
    cp a, $04
    jr z, .Label10DBB
    ret

.Label10D5E ;04:4D5E
    ld a, [wTriggerBrokenStatue]
    or a
    ret z
    ld a, $0D
    ld [wLowColliderBottomY], a
    ld a, $10
    ld [wLowColliderTopY], a
    ld a, $0C
    ld [wLowColliderRightX], a
    ld a, $14
    ld [wLowColliderLeftX], a
    ld hl, room01_broken_statue_masks_pointers ;$7ADE
    jp loadRoomBGMask
.Label10D7D
	ld a, [wTriggerBrokenStatue]
    or a
    ret z
    ld a, $0C
    ld [wLowColliderBottomY], a
    ld a, $10
    ld [wLowColliderTopY], a
    ld a, $00
    ld [wLowColliderRightX], a
    ld a, $09
    ld [wLowColliderLeftX], a
    ld hl, room01_broken_statue_masks_pointers+3 ;$7AE1
    jp loadRoomBGMask
.Label10D9C
    ld a, [wSelectedPlayer]
    or a
    ret z
    ld a, $0B
    ld [wLowColliderBottomY], a
    ld a, $0E
    ld [wLowColliderTopY], a
    ld a, $06
    ld [wLowColliderRightX], a
    ld a, $0A
    ld [wLowColliderLeftX], a
    ld hl, room01_03_blood_mask_pointer ;$7B1D
    jp loadRoomBGMask
.Label10DBB
    ld a, [wTriggerBrokenStatue]
    or a
    ret z
    ld a, $0B
    ld [wLowColliderBottomY], a
    ld a, $10
    ld [wLowColliderTopY], a
    ld a, $03
    ld [wLowColliderRightX], a
    ld a, $0D
    ld [wLowColliderLeftX], a
    ld hl, room01_broken_statue_masks_pointers+6 ;$7AE4
    jp loadRoomBGMask

PianoRoomMask:: ;04:4DDA
    ld a, [wRoomScreen]
    cp a, $01
    jr z, .Label10DE6
    cp a, $03
    jr z, .Label10E0F
    ret

.Label10DE6 ;04:4DE6
    ld a, [wPianoRoomSecretDoorTrigger]
    or a
    ret z
    ld a, [wPianoRoomGoldEmblemTrigger]
    ld c, a
    ld a, [wPianoRoomWoodEmblemTrigger]
    add a, c
    or a
    ret z
    ld a, $00
    ld [wLowColliderBottomY], a
    ld a, $07
    ld [wLowColliderTopY], a
    ld a, $0E
    ld [wLowColliderRightX], a
    ld a, $14
    ld [wLowColliderLeftX], a
    ld hl, room07_secret_door_masks_pointers ;$7B02
    jp loadRoomBGMask
.Label10E0F
    ld a, [wPianoRoomSecretDoorTrigger]
    or a
    ret z
    ld a, [wPianoRoomGoldEmblemTrigger]
    ld c, a
    ld a, [wPianoRoomWoodEmblemTrigger]
    add a, c
    or a
    ret z
    ld a, $00
    ld [wLowColliderBottomY], a
    ld a, $0D
    ld [wLowColliderTopY], a
    ld a, $07
    ld [wLowColliderRightX], a
    ld a, $0D
    ld [wLowColliderLeftX], a
    ld hl, room07_secret_door_masks_pointers+3 ;$7B05
    jp loadRoomBGMask

MansionBathroomMask:: ;04:4E38
    ld a, [wMansionBathroomTubUnplug]
    or a
    ret nz
    ld a, [wRoomScreen]
    cp a, $01
    jr z, .Label10E49
    cp a, $03
    jr z, .Label10E63
    ret

.Label10E49 ;04:4E49
    ld a, $09
    ld [wLowColliderBottomY], a
    ld a, $0B
    ld [wLowColliderTopY], a
    ld a, $07
    ld [wLowColliderRightX], a
    ld a, $0C
    ld [wLowColliderLeftX], a
    ld hl, room11_bathtub_masks_pointers+3 ;$7B6B
    jp loadRoomBGMask
.Label10E63
    ld a, $03
    ld [wLowColliderBottomY], a
    ld a, $0F
    ld [wLowColliderTopY], a
    ld a, $06
    ld [wLowColliderRightX], a
    ld a, $12
    ld [wLowColliderLeftX], a
    ld hl, room11_bathtub_masks_pointers ;$7B68
    jp loadRoomBGMask


ChestPanelMask:: ;04:4E7D
    ld a, [wRoomScreen]
    cp a, $04
    jr z, .Label10E85
    ret

.Label10E85 ;04:4E85
    ld a, [wMoonCrestPlaced]
    or a
    call nz, showMoonCrestPlacedMask
    ld a, [wSunCrestPlaced]
    or a
    call nz, showSunCrestPlacedMask
    ld a, [wStarCrestPlaced]
    or a
    call nz, showStarCrestPlacedMask
    ld a, [wWindCrestPlaced]
    or a
    call nz, showWindCrestPlacedMask
    ret

showMoonCrestPlacedMask:: ;04:4EA2
    ld a, $07
    ld [wLowColliderBottomY], a
    ld a, $0A
    ld [wLowColliderTopY], a
    ld a, $0A
    ld [wLowColliderRightX], a
    ld a, $0D
    ld [wLowColliderLeftX], a
    ld hl, room13_crest_panel_masks_pointer ;$7B1A
    jp loadRoomBGMask

showSunCrestPlacedMask::
    ld a, $03
    ld [wLowColliderBottomY], a
    ld a, $07
    ld [wLowColliderTopY], a
    ld a, $0A
    ld [wLowColliderRightX], a
    ld a, $0D
    ld [wLowColliderLeftX], a
    ld hl, room13_crest_panel_masks_pointer ;$7B1A
    jp loadRoomBGMask

showStarCrestPlacedMask::
    ld a, $09
    ld [wLowColliderBottomY], a
    ld a, $0C
    ld [wLowColliderTopY], a
    ld a, $07
    ld [wLowColliderRightX], a
    ld a, $09
    ld [wLowColliderLeftX], a
    ld hl, room13_crest_panel_masks_pointer ;$7B1A
    jp loadRoomBGMask

showWindCrestPlacedMask::
    ld a, $06
    ld [wLowColliderBottomY], a
    ld a, $09
    ld [wLowColliderTopY], a
    ld a, $0D
    ld [wLowColliderRightX], a
    ld a, $0F
    ld [wLowColliderLeftX], a
    ld hl, room13_crest_panel_masks_pointer ;$7B1A
    jp loadRoomBGMask

TigerStatueMask:: ;04:4F0A
    ld a, [wRoomScreen]
    cp a, $01
    jr z, .Label10F3C
    ld a, [wTigerStatueRotateDirection]
    cp a, $03
    ret z
    ld a, $00
    ld [wLowColliderBottomY], a
    ld a, $06
    ld [wLowColliderTopY], a
    ld a, $07
    ld [wLowColliderRightX], a
    ld a, $0D
    ld [wLowColliderLeftX], a
    ld hl, lionStatueRotatedMasks ;$4F82
    ld a, [wTigerStatueRotateDirection]
    add a
    ld e, a
    ld d, $00
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
    jp loadRoomBGMask

.Label10F3C ;04:4F3C
    ld a, [wTigerStatueRotateDirection]
    cp a, $03
    jr nz, .Label10F4F
    ld a, [wTriggerJewelDinningRoom]
    cp a, $FF
    ret z
    ld a, [wTriggerJewelStatue2F]
    cp a, $FF
    ret z
.Label10F4F
    ld a, $00
    ld [wLowColliderBottomY], a
    ld a, $10
    ld [wLowColliderTopY], a
    ld a, $03
    ld [wLowColliderRightX], a
    ld a, $11
    ld [wLowColliderLeftX], a
    ld hl, lionStatueAnimationMasks ;$4F74
    ld a, [wTigerStatueRotateDirection]
    add a
    ld e, a
    ld d, $00
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
    jp loadRoomBGMask
;4F74

lionStatueAnimationMasks: ;4F74
	dw lion_statue_masks_pointers ;7AE7
	dw lion_statue_masks_pointers+3 ;7AEA
	dw lion_statue_masks_pointers+6 ;7AED
	dw lion_statue_masks_pointers+18 ;7AF9
	dw lion_statue_masks_pointers+9 ;7AF0
	dw lion_statue_masks_pointers+12 ;7AF3
	dw lion_statue_masks_pointers+15 ;7AF6
lionStatueRotatedMasks: ;4F82
	dw lion_statue_masks_pointers+21 ;7AFC
	dw lion_statue_masks_pointers+21 ;7AFC
	dw lion_statue_masks_pointers+21 ;7AFC
	dw $0000
	dw lion_statue_masks_pointers+24 ;7AFF
	dw lion_statue_masks_pointers+24 ;7AFF
	dw lion_statue_masks_pointers+24 ;7AFF
;4F90

TombRoomMask:: ;04:4F90
    ld a, [wRoomScreen]
    or a
    jr z, .Label10F9F
    cp a, $01
    jr z, .Label10FBE
    cp a, $02
    jr z, .Label10FFD
    ret

.Label10F9F ;04:4F9F
    ld a, [wc4db]
    or a
    ret z
    ld a, $00
    ld [wLowColliderBottomY], a
    ld a, $0D
    ld [wLowColliderTopY], a
    ld a, $09
    ld [wLowColliderRightX], a
    ld a, $0B
    ld [wLowColliderLeftX], a
    ld hl, room2A_03_rope_mask_pointer ;$7B86
    jp loadRoomBGMask

.Label10FBE
    ld a, [wc4db]
    or a
    jr z, .Label10FDE
    ld a, $00
    ld [wLowColliderBottomY], a
    ld a, $10
    ld [wLowColliderTopY], a
    ld a, $12
    ld [wLowColliderRightX], a
    ld a, $13
    ld [wLowColliderLeftX], a
    ld hl, room2A_01_rope_mask_pointer ;$7B7A
    call loadRoomBGMask
.Label10FDE
    ld a, [wc420]
    or a
    ret z
    ld a, $07
    ld [wLowColliderBottomY], a
    ld a, $0D
    ld [wLowColliderTopY], a
    ld a, $06
    ld [wLowColliderRightX], a
    ld a, $0C
    ld [wLowColliderLeftX], a
    ld hl, room2A_tomb_mask_pointer ;$7B7D
    jp loadRoomBGMask
.Label10FFD
    ld a, [wc420]
    or a
    ret z
    ld a, $07
    ld [wLowColliderBottomY], a
    ld a, $10
    ld [wLowColliderTopY], a
    ld a, $02
    ld [wLowColliderRightX], a
    ld a, $0D
    ld [wLowColliderLeftX], a
    ld hl, room2A_tomb_mask_pointer+6 ;$7B83
    jp loadRoomBGMask


LibraryMODiskRoomMask:: ;04:501C
    ld a, [wLibrarySecretDoorTrigger]
    or a
    ret nz
    ld a, [wRoomScreen]
    cp a, $04
    jr z, .Label1102B
    cp a, $07
    ret nz
.Label1102B
    ld a, $00
    ld [wLowColliderBottomY], a
    ld a, $09
    ld [wLowColliderTopY], a
    ld a, $0E
    ld [wLowColliderRightX], a
    ld a, $14
    ld [wLowColliderLeftX], a
    ld hl, library_secret_door_mask ;$7BD4 ;invalid mask address %fix
    jp loadRoomBGMask

CourtyardPoolMask:: ;04:5045
    ld a, [wTriggerCourtyardCascade]
    or a
    ret nz
    ld a, [wRoomScreen]
    or a
    jr z, .Label11059
    cp a, $01
    jr z, .Label11073
    cp a, $02
    jr z, .Label1108D
    ret

.Label11059 ;04:5059
    ld a, $09
    ld [wLowColliderBottomY], a
    ld a, $10
    ld [wLowColliderTopY], a
    ld a, $00
    ld [wLowColliderRightX], a
    ld a, $14
    ld [wLowColliderLeftX], a
    ld hl, room37_flooded_gate_masks ;$7B50
    jp loadRoomBGMask
.Label11073
    ld a, $00
    ld [wLowColliderBottomY], a
    ld a, $09
    ld [wLowColliderTopY], a
    ld a, $00
    ld [wLowColliderRightX], a
    ld a, $14
    ld [wLowColliderLeftX], a
    ld hl, room37_flooded_gate_masks+3 ;$7B53
    jp loadRoomBGMask
.Label1108D
    ld a, $08
    ld [wLowColliderBottomY], a
    ld a, $10
    ld [wLowColliderTopY], a
    ld a, $00
    ld [wLowColliderRightX], a
    ld a, $14
    ld [wLowColliderLeftX], a
    ld hl, room37_flooded_gate_masks+6 ;$7B56
    jp loadRoomBGMask

EagleMedalRoomMask:: ;04:50A7
    ld a, [wRoomScreen]
    or a
    jr z, .Label110BA
    cp a, $01
    jr z, .Label110F7
    cp a, $02
    jr z, .Label11116
    cp a, $03
    jr z, .Label11135
    ret

.Label110BA ;04:50BA
    ld a, $06
    ld [wLowColliderBottomY], a
    ld a, $0C
    ld [wLowColliderTopY], a
    ld a, $03
    ld [wLowColliderRightX], a
    ld a, $08
    ld [wLowColliderLeftX], a
    ld hl, underground_statue_wall_masks ;$7BC8 invalid mask %fix
    ld a, [wCatacombStatueWallTrigger]
    or a
    call nz, loadRoomBGMask
    ld a, [wc4c3]
    or a
    ret z
    ld a, $06
    ld [wLowColliderBottomY], a
    ld a, $08
    ld [wLowColliderTopY], a
    ld a, $0E
    ld [wLowColliderRightX], a
    ld a, $10
    ld [wLowColliderLeftX], a
    ld hl, underground_statue_wall_masks ;$7BC8
    jp loadRoomBGMask
.Label110F7
    ld a, [wCatacombStatueWallTrigger]
    or a
    ret z
    ld a, $06
    ld [wLowColliderBottomY], a
    ld a, $0E
    ld [wLowColliderTopY], a
    ld a, $05
    ld [wLowColliderRightX], a
    ld a, $0A
    ld [wLowColliderLeftX], a
    ld hl, underground_statue_wall_masks+3 ;$7BCB
    jp loadRoomBGMask
.Label11116
    ld a, [wc4c3]
    or a
    ret z
    ld a, $04
    ld [wLowColliderBottomY], a
    ld a, $07
    ld [wLowColliderTopY], a
    ld a, $07
    ld [wLowColliderRightX], a
    ld a, $0A
    ld [wLowColliderLeftX], a
    ld hl, underground_statue_wall_masks+6 ;$7BCE
    jp loadRoomBGMask
.Label11135
    ld a, [wCatacombStatueWallTrigger]
    or a
    ret z
    ld a, $08
    ld [wLowColliderBottomY], a
    ld a, $0F
    ld [wLowColliderTopY], a
    ld a, $12
    ld [wLowColliderRightX], a
    ld a, $14
    ld [wLowColliderLeftX], a
    ld hl, underground_statue_wall_masks+9 ;$7BD1
    jp loadRoomBGMask

BoulderRoom2Mask:: ;04:5154
    ld a, [wRoomScreen]
    cp a, $05
    jr z, .Label1115C
    ret

.Label1115C ;04:515C
    ld a, $02
    ld [wLowColliderBottomY], a
    ld a, $0E
    ld [wLowColliderTopY], a
    ld a, $04
    ld [wLowColliderRightX], a
    ld a, $12
    ld [wLowColliderLeftX], a
    ld hl, room3E_rotate_floor_2_masks ;$7B89
    ld a, [wRotateFloor2AnimId]
    ld c, a
    add a
    add a, c
    ld c, a
    ld b, $00
    add hl, bc
    jp loadRoomBGMask

CourtyardCascadeMask:: ;04:5180
    ld a, [wRoomScreen]
    cp a, $05
    jr z, .Label11188
    ret

.Label11188 ;04:5188
    ld a, $04
    ld [wLowColliderBottomY], a
    ld a, $0D
    ld [wLowColliderTopY], a
    ld a, $05
    ld [wLowColliderRightX], a
    ld a, $0E
    ld [wLowColliderLeftX], a
    ld hl, room3E_rotate_floor_1_masks ;$7B92
    ld a, [wRotateFloor1AnimId]
    ld c, a
    add a
    add a, c
    ld c, a
    ld b, $00
    add hl, bc
    jp loadRoomBGMask

SpiderwebMask:: ;04:51AC
    ld a, [wc1b2]
    cp a, $03
    ret nc
    ld a, [wRoomScreen]
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
    ld [wLowColliderBottomY], a
    ld a, $0B
    ld [wLowColliderTopY], a
    ld a, $10
    ld [wLowColliderRightX], a
    ld a, $13
    ld [wLowColliderLeftX], a
    ld hl, room45_00_masks_pointers ;$7BAA
    ld a, [wc1b2]
    or a
    jp z, loadRoomBGMask
    ld hl, room45_00_masks_pointers+3 ;$7BAD
    cp a, $01
    jp z, loadRoomBGMask
    ld hl, room45_00_masks_pointers+6 ;$7BB0
    jp loadRoomBGMask
.Label111F2
    ld a, $0D
    ld [wLowColliderBottomY], a
    ld a, $10
    ld [wLowColliderTopY], a
    ld a, $11
    ld [wLowColliderRightX], a
    ld a, $14
    ld [wLowColliderLeftX], a
    ld hl, room45_01_masks_pointers ;$7BB3
    jp loadRoomBGMask
.Label1120C
    ld a, $04
    ld [wLowColliderBottomY], a
    ld a, $0A
    ld [wLowColliderTopY], a
    ld a, $00
    ld [wLowColliderRightX], a
    ld a, $02
    ld [wLowColliderLeftX], a
    ld hl, room45_02_masks_pointers ;$7BB6
    ld a, [wc1b2]
    or a
    jp z, loadRoomBGMask
    ld hl, room45_02_masks_pointers+3 ;$7BB9
    cp a, $01
    jp z, loadRoomBGMask
    ld hl, room45_02_masks_pointers+6 ;$7BBC
    jp loadRoomBGMask
.Label11238
    ld a, $00
    ld [wLowColliderBottomY], a
    ld a, $0B
    ld [wLowColliderTopY], a
    ld a, $05
    ld [wLowColliderRightX], a
    ld a, $0F
    ld [wLowColliderLeftX], a
    ld hl, room45_03_masks_pointers ;$7BA1
    ld a, [wc1b2]
    or a
    jp z, loadRoomBGMask
    ld hl, room45_03_masks_pointers+3 ;$7BA4
    cp a, $01
    jp z, loadRoomBGMask
    ld hl, room45_03_masks_pointers+6 ;$7BA7
    jp loadRoomBGMask

DormBathroomMask:: ;04:5264
    ld a, [wDorm001BathroomTubUnplug]
    or a
    ret nz
    ld a, [wRoomScreen]
    cp a, $00
    jr z, .Label11275
    cp a, $01
    jr z, .Label1128F
    ret

.Label11275 ;04:5275
    ld a, $0B
    ld [wLowColliderBottomY], a
    ld a, $10
    ld [wLowColliderTopY], a
    ld a, $0E
    ld [wLowColliderRightX], a
    ld a, $14
    ld [wLowColliderLeftX], a
    ld hl, room49_dorm_bathtub_masks ;$7B6E
    jp loadRoomBGMask
.Label1128F
    ld a, $0A
    ld [wLowColliderBottomY], a
    ld a, $0D
    ld [wLowColliderTopY], a
    ld a, $02
    ld [wLowColliderRightX], a
    ld a, $09
    ld [wLowColliderLeftX], a
    ld hl, room49_dorm_bathtub_masks+3 ;$7B71
    jp loadRoomBGMask

AquariumMask:: ;04:52A9
    ld a, [wFloodedRoomsTrigger]
    or a
    ret nz
    ld a, [wRoomScreen]
    cp a, $00
    jr z, .Label112CC
    cp a, $01
    jr z, .Label112E6
    cp a, $02
    jr z, .Label11300
    cp a, $03
    jr z, .Label1131A
    cp a, $04
    jp z, .Label11334
    cp a, $05
    jp z, .Label1134E
    ret

.Label112CC ;04:52CC
    ld a, $06
    ld [wLowColliderBottomY], a
    ld a, $10
    ld [wLowColliderTopY], a
    ld a, $00
    ld [wLowColliderRightX], a
    ld a, $14
    ld [wLowColliderLeftX], a
    ld hl, room4B_aqua_tank_flood_masks ;$7B2C
    jp loadRoomBGMask
.Label112E6
    ld a, $08
    ld [wLowColliderBottomY], a
    ld a, $10
    ld [wLowColliderTopY], a
    ld a, $00
    ld [wLowColliderRightX], a
    ld a, $14
    ld [wLowColliderLeftX], a
    ld hl, room4B_aqua_tank_flood_masks+3 ;$7B2F
    jp loadRoomBGMask
.Label11300
    ld a, $04
    ld [wLowColliderBottomY], a
    ld a, $10
    ld [wLowColliderTopY], a
    ld a, $00
    ld [wLowColliderRightX], a
    ld a, $14
    ld [wLowColliderLeftX], a
    ld hl, room4B_aqua_tank_flood_masks+6 ;$7B32
    jp loadRoomBGMask
.Label1131A
    ld a, $05
    ld [wLowColliderBottomY], a
    ld a, $10
    ld [wLowColliderTopY], a
    ld a, $00
    ld [wLowColliderRightX], a
    ld a, $14
    ld [wLowColliderLeftX], a
    ld hl, room4B_aqua_tank_flood_masks+9 ;$7B35
    jp loadRoomBGMask
.Label11334
    ld a, $06
    ld [wLowColliderBottomY], a
    ld a, $10
    ld [wLowColliderTopY], a
    ld a, $00
    ld [wLowColliderRightX], a
    ld a, $14
    ld [wLowColliderLeftX], a
    ld hl, room4B_aqua_tank_flood_masks+12 ;$7B38
    jp loadRoomBGMask
.Label1134E
    ld a, $07
    ld [wLowColliderBottomY], a
    ld a, $10
    ld [wLowColliderTopY], a
    ld a, $00
    ld [wLowColliderRightX], a
    ld a, $14
    ld [wLowColliderLeftX], a
    ld hl, room4B_aqua_tank_flood_masks+15 ;$7B3B
    jp loadRoomBGMask

CorridorFloodMask:: ;04:5368
    ld a, [wRoomScreen]
    cp a, $05
    jr z, .Label11370
    ret

.Label11370 ;04:5370
    ld a, $05
    ld [wLowColliderBottomY], a
    ld a, $09
    ld [wLowColliderTopY], a
    ld a, $00
    ld [wLowColliderRightX], a
    ld a, $14
    ld [wLowColliderLeftX], a
    ld hl, room4C_flooded_corridor_masks ;$7B3E
    jp loadRoomBGMask


AquariumControlRoomMask:: ;04:538A
    ld a, [wFloodedRoomsTrigger]
    or a
    ret nz
    ld a, [wRoomScreen]
    cp a, $00
    jr z, .Label113A7
    cp a, $01
    jr z, .Label113C1
    cp a, $02
    jr z, .Label113DB
    cp a, $03
    jr z, .Label113F5
    cp a, $04
    jr z, .Label1140F
    ret

.Label113A7 ;04:53A7
    ld a, $05
    ld [wLowColliderBottomY], a
    ld a, $10
    ld [wLowColliderTopY], a
    ld a, $00
    ld [wLowColliderRightX], a
    ld a, $14
    ld [wLowColliderLeftX], a
    ld hl, room4D_control_room_flooded_masks ;$7B41
    jp loadRoomBGMask
.Label113C1
    ld a, $05
    ld [wLowColliderBottomY], a
    ld a, $10
    ld [wLowColliderTopY], a
    ld a, $00
    ld [wLowColliderRightX], a
    ld a, $14
    ld [wLowColliderLeftX], a
    ld hl, room4D_control_room_flooded_masks+3 ;$7B44
    jp loadRoomBGMask
.Label113DB
    ld a, $0C
    ld [wLowColliderBottomY], a
    ld a, $10
    ld [wLowColliderTopY], a
    ld a, $00
    ld [wLowColliderRightX], a
    ld a, $14
    ld [wLowColliderLeftX], a
    ld hl, room4D_control_room_flooded_masks+6 ;$7B47
    jp loadRoomBGMask
.Label113F5
    ld a, $06
    ld [wLowColliderBottomY], a
    ld a, $10
    ld [wLowColliderTopY], a
    ld a, $00
    ld [wLowColliderRightX], a
    ld a, $14
    ld [wLowColliderLeftX], a
    ld hl, room4D_control_room_flooded_masks+9 ;$7B4A
    jp loadRoomBGMask
.Label1140F
    ld a, $06
    ld [wLowColliderBottomY], a
    ld a, $10
    ld [wLowColliderTopY], a
    ld a, $00
    ld [wLowColliderRightX], a
    ld a, $14
    ld [wLowColliderLeftX], a
    ld hl, room4D_control_room_flooded_masks+12 ;$7B4D
    jp loadRoomBGMask

Plant42RootsRoomMask:: ;04:5429
    ld a, [wRoomScreen]
    or a
    jr z, .Label11443
    cp a, $01
    jr z, .Label11462
    cp a, $02
    jp z, .Label1149F
    cp a, $03
    jp z, .Label114DC
    cp a, $04
    jp z, .Label114FB
    ret

.Label11443 ;04:5443
    ld a, [wFloodedRoomsTrigger]
    or a
    ret nz
    ld a, $06
    ld [wLowColliderBottomY], a
    ld a, $10
    ld [wLowColliderTopY], a
    ld a, $00
    ld [wLowColliderRightX], a
    ld a, $14
    ld [wLowColliderLeftX], a
    ld hl, room58_flooded_roots_masks ;$7B59
    jp loadRoomBGMask
.Label11462
    ld a, $02
    ld [wLowColliderBottomY], a
    ld a, $09
    ld [wLowColliderTopY], a
    ld a, $03
    ld [wLowColliderRightX], a
    ld a, $0A
    ld [wLowColliderLeftX], a
    ld hl, room58_roots_masks ;$7B74
    ld a, [wPlant42RootsTrigger]
    or a
    call z, loadRoomBGMask
    ld a, [wFloodedRoomsTrigger]
    or a
    ret nz
    ld a, $07
    ld [wLowColliderBottomY], a
    ld a, $10
    ld [wLowColliderTopY], a
    ld a, $00
    ld [wLowColliderRightX], a
    ld a, $14
    ld [wLowColliderLeftX], a
    ld hl, room58_flooded_roots_masks+3 ;$7B5C
    jp loadRoomBGMask
.Label1149F
    ld a, $02
    ld [wLowColliderBottomY], a
    ld a, $0D
    ld [wLowColliderTopY], a
    ld a, $04
    ld [wLowColliderRightX], a
    ld a, $10
    ld [wLowColliderLeftX], a
    ld hl, room58_roots_masks+3 ;$7B77
    ld a, [wPlant42RootsTrigger]
    or a
    call z, loadRoomBGMask
    ld a, [wFloodedRoomsTrigger]
    or a
    ret nz
    ld a, $08
    ld [wLowColliderBottomY], a
    ld a, $10
    ld [wLowColliderTopY], a
    ld a, $00
    ld [wLowColliderRightX], a
    ld a, $14
    ld [wLowColliderLeftX], a
    ld hl, room58_flooded_roots_masks+6 ;$7B5F
    jp loadRoomBGMask
.Label114DC
    ld a, [wFloodedRoomsTrigger]
    or a
    ret nz
    ld a, $05
    ld [wLowColliderBottomY], a
    ld a, $10
    ld [wLowColliderTopY], a
    ld a, $00
    ld [wLowColliderRightX], a
    ld a, $14
    ld [wLowColliderLeftX], a
    ld hl, room58_flooded_roots_masks+9 ;$7B62
    jp loadRoomBGMask
.Label114FB
    ld a, [wFloodedRoomsTrigger]
    or a
    ret nz
    ld a, $02
    ld [wLowColliderBottomY], a
    ld a, $10
    ld [wLowColliderTopY], a
    ld a, $00
    ld [wLowColliderRightX], a
    ld a, $14
    ld [wLowColliderLeftX], a
    ld hl, room58_flooded_roots_masks+12 ;$7B65
    jp loadRoomBGMask

LabProjectorRoomMask:: ;04:551A
	ld a, [wRoomScreen]
    or a
    jr z, .Label1152D
    cp a, $01
    jr z, .Label11551
    cp a, $02
    jr z, .Label11575
    cp a, $03
    jr z, .Label11599
    ret

.Label1152D ;04:552D
    ld a, $00
    ld [wLowColliderBottomY], a
    ld a, $0B
    ld [wLowColliderTopY], a
    ld a, $00
    ld [wLowColliderRightX], a
    ld a, $04
    ld [wLowColliderLeftX], a
    ld hl, room5D_lab_column_masks ;$7ACC
    ld a, [wLabSlideRoomPillarMoved]
    or a
    jp z, loadRoomBGMask
    ld hl, room5D_lab_column_masks+3 ;$7ACF
    jp loadRoomBGMask
.Label11551
    ld a, $02
    ld [wLowColliderBottomY], a
    ld a, $0C
    ld [wLowColliderTopY], a
    ld a, $0F
    ld [wLowColliderRightX], a
    ld a, $14
    ld [wLowColliderLeftX], a
    ld hl, room5D_lab_column_masks+12 ;$7AD8
    ld a, [wLabSlideRoomPillarMoved]
    or a
    jp z, loadRoomBGMask
    ld hl, room5D_lab_column_masks+15 ;$7ADB
    jp loadRoomBGMask
.Label11575
    ld a, $00
    ld [wLowColliderBottomY], a
    ld a, $0D
    ld [wLowColliderTopY], a
    ld a, $05
    ld [wLowColliderRightX], a
    ld a, $0B
    ld [wLowColliderLeftX], a
    ld hl, room5D_lab_column_masks+9 ;$7AD5
    ld a, [wLabSlideRoomPillarMoved]
    or a
    jp z, loadRoomBGMask
    ld hl, room5D_lab_column_masks+6 ;$7AD2
    jp loadRoomBGMask
.Label11599
    ld a, [wVisualDataRoomPanelButtonOpened]
    or a
    ret nz
    ld a, $04
    ld [wLowColliderBottomY], a
    ld a, $08
    ld [wLowColliderTopY], a
    ld a, $0A
    ld [wLowColliderRightX], a
    ld a, $0C
    ld [wLowColliderLeftX], a
    ld hl, room5D_button_panel_mask ;$7AC9
    jp loadRoomBGMask

PaintingsRoomMask:: ;04:55B8
    ld a, [wPaintingPuzzleSwitch]
    or a
    ret nz
    ld a, [wRoomScreen]
    cp a, $04
    jr z, .Label115C9
    cp a, $05
    jr z, .Label115E3
    ret

.Label115C9 ;04:55C9
    ld a, $03
    ld [wLowColliderBottomY], a
    ld a, $06
    ld [wLowColliderTopY], a
    ld a, $06
    ld [wLowColliderRightX], a
    ld a, $08
    ld [wLowColliderLeftX], a
    ld hl, room6F_paintings_masks ;$7AC0
    jp loadRoomBGMask
.Label115E3
    ld a, $02
    ld [wLowColliderBottomY], a
    ld a, $06
    ld [wLowColliderTopY], a
    ld a, $05
    ld [wLowColliderRightX], a
    ld a, $09
    ld [wLowColliderLeftX], a
    ld hl, room6F_paintings_masks+3 ;$7AC3
    jp loadRoomBGMask
