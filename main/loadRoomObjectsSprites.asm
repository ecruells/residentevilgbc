
loadRoomSpritesData: ;FB:4000
    ld a, [wRoomId]
    or a ;MAIN_HALL_1F
    jp z, loadMainHallItemSprites
    cp a, DINNING_ROOM_1F
    jp z, loadDinningRoom1FItemSprites
    cp a, SAFE_ROOM
    jp z, loadSafeRoomItemSprites
    cp a, MAP_STATUE_ROOM
    jp z, loadExhibitionRoomItemSprites
    cp a, CORRIDOR_05 ;first zombie
    jp z, loadRestStopCorridorItemSprites
    cp a, MANSION_PLANT_ROOM
    jp z, loadGreenhouseItemSprites
    cp a, PIANO_ROOM
    jp z, loadPianoRoomItemSprites
    cp a, CORRIDOR_08 ;safe room
    jp z, load1FWestStaircaseItemSprites
    cp a, BROKEN_SHOTGUN_ROOM ;$09
    jp z, loadFirearmsRoomItemSprites
    cp a, CORRIDOR_0A ;to mansion bathroom
    jp z, loadNorthEastCorridorItemSprites
    cp a, CORRIDOR_0C ;first cerberus
    jp z, loadLShapedCorridorItemSprites
    cp a, CORRIDOR_0D
    jp z, loadEast1FStairsCorridorItemSprites
    cp a, ZOMBIE_CLOSET_BEDROOM
    jp z, loadKeepersRoomItemSprites
    cp a, ROOM_10
    jp z, loadLargeArtRoomItemSprites
    cp a, BATHROOM
    jp z, loadMansionBathroomItemSprites
    cp a, CORRIDOR_12
    jp z, loadOutdoorAreaItemSprites
    cp a, TIGER_STATUE_ROOM
    jp z, loadTigerStatueRoomItemSprites
    cp a, SQUARE_CRANK_ROOM
    jp z, loadShedItemSprites
    cp a, BIG_MIRROR_ROOM
    jp z, loadMirrorRoomItemSprites
    cp a, SHOTGUN_ROOM
    jp z, loadLivingRoomItemSprites
    cp a, CORRIDOR_1A ;below tomb
    jp z, loadUndergroundPassage1ItemSprts
    cp a, RICHARD_ROOM
    jp z, loadPillarCorridorItemSprites
    cp a, CHIMNEY_2F_MAP_ROOM
    jp z, loadLoungeItemSprites
    cp a, CORRIDOR_20 ;to library
    jp z, load2FElevatorRoomItemSprites
    cp a, CORRIDOR_21 ;to forest corpse room
    jp z, loadEastTerraceHallwayItemSprite
    cp a, CANDLE_ROOM
    jp z, loadSmallDinningRoomItemSprt
    cp a, ARMORS_ROOM
    jp z, loadArmorsRoomItemSprites
    cp a, CORRIDOR_25
    jp z, load2FWesternCorridorItemSprt
    cp a, LIGHTER_BEDROOM
    jp z, loadMansionRoomItemSprts
    cp a, ROOM_28
    jp z, loadSmallLibraryItemSprts
    cp a, YAWM_1_ROOM
    jp z, loadAtticItemSprites
    cp a, FOREST_CORPSE_ROOM
    jp z, loadEastTerraceItemSprites
    cp a, RED_JEWEL_ROOM
    jp z, loadTaxidermyRoomItemSprt
    cp a, LIBRARY
    jp z, loadLibraryItemSprites
    cp a, ROOM_33 ;find mansion battery elevator
    jp z, loadMaterialsRoomItemSprt
    cp a, LIBRARY_ROOM_34 ;heliport view
    jp z, loadHelipadLookoutItemSprt
    cp a, ENRICOS_ROOM
    jp z, loadSouthPassageItemSprt
    cp a, GUARDHOUSE_DORM_001
    jp z, loadDorm001ItemSprite
    cp a, GUARDHOUSE_DORM_002
    jp z, loadDorm002ItemSprite
    cp a, AQUUARIUM_ROOM_57
    jp z, loadAquaTankStoreroomItemSprt
    cp a, CORRIDOR_59
    jp z, loadEmergencyTunnelItemSprt
    cp a, SURGERY_MORGUE_ROOM
    jp z, loadOperatingRoomItemSprt
    cp a, PAINTINGS_ROOM
    jp z, loadPaintingsRoomItemSprt
    cp a, CHEMICAL_SAFE_ROOM
    jp z, loadEastStoreroomItemSprt
    ret

