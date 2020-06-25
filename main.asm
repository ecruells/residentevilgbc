INCLUDE "constants.asm"

INCLUDE "home.asm"

SECTION "bank1",ROMX,BANK[$1]

INCLUDE "engine/menus/combine_items2.asm"
INCLUDE "engine/menus/main_menu.asm"
INCLUDE "engine/menus/itembox_menu.asm"
INCLUDE "engine/menus/itembox_menu_inputs.asm"
INCLUDE "engine/menus/main_menu_bookmarks.asm"


enableExtRAM:: ;01:4389
	ld a, $00
	ld [$4000], a ; ram bank 0
	ld a, $0A
	ld [$0000], a
	ret

disableExtRAM:: ;01:4394
	ld a, $00
	ld [$0000], a
	ret

INCLUDE "engine/display_start_game_message.asm"
INCLUDE "engine/print_debug_word.asm"

INCLUDE "engine/oam_routines.asm"

INCLUDE "engine/backgrounds/load_bg_palettes.asm"

INCLUDE "engine/tilemaps/show_death_screen.asm"
INCLUDE "engine/tilemaps/show_pause_screen.asm"
INCLUDE "engine/tilemaps/show_hotgen_studios_logo_screen.asm"

INCLUDE "engine/tilemaps/display_tilemap_rooms_transition.asm"

INCLUDE "engine/show_title_rooms_bg_slide_demo.asm"

INCLUDE "engine/menus/health_meter.asm"

INCLUDE "engine/menus/char_select_update_policecard1.asm"

INCLUDE "engine/menus/load_main_menu_char_faces.asm"

INCLUDE "engine/menus/char_select_update_policecard2.asm"

INCLUDE "engine/sprites/check_blood_frames_id_value.asm"

INCLUDE "engine/menus/print_choice_arrow.asm"

INCLUDE "engine/menus/include_found_item.asm"

INCLUDE "engine/backgrounds/update_room_bg_animation.asm"

INCLUDE "engine/backgrounds/lab_computer_bg_masks.asm"

INCLUDE "engine/backgrounds/show_lab_projector_slides.asm"

INCLUDE "engine/backgrounds/load_room_background_caller.asm"

INCLUDE "engine/menus/check_item_usage.asm"

INCLUDE "engine/sprite_transformation/get_axes_scale_factors.asm"

INCLUDE "engine/menus/loadsave_menu_cursor.asm"

INCLUDE	"text/load_save_menu_text.asm" ;01:5701

INCLUDE	"engine/menus/load_and_save_game_routines.asm"

INCLUDE	"engine/actions/check_action_button_events.asm"

INCLUDE	"engine/actions/check_room_normal_interactions.asm"

INCLUDE	"engine/actions/search_small_key_in_inventory.asm"

INCLUDE	"engine/actions/check_doors_interactions.asm"

INCLUDE	"engine/lab_computer_routines.asm"

INCLUDE	"engine/numeric_panel.asm"


; hl: message table pointer
displayActionMessage: ;01:6E21
    push hl
    call clearMessageBox
    call scrollDownScreen
    pop hl
    call displayMessage
    call waitMessageForPlayerInput
    call clearMessageBox
    jp scrollUpScreen


INCLUDE "engine/menus/display_file.asm" ;6E35


; switch choice messages, return choice value
showSwitchBelowChoice: ;01:6E90
    ld hl, text_pointer_4072 ; There's a switch below. Will you push it?  Yes/No
    jr Label6E98
showSwitchChoice:
    ld hl, text_pointer_408A ; There's a switch. Will you push it?. Yes No .
Label6E98:
    call displayMessage
.Label6E9B
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, .Label6E9B
.Label6EA5
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr nz, .Label6EA5
    call clearMessageBox
    ld a, [wChoiceId]
    ret
;6EB3


; c: entity sprite id
findNpcEntity: ;01:6EB3
    ld de, wNPCEntitiesDataStructs
    ld b, 7
.findNextNPC
    ld hl, wEntityId - wEntityStructData
    add hl, de
    ld a, [hl]
    cp a, c
    jr z, NPCFound
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    dec b
    jr nz, .findNextNPC
.NPCNotFound
    xor a
    ret
NPCFound:
    ld a, $FF
    ret
;6ED0


INCLUDE "engine/math/multiply_division.asm"


;
; rooms backgrounds luts and pointers
;
INCLUDE "data/rooms/rooms_bg_lookup_table.asm" ;71B5
INCLUDE "data/rooms/rooms_bg_pointers.asm" ;7385
INCLUDE "data/rooms/rooms_bg_masks_pointers.asm" ;7A96

INCLUDE "data/rooms/incomplete_bg_masks.asm" ; 7BBC





SECTION "title",ROMX,BANK[$2]

titleScreenTilemap:                 INCBIN "gfx/tilemaps/title_screen.2bpp" ;4000
titleScreenPalette:                 INCBIN "gfx/tilemaps/title_screen.pal" ;5790

characterSelectScreenTilesData:		INCBIN "gfx/tilemaps/character_select_screen.2bpp" ;57D8

