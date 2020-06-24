; rooms item sprites OAMs
; 
; sprite struct:
; - 0: y-sort
; - 1: palette id
; - 2: x position
; - 3: y position
; - 4: width
; - 5: height
; - 6: sprite bank
; - 7: sprite pointer

room00_01_pillar_sprite_02:
	db 101
	dw 4
	db 125, 59
	db 8, 32
	dbw BANK(main_hall_pillar_02), main_hall_pillar_02

room00_01_pillar_sprite_01:
	db 108
	dw 4
	db 104, 57
	db 8, 32
	dbw BANK(main_hall_pillar_01), main_hall_pillar_01

room00_02_pillar_sprite_07:
	db 52
	dw 4
	db 127, 63
	db 16, 48
	dbw BANK(main_hall_pillar_07), main_hall_pillar_07

room00_02_pillar_sprite_10:
	db 65
	dw 4
	db 103, 70
	db 16, 32
	dbw BANK(main_hall_pillar_10), main_hall_pillar_10

room00_02_pillar_sprite_03:
	db 80
	dw 4
	db 88, 64
	db 8, 32
	dbw BANK(main_hall_pillar_03), main_hall_pillar_03

room00_02_pillar_sprite_11:
	db 66
	dw 4
	db 67, 74
	db 16, 32
	dbw BANK(main_hall_pillar_11), main_hall_pillar_11

room00_06_pillar_sprite_05:
	db 104
	dw 4
	db 56, 61
	db 8, 32
	dbw BANK(main_hall_pillar_05), main_hall_pillar_05

room00_06_pillar_sprite_06:
	db 108
	dw 4
	db 77, 60
	db 8, 32
	dbw BANK(main_hall_pillar_06), main_hall_pillar_06

room00_05_pillar_sprite_09:
	db 37
	dw 4
	db 8, 73
	db 24, 48
	dbw BANK(main_hall_pillar_09), main_hall_pillar_09

room00_05_pillar_sprite_08:
	db 48
	dw 4
	db 93, 63
	db 16, 48
	dbw BANK(main_hall_pillar_08), main_hall_pillar_08

room00_05_pillar_sprite_04:
	db 74
	dw 4
	db 72, 69
	db 8, 32
	dbw BANK(main_hall_pillar_04), main_hall_pillar_04

room00_05_pillar_sprite_12:
	db 54
	dw 4
	db 49, 75
	db 16, 32
	dbw BANK(main_hall_pillar_12), main_hall_pillar_12

room00_01_handgun_sprite:
	db -2
	dw 3
	db 82, 92
	db 8, 16
	dbw BANK(handgun_sprite_2), handgun_sprite_2

room00_02_handgun_sprite:
	db -2
	dw 3
	db 64, 112
	db 8, 16
	dbw BANK(handgun_sprite), handgun_sprite

room01_02_emblem_sprite:
	db -2
	dw 3
	db 78, 89
	db 8, 16
	dbw BANK(emblem_far_sprite), emblem_far_sprite

room01_03_emblem_sprite:
	db -2
	dw 3
	db 84, 52
	db 16, 16
	dbw BANK(emblem_medium_sprite), emblem_medium_sprite

room01_06_emblem_sprite:
	db -2
	dw 3
	db 79, 79
	db 16, 16
	dbw BANK(emblem_close_sprite), emblem_close_sprite

room01_05_shield_key_sprite:
	db -2
	dw 3
	db 81, 73
	db 8, 16
	dbw BANK(key_sprite), key_sprite

room01_02_blue_jewel_sprite:
	db -2
	dw 1
	db 40, 128
	db 8, 16
	dbw BANK(round_item_sprite), round_item_sprite

room01_03_blue_jewel_sprite:
	db -2
	dw 1
	db 80, 118
	db 8, 16
	dbw BANK(round_item_sprite), round_item_sprite

unused_round_item_sprite_482A:
	db -2
	dw 0
	db 112, 96
	db 8, 16
	dbw BANK(round_item_sprite), round_item_sprite

unused_round_item_sprite_4834:
	db -2
	dw 0
	db 76, 102
	db 8, 16
	dbw BANK(round_item_sprite), round_item_sprite

