; load all room current screen sprites like items, sprite based bg overlaps and bg animations.
; Entities sprites are not loaded here.  
loadRoomScreenSprites: ;FB:4000
    ld a, [wRoomId]
    or a ; MAIN_HALL_1F
    jp z, loadMainHallItemSprites
    cp a, DINNING_ROOM_1F
    jp z, loadDinningRoom1FItemSprites
    cp a, WEST_STOREROOM
    jp z, loadSafeRoomItemSprites
    cp a, EXHIBITION_ROOM
    jp z, loadExhibitionRoomItemSprites
    cp a, REST_STOP_CORRIDOR
    jp z, loadRestStopCorridorItemSprites
    cp a, GREENHOUSE
    jp z, loadGreenhouseItemSprites
    cp a, PIANO_ROOM
    jp z, loadPianoRoomItemSprites
    cp a, WEST_STAIRCASE_1F
    jp z, load1FWestStaircaseItemSprites
    cp a, FIREARMS_ROOM
    jp z, loadFirearmsRoomItemSprites
    cp a, NORTH_EAST_CORRIDOR_1F
    jp z, loadNorthEastCorridorItemSprites
    cp a, L_SHAPED_CORRIDOR
    jp z, loadLShapedCorridorItemSprites
    cp a, EAST_STAIRS_CORRIDOR_1F
    jp z, loadEast1FStairsCorridorItemSprites
    cp a, KEEPERS_ROOM
    jp z, loadKeepersRoomItemSprites
    cp a, LARGE_ART_ROOM
    jp z, loadLargeArtRoomItemSprites
    cp a, MANSION_BATHROOM
    jp z, loadMansionBathroomItemSprites
    cp a, OUTDOOR_AREA
    jp z, loadOutdoorAreaItemSprites
    cp a, TIGER_STATUE_ROOM
    jp z, loadTigerStatueRoomItemSprites
    cp a, SHED_ROOM
    jp z, loadShedItemSprites
    cp a, MIRROR_ROOM
    jp z, loadMirrorRoomItemSprites
    cp a, LIVING_ROOM
    jp z, loadLivingRoomItemSprites
    cp a, UNDERGROUND_PASSAGE_1
    jp z, loadUndergroundPassage1ItemSprts
    cp a, PILLAR_CORRIDOR
    jp z, loadPillarCorridorItemSprites
    cp a, LOUNGE_ROOM
    jp z, loadLoungeItemSprites
    cp a, ELEVATOR_ROOM_2F
    jp z, load2FElevatorRoomItemSprites
    cp a, HALLWAY_TO_EAST_TERRACE
    jp z, loadEastTerraceHallwayItemSprite
    cp a, SMALL_DINNING_ROOM
    jp z, loadSmallDinningRoomItemSprt
    cp a, ARMORS_ROOM
    jp z, loadArmorsRoomItemSprites
    cp a, WESTERN_CORRIDOR_2F
    jp z, load2FWesternCorridorItemSprt
    cp a, MANSION_BEDROOM
    jp z, loadMansionRoomItemSprts
    cp a, SMALL_LIBRARY
    jp z, loadSmallLibraryItemSprts
    cp a, ATTIC
    jp z, loadAtticItemSprites
    cp a, EAST_TERRACE
    jp z, loadEastTerraceItemSprites
    cp a, TAXIDERMY_ROOM
    jp z, loadTaxidermyRoomItemSprt
    cp a, LIBRARY
    jp z, loadLibraryItemSprites
    cp a, MATERIALS_ROOM
    jp z, loadMaterialsRoomItemSprt
    cp a, HELIPAD_LOOKOUT_ROOM
    jp z, loadHelipadLookoutItemSprt
    cp a, UNDERGROUND_SOUTH_PASSAGE
    jp z, loadSouthPassageItemSprt
    cp a, GUARDHOUSE_DORM_001
    jp z, loadDorm001ItemSprite
    cp a, GUARDHOUSE_DORM_002
    jp z, loadDorm002ItemSprite
    cp a, AQUA_TANK_STOREROOM
    jp z, loadAquaTankStoreroomItemSprt
    cp a, EMERGENCY_TUNNEL
    jp z, loadEmergencyTunnelItemSprt
    cp a, OPERATING_MORGE_ROOM
    jp z, loadOperatingRoomItemSprt
    cp a, LARGE_GALLERY
    jp z, loadPaintingsRoomItemSprt
    cp a, EAST_STOREROOM
    jp z, loadEastStoreroomItemSprt
    ret