policeIdCardTilemap:		        INCBIN "gfx/tilemaps/police_id_card.2bpp" ;5FE8

characterSelectScreenTilesmap:		INCBIN "gfx/tilemaps/character_select_screen.map" ;62D8

characterSelectScreenPalette:		INCBIN "gfx/tilemaps/character_select_screen.pal" ;677C

policeIdCardCharFaces:	            INCBIN "gfx/police_id_card_faces_photos.2bpp" ;67FC
policeIdCardExtraColorsSprites:	    INCBIN "gfx/police_id_card_extra_colors.2bpp" ;6AFC

arrowCursor:		 			    INCBIN "gfx/arrow_cursor.2bpp"	;00:6C7C

saveMenuFonts:				        INCBIN "gfx/save_menu_fonts.2bpp" ;6C9C

db "BANK2"

;6EF1




SECTION "RoomsBgPalettes",ROMX,BANK[$3]

INCLUDE "data/rooms/rooms_palettes.asm" ; 4000

INCLUDE "engine/backgrounds/load_room_palettes.asm" ;03:7A80

db "BANK3"

;7B5A end of bank




SECTION "bank4", ROMX,BANK[$4]

emblem_medium_sprite:		INCBIN "gfx/room_items_sprites/emblem_medium_sprite.2bpp" ;4000
map_sprite_1:		        INCBIN "gfx/room_items_sprites/map_sprite_1.2bpp" ;4040
handgun_sprite:		        INCBIN "gfx/room_items_sprites/handgun_sprite.2bpp" ;4080
herb_sprite:		        INCBIN "gfx/room_items_sprites/herb_sprite.2bpp" ;40A0
round_item_sprite:		    INCBIN "gfx/room_items_sprites/round_item_sprite.2bpp" ;40C0
map_sprite_2:		        INCBIN "gfx/room_items_sprites/map_sprite_2.2bpp" ;40E0
file_sprite_1:		        INCBIN "gfx/room_items_sprites/file_sprite_1.2bpp" ;4100
rect_item_sprite:		    INCBIN "gfx/room_items_sprites/rect_item_sprite.2bpp" ;4120
emblem_close_sprite:		INCBIN "gfx/room_items_sprites/emblem_close_sprite.2bpp" ;4140
emblem_far_sprite:		    INCBIN "gfx/room_items_sprites/emblem_far_sprite.2bpp" ;4180
handgun_sprite_2:		    INCBIN "gfx/room_items_sprites/handgun_sprite_2.2bpp" ;41A0
key_sprite:		            INCBIN "gfx/room_items_sprites/key_sprite.2bpp" ;41C0
serum_far_sprite:		    INCBIN "gfx/room_items_sprites/serum_far_sprite.2bpp" ;41E0
serum_close_sprite:		    INCBIN "gfx/room_items_sprites/serum_close_sprite.2bpp" ;4200
shotgun_sprite_1:		    INCBIN "gfx/room_items_sprites/shotgun_sprite_1.2bpp" ;4220
shells_sprite:		        INCBIN "gfx/room_items_sprites/shells_sprite.2bpp" ;4260
shells_far_sprite:		    INCBIN "gfx/room_items_sprites/shells_far_sprite.2bpp" ;42A0
crank_sprite:		        INCBIN "gfx/room_items_sprites/crank_sprite.2bpp" ;42A0
crank_far_sprite:		    INCBIN "gfx/room_items_sprites/crank_far_sprite.2bpp" ;4300
key_sprite_2:		        INCBIN "gfx/room_items_sprites/key_sprite_2.2bpp" ;4320
key_sprite_3:		        INCBIN "gfx/room_items_sprites/key_sprite_3.2bpp" ;4340
herb_unused_sprite:		    INCBIN "gfx/room_items_sprites/herb_unused_sprite.2bpp" ;4380
lighter_sprite:		        INCBIN "gfx/room_items_sprites/lighter_sprite.2bpp" ;43A0
shotgun_sprite_2:		    INCBIN "gfx/room_items_sprites/shotgun_sprite_2.2bpp" ;43C0
crest_sprite:		        INCBIN "gfx/room_items_sprites/crest_sprite.2bpp" ;43E0
herb_far_sprite:		    INCBIN "gfx/room_items_sprites/herb_far_sprite.2bpp" ;4420
candle_lit_sprite:		    INCBIN "gfx/room_items_sprites/candle_lit_sprite.2bpp" ;4440
candle_unlit_sprite:		INCBIN "gfx/room_items_sprites/candle_unlit_sprite.2bpp" ;4460
shotgun_sprite_3:		    INCBIN "gfx/room_items_sprites/shotgun_sprite_3.2bpp" ;4480
shells_sprite_2:		    INCBIN "gfx/room_items_sprites/shells_sprite_2.2bpp" ;44C0

; animated sprites
fireplace_sprite_sheet_1:	INCBIN "gfx/room_items_sprites/fireplace_sprite_sheet_1.2bpp" ;25-28
fireplace_sprite_sheet_2:	INCBIN "gfx/room_items_sprites/fireplace_sprite_sheet_2.2bpp" ;29-32
gas_sprite_sheet:		    INCBIN "gfx/room_items_sprites/gas_sprite_sheet.2bpp" ;33-34
gas_far_sprite_sheet:		INCBIN "gfx/room_items_sprites/gas_far_sprite_sheet.2bpp" ;35-36
;4780