loadMainHallItemSprites: ;FB:40DF
    ld a, [wRoomScreen]
    cp a, $01
    jr z, loadMainHallPillarsScrn01
    cp a, $02
    jr z, loadMainHallPillarsScrn02
    cp a, $05
    jr z, Label3EC12D
    cp a, $06
    jr z, Label3EC146
    ret
loadMainHallPillarsScrn01: ;FB:40F3
    ld de, main_hall_pillar_02_oam ;$4762
    call loadRoomItemSpriteData
    ld de, main_hall_pillar_01_oam ;$476C
    call loadRoomItemSpriteData
    ld de, room00_01_handgun_sprite_oam ;$47DA
    ld a, [wTriggerHandgunMainHall]
    or a
    call nz, loadRoomItemSpriteData
    ret
loadMainHallPillarsScrn02: ;FB:410A
    ld de, main_hall_pillar_07_oam ;$4776
    call loadRoomItemSpriteData
    ld de, main_hall_pillar_10_oam ;$4780
    call loadRoomItemSpriteData
    ld de, main_hall_pillar_03_oam ;$478A
    call loadRoomItemSpriteData
    ld de, main_hall_pillar_11_oam ;$4794
    call loadRoomItemSpriteData
    ld de, room00_02_handgun_sprite_oam ;$47E4
    ld a, [wTriggerHandgunMainHall]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC12D: ;FB:412D
    ld de, main_hall_pillar_09_oam ;$47B2
    call loadRoomItemSpriteData
    ld de, main_hall_pillar_08_oam ;$47BC
    call loadRoomItemSpriteData
    ld de, main_hall_pillar_04_oam ;$47C6
    call loadRoomItemSpriteData
    ld de, main_hall_pillar_12_oam ;$47D0
    call loadRoomItemSpriteData
    ret
Label3EC146: ;FB:4146
    ld de, main_hall_pillar_05_oam ;$479E
    call loadRoomItemSpriteData
    ld de, main_hall_pillar_06_oam ;$47A8
    call loadRoomItemSpriteData
    ret


loadDinningRoom1FItemSprites: ;FB:4153
    ld a, [wRoomScreen]
    cp a, $02
    jr z, Label3EC16B
    cp a, $03
    jr z, Label3EC185
    cp a, $04
    jr z, Label3EC195
    cp a, $05
    jr z, Label3EC1A0
    cp a, $06
    jr z, Label3EC1B0
    ret
Label3EC16B: ;FB:416B
    ld de, room01_02_emblem_oam ;$47EE
    ld a, [wTriggerGoldenShieldDRoom]
    ld c, a
    ld a, [wDinningRoomGoldEmblemPlaced]
    add a, c
    or a
    call nz, loadRoomItemSpriteData
    ld de, room01_02_jewel_sprite_oam ;$4816
    ld a, [wTriggerJewelDinningRoom]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC185: ;FB:4185
    ld de, room01_03_emblem_sprite_oam ;$47F8
    ld a, [wTriggerGoldenShieldDRoom]
    ld c, a
    ld a, [wDinningRoomGoldEmblemPlaced]
    add a, c
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC195: ;FB:4195
    ld de, room01_03_jewel_sprite_oam ;$4820
    ld a, [wTriggerJewelDinningRoom]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC1A0: ;FB:41A0
    ld de, room01_05_shield_key_sprite_oam ;$480C
    ld a, [wDinningRoomShieldKey]
    ld c, a
    ld a, [wDinningRoomGoldEmblemPlaced]
    add a, c
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC1B0: ;FB:41B0
    ld de, room01_06_emblem_sprite_oam ;$4802
    ld a, [wTriggerGoldenShieldDRoom]
    ld c, a
    ld a, [wDinningRoomGoldEmblemPlaced]
    add a, c
    or a
    call nz, loadRoomItemSpriteData
    ret


loadSafeRoomItemSprites: ;FB:41C0
    ld a, [wRoomScreen]
    or a ;$00
    jr z, Label3EC1D3
    cp a, $01
    jr z, Label3EC1DE
    cp a, $03
    jr z, Label3EC1DF
    cp a, $04
    jr z, Label3EC1EA
    ret
Label3EC1D3: ;FB:41D3
    ld de, room02_00_serum_sprite_oam ;$483E
    ld a, [wSafeRoomSerum]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC1DE: ;FB:41DE
    ret
