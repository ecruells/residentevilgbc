	;priority Y-sort
	;Sprite Id ($04)
	;$00
	;X-pos
	;Y-pos
	;sprite width
	;sprite height
	;sprite bank
	;sprite data pointer low
	;sprite data pointer high

main_hall_pillar_02_oam: ;FB:4762
	db $65
	db $04, $00
	db $7D, $3B
	db $08, $20
	dbw BANK(main_hall_pillar_02), main_hall_pillar_02

main_hall_pillar_01_oam: ;476C
	db $6C
	db $04, $00
	db $68, $39
	db $08, $20
	dbw BANK(main_hall_pillar_01), main_hall_pillar_01

main_hall_pillar_07_oam: ;4776
	db $34
	db $04, $00
	db $7F, $3F
	db $10, $30
	dbw BANK(main_hall_pillar_07), main_hall_pillar_07

main_hall_pillar_10_oam: ;4780
	db $41
	db $04, $00
	db $67, $46
	db $10, $20
	dbw BANK(main_hall_pillar_10), main_hall_pillar_10

main_hall_pillar_03_oam: ;478A
	db $50
	db $04, $00
	db $58, $40
	db $08, $20
	dbw BANK(main_hall_pillar_03), main_hall_pillar_03

main_hall_pillar_11_oam: ;4794
	db $42
	db $04, $00
	db $43, $4A
	db $10, $20
	dbw BANK(main_hall_pillar_11), main_hall_pillar_11

main_hall_pillar_05_oam: ;479E
	db $68
	db $04, $00
	db $38, $3D
	db $08, $20
	dbw BANK(main_hall_pillar_05), main_hall_pillar_05

main_hall_pillar_06_oam: ;47A8
	db $6C
	db $04, $00
	db $4D, $3C
	db $08, $20
	dbw BANK(main_hall_pillar_06), main_hall_pillar_06

main_hall_pillar_09_oam: ;47B2
	db $25
	db $04, $00
	db $08, $49
	db $18, $30
	dbw BANK(main_hall_pillar_09), main_hall_pillar_09

main_hall_pillar_08_oam: ;47BC
	db $30
	db $04, $00
	db $5D, $3F
	db $10, $30
	dbw BANK(main_hall_pillar_08), main_hall_pillar_08

main_hall_pillar_04_oam: ;47C6
	db $4A
	db $04, $00
	db $48, $45
	db $08, $20
	dbw BANK(main_hall_pillar_04), main_hall_pillar_04

main_hall_pillar_12_oam: ;47D0
	db $36
	db $04, $00
	db $31, $4B
	db $10, $20
	dbw BANK(main_hall_pillar_12), main_hall_pillar_12

room00_01_handgun_sprite_oam: ;47DA
	db $FE
	db $03, $00
	db $52, $5C
	db $08, $10
	dbw BANK(room_item_sprite_11), room_item_sprite_11

room00_02_handgun_sprite_oam: ;47E4
	db $FE
	db $03, $00
	db $40, $70
	db $08, $10
	dbw BANK(room_item_sprite_03), room_item_sprite_03

room01_02_emblem_oam: ;47EE
	db $FE
	db $03, $00
	db $4E, $59
	db $08, $10
	dbw BANK(room_item_sprite_10), room_item_sprite_10 ;emblem little

room01_03_emblem_sprite_oam: ;47F8
	db $FE
	db $03, $00
	db $54, $34
	db $10, $10
	dbw BANK(room_item_sprite_01), room_item_sprite_01 ;emblem medium

room01_06_emblem_sprite_oam: ;4802
	db $FE
	db $03, $00
	db $4F, $4F
	db $10, $10
	dbw BANK(room_item_sprite_09), room_item_sprite_09 ;emblem big

room01_05_shield_key_sprite_oam: ;480C
	db $FE
	db $03, $00
	db $51, $49
	db $08, $10
	dbw BANK(room_item_sprite_12), room_item_sprite_12 ;shield key

room01_02_jewel_sprite_oam: ;4816
	db $FE
	db $01, $00
	db $28, $80
	db $08, $10
	dbw BANK(room_item_sprite_05), room_item_sprite_05

room01_03_jewel_sprite_oam: ;4820
	db $FE
	db $01, $00
	db $50, $76
	db $08, $10
	dbw BANK(room_item_sprite_05), room_item_sprite_05