loadMainHallItemSprites: ;FB:40DF
    ld a, [wRoomCameraId]
    cp a, 1
    jr z, loadMainHallPillarsScrn01
    cp a, 2
    jr z, loadMainHallPillarsScrn02
    cp a, 5
    jr z, Label3EC12D
    cp a, 6
    jr z, Label3EC146
    ret
loadMainHallPillarsScrn01: ;FB:40F3
    ld de, room00_01_pillar_sprite_02
    call loadRoomItemSpriteData
    ld de, room00_01_pillar_sprite_01
    call loadRoomItemSpriteData
    ld de, room00_01_handgun_sprite
    ld a, [wRoomsItemsFlags+ROOM00_BERRETTA]
    or a
    call nz, loadRoomItemSpriteData
    ret
loadMainHallPillarsScrn02: ;FB:410A
    ld de, room00_02_pillar_sprite_07
    call loadRoomItemSpriteData
    ld de, room00_02_pillar_sprite_10
    call loadRoomItemSpriteData
    ld de, room00_02_pillar_sprite_03
    call loadRoomItemSpriteData
    ld de, room00_02_pillar_sprite_11
    call loadRoomItemSpriteData
    ld de, room00_02_handgun_sprite
    ld a, [wRoomsItemsFlags+ROOM00_BERRETTA]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC12D: ;FB:412D
    ld de, room00_05_pillar_sprite_09
    call loadRoomItemSpriteData
    ld de, room00_05_pillar_sprite_08
    call loadRoomItemSpriteData
    ld de, room00_05_pillar_sprite_04
    call loadRoomItemSpriteData
    ld de, room00_05_pillar_sprite_12
    call loadRoomItemSpriteData
    ret
Label3EC146: ;FB:4146
    ld de, room00_06_pillar_sprite_05
    call loadRoomItemSpriteData
    ld de, room00_06_pillar_sprite_06
    call loadRoomItemSpriteData
    ret


loadDinningRoom1FItemSprites: ;FB:4153
    ld a, [wRoomCameraId]
    cp a, 2
    jr z, Label3EC16B
    cp a, 3
    jr z, Label3EC185
    cp a, 4
    jr z, Label3EC195
    cp a, 5
    jr z, Label3EC1A0
    cp a, 6
    jr z, Label3EC1B0
    ret
Label3EC16B: ;FB:416B
    ld de, room01_02_emblem_sprite
    ld a, [wRoomsItemsFlags+ROOM01_WOODEN_EMBLEM]
    ld c, a
    ld a, [wRoomsItemsFlags+ROOM01_GOLD_EMBLEM]
    add a, c
    or a
    call nz, loadRoomItemSpriteData
    ld de, room01_02_blue_jewel_sprite
    ld a, [wRoomsItemsFlags+ROOM01_BLUE_JEWEL]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC185: ;FB:4185
    ld de, room01_03_emblem_sprite
    ld a, [wRoomsItemsFlags+ROOM01_WOODEN_EMBLEM]
    ld c, a
    ld a, [wRoomsItemsFlags+ROOM01_GOLD_EMBLEM]
    add a, c
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC195: ;FB:4195
    ld de, room01_03_blue_jewel_sprite
    ld a, [wRoomsItemsFlags+ROOM01_BLUE_JEWEL]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC1A0: ;FB:41A0
    ld de, room01_05_shield_key_sprite
    ld a, [wRoomsItemsFlags+ROOM01_SHIELD_KEY]
    ld c, a
    ld a, [wRoomsItemsFlags+ROOM01_GOLD_EMBLEM]
    add a, c
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC1B0: ;FB:41B0
    ld de, room01_06_emblem_sprite
    ld a, [wRoomsItemsFlags+ROOM01_WOODEN_EMBLEM]
    ld c, a
    ld a, [wRoomsItemsFlags+ROOM01_GOLD_EMBLEM]
    add a, c
    or a
    call nz, loadRoomItemSpriteData
    ret


loadSafeRoomItemSprites: ;FB:41C0
    ld a, [wRoomCameraId]
    or a ; 0
    jr z, Label3EC1D3
    cp a, 1
    jr z, Label3EC1DE
    cp a, 3
    jr z, Label3EC1DF
    cp a, 4
    jr z, Label3EC1EA
    ret
Label3EC1D3: ;FB:41D3
    ld de, room02_00_serum_sprite
    ld a, [wRoomsItemsFlags+ROOM02_SERUM]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC1DE: ;FB:41DE
    ret
Label3EC1DF: ;FB:41DF
    ld de, room02_03_serum_sprite
    ld a, [wRoomsItemsFlags+ROOM02_SERUM]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC1EA: ;FB:41EA
    ret