Label3EC1DF: ;FB:41DF
    ld de, room02_03_serum_sprite_oam ;$4848
    ld a, [wSafeRoomSerum]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC1EA: ;FB:41EA
    ret


loadExhibitionRoomItemSprites: ;FB:41EB
    ld a, [wRoomScreen]
    cp a, $02
    jr z, Label3EC1F7
    cp a, $05
    jr z, Label3EC202
    ret
Label3EC1F7: ;FB:41F7
    ld de, room04_02_map_sprite_oam ;$4852
    ld a, [wTriggerMansion1FMap]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC202: ;FB:4202
    ld de, room04_05_ink_ribbon_sprite_oam ;$485C
    ld a, [wExhibitionRoomInkRibbon]
    or a
    call nz, loadRoomItemSpriteData
    ret

loadRestStopCorridorItemSprites: ;FB:420D
    ld a, [wRoomScreen]
    cp a, $03
    jr z, Label3EC219
    cp a, $04
    jr z, Label3EC220
    ret
Label3EC219: ;FB:4219
    ld de, room05_03_lamp_sprite_oam ;$4866
    call loadRoomItemSpriteData
    ret
Label3EC220: ;FB:4220
    ld a, [wKennethClip1]
    or a
    jr nz, Label3EC22B
    ld a, [wKennethClip2]
    or a
    ret z
Label3EC22B
    ret

loadGreenhouseItemSprites: ;FB:422C
    ld a, [wRoomScreen]
    cp a, $02
    jr z, Label3EC23C
    cp a, $03
    jr z, Label3EC243
    cp a, $05
    jr z, Label3EC250
    ret
Label3EC23C: ;FB:423C
    ld de, room06_02_herb_sprite_oam ;$4870
    call loadRoomItemSpriteData
    ret
Label3EC243: ;FB:4243
    ld de, room06_03_herb_sprite_1_oam ;$487A not pickable herb %fix
    call loadRoomItemSpriteData
    ld de, room06_03_herb_sprite_2_oam ;$4884 nor pickable herb
    call loadRoomItemSpriteData
    ret
Label3EC250: ;FB:4250
    ld de, room06_05_armor_key_sprite_oam ;$488E
    ld a, [wGreenhouseArmorKey]
    or a
    call nz, loadRoomItemSpriteData
    ret

loadPianoRoomItemSprites: ;FB:425B
    ld a, [wRoomScreen]
    cp a, $04
    jr z, Label3EC263
    ret
Label3EC263: ;FB:4263
    ld de, room07_04_emblem_sprite_oam ;$4898
    ld a, [wPianoRoomGoldEmblemTrigger]
    ld c, a
    ld a, [wPianoRoomWoodEmblemTrigger]
    add a, c
    or a
    call nz, loadRoomItemSpriteData
    ret

load1FWestStaircaseItemSprites: ;FB:4273
    ret

loadFirearmsRoomItemSprites: ;FB:4274
    ld a, [wRoomScreen]
    cp a, $02
    jr z, Label3EC280
    cp a, $03
    jr z, Label3EC295
    ret
Label3EC280: ;FB:4280
    ld de, room09_02_broken_shotgun_sprite_oam ;$48A2
    ld a, [wGreenhouseArmorKey] ;it should be broken shotgun taken var?? %fix
    or a
    call nz, loadRoomItemSpriteData
    ld de, room09_02_clip_sprite_oam ;$48AC
    ld a, [wFirearmsClip]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC295: ;FB:4295
    ld de, room_09_03_desk_shells_sprite_oam ;$48B6 doesnt show anything %fix
    ld a, [wFirearmsDeskShells]
    or a
    call nz, loadRoomItemSpriteData
    ret

loadNorthEastCorridorItemSprites: ;FB:42A0
    ld a, [wRoomScreen]
    cp a, $01
    jr z, Label3EC2A8
    ret
Label3EC2A8: ;FB:42A8
    ld de, room0A_01_herb_sprite_oam ;$48C0
    ld a, [wNorthEastCorridorHerb]
    or a
    call nz, loadRoomItemSpriteData
    ret

loadLShapedCorridorItemSprites: ;FB:42B3
    ld a, [wRoomScreen]
    cp a, $02
    jr z, Label3EC2BB
    ret
Label3EC2BB: ;FB:42BB
    ld de, room0C_02_clip_sprite_oam ;$48CA
    ld a, [wLShapedCoddidorClip]
    or a
    call nz, loadRoomItemSpriteData
    ret

