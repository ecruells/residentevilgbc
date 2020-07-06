
; unused rst vectors
SECTION "rst 00", ROM0 [$00]
	nop
SECTION "rst 08", ROM0 [$08]
	nop
SECTION "rst 10", ROM0 [$10]
	nop
SECTION "rst 18", ROM0 [$18]
	nop
SECTION "rst 20", ROM0 [$20]
	nop
SECTION "rst 28", ROM0 [$28]
	nop
SECTION "rst 30", ROM0 [$30]
	nop
SECTION "rst 38", ROM0 [$38]
	nop

; Hardware interrupts
SECTION "vblank", ROM0 [$40]
	jp vblank
SECTION "lcdc", ROM0 [$48]
	jp lcdStatus
SECTION "timer",  ROM0 [$50]
	ret
SECTION "serial", ROM0 [$58]
	ret
SECTION "joypad", ROM0 [$60]
	ret


INCLUDE "gbhw.asm"


SECTION "Entry", ROM0 [$100]
	nop
	jp Start


	ROM_HEADER  ROM_MBC5_RAM_BAT, ROM_SIZE_4MBYTE, RAM_SIZE_8KBYTE


SECTION "Main", ROM0

Start:: ;00:0150
    di
    ld [wInitialRegisterValue], a

; select double speed mode
.cpuSpeedLoop
    ld hl, rKEY1 ; select CPU speed
    bit 7, [hl] ; read current CPU speed
    jr nz, .cpuSpeedLoop ; loop while cpu speed is not zero
    set 0, [hl] ; prepare for double speed mode
    xor a
    ld [rIF], a ;interrupt flag
    ld [rIE], a ;interrupt enable
    ld a, $30
    ld [_HW], a ;write joypad info
    stop

    xor a
    ld [rVBK], a ;vram bank select

initGame:: ;00:016B
    di
    ld sp, $E000 ;init stack pointer
    xor a
    ld [rAUDENA], a ;disable sound (NR52)
    ld [rSTAT], a ;lcd status
    ld [rIF], a ;interrupt flag
    ld [rIE], a ;interrupt enable
    ld [rVBK], a ;vram bank select
    ld [rSCX], a ;scroll screen X
    ld [rSCY], a ;scroll screen Y
    ld a, [wInitialRegisterValue]
    push af

; clear work ram
    ld hl, wWorkRamStart
    ld bc, WRAM_LENGTH
.clearWramLoop
    ld [hl], 0
    inc hl
    dec bc
    ld a, b
    or a, c
    jr nz, .clearWramLoop

    pop af
    ld [wInitialRegisterValue], a
    ld a, $01
    call bankSwitch
    call initOAMDMARoutine
    call hideSprites
    ld a, IEF_LCDC | IEF_VBLANK
    ld [rIE], a ; enable lcdc and vblank interrupts
    ld a, $10
    ld [rWY], a ;window Y pos
    ld a, $08
    ld [rWX], a ;window X pos
    ld a, LCDCF_ON | LCDCF_OBJ16 | LCDCF_OBJON | LCDCF_BGON
    ld [rLCDC], a ; lcd control
    ld a, STATF_LYC
    ld [rSTAT], a ; lcd status
    call muteAudio
    ei

    call haltCPU
    ld a,LCDCF_ON | LCDCF_OBJ16 | LCDCF_OBJON | LCDCF_BGON
    ld [rLCDC], a ; lcd control
    call hideSprites
    xor a
    ld [wScreenYPos], a
    call clearExtRAM
    call enableExtRAM
; check for quick save
    ld a, [sQuickSaveFlag01]
    cp a, SAVE_GAME_FLAG_1
    jr nz, titleScreenActions
    ld a, [sQuickSaveFlag02]
    cp a, SAVE_GAME_FLAG_2
    jr nz, titleScreenActions
    ld a, [sQuickSaveFlag03]
    cp a, SAVE_GAME_FLAG_3
    jr nz, titleScreenActions
; load quick save
    ld hl, wButtonPressId
    ld de, sSRamStart
    ld bc, SAVE_SLOT_LENGTH
.loop1E9
    ld a, [de]
    ld [hli], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, .loop1E9
    ld hl, sQuickSaveFlag01
; reset quick save flags
    xor a
    ld [wSaveGameFlag1], a
    ld [wSaveGameFlag2], a
    ld [wSaveGameFlag3], a
    call disableExtRAM
    ld hl, restartGame
    push hl ; set return point from resumed game
    jp restorePauseMenu