room_item_sprite_05_482A_oam: ;482A
	db $FE
	db $00, $00
	db $70, $60
	db $08, $10
	dbw BANK(room_item_sprite_05), room_item_sprite_05

room_item_sprite_05_4834_oam: ;4834
	db $FE
	db $00, $00
	db $4C, $66
	db $08, $10
	dbw BANK(room_item_sprite_05), room_item_sprite_05

room02_00_serum_sprite_oam: ;483E
	db $FE
	db $03, $00
	db $2A, $4C
	db $08, $10
	dbw BANK(room_item_sprite_13), room_item_sprite_13 ;serum sprite (litle)

room02_03_serum_sprite_oam: ;4848
	db $FE
	db $03, $00
	db $12, $3F
	db $08, $10
	dbw BANK(room_item_sprite_14), room_item_sprite_14 ;serum sprite big

room04_02_map_sprite_oam: ;4852
	db $FE
	db $03, $00
	db $70, $70
	db $10, $10
	dbw BANK(room_item_sprite_02), room_item_sprite_02 ;map 1F sprite

room04_05_ink_ribbon_sprite_oam: ;485C
	db $FE
	db $06, $00
	db $70, $38
	db $08, $10
	dbw BANK(room_item_sprite_05), room_item_sprite_05 ;sphere sprite (ink ribbon)

room05_03_lamp_sprite_oam: ;4866
	db $FE
	db $04, $00
	db $77, $22
	db $10, $40
	dbw BANK(rest_stop_corridor_lamp), rest_stop_corridor_lamp

room06_02_herb_sprite_oam: ;4870
	db $FE
	db $00, $00
	db $2A, $60
	db $08, $10
	dbw BANK(room_item_sprite_04), room_item_sprite_04 ;herb sprite

room06_03_herb_sprite_1_oam: ;487A
	db $FE
	db $00, $00
	db $32, $70
	db $08, $10
	dbw BANK(room_item_sprite_04), room_item_sprite_04

room06_03_herb_sprite_2_oam: ;4884
	db $FE
	db $00, $00
	db $92, $64
	db $08, $10
	dbw BANK(room_item_sprite_04), room_item_sprite_04

room06_05_armor_key_sprite_oam: ;488E
	db $FE
	db $00, $00
	db $5D, $3C
	db $08, $10
	dbw BANK(room_item_sprite_12), room_item_sprite_12 ;key sprite

room07_04_emblem_sprite_oam: ;4898
	db $FE
	db $00, $00
	db $61, $5E
	db $10, $10
	dbw BANK(room_item_sprite_09), room_item_sprite_09

room09_02_broken_shotgun_sprite_oam: ;48A2
	db $FE
	db $00, $00
	db $50, $40
	db $08, $10
	dbw BANK(room_item_sprite_20), room_item_sprite_20 ;broken shotgun sprite

room09_02_clip_sprite_oam: ;48AC
	db $FE
	db $00, $00
	db $7A, $5C
	db $08, $10
	dbw BANK(room_item_sprite_08), room_item_sprite_08 ;clip

room_09_03_desk_shells_sprite_oam: ;48B6
	db $FE
	db $00, $00
	db $4C, $42
	db $10, $10
	dbw BANK(room_item_sprite_16), room_item_sprite_16 ;desk shells

room0A_01_herb_sprite_oam: ;48C0
	db $FE
	db $00, $00
	db $80, $24
	db $08, $10
	dbw BANK(room_item_sprite_04), room_item_sprite_04

room0C_02_clip_sprite_oam: ;48CA
	db $FE
	db $00, $00
	db $6C, $78
	db $08, $10
	dbw BANK(room_item_sprite_08), room_item_sprite_08

room0D_02_herb_sprite_oam: ;48D4
	db $FE
	db $00, $00
	db $5E, $44
	db $08, $10
	dbw BANK(room_item_sprite_04), room_item_sprite_04

room0D_03_herb_sprite_oam: ;48DE
	db $FE
	db $00, $00
	db $2A, $64
	db $08, $10
	dbw BANK(room_item_sprite_04), room_item_sprite_04