loadEast1FStairsCorridorItemSprites: ;FB:42C6
    ld a, [wRoomScreen]
    cp a, $02
    jr z, Label3EC2D2
    cp a, $03
    jr z, Label3EC2DD
    ret
Label3EC2D2: ;FB:42D2
    ld de, room0D_02_herb_sprite_oam ;$48D4
    ld a, [wEastStairsCorridor1FHerb]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC2DD: ;FB:42DD
    ld de, room0D_03_herb_sprite_oam ;$48DE
    ld a, [wEastStairsCorridor1FHerb]
    or a
    call nz, loadRoomItemSpriteData
    ret

loadKeepersRoomItemSprites: ;FB:42E8
    ld a, [wRoomScreen]
    or a ;$00
    jr z, Label3EC2FB
    cp a, $01
    jr z, Label3EC306
    cp a, $02
    jr z, Label3EC311
    cp a, $03
    jr z, Label3EC326
    ret
Label3EC2FB: ;FB:42FB
    ld de, room_0E_00_clip_sprite_oam ;$4906
    ld a, [wKeepersRoomClip]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC306: ;FB:4306
    ld de, room_0E_01_clip_sprite_oam ;$48FC
    ld a, [wKeepersRoomClip]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC311: ;FB:4311
    ld de, room0E_02_shells_sprite_oam ;$48E8
    ld a, [wKeepersRoomShells]
    or a
    call nz, loadRoomItemSpriteData
    ld de, room_0E_02_file_sprite_oam ;$4910
    ld a, [wKeepersRoomFile]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC326: ;FB:4326
    ld de, room0E_03_shells_sprite_oam ;$48F2
    ld a, [wKeepersRoomShells]
    or a
    call nz, loadRoomItemSpriteData
    ld de, room_0E_03_file_sprite_oam ;$491A
    ld a, [wKeepersRoomFile]
    or a
    call nz, loadRoomItemSpriteData
    ret
;433B

loadLargeArtRoomItemSprites: ;FB:433B
    ld a, [wRoomScreen]
    cp a, $03
    jr z, Label3EC343
    ret
Label3EC343: ;FB:4343
    ld de, room10_03_desk_shell_sprite_oam ;$4924
    ld a, [wKeepersRoomClip] ;%fix bad var condition
    or a
    call nz, loadRoomItemSpriteData
    ret

loadMansionBathroomItemSprites: ;FB:434E
    ld a, [wRoomScreen]
    cp a, $03
    jr z, Label3EC356
    ret
Label3EC356: ;FB:4356
    ld de, room_11_03_small_key_sprite_oam ;$492E
    ld a, [wKeepersRoomFile] ;%fix bad var condition
    or a
    call nz, loadRoomItemSpriteData
    ret

loadOutdoorAreaItemSprites: ;FB:4361
    ld a, [wRoomScreen]
    cp a, $02
    jr z, Label3EC36D
    cp a, $03
    jr z, Label3EC37A
    ret
Label3EC36D: ;FB:436D
    ld de, room12_02_herb_sprite_1_oam ;$4942 ;no var, infinite herbs %fix
    call loadRoomItemSpriteData
    ld de, room12_02_herb_sprite_2_oam ;$4956 ;no var, infinite herbs %fix
    call loadRoomItemSpriteData
    ret
Label3EC37A: ;FB:437A
    ld de, room12_03_herb_sprite_1_oam ;$4938
    call loadRoomItemSpriteData
    ld de, room12_03_herb_sprite_2_oam ;$494C
    call loadRoomItemSpriteData
    ret


loadTigerStatueRoomItemSprites: ;FB:4387
    ld a, [wRoomScreen]
    cp a, $00
    jr z, Label3EC38F
    ret
Label3EC38F: ;FB:438F
    ld de, room14_00_wind_crest_sprite_oam ;$4960
    ld a, [wBlueJewelPlaced]
    or a
    call nz, loadRoomItemSpriteData
    ld de, room14_00_colt_phyton_sprite_oam ;$496A
    ld a, [wRedJewelPlaced]
    or a
    call nz, loadRoomItemSpriteData
    ret


loadShedItemSprites: ;FB:43A4
    ld a, [wRoomScreen]
    or a ;$00
    jr z, Label3EC3AF
    cp a, $02
    jr z, Label3EC3BA
    ret
Label3EC3AF: ;FB:43AF
    ld de, room16_00_small_key_sprite_oam ;$497E
    ld a, [wShedSmallKey]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC3BA: ;FB:43BA
    ld de, room16_02_square_crank_sprite_oam ;$4974
    ld a, [wShedSquareCrank]
    or a
    call nz, loadRoomItemSpriteData
    ret