loadExhibitionRoomItemSprites: ;FB:41EB
    ld a, [wRoomCameraId]
    cp a, 2
    jr z, Label3EC1F7
    cp a, 5
    jr z, Label3EC202
    ret
Label3EC1F7: ;FB:41F7
    ld de, room04_02_map_sprite
    ld a, [wRoomsItemsFlags+ROOM04_MAP_1]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC202: ;FB:4202
    ld de, room04_05_ink_ribbon_sprite
    ld a, [wRoomsItemsFlags+ROOM04_INK_RIBBON]
    or a
    call nz, loadRoomItemSpriteData
    ret

loadRestStopCorridorItemSprites: ;FB:420D
    ld a, [wRoomCameraId]
    cp a, 3
    jr z, Label3EC219
    cp a, 4
    jr z, Label3EC220
    ret
Label3EC219: ;FB:4219
    ld de, room05_03_corridor_lamp_sprite
    call loadRoomItemSpriteData
    ret
Label3EC220: ;FB:4220
    ld a, [wRoomsItemsFlags+ROOM05_CLIP1]
    or a
    jr nz, .Label3EC22B
    ld a, [wRoomsItemsFlags+ROOM05_CLIP2]
    or a
    ret z
.Label3EC22B
    ret

loadGreenhouseItemSprites: ;FB:422C
    ld a, [wRoomCameraId]
    cp a, 2
    jr z, Label3EC23C
    cp a, 3
    jr z, Label3EC243
    cp a, 5
    jr z, Label3EC250
    ret
Label3EC23C: ;FB:423C
    ld de, room06_02_herb_sprite
    call loadRoomItemSpriteData
    ret
Label3EC243: ;FB:4243
    ld de, room06_03_herb_sprite_1 ; not pickable herb. TODO: fix
    call loadRoomItemSpriteData
    ld de, room06_03_herb_sprite_2 ; not pickable herb
    call loadRoomItemSpriteData
    ret
Label3EC250: ;FB:4250
    ld de, room06_05_armor_key_sprite
    ld a, [wRoomsItemsFlags+ROOM06_ARMOR_KEY]
    or a
    call nz, loadRoomItemSpriteData
    ret

loadPianoRoomItemSprites: ;FB:425B
    ld a, [wRoomCameraId]
    cp a, 4
    jr z, Label3EC263
    ret
Label3EC263: ;FB:4263
    ld de, room07_04_emblem_sprite
    ld a, [wRoomsItemsFlags+ROOM07_GOLD_EMBLEM]
    ld c, a
    ld a, [wRoomsItemsFlags+ROOM07_WOODEN_EMBLEM]
    add a, c
    or a
    call nz, loadRoomItemSpriteData
    ret

load1FWestStaircaseItemSprites: ;FB:4273
    ret

loadFirearmsRoomItemSprites: ;FB:4274
    ld a, [wRoomCameraId]
    cp a, 2
    jr z, Label3EC280
    cp a, 3
    jr z, Label3EC295
    ret
Label3EC280: ;FB:4280
    ld de, room09_02_broken_shotgun_sprite
    ld a, [wRoomsItemsFlags+ROOM06_ARMOR_KEY] ; it should be broken shotgun flag var. TODO: fix
    or a
    call nz, loadRoomItemSpriteData
    ld de, room09_02_clip_sprite
    ld a, [wRoomsItemsFlags+ROOM07_SHEET_MUSIC] ; wrong item flag. TODO: fix
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC295: ;FB:4295
    ld de, room09_03_shells_sprite ; it does not show anything. TODO: fix
    ld a, [wRoomsItemsFlags+ROOM06_GREEN_HERB4] ; Wrong item flag
    or a
    call nz, loadRoomItemSpriteData
    ret

loadNorthEastCorridorItemSprites: ;FB:42A0
    ld a, [wRoomCameraId]
    cp a, 1
    jr z, Label3EC2A8
    ret
Label3EC2A8: ;FB:42A8
    ld de, room0A_01_herb_sprite
    ld a, [wRoomsItemsFlags+ROOM0A_GREEN_HERB]
    or a
    call nz, loadRoomItemSpriteData
    ret

loadLShapedCorridorItemSprites: ;FB:42B3
    ld a, [wRoomCameraId]
    cp a, 2
    jr z, Label3EC2BB
    ret
Label3EC2BB: ;FB:42BB
    ld de, room0C_02_clip_sprite
    ld a, [wRoomsItemsFlags+ROOM0C_CLIP1]
    or a
    call nz, loadRoomItemSpriteData
    ret