room0E_02_shells_sprite_oam: ;48E8
	db $FE
	db $00, $00
	db $7B, $53
	db $10, $10
	dbw BANK(room_item_sprite_16), room_item_sprite_16 ;shell sprite

room0E_03_shells_sprite_oam: ;48F2
	db $FE
	db $00, $00
	db $54, $62
	db $10, $10
	dbw BANK(room_item_sprite_16), room_item_sprite_16

room_0E_01_clip_sprite_oam: ;48FC
	db $FE
	db $00, $00
	db $77, $7C
	db $08, $10
	dbw BANK(room_item_sprite_08), room_item_sprite_08

room_0E_00_clip_sprite_oam: ;4906
	db $FE
	db $00, $00
	db $3B, $7A
	db $08, $10
	dbw BANK(room_item_sprite_08), room_item_sprite_08

room_0E_02_file_sprite_oam: ;4910
	db $FE
	db $00, $00
	db $2C, $6B
	db $08, $10
	dbw BANK(room_item_sprite_07), room_item_sprite_07 ;file sprite

room_0E_03_file_sprite_oam: ;491A
	db $FE
	db $00, $00
	db $3E, $7C
	db $08, $10
	dbw BANK(room_item_sprite_07), room_item_sprite_07

room10_03_desk_shell_sprite_oam: ;4924
	db $FE
	db $00, $00
	db $49, $50
	db $10, $10
	dbw BANK(room_item_sprite_16), room_item_sprite_16

room_11_03_small_key_sprite_oam: ;492E
	db $FE
	db $00, $00
	db $57, $63
	db $08, $10
	dbw BANK(room_item_sprite_12), room_item_sprite_12

room12_03_herb_sprite_1_oam: ;4938
	db $FE
	db $00, $00
	db $81, $54
	db $08, $10
	dbw BANK(room_item_sprite_04), room_item_sprite_04

room12_02_herb_sprite_1_oam: ;4942
	db $FE
	db $00, $00
	db $5E, $5C
	db $08, $10
	dbw BANK(room_item_sprite_04), room_item_sprite_04

room12_03_herb_sprite_2_oam: ;494C
	db $FE
	db $00, $00
	db $3B, $7C
	db $08, $10
	dbw BANK(room_item_sprite_04), room_item_sprite_04

room12_02_herb_sprite_2_oam: ;4956
	db $FE
	db $00, $00
	db $4C, $6F
	db $08, $10
	dbw BANK(room_item_sprite_04), room_item_sprite_04

room14_00_wind_crest_sprite_oam: ;4960
	db $FE
	db $06, $00
	db $62, $34
	db $08, $10
	dbw BANK(room_item_sprite_05), room_item_sprite_05

room14_00_colt_phyton_sprite_oam: ;496A
	db $FE
	db $06, $00
	db $4E, $34
	db $08, $10
	dbw BANK(room_item_sprite_03), room_item_sprite_03 ;colt phyton sprite

room16_02_square_crank_sprite_oam: ;4974
	db $FE
	db $00, $00
	db $54, $33
	db $10, $10
	dbw BANK(room_item_sprite_18), room_item_sprite_18 ;crank sprite

room16_00_small_key_sprite_oam: ;497E
	db $FE
	db $00, $00
	db $85, $87
	db $08, $10
	dbw BANK(room_item_sprite_12), room_item_sprite_12 ;key sprite

room17_00_herb_sprite_oam: ;4988
	db $FE
	db $00, $00
	db $85, $50
	db $08, $10
	dbw BANK(room_item_sprite_04), room_item_sprite_04

room17_01_ink_ribbon_sprite_oam: ;4992
	db $FE
	db $00, $00
	db $4B, $48 ;misplaced %fix
	db $08, $10
	dbw BANK(room_item_sprite_05), room_item_sprite_05 ;sphere sprite

room18_01_shotgun_sprite_oam: ;499C
	db $FE
	db $00, $00
	db $56, $2E
	db $10, $10
	dbw BANK(room_item_sprite_15), room_item_sprite_15; shotgun sprite

room1A_03_shells_sprite_oam: ;49A6
	db $FE
	db $00, $00
	db $5D, $68
	db $10, $10
	dbw BANK(room_item_sprite_16), room_item_sprite_16