loadMirrorRoomItemSprites: ;FB:43C5
    ld a, [wRoomScreen]
    or a ;$00
    jr z, Label3EC3D0
    cp a, $01
    jr z, Label3EC3E2
    ret
Label3EC3D0: ;FB:43D0
    ld a, [wMirrorRoomHerb]
    or a
    jr nz, Label3EC3DB
    ld a, [wMirrorRoomInkRibbon]
    or a
    ret z
Label3EC3DB
    ld de, room17_00_herb_sprite_oam ;$4988
    call loadRoomItemSpriteData
    ret
Label3EC3E2: ;FB:43E2
    ld de, room17_01_ink_ribbon_sprite_oam ;$4992 %fix misplaces
    ld a, [wMirrorRoomInkRibbon]
    or a
    call nz, loadRoomItemSpriteData
    ret


loadLivingRoomItemSprites: ;FB:43ED
    ld a, [wRoomScreen]
    cp a, $01
    jr z, Label3EC3F5
    ret
Label3EC3F5: ;FB:43F5
    ld de, room18_01_shotgun_sprite_oam ;$499C
    ld a, [wLivingRoomShotgunPlaced]
    or a
    jr nz, Label3EC403
    ld a, [wBrokenShotgunPlaced]
    or a
    ret z
Label3EC403
    call nz, loadRoomItemSpriteData
    ret


loadUndergroundPassage1ItemSprts: ;FB:4407
    ld a, [wRoomScreen]
    cp a, $03
    jr z, Label3EC40F
    ret
Label3EC40F: ;FB:440F
    ld de, room1A_03_shells_sprite_oam ;$49A6
    call loadRoomItemSpriteData ;no item var %fix
    ret


loadPillarCorridorItemSprites: ;FB:4416
    ld a, [wRoomScreen]
    cp a, $02
    jr z, Label3EC41E
    ret
Label3EC41E: ;FB:441E
    ld de, room1E_02_herb_sprite_oam ;$49B0
    call loadRoomItemSpriteData ;no item var %fix
    ret


loadLoungeItemSprites: ;FB:4425
    ld a, [wRoomScreen]
    cp a, $01
    jr z, Label3EC431
    cp a, $02
    jr z, Label3EC46D
    ret
Label3EC431: ;FB:4431
    ld de, room1F_01_2F_map_sprite_oam ;$49BA
    ld a, [wFireplace2FMapEnabled]
    or a
    call nz, loadRoomItemSpriteData
    ld de, room1F_01_herb_sprite_oam ;$49CE
    ld a, [wLoungeHerb]
    or a
    call nz, loadRoomItemSpriteData
    ld a, [wLoungeFireplaceLitted]
    or a
    ret z
    ld de, room1F_01_fireplace_fire_frame_1_oam ;$49D8
    ld a, [wAnimatedRoomSpritesFrameRate]
    and a, $1F
    cp a, $08
    jp c, loadRoomItemSpriteData
    ld de, room1F_01_fireplace_fire_frame_2_oam ;$49E2
    cp a, $10
    jp c, loadRoomItemSpriteData
    ld de, room1F_01_fireplace_fire_frame_3_oam ;$49EC
    cp a, $18
    jp c, loadRoomItemSpriteData
    ld de, room1F_01_fireplace_fire_frame_4_oam ;$49F6
    jp loadRoomItemSpriteData
Label3EC46D
    ld de, room1F_02_2F_map_sprite_oam ;$49C4
    ld a, [wFireplace2FMapEnabled]
    or a
    call nz, loadRoomItemSpriteData
    ld a, [wLoungeFireplaceLitted]
    or a
    ret z
    ld de, room1F_02_fireplace_fire_frame_1_oam ;$4A00
    ld a, [wAnimatedRoomSpritesFrameRate]
    and a, $1F
    cp a, $08
    jp c, loadRoomItemSpriteData
    ld de, room1F_02_fireplace_fire_frame_2_oam ;$4A0A
    cp a, $10
    jp c, loadRoomItemSpriteData
    ld de, room1F_02_fireplace_fire_frame_3_oam ;$4A14
    cp a, $18
    jp c, loadRoomItemSpriteData
    ld de, room1F_02_fireplace_fire_frame_4_oam ;$4A1E
    jp loadRoomItemSpriteData