titleScreenActions::
    call disableExtRAM
.backToTitleScreen
    ld a, $FF
    ld [wCurrentMusicId], a
    call loadTitleScreen
    call resetPalettes
; title screen option choosed
    ld a, [wCursorPosId]
    ld [wCursorIdBuffer], a
    or a ; 0
    jr z, .newGame
; 1 for load game screen
    ld a, LOAD_GAME_MODE
    call loadSaveGameMenu
    ld a, [wCursorPosId]
    cp a, 4
    jr z, .backToTitleScreen ; if exit from load game screen
; saved game loaded
    jr .startGame
.newGame
    call loadPlayerSelectScreen
    ld a, [wCursorPosId]
    ld [wSelectedCharacter], a
.startGame
    call displayStartGameWelcomeMessage
    call initGameDataAndStartGame

restartGame::
    ld a, [wEntityHealth]
    or a
    call z, showDeathScreen
    jp initGame
;246


INCLUDE "home/audio.asm"
INCLUDE "home/jumper_routines.asm"
INCLUDE "home/routine_delay.asm"
INCLUDE "home/joypad.asm"
INCLUDE "home/bankswitch.asm"
INCLUDE "home/lcdstatus.asm"
INCLUDE "home/vblank.asm"
INCLUDE "home/softreset.asm"

; initialize selected player game data and set the position of the player sprite
; at front of the dining room door from main hall 1f
initGameDataAndStartGame:: ;00:039D
    ld a, $01
    ld [wVisitedRoomsFlags], a
    ld a, $FF
    ld [wRoomCameraId], a
    ld a, MAIN_HALL_1F
    ld [wRoomId], a
    xor a
    ld [wRoomIdHigh], a
    call initSelectedCharacterGameDataCaller
    ld a, BANK(roomsActionsDatatable)
    call bankSwitch
    ld a, [wRoomId]
    ld l, a
    ld a, [wRoomIdHigh]
    ld h, a
    add hl, hl
    ld de, roomsActionsDatatable
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld de, 5 ; offset to door action position
    add hl, de
    ld a, [hli]
    ld [wEntityPositionX], a
    ld a, [hli]
    ld [wEntityPositionX+1], a
    ld a, [hli]
    ld [wEntityPositionZ], a
    ld a, [hli]
    ld [wEntityPositionZ+1], a
    ld a, [hli]
    ld [wEntityFacing], a
    ld a, $01
    call bankSwitch

newGameStartSceneSet: ;03E5
	call initGameFlagsCaller
    call loadRoomEntitiesDataCaller
    ld a, SET_FADE_IN
    ld [wPaletteFadeCounter], a
; play main theme, does not change in the entire game
    ld a, DEFAULT_MAIN_THEME
    ld [wRoomMusicId], a
; set new game first scene
    ld a, MAIN_HALL_OPENING_SCENE
    ld [wEventSceneId], a
    ld hl, $4E2 ; set ticks counter
    ld a, l
    ld [wTicksCounter], a
    ld a, h
    ld [wTicksCounterHigh], a


; event scene check before start game loop
gameLoopWithEventCheck: ;405
	call hideSprites
    call haltCPU
    xor a 
    ld [wScreenYPos], a ; scrnY = 0
    call loadRoomScreenCameraAndBgData
    ld a, [wEventSceneId]
    or a
    jr z, .resumeGameplayLoop ; jump if there is not a event to show
; if an event scene was triggered
    call resetPalettes
    call displayEventSceneCaller
    push af
    xor a
    ld [wEventSceneId], a ; reset event scene
    call resetPalettes
    call loadRoomEntitiesDataCaller
    pop af
    cp a, $FF
    jp nz, openTakeItemMenu ; if scene finish by getting an item
    ld a, SET_FADE_IN-1
    ld [wPaletteFadeCounter], a
; update player sprite ID
    ld c, CHRIS
    ld a, [wSelectedCharacter]
    or a
    jr z, .Label43E ; if chris
; else set jill as player
    ld c, JILL
.Label43E
    ld a, c
    ld [wEntityId], a
    jr gameLoopWithEventCheck
.resumeGameplayLoop
    ld a, 8
    ld [wFrameRateCounter], a
;0449