room1E_02_herb_sprite_oam: ;49B0
	db $FE
	db $00, $00
	db $45, $5E
	db $08, $10
	dbw BANK(room_item_sprite_04), room_item_sprite_04

room1F_01_2F_map_sprite_oam: ;49BA
	db $FE
	db $00, $00
	db $59, $47
	db $10, $10
	dbw BANK(room_item_sprite_02), room_item_sprite_02 ;map

room1F_02_2F_map_sprite_oam: ;49C4
	db $FE
	db $00, $00
	db $5D, $2C
	db $10, $10
	dbw BANK(room_item_sprite_02), room_item_sprite_02

room1F_01_herb_sprite_oam: ;49CE
	db $FE
	db $00, $00
	db $28, $72
	db $08, $10
	dbw BANK(room_item_sprite_04), room_item_sprite_04

room1F_01_fireplace_fire_frame_1_oam: ;49D8
	db $FE
	db $04, $00
	db $54, $62
	db $10, $10
	dbw BANK(room_item_sprite_25), room_item_sprite_25 ;fireplace fire sprite 1

room1F_01_fireplace_fire_frame_2_oam: ;49E2
	db $FE
	db $04, $00
	db $54, $62
	db $10, $10
	dbw BANK(room_item_sprite_26), room_item_sprite_26 ;fireplace fire sprite 2

room1F_01_fireplace_fire_frame_3_oam: ;49EC
	db $FE
	db $04, $00
	db $54, $62
	db $10, $10
	dbw BANK(room_item_sprite_27), room_item_sprite_27 ;fireplace fire sprite 3

room1F_01_fireplace_fire_frame_4_oam: ;49F6
	db $FE
	db $04, $00
	db $54, $62
	db $10, $10
	dbw BANK(room_item_sprite_28), room_item_sprite_28 ;fireplace fire sprite 4

room1F_02_fireplace_fire_frame_1_oam: ;4A00
	db $FE
	db $04, $00
	db $56, $6C
	db $10, $10
	dbw BANK(room_item_sprite_29), room_item_sprite_29 ;fireplace fire big sprite 1

room1F_02_fireplace_fire_frame_2_oam: ;4A0A
	db $FE
	db $04, $00
	db $56, $6C
	db $10, $10
	dbw BANK(room_item_sprite_30), room_item_sprite_30 ;fireplace fire big sprite 2

room1F_02_fireplace_fire_frame_3_oam: ;4A14
	db $FE
	db $04, $00
	db $56, $6C
	db $10, $10
	dbw BANK(room_item_sprite_31), room_item_sprite_31 ;fireplace fire big sprite 3

room1F_02_fireplace_fire_frame_4_oam: ;4A1E
	db $FE
	db $04, $00
	db $56, $6C
	db $10, $10
	dbw BANK(room_item_sprite_32), room_item_sprite_32 ;fireplace fire big sprite 4

room20_02_herb_sprite_oam: ;4A28
	db $FE
	db $00, $00
	db $50, $65
	db $08, $10
	dbw BANK(room_item_sprite_04), room_item_sprite_04

room21_00_small_key_sprite_oam: ;4A32
	db $FE
	db $00, $00
	db $66, $2E
	db $08, $10
	dbw BANK(room_item_sprite_12), room_item_sprite_12

room23_00_gas_sprite_frame_1_oam: ;4A3C
	db $FE
	db $03, $00
	db $59, $5B
	db $08, $10
	dbw BANK(room_item_sprite_33), room_item_sprite_33 ;gas sprite A frame 1

room23_00_gas_sprite_frame_2_oam: ;4A46
	db $FE
	db $03, $00
	db $59, $5B
	db $08, $10
	dbw BANK(room_item_sprite_34), room_item_sprite_34 ;gas sprite A frame 2

room23_01_gas_sprite_frame_1_oam: ;4A50
	db $FE
	db $03, $00
	db $57, $46
	db $08, $10
	dbw BANK(room_item_sprite_35), room_item_sprite_35 ;gas sprite B frame 1 (litle)

room23_01_gas_sprite_frame_2_oam: ;4A5A
	db $FE
	db $03, $00
	db $57, $46
	db $08, $10
	dbw BANK(room_item_sprite_36), room_item_sprite_36 ;gas sprite B frame 1 (litle)