room02_00_serum_sprite:
	db -2
	dw 3
	db 42, 76
	db 8, 16
	dbw BANK(serum_far_sprite), serum_far_sprite

room02_03_serum_sprite:
	db -2
	dw 3
	db 18, 63
	db 8, 16
	dbw BANK(serum_close_sprite), serum_close_sprite

room04_02_map_sprite:
	db -2
	dw 3
	db 112, 112
	db 16, 16
	dbw BANK(map_sprite_1), map_sprite_1

room04_05_ink_ribbon_sprite:
	db -2
	dw 6
	db 112, 56
	db 8, 16
	dbw BANK(round_item_sprite), round_item_sprite

room05_03_corridor_lamp_sprite:
	db -2
	dw 4
	db 119, 34
	db 16, 64
	dbw BANK(rest_stop_corridor_lamp), rest_stop_corridor_lamp

room06_02_herb_sprite:
	db -2
	dw 0
	db 42, 96
	db 8, 16
	dbw BANK(herb_sprite), herb_sprite

room06_03_herb_sprite_1:
	db -2
	dw 0
	db 50, 112
	db 8, 16
	dbw BANK(herb_sprite), herb_sprite

room06_03_herb_sprite_2:
	db -2
	dw 0
	db 146, 100
	db 8, 16
	dbw BANK(herb_sprite), herb_sprite

room06_05_armor_key_sprite:
	db -2
	dw 0
	db 93, 60
	db 8, 16
	dbw BANK(key_sprite), key_sprite

room07_04_emblem_sprite:
	db -2
	dw 0
	db 97, 94
	db 16, 16
	dbw BANK(emblem_close_sprite), emblem_close_sprite

room09_02_broken_shotgun_sprite:
	db -2
	dw 0
	db 80, 64
	db 8, 16
	dbw BANK(shotgun_sprite_2), shotgun_sprite_2

room09_02_clip_sprite:
	db -2
	dw 0
	db 122, 92
	db 8, 16
	dbw BANK(rect_item_sprite), rect_item_sprite

room09_03_shells_sprite:
	db -2
	dw 0
	db 76, 66
	db 16, 16
	dbw BANK(shells_sprite), shells_sprite

room0A_01_herb_sprite:
	db -2
	dw 0
	db 128, 36
	db 8, 16
	dbw BANK(herb_sprite), herb_sprite

room0C_02_clip_sprite:
	db -2
	dw 0
	db 108, 120
	db 8, 16
	dbw BANK(rect_item_sprite), rect_item_sprite

room0D_02_herb_sprite:
	db -2
	dw 0
	db 94, 68
	db 8, 16
	dbw BANK(herb_sprite), herb_sprite

room0D_03_herb_sprite:
	db -2
	dw 0
	db 42, 100
	db 8, 16
	dbw BANK(herb_sprite), herb_sprite

room0E_02_shells_sprite:
	db -2
	dw 0
	db 123, 83
	db 16, 16
	dbw BANK(shells_sprite), shells_sprite

room0E_03_shells_sprite:
	db -2
	dw 0
	db 84, 98
	db 16, 16
	dbw BANK(shells_sprite), shells_sprite

room0E_01_clip_sprite:
	db -2
	dw 0
	db 119, 124
	db 8, 16
	dbw BANK(rect_item_sprite), rect_item_sprite

room0E_00_clip_sprite:
	db -2
	dw 0
	db 59, 122
	db 8, 16
	dbw BANK(rect_item_sprite), rect_item_sprite

room0E_02_file_sprite:
	db -2
	dw 0
	db 44, 107
	db 8, 16
	dbw BANK(file_sprite_1), file_sprite_1

room0E_03_file_sprite:
	db -2
	dw 0
	db 62, 124
	db 8, 16
	dbw BANK(file_sprite_1), file_sprite_1

room10_03_shells_sprite:
	db -2
	dw 0
	db 73, 80
	db 16, 16
	dbw BANK(shells_sprite), shells_sprite

room11_03_small_key_sprite:
	db -2
	dw 0
	db 87, 99
	db 8, 16
	dbw BANK(key_sprite), key_sprite