REPT 640
	db $00
ENDR

;4A00

INCLUDE "engine/menus/update_itembox_cursor.asm" ;04:4A00

INCLUDE "engine/sprite_transformation/apply_water_effect.asm" ;04:4A33

INCLUDE "engine/lab_computer_input_checks.asm" ;04:4A8E

INCLUDE "engine/sprites/push_sprite_draw_data.asm" ; 04:4B80

INCLUDE "engine/sprites/update_enemy_blood_sprite.asm" ;04:4BC4

INCLUDE "engine/update_room_gas_damage.asm" ;04:4C34

INCLUDE "engine/init_selected_character_data.asm" ;04:4C5C

INCLUDE "engine/backgrounds/load_room_background_mask.asm"

;04:55FD rest of bank 4 space is empty




SECTION "bank5",ROMX,BANK[$5]

itemsSpriteSheet:		INCBIN "gfx/items_sprite_sheet.2bpp" ;4000

INCLUDE "data/items_sprites_table.asm" ;5B00
INCLUDE "data/items_palette_index_table.asm" ;5BC0

INCLUDE "engine/menus/menu_items_sprites_loaders.asm" ;5C1C

INCLUDE "data/rooms/rooms_map_rects_data.asm" ;5EE7
INCLUDE "data/rooms/rooms_map_rect_pixels_data.asm" ;5FF5

INCLUDE "engine/menus/draw_room_map_rect.asm" ; 05:603D

INCLUDE "engine/update_title_cursors.asm" ; 05:60F4

INCLUDE "engine/scrolldown_typing_message.asm" ; 05:6149


;05:6179 rest of bank is empty




SECTION "Audio bank",ROMX,BANK[$6]

INCLUDE "audio/audio.asm"



SECTION "Rooms background cameras",ROMX,BANK[$7]

INCLUDE "data/rooms/rooms_bgs_cameras_lookup_table.asm" ;4000

INCLUDE "data/rooms/rooms_bgs_cameras.asm" ;40E8

;07:6D0E rest of bank empty




SECTION "Rooms background overlaps masks",ROMX,BANK[$8]

INCLUDE "engine/apply_bg_overlap_masks_on_sprite.asm" ;08:439E

INCLUDE "data/rooms/rooms_bgs_overlap_masks.asm" ;08:46E3
INCLUDE "data/rooms/rooms_bgs_overlap_masks_pointers.asm" ;7373
INCLUDE "data/rooms/rooms_bgs_sprite_based_overlaps.asm" ;799B

db "BANK8"
;7AA0


SECTION "Main and itembox menus gfx data",ROMX,BANK[$9]

mapMenuPalette:			        INCBIN "gfx/main_menu/map_menu_palette.pal" ;4000
mapDetailPalette:				INCBIN "gfx/main_menu/map_detail_palette.pal" ;4040

itemCheckOptionPalette:			INCBIN "gfx/main_menu/item_check_option.pal" ;4080
itemCombineOptionPalette:		INCBIN "gfx/main_menu/item_combine_option.pal" ;40C0
itemUseEquipOptionPalette:		INCBIN "gfx/main_menu/item_use_equip_option.pal" ;4100

mansionMapPreview01Data:		INCBIN "gfx/main_menu/mansion_map_preview_01.2bpp" ;4140 mansion only
mansionMapPreview02Data:		INCBIN "gfx/main_menu/mansion_map_preview_02.2bpp" ;4360 mansion & guardhouse (unused)
mansionMapPreview03Data:		INCBIN "gfx/main_menu/mansion_map_preview_03.2bpp" ;4650 mansion, courtyard & guardhouse (unused)
mansionMapPreview04Data:		INCBIN "gfx/main_menu/mansion_map_preview_04.2bpp" ;4A20 same as map 03 (unused)

filebook01Tilemap:			    INCBIN "gfx/main_menu/filebook_01.2bpp" ;4DF0
filebook02Tilemap:			    INCBIN "gfx/main_menu/filebook_02.2bpp" ;5040
filebook03Tilemap:			    INCBIN "gfx/main_menu/filebook_03.2bpp" ;52B0

itemCheckOptionTilemap:			INCBIN "gfx/main_menu/item_check_option.2bpp" ;5500
itemCombineOptionTilemap:		INCBIN "gfx/main_menu/item_combine_option.2bpp" ;56B0
itemUseOptionTilemap:			INCBIN "gfx/main_menu/item_use_equip_option.2bpp" ;5860

;5A10 rest of bank empty



SECTION "Horizontal shrinking lookup tables",ROMX,BANK[$A]

INCLUDE "data/luts/horizontal_shrinking_lut.asm"

;0A:5A00 rest of bank empty



SECTION "Sine lookup table and doors gfx data",ROMX,BANK[$B]

INCLUDE "data/luts/sine_lookup_table.asm" ;4000