room23_02_gas_sprite_frame_1_oam: ;4A64
	db $FE
	db $03, $00
	db $4E, $5C
	db $08, $10
	dbw BANK(room_item_sprite_33), room_item_sprite_33

room23_02_gas_sprite_frame_2_oam: ;4A6E
	db $FE
	db $03, $00
	db $4E, $5C
	db $08, $10
	dbw BANK(room_item_sprite_34), room_item_sprite_34

room60_05_gas_sprite_frame_1_oam: ;4A78
	db $FE
	db $03, $00
	db $54, $22
	db $08, $10
	dbw BANK(room_item_sprite_33), room_item_sprite_33

room60_05_gas_sprite_frame_2_oam: ;4A82
	db $FE
	db $03, $00
	db $54, $22
	db $08, $10
	dbw BANK(room_item_sprite_34), room_item_sprite_34

room25_00_herb_1_sprite_oam: ;4A8C
	db $FE
	db $00, $00
	db $78, $50
	db $08, $10
	dbw BANK(room_item_sprite_04), room_item_sprite_04

room25_00_herb_2_sprite_oam: ;4A96
	db $FE
	db $00, $00
	db $6E, $46
	db $08, $10
	dbw BANK(room_item_sprite_04), room_item_sprite_04

room25_00_herb_3_sprite_oam: ;4AA0
	db $FE
	db $00, $00
	db $61, $39
	db $08, $10
	dbw BANK(room_item_sprite_04), room_item_sprite_04

room26_02_lighter_sprite_oam: ;4AAA
	db $FE
	db $00, $00
	db $58, $45
	db $08, $10
	dbw BANK(room_item_sprite_19), room_item_sprite_19 ;lighter

room26_02_shells_sprite_oam: ;4AB4
	db $FE
	db $00, $00
	db $38, $35
	db $08, $10
	dbw BANK(room_item_sprite_08), room_item_sprite_08

room26_01_herb_sprite_oam: ;4ABE
	db $FE
	db $00, $00
	db $19, $60
	db $08, $10
	dbw BANK(room_item_sprite_04), room_item_sprite_04

room23_00_botany_book_sprite_oam: ;4AC8
	db $FE
	db $00, $00
	db $50, $60
	db $08, $10
	dbw BANK(room_item_sprite_08), room_item_sprite_08

room2C_04_moon_crest_sprite_oam: ;4AD2
	db $FE
	db $00, $00
	db $22, $33
	db $10, $10
	dbw BANK(room_item_sprite_21), room_item_sprite_21 ;moon crest sprite

room2C_05_moon_crest_sprite_oam: ;4ADC
	db $FE
	db $00, $00
	db $46, $42
	db $08, $10
	dbw BANK(room_item_sprite_22), room_item_sprite_22 ;litle herb? (supposed moon crest)

room2F_02_clip_sprite_oam: ;4AE6
	db $FE
	db $00, $00
	db $58, $5E
	db $08, $10
	dbw BANK(room_item_sprite_08), room_item_sprite_08

room30_03_red_jewel_sprite_oam: ;4AF0
	db $FE
	db $00, $00
	db $52, $48
	db $08, $10
	dbw BANK(room_item_sprite_05), room_item_sprite_05

room30_01_item_sprite_oam: ;4AFA
	db $FE
	db $00, $00
	db $8C, $6F
	db $08, $10
	dbw BANK(room_item_sprite_06), room_item_sprite_06 ;card like item

room31_04_file_sprite_oam: ;4B04
	db $FE
	db $00, $00
	db $45, $45 ;misplaced %fix
	db $08, $10
	dbw BANK(room_item_sprite_08), room_item_sprite_08

room33_01_battery_sprite_oam: ;4B0E
	db $FE
	db $00, $00
	db $3C, $65
	db $08, $10
	dbw BANK(room_item_sprite_17), room_item_sprite_17 ;battery sprite

room33_01_shells_1_sprite_oam: ;4B18
	db $FE
	db $00, $00
	db $4C, $41
	db $10, $10
	dbw BANK(room_item_sprite_16), room_item_sprite_16

room33_01_shells_2_sprite_oam: ;4B22
	db $FE
	db $00, $00
	db $34, $4B
	db $10, $10
	dbw BANK(room_item_sprite_16), room_item_sprite_16