load2FElevatorRoomItemSprites: ;FB:449F
    ld a, [wRoomScreen]
    cp a, $20 ;typo, it should be screen $02 %fix
    jr z, Label3EC4A7
    ret
Label3EC4A7: ;FB:44A7
    ld de, room20_02_herb_sprite_oam ;$4A28
    call loadRoomItemSpriteData
    ret


loadEastTerraceHallwayItemSprite: ;FB:44AE
    ld a, [wRoomScreen]
    or a ;$00
    jr z, Label3EC4B5
    ret
Label3EC4B5: ;FB:44B5
    ld de, room21_00_small_key_sprite_oam ;$4A32
    ld a, [wEastTerraceHallwaySmallKey]
    or a
    call nz, loadRoomItemSpriteData
    ret


loadSmallDinningRoomItemSprt: ;FB:44C0
    ld a, [wRoomScreen]
    or a ;$00
    jr z, Label3EC4CB
    cp a, $01
    jr z, Label3EC4DB
    ret
Label3EC4CB: ;FB:44CB
    ld de, room22_00_candle_sprite_oam ;$4B90
    ld a, [wCandleRoomLight]
    or a
    jr z, Label3EC4D7
    ld de, room22_00_litted_candle_sprite_oam ;$4B9A
Label3EC4D7
    call loadRoomItemSpriteData
    ret
Label3EC4DB: ;FB:44DB
    ld de, room22_01_candle_sprite_oam ;$4BA4
    ld a, [wCandleRoomLight]
    or a
    jr z, Label3EC4E7
    ld de, room22_01_litted_candle_sprite_oam ;$4BAE
Label3EC4E7
    call loadRoomItemSpriteData
    ret


loadArmorsRoomItemSprites: ;FB:44EB
    ld a, [wRoomScreen]
    or a ;$00
    jr z, Label3EC4FA
    cp a, $01
    jr z, Label3EC512
    cp a, $02
    jr z, Label3EC52A
    ret
Label3EC4FA: ;FB:44FA
    ld a, [wPoisonGasActivationByte]
    or a
    ret z
    ld de, room23_00_gas_sprite_frame_1_oam ;$4A3C
    ld a, [wAnimatedRoomSpritesFrameRate]
    and a, $0F
    cp a, $08
    jp c, loadRoomItemSpriteData
    ld de, room23_00_gas_sprite_frame_2_oam ;$4A46
    jp loadRoomItemSpriteData
Label3EC512
    ld a, [wPoisonGasActivationByte]
    or a
    ret z
    ld de, room23_01_gas_sprite_frame_1_oam ;$4A50
    ld a, [wAnimatedRoomSpritesFrameRate]
    and a, $0F
    cp a, $08
    jp c, loadRoomItemSpriteData
    ld de, room23_01_gas_sprite_frame_2_oam ;$4A5A
    jp loadRoomItemSpriteData
Label3EC52A
    ld a, [wPoisonGasActivationByte]
    or a
    ret z
    ld de, room23_02_gas_sprite_frame_1_oam ;$4A64
    ld a, [wAnimatedRoomSpritesFrameRate]
    and a, $0F
    cp a, $08
    jp c, loadRoomItemSpriteData
    ld de, room23_02_gas_sprite_frame_2_oam ;$4A6E
    jp loadRoomItemSpriteData

load2FWesternCorridorItemSprt: ;FB:4542
    ld a, [wRoomScreen]
    or a ;$00
    jr z, Label3EC549
    ret
Label3EC549: ;FB:4549
    ld de, room25_00_herb_1_sprite_oam ;$4A8C
    ld a, [w2FWesternCorridorHerb1]
    or a
    call nz, loadRoomItemSpriteData
    ld de, room25_00_herb_2_sprite_oam ;$4A96
    ld a, [w2FWesternCorridorHerb2]
    or a
    call nz, loadRoomItemSpriteData
    ld de, room25_00_herb_3_sprite_oam ;$4AA0
    ld a, [w2FWesternCorridorHerb3]
    or a
    call nz, loadRoomItemSpriteData
    ret


loadMansionRoomItemSprts: ;FB:4568
    ld a, [wRoomScreen]
    cp a, $01
    jr z, Label3EC574
    cp a, $02
    jr z, Label3EC57F
    ret
Label3EC574: ;FB:4574
    ld de, room26_01_herb_sprite_oam ;$4ABE
    ld a, [wBedroomHerb]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC57F: ;FB:457F
    ld de, room26_02_lighter_sprite_oam ;$4AAA
    ld a, [wBedroomLighter]
    or a
    call nz, loadRoomItemSpriteData
    ld de, room26_02_shells_sprite_oam ;$4AB4
    ld a, [wBedroomShells]
    or a
    call nz, loadRoomItemSpriteData
    ret