doorsSpritesheet: 	INCBIN "gfx/sprite_sheets/doors/doors_spritesheet.2bpp" ;0B:5000
doorsBGPalette:		INCBIN "gfx/door_sprite_palette.pal" ;5900



SECTION "Main menu bg data and firegun tiles",ROMX,BANK[$C]

mainMenuTilemap:	    INCBIN "gfx/tilemaps/main_menu.2bpp" ;4000
mainMenuPalette:	    INCBIN "gfx/tilemaps/main_menu.pal" ;4DC4

greyPalette: 		    INCBIN "gfx/grey_palette.pal" ;4E44

mainMenuCharsFaces:		INCBIN "gfx/main_menu_char_faces.2bpp" ;4E84

firegunAndBloodTiles:   INCBIN "gfx/firegun_and_blood_tiles.2bpp" ;4F04

;0C:4FC0 rest of bank empty


SECTION "bankD",ROMX,BANK[$D]

deathScreenTilemap: 		    INCBIN "gfx/tilemaps/death_screen.2bpp" ;4000
deathScreenPalette: 		    INCBIN "gfx/tilemaps/death_screen.pal" ;4B60

pauseScreenTilemap: 			INCBIN "gfx/tilemaps/pause_screen.2bpp" ;4BB0
pauseScreenPalette: 			INCBIN "gfx/tilemaps/pause_screen.pal" ;56F0

LoadSaveMenuTiles: 				INCBIN "gfx/tilemaps/load_save_menu.2bpp" ;5740
loadSaveMenuFonts: 				INCBIN "gfx/tilemaps/load_save_menu_fonts.2bpp" ;6700
loadSaveMenuIndexes: 			INCBIN "gfx/tilemaps/load_save_menu.map" ;6930
loadSaveMenuPalette: 			INCBIN "gfx/tilemaps/load_save_menu.pal" ;6C48



SECTION "Events",ROMX,BANK[$E]

INCLUDE "events/events_lookup_table.asm"

INCLUDE "engine/display_event.asm"

INCLUDE "events/chris_events_scripts.asm" ;0E:421B
INCLUDE "events/jill_events_scripts.asm"
INCLUDE "events/common_events_scripts.asm"

INCLUDE "engine/display_event_routines.asm" ;5FD1

db "BANKE"

;6438 rest of bank empty



SECTION "bankF",ROMX,BANK[$F]

hotgenStudiosLogoTilemap: 	INCBIN "gfx/tilemaps/hotgen_studios_logo.2bpp" ;4000
hotgenStudiosLogoPalette: 	INCBIN "gfx/tilemaps/hotgen_studios_logo.pal" ;4C70

mainFont: 					INCBIN "gfx/main_font.2bpp" ;4CB0
mainFontBold: 				INCBIN "gfx/main_font_bold.2bpp"

INCLUDE "engine/rooms_elevations.asm" ;5BB0
INCLUDE "engine/numeric_panel_routines.asm" ;5DCB

;6131 rest of bank is empty


;===========================================
;
; ROOMS BACKGROUNDS BANKS SECTIONS ($10-$C3)
;
;
INCLUDE "data/rooms/rooms_bgs_sections.asm" ; this takes up 60% of rom space
;
;===========================================


SECTION "bankC4",ROMX,BANK[$C4]

firstZombieSceneTilemap:	INCBIN "gfx/tilemaps/first_zombie_scene.2bpp" ;4000
firstZombieScenePalette:	INCBIN "gfx/tilemaps/first_zombie_scene.pal" ;4FA0

fallingStatueTilemap:	    INCBIN "gfx/tilemaps/falling_statue.2bpp" ;4FE0
fallingStatuePalette:		INCBIN "gfx/tilemaps/falling_statue.pal" ;6240

INCLUDE "engine/sprites/check_enemy_on_room_screen_visibility.asm" ;C4:6280
INCLUDE "engine/sprites/check_object_on_room_screen_visibility.asm" ;C4:6421

INCLUDE "data/rooms/especial_room_colliders.asm"

INCLUDE "engine/sprites/check_especial_rooms_colliders_collision.asm" ;C4:64FB

INCLUDE "engine/math/math_utils_bank_c4.asm" ;C4:66E7

;6734 rest of bank is empty




SECTION "bankC5",ROMX,BANK[$C5]

INCLUDE "data/rooms/rooms_actions_and_entities_table.asm" ;4000
INCLUDE "data/rooms/rooms_actions_and_entities.asm" ;40E8

INCLUDE "data/rooms/doors_ids_table.asm" ;5B5B

INCLUDE "data/initial_flags_values.asm" ;5F25
INCLUDE "engine/init_game_flags.asm" ;6273

INCLUDE "engine/actions/check_room_actions.asm"
INCLUDE "engine/actions/detect_room_action_by_button_press.asm" ;C5:63A8
INCLUDE "engine/actions/detect_pick_up_dropped_item.asm" ;C5:6467
INCLUDE "engine/actions/detect_door_interaction.asm" ;C5:6519
INCLUDE "engine/actions/detect_typewriter_interaction.asm" ;C5:6638
INCLUDE "engine/actions/detect_itembox_interaction.asm" ;C5:66C8