loadEast1FStairsCorridorItemSprites: ;FB:42C6
    ld a, [wRoomCameraId]
    cp a, 2
    jr z, Label3EC2D2
    cp a, 3
    jr z, Label3EC2DD
    ret
Label3EC2D2: ;FB:42D2
    ld de, room0D_02_herb_sprite
    ld a, [wRoomsItemsFlags+ROOM0D_GREEN_HERB]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC2DD: ;FB:42DD
    ld de, room0D_03_herb_sprite
    ld a, [wRoomsItemsFlags+ROOM0D_GREEN_HERB]
    or a
    call nz, loadRoomItemSpriteData
    ret

loadKeepersRoomItemSprites: ;FB:42E8
    ld a, [wRoomCameraId]
    or a ; 0
    jr z, Label3EC2FB
    cp a, 1
    jr z, Label3EC306
    cp a, 2
    jr z, Label3EC311
    cp a, 3
    jr z, Label3EC326
    ret
Label3EC2FB: ;FB:42FB
    ld de, room0E_00_clip_sprite
    ld a, [wRoomsItemsFlags+ROOM0E_CLIP]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC306: ;FB:4306
    ld de, room0E_01_clip_sprite
    ld a, [wRoomsItemsFlags+ROOM0E_CLIP]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC311: ;FB:4311
    ld de, room0E_02_shells_sprite
    ld a, [wRoomsItemsFlags+ROOM0E_SHELLS]
    or a
    call nz, loadRoomItemSpriteData
    ld de, room0E_02_file_sprite
    ld a, [wRoomsItemsFlags+ROOM0E_NOTHING_ITEM_1]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC326: ;FB:4326
    ld de, room0E_03_shells_sprite
    ld a, [wRoomsItemsFlags+ROOM0E_SHELLS]
    or a
    call nz, loadRoomItemSpriteData
    ld de, room0E_03_file_sprite
    ld a, [wRoomsItemsFlags+ROOM0E_NOTHING_ITEM_1]
    or a
    call nz, loadRoomItemSpriteData
    ret
;433B

loadLargeArtRoomItemSprites: ;FB:433B
    ld a, [wRoomCameraId]
    cp a, 3
    jr z, Label3EC343
    ret
Label3EC343: ;FB:4343
    ld de, room10_03_shells_sprite
    ld a, [wRoomsItemsFlags+ROOM0E_CLIP] ; wrong item flag. TODO: fix
    or a
    call nz, loadRoomItemSpriteData
    ret

loadMansionBathroomItemSprites: ;FB:434E
    ld a, [wRoomCameraId]
    cp a, 3
    jr z, Label3EC356
    ret
Label3EC356: ;FB:4356
    ld de, room11_03_small_key_sprite ;$492E
    ld a, [wRoomsItemsFlags+ROOM0E_NOTHING_ITEM_1] ; wrong var condition. TODO: fix
    or a
    call nz, loadRoomItemSpriteData
    ret

loadOutdoorAreaItemSprites: ;FB:4361
    ld a, [wRoomCameraId]
    cp a, 2
    jr z, Label3EC36D
    cp a, 3
    jr z, Label3EC37A
    ret
Label3EC36D: ;FB:436D
    ld de, room12_02_herb_sprite_1 ; no item flag, meaning infinite herbs. TODO: add flag
    call loadRoomItemSpriteData
    ld de, room12_02_herb_sprite_2  ; no item flag, meaning infinite herbs. TODO: add flag
    call loadRoomItemSpriteData
    ret
Label3EC37A: ;FB:437A
    ld de, room12_03_herb_sprite_1
    call loadRoomItemSpriteData
    ld de, room12_03_herb_sprite_2
    call loadRoomItemSpriteData
    ret


loadTigerStatueRoomItemSprites: ;FB:4387
    ld a, [wRoomCameraId]
    cp a, 0
    jr z, Label3EC38F
    ret
Label3EC38F: ;FB:438F
    ld de, room14_00_wind_crest_sprite
    ld a, [wRoomsItemsFlags+ROOM14_WIND_CREST]
    or a
    call nz, loadRoomItemSpriteData
    ld de, room14_00_colt_python_sprite
    ld a, [wRoomsItemsFlags+ROOM14_COLT_PYTHON]
    or a
    call nz, loadRoomItemSpriteData
    ret


loadShedItemSprites: ;FB:43A4
    ld a, [wRoomCameraId]
    or a ; 0
    jr z, Label3EC3AF
    cp a, 2
    jr z, Label3EC3BA
    ret