room12_03_herb_sprite_1:
	db -2
	dw 0
	db 129, 84
	db 8, 16
	dbw BANK(herb_sprite), herb_sprite

room12_02_herb_sprite_1:
	db -2
	dw 0
	db 94, 92
	db 8, 16
	dbw BANK(herb_sprite), herb_sprite

room12_03_herb_sprite_2:
	db -2
	dw 0
	db 59, 124
	db 8, 16
	dbw BANK(herb_sprite), herb_sprite

room12_02_herb_sprite_2:
	db -2
	dw 0
	db 76, 111
	db 8, 16
	dbw BANK(herb_sprite), herb_sprite

room14_00_wind_crest_sprite:
	db -2
	dw 6
	db 98, 52
	db 8, 16
	dbw BANK(round_item_sprite), round_item_sprite

room14_00_colt_python_sprite:
	db -2
	dw 6
	db 78, 52
	db 8, 16
	dbw BANK(handgun_sprite), handgun_sprite

room16_02_square_crank_sprite:
	db -2
	dw 0
	db 84, 51
	db 16, 16
	dbw BANK(crank_sprite), crank_sprite

room16_00_small_key_sprite:
	db -2
	dw 0
	db 133, 135
	db 8, 16
	dbw BANK(key_sprite), key_sprite

room17_00_herb_sprite:
	db -2
	dw 0
	db 133, 80
	db 8, 16
	dbw BANK(herb_sprite), herb_sprite

room17_01_ink_ribbon_sprite:
	db -2
	dw 0
	db 75, 72
	db 8, 16
	dbw BANK(round_item_sprite), round_item_sprite

room18_01_shotgun_sprite:
	db -2
	dw 0
	db 86, 46
	db 16, 16
	dbw BANK(shotgun_sprite_1), shotgun_sprite_1

room1A_03_shells_sprite:
	db -2
	dw 0
	db 93, 104
	db 16, 16
	dbw BANK(shells_sprite), shells_sprite

room1E_02_herb_sprite:
	db -2
	dw 0
	db 69, 94
	db 8, 16
	dbw BANK(herb_sprite), herb_sprite

room1F_01_mansion_2F_map_sprite:
	db -2
	dw 0
	db 89, 71
	db 16, 16
	dbw BANK(map_sprite_1), map_sprite_1

room1F_02_mansion_2F_map_sprite:
	db -2
	dw 0
	db 93, 44
	db 16, 16
	dbw BANK(map_sprite_1), map_sprite_1

room1F_01_herb_sprite:
	db -2
	dw 0
	db 40, 114
	db 8, 16
	dbw BANK(herb_sprite), herb_sprite

room1F_01_fireplace_sprite_frame01:
	db -2
	dw 4
	db 84, 98
	db 16, 16
	dbw BANK(fireplace_sprite_sheet_1), fireplace_sprite_sheet_1

room1F_01_fireplace_sprite_frame02:
	db -2
	dw 4
	db 84, 98
	db 16, 16
	dbw BANK(fireplace_sprite_sheet_1), fireplace_sprite_sheet_1+64

room1F_01_fireplace_sprite_frame03:
	db -2
	dw 4
	db 84, 98
	db 16, 16
	dbw BANK(fireplace_sprite_sheet_1), fireplace_sprite_sheet_1+128

room1F_01_fireplace_sprite_frame04:
	db -2
	dw 4
	db 84, 98
	db 16, 16
	dbw BANK(fireplace_sprite_sheet_1), fireplace_sprite_sheet_1+192

room1F_02_fireplace_sprite_frame01:
	db -2
	dw 4
	db 86, 108
	db 16, 16
	dbw BANK(fireplace_sprite_sheet_2), fireplace_sprite_sheet_2

room1F_02_fireplace_sprite_frame02:
	db -2
	dw 4
	db 86, 108
	db 16, 16
	dbw BANK(fireplace_sprite_sheet_2), fireplace_sprite_sheet_2+64