INCLUDE "engine/actions/check_door_unlocked.asm" ;C5:66C8

INCLUDE "engine/menus/inventory_search_routines.asm"

INCLUDE "engine/get_room_item_flag.asm" ;C5:6A80

INCLUDE "engine/load_room_entities_data.asm" ;C5:6ADC

INCLUDE "engine/math/math_utils_bank_c5.asm" ;C5;6C57

;C5:6C85 rest of bank is empty




SECTION "rooms camera change",ROMX,BANK[$C6]

INCLUDE "engine/backgrounds/check_room_camera_change.asm" ; 4000

INCLUDE "engine/math/math_utils_bank_c6.asm" ; 64E1

;652E rest of bank is empty



SECTION "bank_C7",ROMX,BANK[$C7]

stairsTypeATilemap:		INCBIN "gfx/tilemaps/stairs_type_a.2bpp" ;4000
stairsTypeAPalette:		INCBIN "gfx/tilemaps/stairs_type_a.pal" ;44E0

stairsTypeBTilemap:		INCBIN "gfx/tilemaps/stairs_type_b.2bpp" ;4520
stairsTypeBPalette:		INCBIN "gfx/tilemaps/stairs_type_b.pal" ;4A40

ladderTilemap:			INCBIN "gfx/tilemaps/ladder.2bpp" ;4A80
ladderTilemapPalette:	INCBIN "gfx/tilemaps/ladder.pal" ;4DB0

ropeTilemap:			INCBIN "gfx/tilemaps/rope.2bpp" ;4DF0
ropeTilemapPalette:		INCBIN "gfx/tilemaps/rope.pal" ;5110

;5150 rest of bank empty



SECTION "bank_C8",ROMX,BANK[$C8]

objects_spritesheet:	                INCBIN "gfx/sprite_sheets/objects/objects_spritesheet.2bpp"



SECTION "bank_C9",ROMX,BANK[$C9]

INCLUDE "text/room_actions_messages.asm"

;67CE rest of bank empty



SECTION "bank_CA",ROMX,BANK[$CA]
rebecca_front_spritesheet:				INCBIN "gfx/sprite_sheets/rebecca/rebecca_front_spritesheet.2bpp"
rebecca_front_right_spritesheet:		INCBIN "gfx/sprite_sheets/rebecca/rebecca_front_right_spritesheet.2bpp"
rebecca_right_spritesheet:				INCBIN "gfx/sprite_sheets/rebecca/rebecca_right_spritesheet.2bpp"

SECTION "bank_CB",ROMX,BANK[$CB]
rebecca_back_right_spritesheet:			INCBIN "gfx/sprite_sheets/rebecca/rebecca_back_right_spritesheet.2bpp"
rebecca_back_spritesheet:				INCBIN "gfx/sprite_sheets/rebecca/rebecca_back_spritesheet.2bpp"
rebecca_back_left_spritesheet:			INCBIN "gfx/sprite_sheets/rebecca/rebecca_back_left_spritesheet.2bpp"

SECTION "bank_CC",ROMX,BANK[$CC]
rebecca_left_spritesheet:				INCBIN "gfx/sprite_sheets/rebecca/rebecca_left_spritesheet.2bpp"
rebecca_front_left_spritesheet:			INCBIN "gfx/sprite_sheets/rebecca/rebecca_front_left_spritesheet.2bpp"


;wesker/barry spritesheet
SECTION "bank_CD",ROMX,BANK[$CD]
weskerbarry_front_spritesheet:			INCBIN "gfx/sprite_sheets/weskerbarry/weskerbarry_front_spritesheet.2bpp"
weskerbarry_front_right_spritesheet:	INCBIN "gfx/sprite_sheets/weskerbarry/weskerbarry_front_right_spritesheet.2bpp"
weskerbarry_right_spritesheet:			INCBIN "gfx/sprite_sheets/weskerbarry/weskerbarry_right_spritesheet.2bpp"

SECTION "bank_CE",ROMX,BANK[$CE]
weskerbarry_back_right_spritesheet:		INCBIN "gfx/sprite_sheets/weskerbarry/weskerbarry_back_right_spritesheet.2bpp"
weskerbarry_back_spritesheet:			INCBIN "gfx/sprite_sheets/weskerbarry/weskerbarry_back_spritesheet.2bpp"
weskerbarry_back_left_spritesheet:		INCBIN "gfx/sprite_sheets/weskerbarry/weskerbarry_back_left_spritesheet.2bpp"

SECTION "bank_CF",ROMX,BANK[$CF]
weskerbarry_left_spritesheet:			INCBIN "gfx/sprite_sheets/weskerbarry/weskerbarry_left_spritesheet.2bpp"
weskerbarry_front_left_spritesheet:		INCBIN "gfx/sprite_sheets/weskerbarry/weskerbarry_front_left_spritesheet.2bpp"