Label3EC3AF: ;FB:43AF
    ld de, room16_00_small_key_sprite
    ld a, [wRoomsItemsFlags+ROOM16_SMALL_KEY_2]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC3BA: ;FB:43BA
    ld de, room16_02_square_crank_sprite
    ld a, [wRoomsItemsFlags+ROOM16_SQUARE_CRANK]
    or a
    call nz, loadRoomItemSpriteData
    ret

loadMirrorRoomItemSprites: ;FB:43C5
    ld a, [wRoomCameraId]
    or a ; 0
    jr z, Label3EC3D0
    cp a, 1
    jr z, Label3EC3E2
    ret
Label3EC3D0: ;FB:43D0
    ld a, [wRoomsItemsFlags+ROOM17_GREEN_HERB1]
    or a
    jr nz, .Label3EC3DB
    ld a, [wRoomsItemsFlags+ROOM17_GREEN_HERB2]
    or a
    ret z
.Label3EC3DB
    ld de, room17_00_herb_sprite ;$4988
    call loadRoomItemSpriteData
    ret
Label3EC3E2: ;FB:43E2
    ld de, room17_01_ink_ribbon_sprite ; misplaced. TODO: fix
    ld a, [wRoomsItemsFlags+ROOM17_GREEN_HERB2]
    or a
    call nz, loadRoomItemSpriteData
    ret


loadLivingRoomItemSprites: ;FB:43ED
    ld a, [wRoomCameraId]
    cp a, 1
    jr z, Label3EC3F5
    ret
Label3EC3F5: ;FB:43F5
    ld de, room18_01_shotgun_sprite
    ld a, [wRoomsItemsFlags+ROOM18_SHOTGUN]
    or a
    jr nz, .Label3EC403
    ld a, [wRoomsItemsFlags+ROOM18_BROKEN_SHOTGUN]
    or a
    ret z
.Label3EC403
    call nz, loadRoomItemSpriteData
    ret


loadUndergroundPassage1ItemSprts: ;FB:4407
    ld a, [wRoomCameraId]
    cp a, 3
    jr z, Label3EC40F
    ret
Label3EC40F: ;FB:440F
    ld de, room1A_03_shells_sprite
    call loadRoomItemSpriteData ; no item flag. TODO: fix
    ret


loadPillarCorridorItemSprites: ;FB:4416
    ld a, [wRoomCameraId]
    cp a, 2
    jr z, Label3EC41E
    ret
Label3EC41E: ;FB:441E
    ld de, room1E_02_herb_sprite ;$49B0
    call loadRoomItemSpriteData ; no item flag. TODO: fix
    ret


loadLoungeItemSprites: ;FB:4425
    ld a, [wRoomCameraId]
    cp a, 1
    jr z, Label3EC431
    cp a, 2
    jr z, Label3EC46D
    ret
Label3EC431: ;FB:4431
    ld de, room1F_01_mansion_2F_map_sprite
    ld a, [wRoomsItemsFlags+ROOM1F_MAP_2]
    or a
    call nz, loadRoomItemSpriteData
    ld de, room1F_01_herb_sprite
    ld a, [wRoomsItemsFlags+ROOM1F_GREEN_HERB]
    or a
    call nz, loadRoomItemSpriteData
    ld a, [wLoungeFireplaceLittedFlag]
    or a
    ret z
    ld de, room1F_01_fireplace_sprite_frame01
; animate fireplace fire sprites, change sprite every 8 frames
    ld a, [wAnimatedRoomSpritesFrameCounter]
    and a, 31
    cp a, 8
    jp c, loadRoomItemSpriteData
    ld de, room1F_01_fireplace_sprite_frame02
    cp a, 16
    jp c, loadRoomItemSpriteData
    ld de, room1F_01_fireplace_sprite_frame03
    cp a, 24
    jp c, loadRoomItemSpriteData
    ld de, room1F_01_fireplace_sprite_frame04
    jp loadRoomItemSpriteData

Label3EC46D:
    ld de, room1F_02_mansion_2F_map_sprite
    ld a, [wRoomsItemsFlags+ROOM1F_MAP_2]
    or a
    call nz, loadRoomItemSpriteData
    ld a, [wLoungeFireplaceLittedFlag]
    or a
    ret z
    ld de, room1F_02_fireplace_sprite_frame01
; animate fireplace fire sprites, change sprite every 8 frames
    ld a, [wAnimatedRoomSpritesFrameCounter]
    and a, 31
    cp a, 8
    jp c, loadRoomItemSpriteData
    ld de, room1F_02_fireplace_sprite_frame02
    cp a, 16
    jp c, loadRoomItemSpriteData
    ld de, room1F_02_fireplace_sprite_frame03
    cp a, 24
    jp c, loadRoomItemSpriteData
    ld de, room1F_02_fireplace_sprite_frame04
    jp loadRoomItemSpriteData