room34_01_clip_sprite_oam: ;4B2C
	db $FE
	db $00, $00
	db $43, $54
	db $08, $10
	dbw BANK(room_item_sprite_05), room_item_sprite_05

room3C_01_hex_crank_sprite_oam: ;4B36
	db $FE
	db $00, $00
	db $54, $6D
	db $10, $10
	dbw BANK(room_item_sprite_18), room_item_sprite_18

room48_01_redbook_sprite_oam: ;4B40
	db $FE
	db $00, $00
	db $70, $7A
	db $08, $10
	dbw BANK(room_item_sprite_08), room_item_sprite_08

room48_02_redbook_sprite_oam: ;4B4A
	db $FE
	db $00, $00
	db $80, $6A
	db $08, $10
	dbw BANK(room_item_sprite_07), room_item_sprite_07

room50_03_file_sprite_oam: ;4B54
	db $FE
	db $00, $00
	db $80, $68
	db $08, $10
	dbw BANK(room_item_sprite_07), room_item_sprite_07

room50_04_file_sprite_oam: ;4B5E
	db $FE
	db $00, $00
	db $30, $68
	db $08, $10
	dbw BANK(room_item_sprite_08), room_item_sprite_08

room57_00_clip_sprite_oam: ;4B68
	db $FE
	db $00, $00
	db $1C, $58
	db $08, $10
	dbw BANK(room_item_sprite_08), room_item_sprite_08

room57_01_shell_sprite_oam: ;4B72
	db $FE
	db $00, $00
	db $58, $4B
	db $08, $10
	dbw BANK(room_item_sprite_17), room_item_sprite_17 ;shells sprite (little)

room57_01_dorm003_key_sprite_oam: ;4B7C
	db $FE
	db $00, $00
	db $88, $60
	db $08, $10
	dbw BANK(room_item_sprite_12), room_item_sprite_12 ;key

room59_05_battery_sprite_oam: ;4B86
	db $FE
	db $00, $00
	db $38, $58
	db $08, $10
	dbw BANK(room_item_sprite_17), room_item_sprite_17

room22_00_candle_sprite_oam: ;4B90
	db $FE
	db $00, $00
	db $62, $6C
	db $08, $10
	dbw BANK(room_item_sprite_24), room_item_sprite_24 ;candle sprite

room22_00_litted_candle_sprite_oam: ;4B9A
	db $FE
	db $00, $00
	db $62, $6C
	db $08, $10
	dbw BANK(room_item_sprite_23), room_item_sprite_23 ;litted candle sprit

room22_01_candle_sprite_oam: ;4BA4
	db $FE
	db $00, $00
	db $46, $64
	db $08, $10
	dbw BANK(room_item_sprite_24), room_item_sprite_24

room22_01_litted_candle_sprite_oam: ;4BAE
	db $FE
	db $00, $00
	db $46, $64
	db $08, $10
	dbw BANK(room_item_sprite_23), room_item_sprite_23

room6F_04_star_crest_sprite_oam: ;4BB8
	db $FE
	db $06, $00
	db $3C, $30
	db $08, $10
	dbw BANK(room_item_sprite_22), room_item_sprite_22 ;lil herb sprite?

room6F_05_star_crest_sprite_oam: ;4BC2
	db $FE
	db $06, $00
	db $41, $2E
	db $10, $10
	dbw BANK(room_item_sprite_21), room_item_sprite_21

room70_01_herbicide_sprite_oam: ;4BCC
	db $FE
	db $00, $00
	db $63, $78
	db $08, $10
	dbw BANK(room_item_sprite_08), room_item_sprite_08

room70_01_f_aid_spray_sprite_oam: ;4BD6
	db $FE
	db $00, $00
	db $47, $7B
	db $08, $10
	dbw BANK(room_item_sprite_13), room_item_sprite_13 ;f-aid spray

room70_01_shells_sprite_oam: ;4BE0
	db $FE
	db $00, $00
	db $78, $83
	db $08, $10
	dbw BANK(room_item_sprite_17), room_item_sprite_17

room70_00_clip_sprite_oam: ;4BEA
	db $FE
	db $00, $00
	db $31, $86
	db $08, $10
	dbw BANK(room_item_sprite_08), room_item_sprite_08