;zombie spritesheets
SECTION "bank_D0",ROMX,BANK[$D0]
zombie_front_spritesheet:			        INCBIN "gfx/sprite_sheets/zombie/zombie_front_spritesheet.2bpp"
zombie_front_right_spritesheet:		        INCBIN "gfx/sprite_sheets/zombie/zombie_front_right_spritesheet.2bpp"
zombie_right_spritesheet:			        INCBIN "gfx/sprite_sheets/zombie/zombie_right_spritesheet.2bpp"
zombie_back_right_spritesheet:		        INCBIN "gfx/sprite_sheets/zombie/zombie_back_right_spritesheet.2bpp"
zombie_back_spritesheet:			        INCBIN "gfx/sprite_sheets/zombie/zombie_back_spritesheet.2bpp"

SECTION "bank_D1",ROMX,BANK[$D1]
zombie_back_left_spritesheet:		        INCBIN "gfx/sprite_sheets/zombie/zombie_back_left_spritesheet.2bpp"
zombie_left_spritesheet:			        INCBIN "gfx/sprite_sheets/zombie/zombie_left_spritesheet.2bpp"
zombie_front_left_spritesheet:		        INCBIN "gfx/sprite_sheets/zombie/zombie_front_left_spritesheet.2bpp"

SECTION "bank_D2",ROMX,BANK[$D2]
zombie_overhead_front_spritesheet:			INCBIN "gfx/sprite_sheets/zombie/zombie_overhead_front_spritesheet.2bpp"
zombie_overhead_front_right_spritesheet:	INCBIN "gfx/sprite_sheets/zombie/zombie_overhead_front_right_spritesheet.2bpp"
zombie_overhead_right_spritesheet:			INCBIN "gfx/sprite_sheets/zombie/zombie_overhead_right_spritesheet.2bpp"
zombie_overhead_back_right_spritesheet:		INCBIN "gfx/sprite_sheets/zombie/zombie_overhead_back_right_spritesheet.2bpp"
zombie_overhead_back_spritesheet:			INCBIN "gfx/sprite_sheets/zombie/zombie_overhead_back_spritesheet.2bpp"

SECTION "bank_D3",ROMX,BANK[$D3]
zombie_overhead_back_left_spritesheet:		INCBIN "gfx/sprite_sheets/zombie/zombie_overhead_back_left_spritesheet.2bpp"
zombie_overhead_left_spritesheet:			INCBIN "gfx/sprite_sheets/zombie/zombie_overhead_left_spritesheet.2bpp"
zombie_overhead_front_left_spritesheet:		INCBIN "gfx/sprite_sheets/zombie/zombie_overhead_front_left_spritesheet.2bpp"



SECTION "bank_D4",ROMX,BANK[$D4]

;empty bank

SECTION "bank_D5",ROMX,BANK[$D5]

;empty bank

SECTION "bank_D6",ROMX,BANK[$D6]

;empty bank

SECTION "bank_D7",ROMX,BANK[$D7]

;empty bank



; overhead jill sprites
SECTION "bank_D8",ROMX,BANK[$D8]
jill_overhead_front_spritesheet:		INCBIN "gfx/sprite_sheets/jill/jill_overhead_front_spritesheet.2bpp"

SECTION "bank_D9",ROMX,BANK[$D9]
jill_overhead_front_right_spritesheet:	INCBIN "gfx/sprite_sheets/jill/jill_overhead_front_right_spritesheet.2bpp"

SECTION "bank_DA",ROMX,BANK[$DA]
jill_overhead_right_spritesheet:		INCBIN "gfx/sprite_sheets/jill/jill_overhead_right_spritesheet.2bpp"

SECTION "bank_DB",ROMX,BANK[$DB]
jill_overhead_back_right_spritesheet:	INCBIN "gfx/sprite_sheets/jill/jill_overhead_back_right_spritesheet.2bpp"

SECTION "bank_DC",ROMX,BANK[$DC]
jill_overhead_back_spritesheet:			INCBIN "gfx/sprite_sheets/jill/jill_overhead_back_spritesheet.2bpp"

SECTION "bank_DD",ROMX,BANK[$DD]
jill_overhead_back_left_spritesheet:	INCBIN "gfx/sprite_sheets/jill/jill_overhead_back_left_spritesheet.2bpp"

SECTION "bank_DE",ROMX,BANK[$DE]
jill_overhead_left_spritesheet:			INCBIN "gfx/sprite_sheets/jill/jill_overhead_left_spritesheet.2bpp"

SECTION "bank_DF",ROMX,BANK[$DF]
jill_overhead_front_left_spritesheet:	INCBIN "gfx/sprite_sheets/jill/jill_overhead_front_left_spritesheet.2bpp"



; chris sprites
SECTION "bank_E0",ROMX,BANK[$E0]
chris_front_spritesheet:			INCBIN "gfx/sprite_sheets/chris/chris_front_spritesheet.2bpp"

SECTION "bank_E1",ROMX,BANK[$E1]
chris_front_right_spritesheet:		INCBIN "gfx/sprite_sheets/chris/chris_front_right_spritesheet.2bpp"

SECTION "bank_E2",ROMX,BANK[$E2]
chris_right_spritesheet:			INCBIN "gfx/sprite_sheets/chris/chris_right_spritesheet.2bpp"

SECTION "bank_E3",ROMX,BANK[$E3]
chris_back_right_spritesheet:		INCBIN "gfx/sprite_sheets/chris/chris_back_right_spritesheet.2bpp"