load2FElevatorRoomItemSprites: ;FB:449F
    ld a, [wRoomCameraId]
    cp a, $20 ; typo, it should be screen $02. TODO: fix this
    jr z, Label3EC4A7
    ret
Label3EC4A7: ;FB:44A7
    ld de, room20_02_herb_sprite
    call loadRoomItemSpriteData
    ret


loadEastTerraceHallwayItemSprite: ;FB:44AE
    ld a, [wRoomCameraId]
    or a ; 0
    jr z, Label3EC4B5
    ret
Label3EC4B5: ;FB:44B5
    ld de, room21_00_small_key_sprite
    ld a, [wRoomsItemsFlags+ROOM21_SMALL_KEY_3]
    or a
    call nz, loadRoomItemSpriteData
    ret


loadSmallDinningRoomItemSprt: ;FB:44C0
    ld a, [wRoomCameraId]
    or a ; 0
    jr z, Label3EC4CB
    cp a, 1
    jr z, Label3EC4DB
    ret
Label3EC4CB: ;FB:44CB
    ld de, room22_00_candle_unlit_sprite
    ld a, [wSmallDinningRoomLittedCandleFlag]
    or a
    jr z, .Label3EC4D7
    ld de, room22_00_candle_lit_sprite
.Label3EC4D7
    call loadRoomItemSpriteData
    ret
Label3EC4DB: ;FB:44DB
    ld de, room22_01_candle_unlit_sprite
    ld a, [wSmallDinningRoomLittedCandleFlag]
    or a
    jr z, .Label3EC4E7
    ld de, room22_01_candle_lit_sprite
.Label3EC4E7
    call loadRoomItemSpriteData
    ret


loadArmorsRoomItemSprites: ;FB:44EB
    ld a, [wRoomCameraId]
    or a ; 0
    jr z, Label3EC4FA
    cp a, 1
    jr z, Label3EC512
    cp a, 2
    jr z, Label3EC52A
    ret
Label3EC4FA: ;FB:44FA
    ld a, [wRoomGasActivatedFlag]
    or a
    ret z
    ld de, room23_00_gas_sprite_frame01
; animate gas sprite
    ld a, [wAnimatedRoomSpritesFrameCounter]
    and a, $0F
    cp a, 8
    jp c, loadRoomItemSpriteData
    ld de, room23_00_gas_sprite_frame02
    jp loadRoomItemSpriteData

Label3EC512:
    ld a, [wRoomGasActivatedFlag]
    or a
    ret z
    ld de, room23_01_gas_sprite_frame01
    ld a, [wAnimatedRoomSpritesFrameCounter]
    and a, $0F
    cp a, 8
    jp c, loadRoomItemSpriteData
    ld de, room23_01_gas_sprite_frame02
    jp loadRoomItemSpriteData

Label3EC52A:
    ld a, [wRoomGasActivatedFlag]
    or a
    ret z
    ld de, room23_02_gas_sprite_frame01
    ld a, [wAnimatedRoomSpritesFrameCounter]
    and a, $0F
    cp a, 8
    jp c, loadRoomItemSpriteData
    ld de, room23_02_gas_sprite_frame02
    jp loadRoomItemSpriteData


load2FWesternCorridorItemSprt: ;FB:4542
    ld a, [wRoomCameraId]
    or a ; 0
    jr z, Label3EC549
    ret
Label3EC549: ;FB:4549
    ld de, room25_00_herb_sprite_1
    ld a, [wRoomsItemsFlags+ROOM25_GREEN_HERB2]
    or a
    call nz, loadRoomItemSpriteData
    ld de, room25_00_herb_sprite_2
    ld a, [wRoomsItemsFlags+ROOM25_GREEN_HERB1]
    or a
    call nz, loadRoomItemSpriteData
    ld de, room25_00_herb_sprite_3
    ld a, [wRoomsItemsFlags+ROOM25_BLUE_HERB]
    or a
    call nz, loadRoomItemSpriteData
    ret


loadMansionRoomItemSprts: ;FB:4568
    ld a, [wRoomCameraId]
    cp a, 1
    jr z, Label3EC574
    cp a, 2
    jr z, Label3EC57F
    ret
Label3EC574: ;FB:4574
    ld de, room26_01_herb_sprite
    ld a, [wRoomsItemsFlags+ROOM26_RED_HERB]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC57F: ;FB:457F
    ld de, room26_02_lighter_sprite
    ld a, [wRoomsItemsFlags+ROOM26_LIGHTER]
    or a
    call nz, loadRoomItemSpriteData
    ld de, room26_02_shells_sprite
    ld a, [wRoomsItemsFlags+ROOM26_SHELLS]
    or a
    call nz, loadRoomItemSpriteData
    ret