; this is the main gameplay loop
;
; the gameplay framerate tries to run as fast as it can. With nothing in a room, but only the player sprite,
; the fps are ~30fps, but with each new npc sprite added, the framerate is cut by half, so to avoid fps abrupt 
; variations, the framerate is cut by 4 to maintain an "stable" framerate of ~14fps.
mainGameLoop: ;00:0449
    call haltCPU
    ld a, [wFrameRateCounter]
    cp a, 4
    jr c, mainGameLoop ; limit framerate
; print debug info at the bottom of the screen
    ld hl, _SCRN0+$200 ;tile pos
    ld a, [wRoomCameraId]
    ld e, a
    ld a, [wRoomId]
    ld d, a
    call printDebugWord ; print room & screen Id
    ld hl, _SCRN0+$205
    ld a, [wEntityPositionX]
    ld e, a
    ld a, [wEntityPositionX+1]
    ld d, a
    call div8Word
    call printDebugWord ; print player X position
    ld hl, _SCRN0+$20A
    ld a, [wEntityPositionZ]
    ld e, a
    ld a, [wEntityPositionZ+1]
    ld d, a
    call div8Word
    call printDebugWord ; print player Y position
    ld hl, _SCRN0+$20F
    ld a, [wEntityFacing]
    ld e, a
    ld d, $00
    call printDebugWord ; print player facing
    ld hl, _SCRN0+$220
    ld a, [wEntityZOrder]
    ld e, a
    ld a, [wRotateFloor2AnimId]
    ld d, a
    call printDebugWord
    ld hl, _SCRN0+$225
    ld a, [wEntityPositionY]
    ld e, a
    ld a, [wEntityPositionY+1]
    ld d, a
    call printDebugWord ; print player Z-elevation
    ld hl, $0000
    add hl, sp
    push hl
    pop de
    ld hl, _SCRN0+$22A
    call printDebugWord ; print stack pointer
; end debug info
    xor a
    ld [wFrameRateCounter], a ; reset framerate counter

    call resetSpriteStructsBuffers
    call calcAllSpritesSizeAndScreenPosition
    call loadRoomScreenSpritesCaller
    call hideOAM
    call sortSpriteListByDrawPriorityCaller
    call loadAllSpritesTilesData
    call enableHDMA
    call swapCurrentOAMBuffer
    call updatePlayerInputsCaller
    ld a, [wActionButtonEventId]
    cp a, DROPPED_ITEM_ACTION
    jp z, includeDroppedItem
    call updateZombieAndObjectsAnimationCaller
    call checkEnemyBoundariesCaller
    call checkRoomBoundariesCaller
    call checkSpritesCollisionCaller
    call checkRoomsCollidersCollisionCaller
    call checkEspecialRoomCollidersCollisionCaller
    call checkRoomCameraChangeCaller
    or a
    jp nz, cameraChangeTransition

    call checkRoomsActionsCaller
    ld a, [wActionButtonEventId]
    cp a, BTN_CHECK_ACTION
    call z, checkButtonActionEventsCaller
    ld a, [wActionButtonEventId]
    cp a, OPEN_DOOR_ACTION
    jp z, showDoorTransitions
    cp a, LOAD_SAVE_MENU_ACTION
    jp z, openSaveGameMenu
    cp a, GET_ITEM_ACTION
    jp z, openTakeItemMenu
    cp a, ITEMBOX_MENU_ACTION
    jp z, openItemboxMenu

; set current room as visited
    ld a, [wRoomId]
    ld e, a
    ld a, [wRoomIdHigh]
    ld d, a
    ld hl, wVisitedRoomsFlags
    add hl, de
    ld [hl], $01 ; set room visited flag

; update room gas damage
    call updateRoomGasDamageCaller

; update tick counter
    ld a, [wTicksCounter]
    dec a
    ld [wTicksCounter], a

; update room animation masks
    call updateRoomBgAnimationMasks

; check open main menu
    ld a, [wPaletteFadeCounter]
    cp a, FADE_OUT_FINISHED
    jp z, openMainMenu ; if bg palette is fully faded out, then open main menu
    or a
    jr nz, .skipOpenMenu
    ld a, [wButtonPressId]
    and a, SELECT_INPUT
    jr z, .skipOpenMenu
    ld a, CHANGE_SCREEN_FADE_OUT
    ld [wPaletteFadeCounter], a ; set open main menu