room1F_02_fireplace_sprite_frame03:
	db -2
	dw 4
	db 86, 108
	db 16, 16
	dbw BANK(fireplace_sprite_sheet_2), fireplace_sprite_sheet_2+128

room1F_02_fireplace_sprite_frame04:
	db -2
	dw 4
	db 86, 108
	db 16, 16
	dbw BANK(fireplace_sprite_sheet_2), fireplace_sprite_sheet_2+192

room20_02_herb_sprite:
	db -2
	dw 0
	db 80, 101
	db 8, 16
	dbw BANK(herb_sprite), herb_sprite

room21_00_small_key_sprite:
	db -2
	dw 0
	db 102, 46
	db 8, 16
	dbw BANK(key_sprite), key_sprite

room23_00_gas_sprite_frame01:
	db -2
	dw 3
	db 89, 91
	db 8, 16
	dbw BANK(gas_sprite_sheet), gas_sprite_sheet

room23_00_gas_sprite_frame02:
	db -2
	dw 3
	db 89, 91
	db 8, 16
	dbw BANK(gas_sprite_sheet), gas_sprite_sheet+32

room23_01_gas_sprite_frame01:
	db -2
	dw 3
	db 87, 70
	db 8, 16
	dbw BANK(gas_far_sprite_sheet), gas_far_sprite_sheet

room23_01_gas_sprite_frame02:
	db -2
	dw 3
	db 87, 70
	db 8, 16
	dbw BANK(gas_far_sprite_sheet), gas_far_sprite_sheet+32

room23_02_gas_sprite_frame01:
	db -2
	dw 3
	db 78, 92
	db 8, 16
	dbw BANK(gas_sprite_sheet), gas_sprite_sheet

room23_02_gas_sprite_frame02:
	db -2
	dw 3
	db 78, 92
	db 8, 16
	dbw BANK(gas_sprite_sheet), gas_sprite_sheet+32

room60_05_gas_sprite_frame01:
	db -2
	dw 3
	db 84, 34
	db 8, 16
	dbw BANK(gas_sprite_sheet), gas_sprite_sheet

room60_05_gas_sprite_frame02:
	db -2
	dw 3
	db 84, 34
	db 8, 16
	dbw BANK(gas_sprite_sheet), gas_sprite_sheet+32

room25_00_herb_sprite_1:
	db -2
	dw 0
	db 120, 80
	db 8, 16
	dbw BANK(herb_sprite), herb_sprite

room25_00_herb_sprite_2:
	db -2
	dw 0
	db 110, 70
	db 8, 16
	dbw BANK(herb_sprite), herb_sprite

room25_00_herb_sprite_3:
	db -2
	dw 0
	db 97, 57
	db 8, 16
	dbw BANK(herb_sprite), herb_sprite

room26_02_lighter_sprite:
	db -2
	dw 0
	db 88, 69
	db 8, 16
	dbw BANK(lighter_sprite), lighter_sprite

room26_02_shells_sprite:
	db -2
	dw 0
	db 56, 53
	db 8, 16
	dbw BANK(rect_item_sprite), rect_item_sprite

room26_01_herb_sprite:
	db -2
	dw 0
	db 25, 96
	db 8, 16
	dbw BANK(herb_sprite), herb_sprite

room23_00_botany_book_sprite:
	db -2
	dw 0
	db 80, 96
	db 8, 16
	dbw BANK(rect_item_sprite), rect_item_sprite

room2C_04_moon_crest_sprite:
	db -2
	dw 0
	db 34, 51
	db 16, 16
	dbw BANK(crest_sprite), crest_sprite

room2C_05_moon_crest_sprite:
	db -2
	dw 0
	db 70, 66
	db 8, 16
	dbw BANK(herb_far_sprite), herb_far_sprite

room2F_02_clip_sprite:
	db -2
	dw 0
	db 88, 94
	db 8, 16
	dbw BANK(rect_item_sprite), rect_item_sprite

room30_03_red_jewel_sprite:
	db -2
	dw 0
	db 82, 72
	db 8, 16
	dbw BANK(round_item_sprite), round_item_sprite

room30_01_file_sprite:
	db -2
	dw 0
	db 140, 111
	db 8, 16
	dbw BANK(map_sprite_2), map_sprite_2