loadSmallLibraryItemSprts: ;FB:4594
    ld a, [wRoomCameraId]
    cp a, 3
    jr z, Label3EC59C
    ret
Label3EC59C: ;FB:459C
    ld de, room23_00_botany_book_sprite
    call loadRoomItemSpriteData ; no item flag. TODO: fix
    ret


loadAtticItemSprites: ;FB:45A3
    ld a, [wRoomCameraId]
    cp a, 4
    jr z, Label3EC5AF
    cp a, 5
    jr z, Label3EC5BA
    ret
Label3EC5AF: ;FB:45AF
    ld de, room2C_04_moon_crest_sprite
    ld a, [wRoomsItemsFlags+ROOM2C_MOON_CREST]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC5BA: ;FB:45BA unused screen
    ld de, room2C_05_moon_crest_sprite
    ld a, [wRoomsItemsFlags+ROOM2C_MOON_CREST]
    or a
    call nz, loadRoomItemSpriteData
    ret


loadEastTerraceItemSprites: ;FB:45C5
    ld a, [wRoomCameraId]
    cp a, 2
    jr z, Label3EC5CD
    ret
Label3EC5CD: ;FB:45CD
    ld de, room2F_02_clip_sprite
    ld a, [wRoomsItemsFlags+ROOM2F_CLIP]
    or a
    call nz, loadRoomItemSpriteData
    ret


loadTaxidermyRoomItemSprt: ;FB:45D8
    ld a, [wRoomCameraId]
    cp a, 1
    jr z, Label3EC5E4
    cp a, 3
    jr z, Label3EC5EF
    ret
Label3EC5E4: ;FB:45E4
    ld de, room30_01_file_sprite
    ld a, [wRoomsItemsFlags+ROOM30_NOTHING_ITEM_6]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC5EF: ;FB:45EF
    ld de, room30_03_red_jewel_sprite
    ld a, [wRoomsItemsFlags+ROOM30_RED_JEWEL]
    or a
    call nz, loadRoomItemSpriteData
    ret


loadLibraryItemSprites: ;FB:45FA
    ld a, [wRoomCameraId]
    cp a, 4
    jr z, Label3EC602
    ret
Label3EC602: ;FB:4602
    ld de, room31_04_file_sprite
    ld a, [wRoomsItemsFlags+ROOM31_NOTHING_ITEM_7]
    or a
    call nz, loadRoomItemSpriteData
    ret


loadMaterialsRoomItemSprt: ;FB:460D
    ld a, [wRoomCameraId]
    cp a, 1
    jr z, Label3EC615
    ret
Label3EC615: ;FB:4615
    ld de, room33_01_battery_sprite
    ld a, [wRoomsItemsFlags+ROOM33_COURTYARD_BATTERY]
    or a
    call nz, loadRoomItemSpriteData
    ld de, room33_01_shells_sprite_1
    ld a, [wRoomsItemsFlags+ROOM33_SHELLS1]
    or a
    call nz, loadRoomItemSpriteData
    ld de, room33_01_shells_sprite_2
    ld a, [wRoomsItemsFlags+ROOM33_SHELLS2]
    or a
    call nz, loadRoomItemSpriteData
    ret


loadHelipadLookoutItemSprt: ;FB:4634
    ld a, [wRoomCameraId]
    cp a, 0
    jr z, Label3EC63C
    ret
Label3EC63C: ;FB:463C
    ld de, room34_01_clip_sprite
    ld a, [wRoomsItemsFlags+ROOM34_INK_RIBBON]
    or a
    call nz, loadRoomItemSpriteData
    ret


loadSouthPassageItemSprt: ;FB:4647
    ld a, [wRoomCameraId]
    cp a, 1
    jr z, Label3EC64F
    ret
Label3EC64F: ;FB:464F
    ld de, room3C_01_hex_crank_sprite
    ld a, [wRoomsItemsFlags+ROOM3C_HEX_CRANK]
    or a
    call nz, loadRoomItemSpriteData
    ret


loadDorm001ItemSprite: ;FB:465A
    ld a, [wRoomCameraId]
    cp a, 1
    jr z, Label3EC666
    cp a, 2
    jr z, Label3EC671
    ret