loadSmallLibraryItemSprts: ;FB:4594
    ld a, [wRoomScreen]
    cp a, $03
    jr z, Label3EC59C
    ret
Label3EC59C: ;FB:459C
    ld de, room23_00_botany_book_sprite_oam ;$4AC8
    call loadRoomItemSpriteData ;no item var %fix
    ret


loadAtticItemSprites: ;FB:45A3
    ld a, [wRoomScreen]
    cp a, $04
    jr z, Label3EC5AF
    cp a, $05
    jr z, Label3EC5BA
    ret
Label3EC5AF: ;FB:45AF
    ld de, room2C_04_moon_crest_sprite_oam ;$4AD2
    ld a, [wAtticMoonCrest]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC5BA: ;FB:45BA unused screen
    ld de, room2C_05_moon_crest_sprite_oam ;$4ADC
    ld a, [wAtticMoonCrest]
    or a
    call nz, loadRoomItemSpriteData
    ret


loadEastTerraceItemSprites: ;FB:45C5
    ld a, [wRoomScreen]
    cp a, $02
    jr z, Label3EC5CD
    ret
Label3EC5CD: ;FB:45CD
    ld de, room2F_02_clip_sprite_oam ;$4AE6
    ld a, [wEastTerraceClip]
    or a
    call nz, loadRoomItemSpriteData
    ret


loadTaxidermyRoomItemSprt: ;FB:45D8
    ld a, [wRoomScreen]
    cp a, $01
    jr z, Label3EC5E4
    cp a, $03
    jr z, Label3EC5EF
    ret
Label3EC5E4: ;FB:45E4
    ld de, room30_01_item_sprite_oam ;$4AFA
    ld a, [wTaxidermyRoomDroppedItem]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC5EF: ;FB:45EF
    ld de, room30_03_red_jewel_sprite_oam ;$4AF0
    ld a, [wTaxidermyRoomRedJewel]
    or a
    call nz, loadRoomItemSpriteData
    ret


loadLibraryItemSprites: ;FB:45FA
    ld a, [wRoomScreen]
    cp a, $04
    jr z, Label3EC602
    ret
Label3EC602: ;FB:4602
    ld de, room31_04_file_sprite_oam ;$4B04
    ld a, [wLibraryFile]
    or a
    call nz, loadRoomItemSpriteData
    ret


loadMaterialsRoomItemSprt: ;FB:460D
    ld a, [wRoomScreen]
    cp a, $01
    jr z, Label3EC615
    ret
Label3EC615: ;FB:4615
    ld de, room33_01_battery_sprite_oam ;$4B0E
    ld a, [wMaterialsRoomBattery]
    or a
    call nz, loadRoomItemSpriteData
    ld de, room33_01_shells_1_sprite_oam ;$4B18
    ld a, [wMaterialsRoomShells1]
    or a
    call nz, loadRoomItemSpriteData
    ld de, room33_01_shells_2_sprite_oam ;$4B22
    ld a, [wMaterialsRoomShells2]
    or a
    call nz, loadRoomItemSpriteData
    ret


loadHelipadLookoutItemSprt: ;FB:4634
    ld a, [wRoomScreen]
    cp a, $00
    jr z, Label3EC63C
    ret
Label3EC63C: ;FB:463C
    ld de, room34_01_clip_sprite_oam ;$4B2C
    ld a, [wHelipadLookoutRoomClip]
    or a
    call nz, loadRoomItemSpriteData
    ret


loadSouthPassageItemSprt: ;FB:4647
    ld a, [wRoomScreen]
    cp a, $01
    jr z, Label3EC64F
    ret
Label3EC64F: ;FB:464F
    ld de, room3C_01_hex_crank_sprite_oam ;$4B36
    ld a, [wSouthPassageHexCrank]
    or a
    call nz, loadRoomItemSpriteData
    ret


loadDorm001ItemSprite: ;FB:465A
    ld a, [wRoomScreen]
    cp a, $01
    jr z, Label3EC666
    cp a, $02
    jr z, Label3EC671
    ret
Label3EC666: ;FB:4666
    ld de, room48_01_redbook_sprite_oam ;$4B40
    ld a, [wDorm001Redbook]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC671: ;FB:4671
    ld de, room48_02_redbook_sprite_oam ;$4B4A
    ld a, [wDorm001Redbook]
    or a
    call nz, loadRoomItemSpriteData
    ret