room31_04_file_sprite:
	db -2
	dw 0
	db 69, 69
	db 8, 16
	dbw BANK(rect_item_sprite), rect_item_sprite

room33_01_battery_sprite:
	db -2
	dw 0
	db 60, 101
	db 8, 16
	dbw BANK(shells_far_sprite), shells_far_sprite

room33_01_shells_sprite_1:
	db -2
	dw 0
	db 76, 65
	db 16, 16
	dbw BANK(shells_sprite), shells_sprite

room33_01_shells_sprite_2:
	db -2
	dw 0
	db 52, 75
	db 16, 16
	dbw BANK(shells_sprite), shells_sprite

room34_01_clip_sprite:
	db -2
	dw 0
	db 67, 84
	db 8, 16
	dbw BANK(round_item_sprite), round_item_sprite

room3C_01_hex_crank_sprite:
	db -2
	dw 0
	db 84, 109
	db 16, 16
	dbw BANK(crank_sprite), crank_sprite

room48_01_redbook_sprite:
	db -2
	dw 0
	db 112, 122
	db 8, 16
	dbw BANK(rect_item_sprite), rect_item_sprite

room48_02_redbook_sprite:
	db -2
	dw 0
	db 128, 106
	db 8, 16
	dbw BANK(file_sprite_1), file_sprite_1

room50_03_file_sprite:
	db -2
	dw 0
	db 128, 104
	db 8, 16
	dbw BANK(file_sprite_1), file_sprite_1

room50_04_file_sprite:
	db -2
	dw 0
	db 48, 104
	db 8, 16
	dbw BANK(rect_item_sprite), rect_item_sprite

room57_00_clip_sprite:
	db -2
	dw 0
	db 28, 88
	db 8, 16
	dbw BANK(rect_item_sprite), rect_item_sprite

room57_01_shells_sprite:
	db -2
	dw 0
	db 88, 75
	db 8, 16
	dbw BANK(shells_far_sprite), shells_far_sprite

room57_01_dorm003_key_sprite:
	db -2
	dw 0
	db 136, 96
	db 8, 16
	dbw BANK(key_sprite), key_sprite

room59_05_battery_sprite:
	db -2
	dw 0
	db 56, 88
	db 8, 16
	dbw BANK(shells_far_sprite), shells_far_sprite

room22_00_candle_unlit_sprite:
	db -2
	dw 0
	db 98, 108
	db 8, 16
	dbw BANK(candle_unlit_sprite), candle_unlit_sprite

room22_00_candle_lit_sprite:
	db -2
	dw 0
	db 98, 108
	db 8, 16
	dbw BANK(candle_lit_sprite), candle_lit_sprite

room22_01_candle_unlit_sprite:
	db -2
	dw 0
	db 70, 100
	db 8, 16
	dbw BANK(candle_unlit_sprite), candle_unlit_sprite

room22_01_candle_lit_sprite:
	db -2
	dw 0
	db 70, 100
	db 8, 16
	dbw BANK(candle_lit_sprite), candle_lit_sprite

room6F_04_star_crest_sprite:
	db -2
	dw 6
	db 60, 48
	db 8, 16
	dbw BANK(herb_far_sprite), herb_far_sprite

room6F_05_star_crest_sprite:
	db -2
	dw 6
	db 65, 46
	db 16, 16
	dbw BANK(crest_sprite), crest_sprite

room70_01_herbicide_sprite:
	db -2
	dw 0
	db 99, 120
	db 8, 16
	dbw BANK(rect_item_sprite), rect_item_sprite

room70_01_first_aid_spray_sprite:
	db -2
	dw 0
	db 71, 123
	db 8, 16
	dbw BANK(serum_far_sprite), serum_far_sprite

room70_01_shells_sprite:
	db -2
	dw 0
	db 120, 131
	db 8, 16
	dbw BANK(shells_far_sprite), shells_far_sprite

room70_00_clip_sprite:
	db -2
	dw 0
	db 49, 134
	db 8, 16
	dbw BANK(rect_item_sprite), rect_item_sprite