Label3EC666: ;FB:4666
    ld de, room48_01_redbook_sprite
    ld a, [wRoomsItemsFlags+ROOM48_RED_BOOK]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC671: ;FB:4671
    ld de, room48_02_redbook_sprite
    ld a, [wRoomsItemsFlags+ROOM48_RED_BOOK]
    or a
    call nz, loadRoomItemSpriteData
    ret


loadDorm002ItemSprite: ;FB:467C
    ld a, [wRoomCameraId]
    cp a, 3
    jr z, Label3EC688
    cp a, 4
    jr z, Label3EC693
    ret
Label3EC688: ;FB:4688
    ld de, room50_03_file_sprite
    ld a, [wRoomsItemsFlags+ROOM50_NOTHING_ITEM_8]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC693: ;FB:4693
    ld de, room50_04_file_sprite
    ld a, [wRoomsItemsFlags+ROOM50_NOTHING_ITEM_8]
    or a
    call nz, loadRoomItemSpriteData
    ret


loadAquaTankStoreroomItemSprt: ;FB:469E
    ld a, [wRoomCameraId]
    or a ; 0
    jr z, Label3EC6A9
    cp a, 1
    jr z, Label3EC6BB
    ret
Label3EC6A9: ;FB:46A9
    ld de, room57_00_clip_sprite
    ld a, [wRoomsItemsFlags+ROOM57_CLIP1]
    or a
    jp nz, loadRoomItemSpriteData
    ld a, [wRoomsItemsFlags+ROOM57_CLIP2]
    or a
    jp nz, loadRoomItemSpriteData
    ret
Label3EC6BB: ;FB:46BB
    ld de, room57_01_dorm003_key_sprite
    ld a, [wRoomsItemsFlags+ROOM57_DORMITORY_3_KEY]
    or a
    call nz, loadRoomItemSpriteData
    ld de, room57_01_shells_sprite
    ld a, [wRoomsItemsFlags+ROOM57_SHELLS1]
    or a
    jp nz, loadRoomItemSpriteData
    ld a, [wRoomsItemsFlags+ROOM57_SHELLS2]
    or a
    jp nz, loadRoomItemSpriteData
    ret


loadEmergencyTunnelItemSprt: ;FB:46D7
    ld a, [wRoomCameraId]
    cp a, 5
    jr z, Label3EC6DF
    ret
Label3EC6DF: ;FB:46DF
    ld de, room59_05_battery_sprite
    ld a, [wRoomsItemsFlags+ROOM59_LAB_BATTERY]
    or a
    call nz, loadRoomItemSpriteData
    ret


loadOperatingRoomItemSprt: ;FB:46EA
    ld a, [wRoomCameraId]
    cp a, 5
    jr z, Label3EC6F2
    ret
Label3EC6F2: ;FB:46F2
    ld a, [wRoomGasActivatedFlag]
    or a
    ret z
    ld de, room60_05_gas_sprite_frame01
; animate gas sprite
    ld a, [wAnimatedRoomSpritesFrameCounter]
    and a, $0F
    cp a, 8
    jp c, loadRoomItemSpriteData
    ld de, room60_05_gas_sprite_frame02
    jp loadRoomItemSpriteData

loadPaintingsRoomItemSprt: ;FB:470A
    ld a, [wRoomCameraId]
    cp a, 4
    jr z, Label3EC716
    cp a, 5
    jr z, Label3EC721
    ret
Label3EC716: ;FB:4716
    ld de, room6F_04_star_crest_sprite
    ld a, [wRoomsItemsFlags+ROOM6F_STAR_CREST]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC721: ;FB:4721
    ld de, room6F_05_star_crest_sprite
    ld a, [wRoomsItemsFlags+ROOM6F_STAR_CREST]
    or a
    call nz, loadRoomItemSpriteData
    ret


loadEastStoreroomItemSprt: ;FB:472C
    ld a, [wRoomCameraId]
    cp a, 0
    jr z, Label3EC757
    cp a, 1
    jr z, Label3EC738
    ret
Label3EC738: ;FB:4738
    ld de, room70_01_herbicide_sprite
    ld a, [wRoomsItemsFlags+ROOM70_CHEMICAL]
    or a
    call nz, loadRoomItemSpriteData
    ld de, room70_01_first_aid_spray_sprite
    ld a, [wRoomsItemsFlags+ROOM70_F_AID_SPRAY]
    or a
    call nz, loadRoomItemSpriteData
    ld de, room70_01_shells_sprite
    ld a, [wRoomsItemsFlags+ROOM70_SHELLS]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC757: ;FB:4757
    ld de, room70_00_clip_sprite
    ld a, [wRoomsItemsFlags+ROOM70_CLIP]
    or a
    call nz, loadRoomItemSpriteData
    ret
;4762