SECTION "bank_E4",ROMX,BANK[$E4]
chris_back_spritesheet:				INCBIN "gfx/sprite_sheets/chris/chris_back_spritesheet.2bpp"

SECTION "bank_E5",ROMX,BANK[$E5]
chris_back_left_spritesheet:		INCBIN "gfx/sprite_sheets/chris/chris_back_left_spritesheet.2bpp"

SECTION "bank_E6",ROMX,BANK[$E6]
chris_left_spritesheet:				INCBIN "gfx/sprite_sheets/chris/chris_left_spritesheet.2bpp"

SECTION "bank_E7",ROMX,BANK[$E7]
chris_front_left_spritesheet:		INCBIN "gfx/sprite_sheets/chris/chris_front_left_spritesheet.2bpp"

SECTION "bank_E8",ROMX,BANK[$E8]
chris_overhead_front_spritesheet:	INCBIN "gfx/sprite_sheets/chris/chris_overhead_front_spritesheet.2bpp"

SECTION "bank_E9",ROMX,BANK[$E9]
chris_overhead_front_right_spritesheet:		INCBIN "gfx/sprite_sheets/chris/chris_overhead_front_right_spritesheet.2bpp"

SECTION "bank_EA",ROMX,BANK[$EA]
chris_overhead_right_spritesheet:			INCBIN "gfx/sprite_sheets/chris/chris_overhead_right_spritesheet.2bpp"

SECTION "bank_EB",ROMX,BANK[$EB]
chris_overhead_back_right_spritesheet:		INCBIN "gfx/sprite_sheets/chris/chris_overhead_back_right_spritesheet.2bpp"

SECTION "bank_EC",ROMX,BANK[$EC]
chris_overhead_back_spritesheet:			INCBIN "gfx/sprite_sheets/chris/chris_overhead_back_spritesheet.2bpp"

SECTION "bank_ED",ROMX,BANK[$ED]
chris_overhead_back_left_spritesheet:		INCBIN "gfx/sprite_sheets/chris/chris_overhead_back_left_spritesheet.2bpp"

SECTION "bank_EE",ROMX,BANK[$EE]
chris_overhead_left_spritesheet:			INCBIN "gfx/sprite_sheets/chris/chris_overhead_left_spritesheet.2bpp"

SECTION "bank_EF",ROMX,BANK[$EF]
chris_overhead_front_left_spritesheet:		INCBIN "gfx/sprite_sheets/chris/chris_overhead_front_left_spritesheet.2bpp"


; jill spritesheets
SECTION "bank_F0",ROMX,BANK[$F0]
jill_front_spritesheet:				INCBIN "gfx/sprite_sheets/jill/jill_front_spritesheet.2bpp"

SECTION "bank_F1",ROMX,BANK[$F1]
jill_front_right_spritesheet:		INCBIN "gfx/sprite_sheets/jill/jill_front_right_spritesheet.2bpp"

SECTION "bank_F2",ROMX,BANK[$F2]
jill_right_spritesheet:				INCBIN "gfx/sprite_sheets/jill/jill_right_spritesheet.2bpp"

SECTION "bank_F3",ROMX,BANK[$F3]
jill_back_right_spritesheet:		INCBIN "gfx/sprite_sheets/jill/jill_back_right_spritesheet.2bpp"

SECTION "bank_F4",ROMX,BANK[$F4]
jill_back_spritesheet:				INCBIN "gfx/sprite_sheets/jill/jill_back_spritesheet.2bpp"

SECTION "bank_F5",ROMX,BANK[$F5]
jill_back_left_spritesheet:			INCBIN "gfx/sprite_sheets/jill/jill_back_left_spritesheet.2bpp"

SECTION "bank_F6",ROMX,BANK[$F6]
jill_left_spritesheet:				INCBIN "gfx/sprite_sheets/jill/jill_left_spritesheet.2bpp"

SECTION "bank_F7",ROMX,BANK[$F7]
jill_front_left_spritesheet:		INCBIN "gfx/sprite_sheets/jill/jill_front_left_spritesheet.2bpp"




SECTION "bank_F8",ROMX,BANK[$F8]

INCLUDE "text/event_messages_names.asm"

INCLUDE "text/event_text_scripts.asm"




SECTION "bank_F9",ROMX,BANK[$F9]

INCLUDE "text/files_texts.asm" ;4000
INCLUDE "text/doors_interactions_texts.asm" ;6D04

;71BD rest of bank empty



SECTION "text pointers",ROMX,BANK[$FA]

INCLUDE "text/texts_pointers.asm" ;4000

INCLUDE "text/items_names.asm" ;48EC
INCLUDE "text/include_item_texts.asm" ;4F3C

INCLUDE "text/start_game_messages.asm" ;59FA

INCLUDE "text/items_descriptions.asm"

INCLUDE "text/cleared_texts.asm"

;FA:64A0 rest of bank is empty




SECTION "sprites collisions",ROMX,BANK[$FB]

INCLUDE "engine/sprites/load_room_screen_sprites.asm" ; 4000