.skipOpenMenu
    ld a, [wButtonPressId]
    and a, START_INPUT
    jp nz, showPauseScreen

; check event scene
    ld a, [wEventSceneId]
    or a
    jp nz, restartFrameWithEventCheck

; check room palette update
    ld a, [wPaletteFadeCounter]
    push af
    call updateRoomPalette
    pop bc
    ld a, [wPaletteFadeCounter]
    or a
    jr nz, .continueNextTick
    ld a, b
    cp a, $01
    jr nz, .continueNextTick

; update room music id
    ld a, [wRoomMusicId]
    ld c, a
    ld a, [wCurrentMusicId]
    cp a, c
    jr z, .continueNextTick
    ld a, c
    call playMusic
.continueNextTick
    jp mainGameLoop
;57E



resetAndUpdatePalette: ;00:057E
    call haltCPU
    call hideSprites
    call resetPalettes
    ld a, UPDATE_BG_PALETTE
    ld [wPaletteFadeCounter], a
    ret
;058D


openMainMenu: ;00:058D
    ld a, [wEntityHealth]
    or a
    ret z ; if player is dead, return back to stored restartGame pointer
    call mainMenuRoutine
    ld a, UPDATE_BG_PALETTE
    ld [wPaletteFadeCounter], a
    jp gameLoopWithEventCheck
;059D


openItemboxMenu: ;00:059D
    call resetPalettes
    call hideSprites
    call itemboxMenu
    ld a, UPDATE_BG_PALETTE
    ld [wPaletteFadeCounter], a
    jp gameLoopWithEventCheck


cameraChangeTransition: ;00:05AE
    call resetAndUpdatePalette
    call loadRoomScreenSpritesCaller
    call updateZombieAndObjectsAnimationCaller
    call calcAllSpritesSizeAndScreenPosition
    jp gameLoopWithEventCheck
;05BD

checkButtonActionEventsCaller: ;00:05BD
    call checkButtonActionEvents
    ret
;5C1


showDoorTransitions: ;00:05C1
    call resetPalettes
    ld a, [wDoorAnimationType]
    cp a, STAIRS_1_UPWARD
    jr c, normalDoorAnimation
; special room transition
    call displayTilemapRoomsTransitions
    jr Label5D3
normalDoorAnimation
    call showSpriteDoorsAnimation
Label5D3
    ld a, UPDATE_BG_PALETTE
    ld [wPaletteFadeCounter], a
    call checkRoomCameraChangeCaller
    call loadRoomEntitiesDataCaller
    jp gameLoopWithEventCheck


openSaveGameMenu: ;5E1
    ld a, NO_MUSIC
    call playMusic
    call resetPalettes
    ld a, IDLE_ANIM
    ld [wEntityAnimationId], a
    xor a
    ld [wEntityAnimationFrameId], a
    ld a, SAVE_GAME_MODE
    call loadSaveGameMenu
    ld a, UPDATE_BG_PALETTE
    ld [wPaletteFadeCounter], a
    jp gameLoopWithEventCheck
;5FF


includeDroppedItem: ;5FF
    ld a, [wFoundItemId]
    ld [wSelectedItemId], a
openTakeItemMenu: ;00:0605
    call takeItemMenu
    ld a, UPDATE_BG_PALETTE
    ld [wPaletteFadeCounter], a
    jp gameLoopWithEventCheck
;610


INCLUDE "engine/display_event_home_routines.asm" ;00:0610

;73B
restartFrameWithEventCheck: ;73B
    call resetPalettes
    jp gameLoopWithEventCheck
;0741

INCLUDE "engine/backgrounds/load_room_screen_camera_and_bg.asm" ;00:0741

INCLUDE "home/caller_routines.asm" ;00:0829

INCLUDE	"engine/sprite_transformation/sprites_size_and_screen_posicion_calc_routines.asm"

INCLUDE "home/display_message_routines.asm" ;0C0A


INCLUDE "home/scroll_screen.asm" ;00:0C4C


INCLUDE "engine/sprite_transformation/scale_and_load_doors_sprites.asm"

INCLUDE "engine/sprite_transformation/rotation_matrix_and_projection_routines.asm"
INCLUDE "engine/sprite_transformation/rotation_math_utils.asm"


enableHDMA:: ;00:11AD
    ld a, $01
    ld [wHDMAFlag], a
    ret

INCLUDE "engine/sprites/update_firegun_sprite.asm" ; 00:11B3