loadDorm002ItemSprite: ;FB:467C
    ld a, [wRoomScreen]
    cp a, $03
    jr z, Label3EC688
    cp a, $04
    jr z, Label3EC693
    ret
Label3EC688: ;FB:4688
    ld de, room50_03_file_sprite_oam ;$4B54
    ld a, [wDorm002File]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC693: ;FB:4693
    ld de, room50_04_file_sprite_oam ;$4B5E
    ld a, [wDorm002File]
    or a
    call nz, loadRoomItemSpriteData
    ret


loadAquaTankStoreroomItemSprt: ;FB:469E
    ld a, [wRoomScreen]
    or a ;$00
    jr z, Label3EC6A9
    cp a, $01
    jr z, Label3EC6BB
    ret
Label3EC6A9: ;FB:46A9
    ld de, room57_00_clip_sprite_oam ;$4B68
    ld a, [wAquaTankStoreroomClip1]
    or a
    jp nz, loadRoomItemSpriteData
    ld a, [wAquaTankStoreroomClip2]
    or a
    jp nz, loadRoomItemSpriteData
    ret
Label3EC6BB: ;FB:46BB
    ld de, room57_01_dorm003_key_sprite_oam ;$4B7C
    ld a, [wAquaTankStoreroomDorm03Key]
    or a
    call nz, loadRoomItemSpriteData
    ld de, room57_01_shell_sprite_oam ;$4B72
    ld a, [wAquaTankStoreroomShell1]
    or a
    jp nz, loadRoomItemSpriteData
    ld a, [wAquaTankStoreroomShell2]
    or a
    jp nz, loadRoomItemSpriteData
    ret


loadEmergencyTunnelItemSprt: ;FB:46D7
    ld a, [wRoomScreen]
    cp a, $05
    jr z, Label3EC6DF
    ret
Label3EC6DF: ;FB:46DF
    ld de, room59_05_battery_sprite_oam ;$4B86
    ld a, [wEmergencyTunnelBattery]
    or a
    call nz, loadRoomItemSpriteData
    ret


loadOperatingRoomItemSprt: ;FB:46EA
    ld a, [wRoomScreen]
    cp a, $05
    jr z, Label3EC6F2
    ret
Label3EC6F2: ;FB:46F2
    ld a, [wPoisonGasActivationByte]
    or a
    ret z
    ld de, room60_05_gas_sprite_frame_1_oam ;$4A78
    ld a, [wAnimatedRoomSpritesFrameRate]
    and a, $0F
    cp a, $08
    jp c, loadRoomItemSpriteData
    ld de, room60_05_gas_sprite_frame_2_oam ;$4A82
    jp loadRoomItemSpriteData

loadPaintingsRoomItemSprt: ;FB:470A
    ld a, [wRoomScreen]
    cp a, $04
    jr z, Label3EC716
    cp a, $05
    jr z, Label3EC721
    ret
Label3EC716: ;FB:4716
    ld de, room6F_04_star_crest_sprite_oam ;$4BB8
    ld a, [wPaintingsRoomStarCrest]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC721: ;FB:4721
    ld de, room6F_05_star_crest_sprite_oam ;$4BC2
    ld a, [wPaintingsRoomStarCrest]
    or a
    call nz, loadRoomItemSpriteData
    ret


loadEastStoreroomItemSprt: ;FB:472C
    ld a, [wRoomScreen]
    cp a, $00
    jr z, Label3EC757
    cp a, $01
    jr z, Label3EC738
    ret
Label3EC738: ;FB:4738
    ld de, room70_01_herbicide_sprite_oam ;$4BCC
    ld a, [wEastStoreroomHerbicide]
    or a
    call nz, loadRoomItemSpriteData
    ld de, room70_01_f_aid_spray_sprite_oam ;$4BD6
    ld a, [wEastStoreroomFAidSpray]
    or a
    call nz, loadRoomItemSpriteData
    ld de, room70_01_shells_sprite_oam ;$4BE0
    ld a, [wEastStoreroomShells]
    or a
    call nz, loadRoomItemSpriteData
    ret
Label3EC757: ;FB:4757
    ld de, room70_00_clip_sprite_oam ;$4BEA
    ld a, [wEastStoreroomClip]
    or a
    call nz, loadRoomItemSpriteData
    ret
;4762

INCLUDE "main/RoomsSpritesDataTable.asm"

;4BF4