INCLUDE "data/rooms/rooms_bgs_items_sprites_table.asm" ; 4762

INCLUDE "data/entities/object_entities_colliders_table.asm" ; 4BF4

INCLUDE "engine/sprites/check_sprites_collision.asm" ; FB:4C94
INCLUDE "engine/sprites/check_objects_collision.asm" 
INCLUDE "engine/sprites/check_zombie_collision.asm" 

INCLUDE "engine/sprites/search_npc.asm"

INCLUDE "data/entities/objects_move_table.asm"

INCLUDE "engine/sprites/detect_zombie_collision.asm"  ; FB:4FFA
INCLUDE "engine/sprites/detect_object_collision.asm"  ; FB:50D6

INCLUDE "engine/sprites/check_zombies_attack_collision.asm"  ; FB:5211
INCLUDE "engine/sprites/check_zombies_proximity.asm"  ; FB:535F

INCLUDE "engine/math/math_utils_bank_fb.asm" ; FB:5481

;54CE rest of bank empty




SECTION "BankFC",ROMX,BANK[$FC]

INCLUDE "data/entities/enemies_boundaries_table.asm"

INCLUDE "engine/sprites/check_enemies_boundaries.asm" ;FC:41E4

INCLUDE "engine/sprites/update_zombie_and_objects_animations.asm" ;FC:42AA


; player movement, animations and inputs logic
INCLUDE "engine/player/update_player_input_logic.asm" ;FC:44DB

INCLUDE "engine/player/check_weapon_aim_and_attack.asm" ;45FA

INCLUDE "engine/player/update_player_movement.asm" ;FC:4794

INCLUDE "engine/math/math_utils_bank_fc.asm" ;FC:4982

INCLUDE "engine/player/detect_shot_hit.asm" ; FC:49B0



INCLUDE "engine/sprites/sprite_list_sorter.asm" ;FC:4CAA

; main menu data
INCLUDE "data/main_menu_cursors_data.asm" ;4CF4

INCLUDE "engine/menus/update_main_menu_slots_cursors.asm" ;4DBA

itemBoxMenuTilemap:		INCBIN "gfx/tilemaps/item_box_menu.2bpp" ;4EBC
itemBoxMenuPalette:		INCBIN "gfx/tilemaps/item_box_menu.pal" ;5B60

;5BE0 rest of bank empty




SECTION "bankFD",ROMX,BANK[$FD]

INCLUDE "data/rooms/rooms_boundaries.asm" ;4000

INCLUDE "engine/sprites/check_room_boundaries.asm" ;FD:43A0

INCLUDE "data/rooms/rooms_colliders_table.asm"
INCLUDE "data/rooms/rooms_colliders.asm"

INCLUDE "engine/sprites/check_room_colliders_collision.asm" ;FD:511C

INCLUDE "engine/math/math_utils_bank_fd.asm" ;FD:524A

INCLUDE "engine/backgrounds/set_priority_flags_on_rooms_bg.asm"


entitiesSpritesheetsTables: ;FD:52EB
INCLUDE "data/sprite_sheets_tables/chris_sprite_sheets_table.asm"
INCLUDE "data/sprite_sheets_tables/jill_sprite_sheets_table.asm"
INCLUDE "data/sprite_sheets_tables/wesker_barry_sprite_sheets_table.asm"
INCLUDE "data/sprite_sheets_tables/rebecca_sprite_sheets_table.asm"
INCLUDE "data/sprite_sheets_tables/zombie_sprite_sheets_table.asm"
INCLUDE "data/sprite_sheets_tables/objects_sprite_sheets_table.asm"
INCLUDE "data/sprite_sheets_tables/yawn_sprite_sheets_table.asm"


;yawn spritesheets
yawn_back_right_spritesheet:	INCBIN "gfx/sprite_sheets/yawn/yawn_back_right_spritesheet.2bpp" ;FD:69EB

SECTION "yawn sprite sheets",ROMX,BANK[$FE]
yawn_right_spritesheet:			INCBIN "gfx/sprite_sheets/yawn/yawn_right_spritesheet.2bpp"
yawn_front_right_spritesheet:   INCBIN "gfx/sprite_sheets/yawn/yawn_front_right_spritesheet.2bpp"
yawn_front_spritesheet:      	INCBIN "gfx/sprite_sheets/yawn/yawn_front_spritesheet.2bpp"
yawn_front_left_spritesheet:    INCBIN "gfx/sprite_sheets/yawn/yawn_front_left_spritesheet.2bpp"
yawn_left_spritesheet:      	INCBIN "gfx/sprite_sheets/yawn/yawn_left_spritesheet.2bpp"
yawn_back_left_spritesheet:     INCBIN "gfx/sprite_sheets/yawn/yawn_back_left_spritesheet.2bpp"
yawn_back_spritesheet:      	INCBIN "gfx/sprite_sheets/yawn/yawn_back_spritesheet.2bpp"



SECTION "play title PCM",ROMX,BANK[$FF]

INCLUDE "audio/pcm/play_title_pcm.asm"

titleVoicePcm:      INCBIN "audio/pcm/title_voice.pcm" ;FF:4098

; FF:6040 rest of bank empty