INCLUDE "engine/sprites/load_sprites_data.asm" ; 00:1309

INCLUDE "data/luts/vertical_scale_lut.asm" ; 1397
INCLUDE "data/luts/vertical_scale_table.asm"

INCLUDE "engine/sprite_transformation/scale_and_load_sprite_tiles.asm" ; 00:2687

INCLUDE "engine/sprite_transformation/shrank_lines_shifting_routines.asm" ; 00:270B

INCLUDE "engine/sprite_transformation/scale_and_load_sprite_tiles_section_half.asm" ; 00:299F

INCLUDE "engine/sprites/load_room_sprites_routines.asm" ; 00:2A37

INCLUDE "engine/sprites/load_entity_sprite_tiles_data.asm"

INCLUDE "engine/sprites/load_and_scale_door_sprites.asm" ; 00:2D62

INCLUDE "engine/menus/load_and_save_game_menu.asm" ;00:2DD0

;00:2EE6
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop


INCLUDE  "data/tilemaps_structs.asm" ;00:2EEE

INCLUDE "engine/backgrounds/load_tilemap_image.asm" ;00:2FDC

INCLUDE "engine/backgrounds/load_room_background.asm" ;00:3073

INCLUDE "home/copy_data_routines.asm" ;00:321C

INCLUDE "home/load_palette.asm"

INCLUDE "engine/load_title_screen.asm"

INCLUDE "engine/menus/char_select_menu.asm" ;00:33EB

INCLUDE "engine/menus/item_detail_window_routines.asm" ;00:34A9


INCLUDE "home/load_bg_palette.asm" ;00:353C


;
; main menu routines
;

INCLUDE "data/main_menu_submenus_tilemaps.asm" ;356B

INCLUDE "engine/menus/update_submenus_tilemaps.asm" ;00:35BF

INCLUDE "engine/menus/take_item_menu.asm" ;00:366F

INCLUDE "engine/menus/display_selected_item_name.asm" ;00:36D2

INCLUDE "engine/menus/load_main_menu_tilemap.asm" ;00:3728


INCLUDE "home/load_font_tiles.asm" ;00:37B8


scrolldownTypingMessageCaller:: ;00:37DB
	ld a, BANK(scrolldownTypingMessage)
	ld hl, scrolldownTypingMessage
	jp jumpToHLRoutineC
;37E3


INCLUDE "engine/menus/main_menu_inputs_logic.asm" ;00:37E3


INCLUDE "engine/menus/char_select_update_idcard_position.asm" ;00:3C37


INCLUDE "engine/sprites/update_oam_routines.asm" ;00:3D04


waitDelay:: ;00:3D7F
	dec bc
	ld a, b
	or c
	jr nz, waitDelay
	ret


; get the OAM buffer address by checking the current OAM buffer flag
; Flag value:
;   0: $C9 default (stored in h)
;   1: $CA
getOamBufferAddress:: ;00:3D85
    push af
    ld a, [wCurrentOAMBufferFlag]
    or a
    jr nz, .Label3D8D
    inc h
.Label3D8D
    pop af
    ret


INCLUDE "home/print_text_routines.asm"


; iterate over all NPC data structures list and return (de) the first avariable slot
getFirstEmptyNPCDataSlot:: ;00:3EB8
    push bc
    ld de, wNPCEntitiesDataStructs
    ld b, 7 ; npcs sprites count
.loop3EBE
    ld a, [de]
    and a, ENTITY_ENABLED_FLAG
    jr z, .Label3ED0 ; return if NPC sprite is disabled
    ld a, e
    add a, $20 ; go to next NPCs sprite data
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    dec b
    jr nz, .loop3EBE
    pop bc
    ret
.Label3ED0 ;00:3ED0
    pop bc
    ret


; halts the cpu until vblank interrupt
haltCPU:: ;00:3ED2
    ld a, $FF
    ld [wHaltCPUFlag], a
.haltLoop
    halt
    ;nop
	ld a, [wHaltCPUFlag]
	or a
	jr nz, .haltLoop
	ret


INCLUDE "engine/menus/delete_saved_slot_text.asm" ;00:3EE0

INCLUDE "engine/menus/display_itembox_items_list.asm" ;00:3F43

; this routine continue in bank 1, no shiftable space left
INCLUDE "engine/menus/combine_items1.asm" ;00:3F92
