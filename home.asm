
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
	jp Vblank
SECTION "hblank", ROM0 [$48]
	jp Hblank
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


;SECTION "Header", ROM0 [$104]
;	ds $150 - $104

	ROM_HEADER  ROM_MBC5_RAM_BAT, ROM_SIZE_4MBYTE, RAM_SIZE_8KBYTE




SECTION "Main", ROM0

Start:: ;00:0150
    di ;disable interrupts
    ld [wc104], a

	;set CPU speed to normal
.cpuSpeedLoop
    ld hl, hCpuSpeedSelect ;$FF4D
    bit 7, [hl]
    jr nz, .cpuSpeedLoop ;loop while cpu speed is not zero
    set 0, [hl]
    xor a
    ld [rIF], a ;interrupt flag
    ld [rIE], a ;interrupt enable
    ld a, %00110000 ;$30
    ld [_HW], a ;write joypad info
    stop

    xor a
    ld [vramBank], a ;vram bank select

InitGame:: ;00:016B
    di
    ld sp, $E000 ;init stack pointer
    xor a
    ld [rAUDENA], a ;disable sound (NR52)
    ld [rSTAT], a ;lcd status
    ld [rIF], a ;interrupt flag
    ld [rIE], a ;interrupt enable
    ld [vramBank], a ;vram bank select
    ld [rSCX], a ;scroll screen X
    ld [rSCY], a ;scroll screen Y
    ld a, [wc104]
    push af

;clear work ram
    ld hl, wWorkRamStart
    ld bc, WRAM_LENGTH ;$1F00
.clearWramLoop
    ld [hl], $00
    inc hl
    dec bc
    ld a, b
    or a, c
    jr nz, .clearWramLoop

    pop af
    ld [wc104], a
    ld a, $01
    call BankSwitch
    call initOAMDMARoutine
    call hideSprites
    ld a, $03
    ld [rIE], a ;interrupt enable
    ld a, $10
    ld [rWY], a ;window Y pos
    ld a, $08
    ld [rWX], a ;window X pos
    ld a, $87
    ld [rLCDC], a ;lcd control
    ld a, $40
    ld [rSTAT], a ;lcd status
    call muteAudio
    ei

    call haltCPU
    ld a, %10000111 ;$87
    ld [rLCDC], a ;lcd control
    call hideSprites
    xor a
    ld [wScreenYPos], a
    call clearExtRAM
    call enableExtRAM
	;check for quick save
    ld a, [sQuickSaveFlagB9]
    cp a, $53
    jr nz, .goToTitle
    ld a, [sQuickSaveFlagBA]
    cp a, $50
    jr nz, .goToTitle
    ld a, [sQuickSaveFlagBC]
    cp a, $41
    jr nz, .goToTitle

	;load quick save
    ld hl, wButtonPressId
    ld de, sSRamStart ;$A000
    ld bc, SAVE_SLOT_LENGTH ;$600
.loop1E9
    ld a, [de]
    ld [hli], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, .loop1E9
    ld hl, sQuickSaveFlagB9
	;reset quick save flags
    xor a
    ld [wQuickSaveFlagB9], a
    ld [wQuickSaveFlagBA], a
    ld [wQuickSaveFlagBC], a
    call disableExtRAM
    ld hl, $23C
    push hl
    jp restorePauseMenu ;45CF

;title screen routines
.goToTitle
    call disableExtRAM
.Label20B
    ld a, $FF
    ld [wCurrentMusicId], a
    call loadTitleScreen ;210
    call ResetPal
    ld a, [wCursorPosId]
    ld [wCursorIdBuffer], a
    or a
    jr z, .newGame ;if cursor is 0, go to new game
	;else go to load game screen
    ld a, LOAD_GAME_MODE ;$00
    call loadSaveGameMenu
    ld a, [wCursorPosId]
    cp a, $04
    jr z, .Label20B ;if do not load/save option was chosen
	;game loaded
    jr .Label236
.newGame
    call loadPlayerSelectMenu ;$33EB
    ld a, [wCursorPosId]
    ld [wSelectedPlayer], a ;set selected player id, 0:chris, 1:jill
.Label236
    call displayLoadGameWelcomeMsg ;$439A
    call StartGameScene ;$039D
    ld a, [wCharHealth] ;check player health
    or a
    call z, showDeathScreen ;$4538
    jp InitGame
;246

muteAudio:: ;0246
	ld a, [wCurrentRomBank]
	push af
	ld a, BANK(goToDisableSound) ;$06
	call BankSwitch
	call goToDisableSound ;$4000
	pop af
	jp BankSwitch


playMusic:: ;0256
;a: music id
	ld c, a
	ld a, [wCurrentRomBank]
	push af
	ld a, BANK(goToPlayMusicRoutine) ;$06
	call BankSwitch
	ld a, c
	ld [wCurrentMusicId], a
	call goToPlayMusicRoutine ;$4006
	pop af
	jp BankSwitch

playSFX:: ;026B
    ld c, a
    ld a, [wCurrentRomBank]
    push af
    ld a, BANK(goToPlaySFXRoutine) ;$06
    call BankSwitch
    ld a, c
    ld [wCurrentSoundId], a
    call goToPlaySFXRoutine
    pop af
    jp BankSwitch


jumpToFunctionHL1:: ;0280
    call BankSwitch
    ld de, jumpToFunctionHL1+8 ;$288
    push de
    jp [hl]
    push af
    ld a, $01
    call BankSwitch
    pop af
    ret

jumpToFunctionHL2:: ;0290
    call BankSwitch
    ld bc, jumpToFunctionHL2+8 ;$298
    push bc
    jp [hl]
    push af
    ld a, $01
    call BankSwitch
    pop af
    ret

jumToFunctionHL3:: ;02A0
	ld c, a
	ld a, [wCurrentRomBank]
	push af
	ld a, c
	call BankSwitch
	ld de, jumToFunctionHL3+14 ;$02AE
	push de
	jp [hl]
	pop af
	jp BankSwitch


routineDelay:: ;02B2
	push bc
	call haltCPU
	pop bc
	dec b
	jr nz, routineDelay
	ret


INCLUDE "home/joypad.asm"


BankSwitch:: ;00:02EE
    push bc
    ld b, a
    ld a, [wCurrentRomBank]
    ld c, a
    ld a, b
    ld [wCurrentRomBank], a
    ld [$2000], a ;bank Switch
    ld a, c
    pop bc
    ret


INCLUDE "home/hblank.asm"
INCLUDE "home/vblank.asm"

SoftReset:: ;00:0391
	di
	ld a, $01
	call BankSwitch
	call ResetPal
	jp InitGame

StartGameScene:: ;00:039D
    ld a, $01
    ld [wVisitedRoom00Trigger], a
    ld a, $FF
    ld [wRoomScreen], a
    ld a, MAIN_HALL_1F ;$00
    ld [wRoomId], a
    xor a
    ld [wRoomIdHigh], a
    call goToInitSelectedPlayerData ;$0890
    ld a, BANK(roomsActionsDatatable) ;$C5
    call BankSwitch
    ld a, [wRoomId]
    ld l, a
    ld a, [wRoomIdHigh]
    ld h, a
    add hl, hl
    ld de, roomsActionsDatatable ;4000
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld de, $0005 ;set action area offset
    add hl, de
    ld a, [hli]
    ld [wSpritePosXoffsetLowByte], a
    ld a, [hli]
    ld [wSpritePosXoffsetHighByte], a
    ld a, [hli]
    ld [wSpritePosYoffsetLowByte], a
    ld a, [hli]
    ld [wSpritePosYoffsetHighByte], a
    ld a, [hli]
    ld [wSpriteFacing], a
    ld a, $01
    call BankSwitch

newGameStartSceneSet: ;03E5
	call goToInitGameTriggers ;$8B2
    call goToInitRoomSprites ;$906
    ld a, $20
    ld [wLCDUpdate], a
    ld a, DEFAULT_MAIN_THEME ;$05
    ld [wRoomMusicId], a
    ld a, $01
    ld [wEventId], a ;set event id to new game first scene
    ld hl, $04E2 ;set timer and frame counter values
    ld a, l
    ld [wTimer], a
    ld a, h
    ld [wc1c5], a
gameLoopWithEventCheck: ;405
	call hideSprites
    call haltCPU
    xor a
    ld [wScreenYPos], a ;set screen Y-po to $00
    call loadAllRoomBgData
    ld a, [wEventId]
    or a
    jr z, .Label444 ;jump if there is not a event to show
    call ResetPal
    call goToDisplayEvent ;$070B
    push af
    xor a
    ld [wEventId], a ;reset eventId after event
    call ResetPal
    call goToInitRoomSprites ;$0906
    pop af
    cp a, $FF
    jp nz, $0605 ;if event return was by getting item
    ld a, $1F ;set fade-in screen
    ld [wLCDUpdate], a
    ld c, CHRIS ;$92 init player sprite id, chris by default
    ld a, [wSelectedPlayer]
    or a
    jr z, .Label43E ;jump if chris selected
	;else set jill as player
    ld c, JILL ;$93
.Label43E
    ld a, c
    ld [wSpriteId], a
    jr gameLoopWithEventCheck ;reload Room Bg and screen Y-pos data
.Label444
    ld a, $08
    ld [wPlayerSpeed], a
;0449

gamePlayLoop: ;00:0449
    call haltCPU
    ld a, [wPlayerSpeed]
    cp a, $04
    jr c, gamePlayLoop ;limit framerate
	;print debug info
    ld hl, _SCRN0+$200 ;tile pos
    ld a, [wRoomScreen]
    ld e, a
    ld a, [wRoomId]
    ld d, a
    call printDebugWord ;print room & screen Id
    ld hl, _SCRN0+$205
    ld a, [wSpritePosXoffsetLowByte]
    ld e, a
    ld a, [wSpritePosXoffsetHighByte]
    ld d, a
    call div8SignedWord
    call printDebugWord ;print player X position
    ld hl, _SCRN0+$20A
    ld a, [wSpritePosYoffsetLowByte]
    ld e, a
    ld a, [wSpritePosYoffsetHighByte]
    ld d, a
    call div8SignedWord
    call printDebugWord ;print player Y position
    ld hl, _SCRN0+$20F
    ld a, [wSpriteFacing]
    ld e, a
    ld d, $00
    call printDebugWord ;print player facing
    ld hl, _SCRN0+$220
    ld a, [wSpriteYPosLowBuffer]
    ld e, a
    ld a, [wRotateFloor2AnimId]
    ld d, a
    call printDebugWord
    ld hl, _SCRN0+$225
    ld a, [wSpritePosZLowByte]
    ld e, a
    ld a, [wSpritePosZHighByte]
    ld d, a
    call printDebugWord ;print player Z-elevation
    ld hl, $0000
    add hl, sp
    push hl
    pop de
    ld hl, _SCRN0+$22A
    call printDebugWord ;print stack pointer
    xor a
    ld [wPlayerSpeed], a ;reset framerate counter
    call initSprtBufferAddr
    call calcAllSpritesData
    call goToLoadRoomSpritesData
    call hideOAM
    call goToSprtPrioritySort
    call loadAllSpritesTilesData
    call enableHDMA
    call swapOAMDMAopcode
    call goToCheckPlayerInput
    ld a, [wButtonAEventId]
    cp a, DROPPED_ITEM_ACTION ;$01
    jp z, includeDroppedItem ;05FF
    call goToLoadZombieAndObjAnimFrames
    call goToCheckEnemyBoundaries
    call goToCheckRoomBoundaries
    call goToCheckSpritesCollision
    call goToCheckRoomsColliders
    call goToCheckRoomsEventsColliders ;8F8
    call goToCheckRoomsCameraChange
    or a
    jp nz, cameraChangeTransition
    call goToCheckRoomsActions
    ld a, [wButtonAEventId]
    cp a, BTN_CHECK_ACTION ;$05
    call z, goToCheckButtonActionEvents ;$5BD
    ld a, [wButtonAEventId]
    cp a, OPEN_DOOR_ACTION ;$01
    jp z, showDoorTransitions
    cp a, LOAD_SAVE_MENU_ACTION ;$02
    jp z, goToLoadSaveGameMenu
    cp a, GET_ITEM_ACTION ;$03
    jp z, goToIncludeItemMenu
    cp a, ITEMBOX_MENU_ACTION ;$04
    jp z, goToItemBoxMenuRoutine
    ld a, [wRoomId]
    ld e, a
    ld a, [wRoomIdHigh]
    ld d, a
    ld hl, wVisitedRoom00Trigger ;c200
    add hl, de
    ld [hl], $01 ;set room visited
    call goToCheckGasRooms
    ld a, [wTimer]
    dec a
    ld [wTimer], a
    call showRoomAnimation ;$4AFE
    ld a, [wLCDUpdate]
    cp a, $5E
    jp z, goToMainMenuRoutine ;go to main menu if fade-out value if $5E
    or a
    jr nz, skipOpenMenu
    ld a, [wButtonPressId]
    and a, SELECT_INPUT
    jr z, skipOpenMenu
    ld a, $5C
    ld [wLCDUpdate], a ;set open main menu
skipOpenMenu
    ld a, [wButtonPressId]
    and a, START_INPUT
    jp nz, showPauseMenu ;$45A9
    ld a, [wEventId]
    or a
    jp nz, jumpToEventCheck ;73B
    ld a, [wLCDUpdate]
    push af
    call checkAndLoadRoomPal ;$44CD
    pop bc
    ld a, [wLCDUpdate]
    or a
    jr nz, Label57B
    ld a, b
    cp a, $01
    jr nz, Label57B
    ld a, [wRoomMusicId]
    ld c, a
    ld a, [wCurrentMusicId]
    cp a, c
    jr z, Label57B
    ld a, c
    call playMusic
Label57B
    jp gamePlayLoop
;57E

resetScreenAndFadeIn: ;00:057E
    call haltCPU
    call hideSprites
    call ResetPal
    ld a, $01
    ld [wLCDUpdate], a
    ret
;058D


goToMainMenuRoutine: ;00:058D
    ld a, [wCharHealth]
    or a
    ret z ;ret if player is dead
    call mainMenuRoutine ;$40A5
    ld a, $01
    ld [wLCDUpdate], a ;set fade-in
    jp gameLoopWithEventCheck
;059D

goToItemBoxMenuRoutine: ;00:059D
    call ResetPal
    call hideSprites
    call itemBoxMenuRoutine ;$40F6
    ld a, $01
    ld [wLCDUpdate], a
    jp gameLoopWithEventCheck

cameraChangeTransition: ;00:05AE
    call resetScreenAndFadeIn
    call goToLoadRoomSpritesData
    call goToLoadZombieAndObjAnimFrames
    call calcAllSpritesData
    jp gameLoopWithEventCheck
;05BD

goToCheckButtonActionEvents: ;00:05BD
    call checkButtonActionEvents
    ret
;5C1

showDoorTransitions: ;00:05C1
    call ResetPal
    ld a, [wDoorAnimationType]
    cp a, $7C
    jr c, Label5D0 ;jump if normal door animation
    call loadBgTypeDoorTransitions
    jr Label5D3
Label5D0
    call showSpriteDoorsAnimation
Label5D3
    ld a, $01 ;set fade-in
    ld [wLCDUpdate], a
    call goToCheckRoomsCameraChange
    call goToInitRoomSprites
    jp gameLoopWithEventCheck

goToLoadSaveGameMenu: ;5E1
    ld a, NO_MUSIC ;$00
    call playMusic
    call ResetPal
    ld a, IDLE_ANIM
    ld [wSpriteAnimationId], a
    xor a
    ld [wSpriteAnimationLoopTimer], a
    ld a, SAVE_GAME_MODE ;$01
    call loadSaveGameMenu
    ld a, $01
    ld [wLCDUpdate], a ;set fade-in
    jp gameLoopWithEventCheck
;5FF

includeDroppedItem: ;5FF
    ld a, [wFoundItemId]
    ld [selectedItemId], a
goToIncludeItemMenu: ;00:0605
    call includeItemMenu ;$366F
    ld a, $01
    ld [wLCDUpdate], a ;set fade-in
    jp gameLoopWithEventCheck
;610

showEventMsgCharName:: ;00:0610
;a: bank
;de: msg pointer
;hl: text start position
    ld a, [wCurrentRomBank]
    push af
    ld a, $01
    call BankSwitch
    ld a, c
    ld c, e
    ld b, d
    call printMessage
    pop af
    jp BankSwitch

showEventMessage:: ;00:0623
    ld a, [wCurrentRomBank]
    push af
    ld a, $FA
    call BankSwitch
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    inc de
    ld a, [de]
    ld e, a
    ld a, $01
    call BankSwitch
    ld a, e ;message bank
    call printAutoTypingMessage
    pop af
    jp BankSwitch

loadEventRoomScreen: ;00:0641
    ld a, [wCurrentRomBank]
    push af
    push hl
    ld a, $01
    call BankSwitch
    call ResetPal
    call hideSprites
    call loadAllRoomBgData
    ld a, $01
    ld [wLCDUpdate], a
    call haltCPU
    call checkAndLoadRoomPal
    pop hl
    pop af
    jp BankSwitch

loadStoredRoomBg:: ;00:0664
    ld a, [wCurrentRomBank]
    push af
    ld a, $01
    call BankSwitch
    call ResetPal
    call hideSprites
    call loadAllRoomBgData
    pop af
    jp BankSwitch

FadeScreen:: ;00:067A
    ld a, [wCurrentRomBank]
    push af
    ld a, $01
    call BankSwitch
    ld a, c
    ld [wLCDUpdate], a
    ld b, $20
Loop689
    push bc
    call haltCPU
    ld a, [wLoadEventBgImagePal]
    or a
    jr z, Label6AA ;if zero, load Room pallete
	;else, load bg image pallete
    add a
    add a
    ld c, a
    ld b, $00
    ld hl, fallingStatueBgImgPal+2 ;$2FD0
    add hl, bc
    inc hl
    inc hl
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld de, $0008
    add hl, de
    call loadBGPallete
    jr Label6AD
Label6AA
    call checkAndLoadRoomPal
Label6AD
    pop bc
    dec b
    jr nz, Loop689
    pop af
    jp BankSwitch

;6B5

showEventDoorAnimation:: ;00:06B5
    ld a, [wCurrentRomBank]
    push af
    ld a, $01
    call BankSwitch
    call ResetPal
    ld a, [wDoorAnimationType]
    cp a, $7C
    jr nc, Label6CF
    call showSpriteDoorsAnimation ;$0C80
    pop af
    jp BankSwitch

Label6CF: ;06CF
    call $465F
    pop af
    jp BankSwitch

loadAndCalcEventSpritesData:: ;00:06D6
    ld a, [wCurrentRomBank]
    push af
    ld a, $01
    call BankSwitch
    call initSprtBufferAddr
    call calcAllSpritesData ;0B72
    call goToLoadRoomSpritesData ;08E3
    call hideOAM
    call goToSprtPrioritySort
    call loadAllSpritesTilesData
    call enableHDMA
    call swapOAMDMAopcode
    pop af
    jp BankSwitch

;06FB

loadEventBgMask: ;00:06FB
    ld a, [wCurrentRomBank]
    push af
    ld a, $01
    call BankSwitch
    call goToLoadRoomBgMask
    pop af
    jp BankSwitch

goToDisplayEvent:: ;00:070B
    ld a, BANK(displayEvent) ;$0E
    ld hl, displayEvent ;$409A
    jp jumpToFunctionHL1
;713

showEventBgImage: ;00:0713
    ld c, a
    ld a, [wCurrentRomBank]
    push af
    ld a, $01
    call BankSwitch
    push bc
    call ResetPal
    pop bc
    sla c
    sla c
    ld b, $00
    ld hl, fallingStatueBgImgPal+2 ;$2FD0
    add hl, bc
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld a, c
    call loadTileMap
    pop af
    jp BankSwitch

;73B
jumpToEventCheck: ;73B
    call ResetPal
    jp gameLoopWithEventCheck
;0741

loadAllRoomBgData:: ;00:0741
    ld a, $07
    call BankSwitch
    ld a, [wRoomId]
    ld l, a
    ld a, [wRoomIdHigh]
    ld h, a
    add hl, hl
    ld de, RoomsBgCamerasLookupTable ;$4000
;Label752
    add hl, de
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc de
    ld a, [wRoomScreen]
    ld l, a
    ld h, $00
    add hl, hl
    push hl
    add hl, hl
    add hl, hl
    add hl, hl
    pop bc
    add hl, bc
    add hl, de
    ld a, [hli]
    ld [wCameraXAxisLowByte], a
    ld a, [hli]
    ld [wCameraXAxisHighByte], a
    ld a, [hli]
    ld [wCameraZAxisLowByte], a
    ld a, [hli]
    ld [wCameraZAxisHighByte], a
    ld a, [hli]
    ld [wCameraYAxisLowByte], a
    ld a, [hli]
    ld [wCameraYAxisHighByte], a
    ld a, [hli]
    ld [wSpriteSizeLow], a
    ld a, [hli]
    ld [wSpriteSizeHigh], a
    ld a, [hli]
    ld [wCameraZoomLow], a
    ld a, [hli]
    ld [wCameraZoomHigh], a
    ld a, [hli]
    ld [wCameraXPaddingLowByte], a
    ld a, [hli]
    ld [wCameraXPaddingHighByte], a
    ld a, [hli]
    ld [wCameraYPaddingLowByte], a
    ld a, [hli]
    ld [wCameraYPaddingHighByte], a
    ld a, [hli]
    ld [wCameraZPaddingLowByte], a
    ld a, [hli]
    ld [wCameraZPaddingHighByte], a
    ld a, [hli]
    ld [wCameraFacing], a
    ld a, [hl]
    and a, %00111111 ;$3F
    ld [wCameraC16F], a ;unused camera value
    ld a, [hl]
    and a, %01000000 ;($40) bit 6 indicate camera type
    ld [wCameraType], a
    ld a, $01
    call BankSwitch
    call getScreenCameraPosValues
    call goToApplyPlayerElevation
    ld a, [wRoomId]
    ld l, a
    ld a, [wRoomIdHigh]
    ld h, a
    add hl, hl
    add hl, hl
    ld de, RoomsBgLookupTable ;$71B5
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
    call goToLoadRoomBgData
    ld a, $01
    ld [vramBank], a ;vram bank select
    ld a, $0F
    call BankSwitch
    ld de, mainFonts ;$4CB0
    ld hl, _VRAM+$800 ; fonts vram
    ld bc, $0800 ; bytes number to load
    call loadDataToRam
    ld a, $01
    call BankSwitch
    xor a
    ld [vramBank], a ;vram bank select
    ld a, $0C
    call BankSwitch
    ld de, FiregunTiles ;$4F04
    ld hl, _VRAM+$740 ; sprites tiles vram
    ld bc, $00C0 ; bytes number to load
    call loadDataToRam
    ld a, $01
    call BankSwitch
    ld hl, _SCRN0+$200 ;debug black frame tilemap
    ld b, $80
.loop80C
    xor a
    ld [vramBank], a ;vram bank select
    call VBlankWait
    ld [hl], $80
    ld a, $01
    ld [vramBank], a ;vram bank select
    ld [hl], $09
    inc hl
    dec b
    jr nz, .loop80C
    xor a
    ld [vramBank], a ;vram bank select
    ld hl, Function3F5297 ;FD:5297
    ld a, BANK(Function3F5297) ;$FD
    jp jumpToFunctionHL1

goToLoadEnemyBloodSprt:: ;00:0829
    ld a, [wCurrentRomBank]
    push af
    ld a, BANK(loadEnemyBloodSprite) ;$04
    call BankSwitch
    call loadEnemyBloodSprite ;04:4BC4
    pop af
    jp BankSwitch

goToLoadSprtPriorityData:: ;00:0839
	ld a, [wCurrentRomBank]
    push af
    ld a, BANK(loadSpritePriorityData) ;$04
    call BankSwitch
    call loadSpritePriorityData ;$4B80
    pop af
    jp BankSwitch

callLoadRoomPal:: ;00:0849
    ld a, BANK(loadRoomPallete) ;$03
    call BankSwitch
    call loadRoomPallete ;03:7A80
    ld a, $01
    jp BankSwitch

goToLoadZombieAndObjAnimFrames: ;00:0856
    ld hl, loadZombieAndObjectAnimFrames ;$42AA
    ld a, BANK(loadZombieAndObjectAnimFrames) ;$FC
    jp goToJumpFuncHL

goToCheckKeyboardKeyInput: ;085E
    ld hl, checkKeyboardKeyInput ;$4AD4
    ld a, BANK(checkKeyboardKeyInput) ;$04
    jp goToJumpFuncHL

goToCheckELocksFloorSelectInput: ;0866
    ld hl, checkELocksFloorSelectInput ;$4A8E
    ld a, BANK(checkELocksFloorSelectInput) ;$04
    jp goToJumpFuncHL

goToLoadItemboxCursor: ;086E
    ld hl, loadItemboxCursor ;$4A00
    ld a, BANK(loadItemboxCursor) ;$04
    jp goToJumpFuncHL

callSprtFloodEfect:: ;00:0876
    ld a, BANK(applySprtWaterEffect) ;$04
    call BankSwitch
    call applySprtWaterEffect ;4A33
    ld a, $01
    jp BankSwitch

callRoomOverlapSprt:: ;00:0883
    ld a, BANK(applyRoomOverlapToSprt) ;$08
    call BankSwitch
    call applyRoomOverlapToSprt ;$4000
    ld a, $01
    jp BankSwitch

goToInitSelectedPlayerData:: ;00:0890
    ld hl, InitSelectedPlayerData ;$4C5C
    ld a, BANK(InitSelectedPlayerData) ;$04
    jp goToJumpFuncHL

goToCheckGasRooms: ;00:0898
    ld hl, checkGasRooms ;$4C34
    ld a, BANK(checkGasRooms) ;$04
    jp goToJumpFuncHL

goToCheckEnemyBoundaries: ;00:08A0
    ld hl, checkEnemyBoundaries ;$41E4
    ld a, BANK(checkEnemyBoundaries) ;$FC
    jp goToJumpFuncHL

goToCheckPlayerInput: ;00:08A8
    call goToApplyPlayerElevation
    ld hl, checkPlayerInput ;$44DB
    ld a, BANK(checkPlayerInput) ;$FC
    jr goToJumpFuncHL

goToInitGameTriggers:: ;00:08B2
    ld a, BANK(InitGameTriggers) ;$C5
    ld hl, InitGameTriggers ;$6273
    jr goToJumpFuncHL

goToLoadMenuItemsSprtData:: ;00:08B9
    ld a, BANK(loadMenuItemsSprtData) ;$05
    ld hl, loadMenuItemsSprtData ;$5C1C
    jr goToJumpFuncHL

goToLoadEquipedSpriteData:: ;00:08C0
    ld a, BANK(loadEquipedSpriteData) ;$05
    ld hl, loadEquipedSpriteData ;$5E40
    jr goToJumpFuncHL

goToLoadSelectedItemboxItemSprite:: ;00:08C7
    ld a, BANK(loadSelectedItemboxItemSprite) ;$05
    ld hl, loadSelectedItemboxItemSprite ;$5E90
    jr goToJumpFuncHL

goToLoadItemBigSprite:: ;00:08CE
    ld a, BANK(loadItemBigSprite) ;$05
    ld hl, loadItemBigSprite ;$5CE6
    jr goToJumpFuncHL

goToCheckTitleCursor:: ;00:08D5
    ld a, BANK(checkTitleCursor) ;$05
    ld hl, checkTitleCursor ;$60F4
    jr goToJumpFuncHL

goToSprtPrioritySort:: ;00:08DC
    ld hl, spritePrioritySort ;$4CAA
    ld a, BANK(spritePrioritySort) ;$FC
    jr goToJumpFuncHL

goToLoadRoomSpritesData:: ;00:08E3
    ld hl, loadRoomSpritesData ;$4000
    ld a, BANK(loadRoomSpritesData) ;$FB
    jr goToJumpFuncHL

goToCheckSpritesCollision:: ;00:08EA
    ld hl, checkSpritesCollision ;$4C94
    ld a, BANK(checkSpritesCollision) ;$FB
    jr goToJumpFuncHL

goToCheckRoomsColliders: ;00:08F1
    ld hl, checkRoomsColliders ;$511C
    ld a, BANK(checkRoomsColliders) ;$FD
    jr goToJumpFuncHL

goToCheckRoomsEventsColliders:: ;00:08F8
    ld hl, checkRoomsEventsColliders ;$64FB
    ld a, BANK(checkRoomsEventsColliders) ;$C4
    jr goToJumpFuncHL

goToCheckRoomsActions:: ;00:08FF
    ld a, BANK(checkRoomsActions) ;$C5
    ld hl, checkRoomsActions ;$62C5
    jr goToJumpFuncHL

goToInitRoomSprites:: ;00:0906
    ld a, BANK(InitRoomSprites) ;$C5
    ld hl, InitRoomSprites ;$6ADC
    jr goToJumpFuncHL

goToCheckRoomBoundaries:: ;00:090D
    ld hl, checkRoomBoundaries ;$43A0
    ld a, BANK(checkRoomBoundaries) ;$FD
    jr goToJumpFuncHL

goToCheckRoomsCameraChange:: ;00:0914
    ld hl, checkRoomsCameraChange ;$4000
    ld a, BANK(checkRoomsCameraChange) ;$C6
    jr goToJumpFuncHL

goToApplyPlayerElevation:: ;00:091B
    ld hl, applyPlayerElevation ;$5BB0
    ld a, BANK(applyPlayerElevation) ;$0F
    jr goToJumpFuncHL

goToJumpFuncHL:: ;00:0922
	jp jumpToFunctionHL1

goToCheckNumericPanelInput:: ;00:0925
    ld hl, checkNumericPanelInput ;$5F7F
    ld a, BANK(checkNumericPanelInput) ;$0F
    jr goToJumpFuncHL

goToLoadNumericPanelSprites:: ;00:092C
    ld hl, loadNumericPanelSprites ;$5DCB
    ld a, BANK(loadNumericPanelSprites) ;$0F
    jr goToJumpFuncHL

goToCheckZombieVisibility:: ;00:0933
    ld hl, checkAxSpritesScreenId
    ld a, BANK(checkAxSpritesScreenId) ;$C4
    jr label93F

goToCheckObjVisibility: ;00:093A
    ld hl, checkObjectsVisibility
    ld a, BANK(checkObjectsVisibility) ;$C4
label93F
    jp jumpToFunctionHL2

goToLoadRoomBgMask:: ;00:0942
    ld hl, applyRoomBgMask
    ld a, BANK(applyRoomBgMask) ;$04
    jp goToJumpFuncHL

calcSpriteScalePos:: ;00:094A
    ld a, [wCameraType]
    or a
    jp z, setSpritePosScale
    push de
    ld hl, wSpritePosXoffsetLowByte - wCharSpritesData ;$11
    add hl, de
    ld e, [hl]
    inc hl ;wSpritePosXoffsetHighByte
    ld d, [hl]
    call div8SignedWord
    ld a, e
    ld [wSpriteLowPosXBuffer], a
    ld a, d
    ld [wSpriteHighPosXBuffer], a
    pop de
    push de
    ld hl, wSpritePosYoffsetLowByte - wCharSpritesData ;$13
    add hl, de
    ld e, [hl]
    inc hl ;wSpritePosYoffsetHighByte
    ld d, [hl]
    call div8SignedWord
    ld a, e
    ld [wSpriteLowPosYBuffer], a
    ld a, d
    ld [wSpriteHighPosYBuffer], a
    ld hl, wCharSpritesData - wCharSpritesData ;$0
    ld a, l
    ld [wSpriteLowPosZBuffer], a
    ld a, h
    ld [wSpriteHighPosZBuffer], a
    call calcSpritePos
    pop de
    ld hl, wSpriteXPosLowBuffer - wCharSpritesData ;$0002
    add hl, de
    ld a, [wSpriteLowPosXBuffer]
    ld [hl], a
    ld hl, wSpriteZPosLowBuffer - wCharSpritesData ;$3
    add hl, de
    ld a, [wSpriteLowPosZBuffer]
    ld [hl], a
    ld hl, wSpriteYPosLowBuffer - wCharSpritesData ;$1
    add hl, de
    ld a, [wSpriteLowPosYBuffer]
    ld [hl], a
    ld a, [wSpriteHighPosYBuffer]
    or a
    ret nz
    ld a, [wSpriteLowPosYBuffer]
    or a
    ret z
    push de
    ld de, $16
    call loadSpriteScaleData
    pop de
    push de
    ld hl, wSpritePosXoffsetLowByte - wCharSpritesData ;$11
    add hl, de
    ld e, [hl]
    inc hl ;wSpritePosXoffsetHighByte
    ld d, [hl]
    call div8SignedWord
    ld a, [wSpriteScaleC144Low]
    ld l, a
    ld a, [wSpriteScaleC145High]
    ld h, a
    add hl, de
    ld a, l
    ld [wSpriteLowPosXBuffer], a
    ld a, h
    ld [wSpriteHighPosXBuffer], a
    pop de
    push de
    ld hl, wSpritePosYoffsetLowByte - wCharSpritesData ;$13
    add hl, de
    ld e, [hl]
    inc hl ;wSpritePosYoffsetHighByte
    ld d, [hl]
    call div8SignedWord
    ld a, [wSpriteZoomLowByte]
    ld l, a
    ld a, [wSpriteZoomHighByte]
    ld h, a
    add hl, de
    ld a, l
    ld [wSpriteLowPosYBuffer], a
    ld a, h
    ld [wSpriteHighPosYBuffer], a
    ld hl, $0000 ;reset pos Z buffer
    ld a, l
    ld [wSpriteLowPosZBuffer], a
    ld a, h
    ld [wSpriteHighPosZBuffer], a
    call calcSpritePos
    pop de
    ld a, [wSpriteLowPosXBuffer]
    ld c, a
    ld hl, wSpriteXPosLowBuffer - wCharSpritesData ;$2
    add hl, de
    ld a, [hl]
    sub a, c
    ld hl, wSpriteXscale - wCharSpritesData ;$4
    add hl, de
    ld [hl], a
    cp a, $20
    jr c, .LabelA0F
    ld a, $1F
    ld [hl], a
.LabelA0F
    ld hl, wSpriteXscale - wCharSpritesData ;$4
    add hl, de
    ld a, [hl]
    ld c, a
    srl a
    add a, c
    ld hl, wSpriteYscale - wCharSpritesData ;$5
    add hl, de
    ld [hl], a
    srl a
    ld c, a
    ld hl, wSpriteZPosLowBuffer - wCharSpritesData ;$3
    add hl, de
    ld a, [hl]
    sub a, c
    ld [hl], a
    ld hl, wSpriteXPosLowBuffer - wCharSpritesData ;$2
    add hl, de
    ld a, [hl]
    sub a, $10
    ld [hl], a
    ld a, $C0
    ld [de], a
    ret

setSpritePosScale:: ;00:0A33
    push de
    ld hl, wSpritePosXoffsetLowByte - wCharSpritesData ;$11
    add hl, de
    ld e, [hl]
    inc hl ;wSpritePosXoffsetHighByte
    ld d, [hl]
    call div8SignedWord
    ld a, e
    ld [wSpriteLowPosXBuffer], a
    ld a, d
    ld [wSpriteHighPosXBuffer], a
    pop de
    push de
    ld hl, wSpritePosYoffsetLowByte - wCharSpritesData ;$13
    add hl, de
    ld e, [hl]
    inc hl ;wSpritePosYoffsetHighByte
    ld d, [hl]
    call div8SignedWord
    ld a, e
    ld [wSpriteLowPosYBuffer], a
    ld a, d
    ld [wSpriteHighPosYBuffer], a
    pop de
    push de
    ld hl, wSpritePosZLowByte - wCharSpritesData ;$19
    add hl, de
    ld a, [hli]
    ld [wSpriteLowPosZBuffer], a
    ld a, [hli]
    ld [wSpriteHighPosZBuffer], a
    call calcSpritePos
    pop de
    ld a, [wSpriteHighPosXBuffer]
    or a
    jr z, .LabelA7D
    cp a, $FF
    ret nz
    ld a, [wSpriteLowPosXBuffer]
    cp a, $E0
    ret c
    jr .LabelA83
.LabelA7D
    ld a, [wSpriteLowPosXBuffer]
    cp a, $A8
    ret nc
.LabelA83
    ld hl, wSpriteXPosLowBuffer - wCharSpritesData ;$2
    add hl, de
    ld a, [wSpriteLowPosXBuffer]
    ld [hl], a
    ld a, [wSpriteHighPosZBuffer]
    or a
    ret nz
    ld hl, wSpriteZPosLowBuffer - wCharSpritesData ;$3
    add hl, de
    ld a, [wSpriteLowPosZBuffer]
    ld [hl], a
    ld hl, wSpriteYPosLowBuffer - wCharSpritesData ;$1
    add hl, de
    ld a, [wSpriteLowPosYBuffer]
    ld [hl], a
    ld a, [wSpriteHighPosYBuffer]
    or a
    ret nz
    ld a, [wSpriteLowPosYBuffer]
    or a
    ret z
    ld a, [spriteIdBuffer]
    cp a, BOOKCASE_1 ;$E6
    jr z, LabelAC3
    cp a, LITLE_STATUE ;$E7
    jr z, LabelACD
    cp a, $E8
    jr z, LabelACD
    cp a, DORM_CLOSET_B ;$EA
    jr z, LabelAC3
    cp a, LITLE_STATUE_2 ;$ED
    jr z, LabelACD
    jr LabelAD7
LabelAC3
    push de
    ld de, $0098
    call loadSpriteScaleData
    pop de
    jr LabelADF
LabelACD
    push de
    ld de, $0060
    call loadSpriteScaleData
    pop de
    jr LabelADF
LabelAD7
    push de
    ld de, $0080
    call loadSpriteScaleData
    pop de
LabelADF
    push de
    ld hl, wSpritePosXoffsetLowByte - wCharSpritesData ;$0011
    add hl, de
    ld e, [hl]
    inc hl ; wSpritePosXoffsetHighByte
    ld d, [hl]
    call div8SignedWord
    ld a, [wSpriteScaleC144Low]
    ld l, a
    ld a, [wSpriteScaleC145High]
    ld h, a
    add hl, de
    ld a, l
    ld [wSpriteLowPosXBuffer], a
    ld a, h
    ld [wSpriteHighPosXBuffer], a
    pop de
    push de
    ld hl, wSpritePosYoffsetLowByte - wCharSpritesData ;$13
    add hl, de
    ld e, [hl]
    inc hl ;wSpritePosYoffsetHighByte
    ld d, [hl]
    call div8SignedWord
    ld a, [wSpriteZoomLowByte]
    ld l, a
    ld a, [wSpriteZoomHighByte]
    ld h, a
    add hl, de
    ld a, l
    ld [wSpriteLowPosYBuffer], a
    ld a, h
    ld [wSpriteHighPosYBuffer], a
    ld hl, $0000
    ld a, l
    ld [wSpriteLowPosZBuffer], a
    ld a, h
    ld [wSpriteHighPosZBuffer], a
    call calcSpritePos
    pop de
    ld a, [wSpriteLowPosXBuffer]
    ld c, a
    ld a, [wSpriteHighPosXBuffer]
    ld b, a
    ld hl, wSpriteXPosLowBuffer - wCharSpritesData ;$0002
    add hl, de
    ld a, [hl]
	;reverse bc sign
    sub a, c
    ld c, a
    ld a, $00
    sbc a, b
    ld b, a
	;div bc by 4
    srl b
    rr c
    srl b
    rr c
    ld a, c
    srl a
    ld hl, wSpriteXscale - wCharSpritesData ;$0004
    add hl, de
    ld [hl], a
    cp a, $20
    jr c, LabelB51
    ld a, $1F
    ld [hl], a
LabelB51
    ld a, c
    cp a, $60
    jr c, LabelB58
    ld a, $5F
LabelB58
    ld hl, wSpriteYscale - wCharSpritesData ;$0005
    add hl, de
    ld [hl], a
    ld c, a
    ld hl, wSpriteZPosLowBuffer - wCharSpritesData ;$0003
    add hl, de
    ld a, [hl]
    inc a
    sub a, c
    ld [hl], a
    ld hl, wSpriteXPosLowBuffer - wCharSpritesData ;$0002
    add hl, de
    ld a, [hl]
    sub a, $10
    ld [hl], a
    ld a, $C0
    ld [de], a
    ret

calcAllSpritesData: ;00:0B72
    ld de, wCharSpritesData
    ld b, $08 ;sprites count
loadSpritesDataLoop
    push bc
    push de
    ld a, [de]
    and a, %10000000 ;$80 hide sprite
    ld [de], a
    jr z, continueNextSprite ;jump to next if sprite is disabled
    ld hl, wSpriteId - wCharSpritesData ;$000B
    add hl, de
    ld a, [hl]
    cp a, ZOMBIE
    jr c, LabelB9F ; jump if char is less than zombie (main chars)
    cp a, $A8
    jr c, LabelBBD ; jump if chars is a zombie
    cp a, OBJECTS
    jp nc, LabelBE4 ; jump is char is an object
continueNextSprite: ;0B91
    pop de
    pop bc
    ld a, e
    add a, $20 ; next sprite offset
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    dec b
    jr nz, loadSpritesDataLoop
    ret

LabelB9F: ;00:0B9F
;chars
    ld [spriteIdBuffer], a
    push de
    call calcSpriteScalePos
    pop de
    ld a, [de]
    and a, $40
    jr z, continueNextSprite
    push de
    call goToLoadSprtPriorityData
    pop de
    ld hl, wFiregunFramesId - wCharSpritesData ;$C
    add hl, de
    ld a, [hl]
    and a, %10000000 ;$80
    call nz, LabelBFE ;call if sprite enabled
    jr continueNextSprite

LabelBBD: ;00:0BBD
;zombie
    ld [spriteIdBuffer], a
    call goToCheckZombieVisibility ;0933
    or a
    jr z, continueNextSprite ; jump if $00
    call checkBloodFramesIdValue
    push de
    call calcSpriteScalePos
    pop de
    ld a, [de] ;C3x0
    and a, %01000000 ;$40 check if hidden
    jr z, continueNextSprite ;to next sprt if char is hidden
    push de
    call goToLoadSprtPriorityData ;0839
    pop de
    ld hl, wBloodFramesId - wCharSpritesData ;$D
    add hl, de
    ld a, [hl]
    and a, $80
    call nz, LabelC04
    jr continueNextSprite

LabelBE4: ;0BE4
;objects
    ld [spriteIdBuffer], a
    call goToCheckObjVisibility
    or a
    jr z, continueNextSprite ;next sprite if $00 (not visible)
    push de
    call calcSpriteScalePos
    pop de
    ld a, [de]
    and a, %01000000 ;$40
    jr z, continueNextSprite
    push de
    call goToLoadSprtPriorityData
    pop de
    jr continueNextSprite

LabelBFE: ;00:0BFE
    push de
    call loadFiregunSprite ;11B3
    pop de
    ret

LabelC04: ;00:0C04
    push de
    call goToLoadEnemyBloodSprt
    pop de
    ret

;0C0A

getMsgPointerAndShow: ;00:0C0A
;get message pointen and bank, and display it
    ld a, BANK(textPointers) ;$FA
    call BankSwitch
    ld c, [hl]
    inc hl
    ld b, [hl] ;msg pointer in bc
    inc hl
    ld e, [hl] ;msg bank in e
    ld a, $01
    call BankSwitch
    ld a, e ;set msg bank
    ld hl, $1000 ;message position
    jp printMessage

clearMessageBox: ;00:0C20
    push hl
    ld bc, ClearThreeTextLines ;$6431
    ld hl, $1000 ;tile coord (00,10)
    ld a, BANK(ClearThreeTextLines) ;$FA
    call printMessage
    pop hl
    ret
;0C2E

msgInputPressWaitLoop:: ;00:0C2E
    push hl
.loopC2F
    ld hl, wButtonPressId
    call haltCPU
    ld a, [hl]
    and a, $03
    jr nz, .loopC2F
.loopC3A
    call haltCPU
    ld a, [hl]
    and a, $03
    jr z, .loopC3A
.loopC42
    call haltCPU
    ld a, [hl]
    and a, $03
    jr nz, .loopC42
    pop hl
    ret

;00:0C4C

scrollDownScreen: ;00:0C4C
    ld c, $FF
    jr LabelC52
scrollUpScreen: ;00:0C50
    ld c, $01
LabelC52
    ld b, $10
LoopC54
    push bc
    call haltCPU
    call haltCPU
    ld a, [wScreenYPos]
    sub a, c
    ld [wScreenYPos], a
    call scrnYposToOAMBuffer
    pop bc
    dec b
    jr nz, LoopC54
    ret
;C6A

scrnYposToOAMBuffer: ;00:0C6A
    ld hl, wOAMBufferC9 ;$C900
    call applyYscrnOffsetToOAM
    ld hl, wOAMBufferCA ;$CA00
applyYscrnOffsetToOAM:
    ld de, $4
    ld b, $28
LoopC78
    ld a, [hl]
    add a, c
    ld [hl], a
    add hl, de
    dec b
    jr nz, LoopC78
    ret
;0C80

showSpriteDoorsAnimation:: ;00:0C80
    call hideSprites
    ld a, $00
    ld [wSpriteAnimationId], a
    xor a
    ld [wSpriteAnimationLoopTimer], a
    ld hl, _SCRN0 ;$9800
    ld bc, $400
	;clear screen loop
.loop0C92
    call VBlankWait
    xor a
    ld [vramBank], a ;vram bank select
    ld [hl], $80
    ld a, $01
    ld [vramBank], a ;vram bank select
    ld [hl], $08
    inc hl
    xor a
    ld [vramBank], a ;vram bank select
    dec bc
    ld a, b
    or a, c
    jr nz, .loop0C92
    ld a, $20
    ld [wLCDUpdate], a
    xor a
    ld [wDoorAnimationFrameCounter], a
    ld a, [wDoorSpriteId]
    cp a, $08
    jp c, LabelDEF ;jump if single door
	;double door
LabelCBA
    call haltCPU
    call hideOAM
    xor a
    ld [wDoorSprtTileBufferOffset], a
    ld hl, doorsSpritesheet ;$5000
    ld a, [wDoorSpriteId]
    and a, $07 ;get door sprite id
	;apply door sprite offset
    ld e, a
    add a
    add a, e
    add a, h
    ld h, a
    ld de, $3004 ;sprite scale (vertical-horizontal)
    ld bc, $3E40 ;door sprite position
    ld a, [wDoorAnimationFrameCounter]
    cp a, $08
    jr c, LabelD05
    ld a, l
    add a, $80
    ld l, a
    ld a, h
    adc a, $01
    ld h, a
    ld e, $08
    ld a, [wDoorAnimationFrameCounter]
    cp a, $10
    jr c, LabelD05
    sub a, $10
    ld c, a
    ld a, c
    srl a
    add a, d
    ld d, a
    ld a, b
    ld b, a
    ld a, c
    srl a
    srl a
    srl a
    ld c, a
    ld a, $40
    sub a, c
    ld c, a
LabelD05
    ld a, l
    ld [wDoorSpriteAddressLow], a
    ld a, h
    ld [wDoorSpriteAddressHigh], a
    ld a, d
    ld [wSprtPriorHeight], a
    ld a, e
    ld [wSprtPriorWidth], a
    ld a, b
    sub a, e
    ld [wDoorSpriteYPos], a
    ld a, c
    ld [wDoorSpriteXPos], a
    ld a, [wDoorPalleteId]
    ld [wc161], a
	;load left door
    call loadDoorSpriteData ;$2D62
    ld hl, doorsSpritesheet ;$5000
    ld a, [wDoorSpriteId]
    and a, $07
    ld e, a
    add a
    add a, e
    add a, h
    ld h, a
    ld de, $3004 ;right door scale
    ld bc, $5440 ;right door position
    ld a, [wDoorAnimationFrameCounter]
    cp a, $10
    jr c, LabelD68
    sub a, $10
    ld c, a
    ld a, c
    srl a
    add a, d
    ld d, a
    ld a, c
    srl a
    srl a
    ld e, a
    ld a, $04
    sub a, e
    ld e, a
    cp a, $05
    jr c, LabelD59
    ld e, $00
LabelD59
    ld a, b
    add a, c
    ld b, a
    ld a, c
    srl a
    srl a
    srl a
    ld c, a
    ld a, $40
    sub a, c
    ld c, a
LabelD68
    ld a, l
    ld [wDoorSpriteAddressLow], a
    ld a, h
    ld [wDoorSpriteAddressHigh], a
    ld a, d
    ld [wSprtPriorHeight], a
    ld a, e
    ld [wSprtPriorWidth], a
    ld a, b
    ld [wDoorSpriteYPos], a
    ld a, c
    ld [wDoorSpriteXPos], a
    ld a, [wDoorPalleteId]
    ld [wc161], a
	;load right door
    call loadDoorSpriteData ;$2D62
    call enableHDMA
    call swapOAMDMAopcode
	;fade-in door
    ld a, [wLCDUpdate]
    or a
    jr z, LabelD99
    cp a, $20
    jr c, LabelDB7
LabelD99
    ld a, [wDoorAnimationFrameCounter]
    cp a, $1F
    jr c, LabelDAC
    ld a, [wLCDUpdate]
    cp a, $40
    jr nc, LabelDAC
    ld a, $40
    ld [wLCDUpdate], a
LabelDAC
    ld a, [wDoorAnimationFrameCounter]
    cp a, $2F
    jr nc, LabelDB7
    inc a
    ld [wDoorAnimationFrameCounter], a
LabelDB7 ;play open door sound
    ld c, OPEN_DOOR_SFX ;$04
    ld a, [wCurrentSoundId]
    cp a, c
    jr z, LabelDCA
    ld a, [wDoorAnimationFrameCounter]
    cp a, $04
    jr nz, LabelDCA
    ld a, c
    call playSFX
LabelDCA
    ld a, [wLCDUpdate]
    cp a, $5E
    jp z, LabelDEA
    or a
    jr nz, LabelDE1
    ld a, [wButtonPressId]
    and a, SELECT_INPUT
    jr z, LabelDE1 ;skip door animation
    ld a, $40
    ld [wLCDUpdate], a
LabelDE1
    ld hl, doorsPallete ;$2EEE
    call loadBGPallete
    jp LabelCBA
LabelDEA
    ld a, CLOSE_DOOR_SFX ;$05
    jp playSFX ;play close door sound and end function
;load single door
LabelDEF
    call haltCPU
    call haltCPU
    call hideOAM
    xor a
    ld [wDoorSprtTileBufferOffset], a
    ld hl, doorsSpritesheet ;$5000
    ld a, [wDoorSpriteId]
    and a, $07
    ld e, a
    add a
    add a, e
    add a, h
    ld h, a
    ld de, $3004 ;door scale
    ld bc, $4E40 ;door position
    ld a, [wDoorAnimationFrameCounter]
    cp a, $08
    jr c, LabelE3D
    ld a, l
    add a, $80
    ld l, a
    ld a, h
    adc a, $01
    ld h, a
    ld e, $08
    ld a, [wDoorAnimationFrameCounter]
    cp a, $10
    jr c, LabelE3D
    sub a, $10
    ld c, a
    ld a, c
    srl a
    add a, d
    ld d, a
    ld a, b
    ld b, a
    ld a, c
    srl a
    srl a
    srl a
    ld c, a
    ld a, $40
    sub a, c
    ld c, a
LabelE3D
    ld a, l
    ld [wDoorSpriteAddressLow], a
    ld a, h
    ld [wDoorSpriteAddressHigh], a
    ld a, d
    ld [wSprtPriorHeight], a
    ld a, e
    ld [wSprtPriorWidth], a
    ld a, b
    sub a, e
    ld [wDoorSpriteYPos], a
    ld a, c
    ld [wDoorSpriteXPos], a
    ld a, [wDoorPalleteId]
    ld [wc161], a
    call loadDoorSpriteData ;2D62
    call enableHDMA
    call swapOAMDMAopcode
    ld a, [wLCDUpdate]
    or a
    jr z, LabelE6F
    cp a, $20
    jr c, LabelE8D
LabelE6F
    ld a, [wDoorAnimationFrameCounter]
    cp a, $1F
    jr c, LabelE82
    ld a, [wLCDUpdate]
    cp a, $40
    jr nc, LabelE82
    ld a, $40
    ld [wLCDUpdate], a
LabelE82
    ld a, [wDoorAnimationFrameCounter]
    cp a, $2F
    jr nc, LabelE8D
    inc a
    ld [wDoorAnimationFrameCounter], a
LabelE8D
    ld c, OPEN_DOOR_SFX ;$04
    ld a, [wCurrentSoundId]
    cp a, c
    jr z, LabelEA0
    ld a, [wDoorAnimationFrameCounter]
    cp a, $04
    jr nz, LabelEA0
    ld a, c
    call playSFX
LabelEA0
    ld a, [wLCDUpdate]
    cp a, $5E
    jp z, LabelEC0
    or a
    jr nz, LabelEB7
    ld a, [wButtonPressId]
    and a, SELECT_INPUT ;skip door animation
    jr z, LabelEB7
    ld a, $40
    ld [wLCDUpdate], a
LabelEB7
    ld hl, doorsPallete ;$2EEE
    call loadBGPallete
    jp LabelDEF
LabelEC0
    ld a, CLOSE_DOOR_SFX ;$05
    jp playSFX

calcSpritePos:: ;00:0EC5
    ld a, [wCameraXAxisLowByte]
    ld e, a
    ld a, [wCameraXAxisHighByte]
    ld d, a
    ld a, [wSpriteLowPosXBuffer]
    ld l, a
    ld a, [wSpriteHighPosXBuffer]
    ld h, a
    add hl, de ;cam X axis + sprite X pos
    ld a, l
    ld [wSpriteLowPosXBuffer], a
    ld [wSpriteLowPosXCamX], a
    ld a, h
    ld [wSpriteHighPosXBuffer], a
    ld [wSpriteHighPosXCamX], a
    ld a, [wCameraZAxisLowByte]
    ld e, a
    ld a, [wCameraZAxisHighByte]
    ld d, a
    ld a, [wSpriteLowPosZBuffer]
    ld l, a
    ld a, [wSpriteHighPosZBuffer]
    ld h, a
    add hl, de ; cam Z axis + sprite Z pos
    ld e, l
    ld d, h
    call reverseDESign
    ld a, e
    ld [wSpriteLowPosZBuffer], a
    ld [wSpriteLowPosZcamZ], a
    ld a, d
    ld [wSpriteHighPosZBuffer], a
    ld [wSpriteHighPosZcamZ], a
    ld a, [wCameraYAxisLowByte]
    ld e, a
    ld a, [wCameraYAxisHighByte]
    ld d, a
    ld a, [wSpriteLowPosYBuffer]
    ld l, a
    ld a, [wSpriteHighPosYBuffer]
    ld h, a
    add hl, de ;camera Y axis + sprite Y pos
    ld a, l
    ld [wSpriteLowPosYBuffer], a
    ld [wSpriteLowPosYCamY], a
    ld a, h
    ld [wSpriteHighPosYBuffer], a
    ld [wSpriteHighPosYCamY], a
    ld a, [wSpriteLowPosXBuffer]
    ld e, a
    ld a, [wSpriteHighPosXBuffer]
    ld d, a
    ld a, [wCameraPosX]
    ld l, a
    ld h, $00
    call func6F11
    ld a, e
    ld [wc154], a
    ld a, d
    ld [wc155], a
    ld a, [wSpriteLowPosYBuffer]
    ld e, a
    ld a, [wSpriteHighPosYBuffer]
    ld d, a
    ld a, [wCameraPosY]
    ld l, a
    ld h, $00
    call func6F11
    call func10E9
    call div16SignedWord
    ld a, e
    ld [wSpriteScaleC144Low], a
    ld a, d
    ld [wSpriteScaleC145High], a
    ld a, [wSpriteLowPosZBuffer]
    ld [wc146], a
    ld a, [wSpriteHighPosZBuffer]
    ld [wc147], a
    ld a, [wSpriteLowPosXBuffer]
    ld e, a
    ld a, [wSpriteHighPosXBuffer]
    ld d, a
    ld a, [wCameraPosY]
    ld l, a
    ld h, $00
    call func6F11
    ld a, e
    ld [wc154], a
    ld a, d
    ld [wc155], a
    ld a, [wSpriteLowPosYBuffer]
    ld e, a
    ld a, [wSpriteHighPosYBuffer]
    ld d, a
    ld a, [wCameraPosX]
    ld l, a
    ld h, $00
    call func6F11
    call func10FA
    call div64signedWord
    ld a, e
    ld [wSpriteZoomLowByte], a
    ld a, d
    ld [wSpriteZoomHighByte], a
    ld a, [wSpriteScaleC144Low]
    ld [wSpriteLowPosXBuffer], a
    ld a, [wSpriteScaleC145High]
    ld [wSpriteHighPosXBuffer], a
    ld a, [wc146]
    ld e, a
    ld a, [wc147]
    ld d, a
    ld a, [wCameraC12D]
    ld l, a
    ld h, $00
    call func6F11
    ld a, e
    ld [wc154], a
    ld a, d
    ld [wc155], a
    ld a, [wSpriteZoomLowByte]
    ld e, a
    ld a, [wSpriteZoomHighByte]
    ld d, a
    ld a, [wCameraC12C]
    ld l, a
    ld h, $00
    call func6F11
    call func10E9
    call div64signedWord
    ld a, e
    ld [wSpriteLowPosYBuffer], a
    ld a, d
    ld [wSpriteHighPosYBuffer], a
    ld a, [wc146]
    ld e, a
    ld a, [wc147]
    ld d, a
    ld a, [wCameraC12C]
    ld l, a
    ld h, $00
    call func6F11
    ld a, e
    ld [wc154], a
    ld a, d
    ld [wc155], a
    ld a, [wSpriteZoomLowByte]
    ld e, a
    ld a, [wSpriteZoomHighByte]
    ld d, a
    ld a, [wCameraC12D]
    ld l, a
    ld h, $00
    call func6F11
    call func10FA
    call div16SignedWord
    ld a, e
    ld [wSpriteLowPosZBuffer], a
    ld a, d
    ld [wSpriteHighPosZBuffer], a
    ld a, [wCameraXPaddingLowByte]
    ld l, a
    ld a, [wCameraXPaddingHighByte]
    ld h, a
    ld a, [wSpriteLowPosXBuffer]
    ld e, a
    ld a, [wSpriteHighPosXBuffer]
    ld d, a
    add hl, de
    ld a, l
    ld [wSpriteLowPosXBuffer], a
    ld a, h
    ld [wSpriteHighPosXBuffer], a
    ld a, [wCameraYPaddingLowByte]
    ld l, a
    ld a, [wCameraYPaddingHighByte]
    ld h, a
    ld a, [wSpriteLowPosZBuffer]
    ld e, a
    ld a, [wSpriteHighPosZBuffer]
    ld d, a
    add hl, de
    ld a, l
    ld [wSpriteLowPosZBuffer], a
    ld a, h
    ld [wSpriteHighPosZBuffer], a
    ld a, [wCameraZPaddingLowByte]
    ld l, a
    ld a, [wCameraZPaddingHighByte]
    ld h, a
    ld a, [wSpriteLowPosYBuffer]
    ld e, a
    ld a, [wSpriteHighPosYBuffer]
    ld d, a
    add hl, de
    ld a, l
    ld [wSpriteLowPosYBuffer], a
    ld a, h
    ld [wSpriteHighPosYBuffer], a
    ld hl, wSpriteLowPosXBuffer
    call div4WordInHLPointer
    ld hl, wSpriteLowPosZBuffer
    call div4WordInHLPointer
    ld a, [wSpriteLowPosYBuffer]
    ld e, a
    ld a, [wSpriteHighPosYBuffer]
    ld d, a
    ld a, [wSpriteScaling3LowByte]
    ld l, a
    ld a, [wSpriteScaling3HighByte]
    ld h, a
    call func6F11
    call div128signedWord
    ld a, e
    ld [wSpriteLowPosYBuffer], a
    ld a, d
    ld [wSpriteHighPosYBuffer], a
    ld a, [wSpriteLowPosXBuffer]
    ld e, a
    ld a, [wSpriteHighPosXBuffer]
    ld d, a
    ld a, [wSpriteScaling1LowByte]
    ld l, a
    ld a, [wSpriteScaling1HighByte]
    ld h, a
;00:10A4
    call func6F11
    ld a, [wSpriteLowPosYBuffer]
    ld c, a
    ld a, [wSpriteHighPosYBuffer]
    ld b, a
    call func6FBC
    ld a, e
    add a, $58
    ld [wSpriteLowPosXBuffer], a
    ld a, d
    adc a, $00
    ld [wSpriteHighPosXBuffer], a
    ld a, [wSpriteLowPosZBuffer]
    ld e, a
    ld a, [wSpriteHighPosZBuffer]
    ld d, a
    ld a, [wSpriteScaling2LowByte]
    ld l, a
    ld a, [wSpriteScaling2HighByte]
    ld h, a
    call func6F11
    ld a, [wSpriteLowPosYBuffer]
    ld c, a
    ld a, [wSpriteHighPosYBuffer]
    ld b, a
    call func6FBC
    ld a, e
    add a, $50
    ld [wSpriteLowPosZBuffer], a
    ld a, d
    adc a, $00
    ld [wSpriteHighPosZBuffer], a
    ret

func10E9: ;00:10E9
    push hl
    ld a, [wc154]
    ld l, a
    ld a, [wc155]
    ld h, a
    call reverseDESign
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ret

func10FA: ;00:10FA
    push hl
    ld a, [wc154]
    ld l, a
    ld a, [wc155]
    ld h, a
    add hl, de
    ld e, l
    ld d, h
    pop hl
    ret

loadSpriteScaleData:: ;00:1108
    push de
    call getSpriteScaleData
    pop de
    push de
    ld a, [wSpriteScaleValueB]
    ld l, a
    ld h, $00
    call func6F11
    call div64signedWord
    ld a, e
    ld [wSpriteScaleC144Low], a
    ld a, d
    ld [wSpriteScaleC145High], a
    pop de
    ld a, [wSpriteScaleValueA]
    ld l, a
    ld h, $00
    call func6F11
    call div64signedWord
    ld a, e
    ld [wSpriteZoomLowByte], a
    ld a, d
    ld [wSpriteZoomHighByte], a
    ret

getScreenCameraPosValues:: ;00:1138
    ld a, BANK(scaleDataTable) ;$0B
    call BankSwitch
    ld de, scaleDataTable ;$4000
    ld a, [wSpriteSizeLow]
    ld l, a
    ld a, [wSpriteSizeHigh]
    add a, $08
    and a, $0F
    add a, d
    ld h, a
    ld a, [hl]
    ld [wCameraPosY], a
    ld a, h
    sub a, d
    add a, $04
    and a, $0F
    add a, d
    ld h, a
    ld a, [hl]
    ld [wCameraPosX], a
    ld a, [wCameraZoomLow]
    ld l, a
    ld a, [wCameraZoomHigh]
    add a, d
    ld h, a
    ld a, [hl]
    ld [wCameraC12C], a
    ld a, h
    sub a, d
    add a, $04
    and a, $0F
    add a, d
    ld h, a
    ld a, [hl]
    ld [wCameraC12D], a
    ld a, $01
    call BankSwitch
    jp initSpecialCameraAngles

getSpriteScaleData:: ;00:117E
    ld a, [wSpriteSizeLow]
    ld e, a
    ld a, [wSpriteSizeHigh]
    ld d, a
    call reverseDESign
    ld l, e
    ld h, d
    ld a, BANK(scaleDataTable) ;$0B
    call BankSwitch
    ld de, scaleDataTable ;$4000
    ld a, h
    and a, $0F
    add a, d
    ld h, a
    ld a, [hl]
    ld [wSpriteScaleValueA], a
    ld a, h
    sub a, d
    add a, $04
    and a, $0F
    add a, d
    ld h, a
    ld a, [hl]
    ld [wSpriteScaleValueB], a
    ld a, $01
    jp BankSwitch

enableHDMA:: ;00:11AD
    ld a, $01
    ld [wHDMAtrigger], a
    ret

loadFiregunSprite: ;00:11B3
;de: C3x0 charData addr
    push bc
    push de
    push hl
    ld a, [wSprtPriorityTblLow]
    ld l, a
    ld a, [wSprtPriorityTblHigh]
    ld h, a
    inc de ;Sprite Y pos Low
    ld a, [de]
    ld [hl], a
    inc hl
    inc de
    push de
    ld de, $2B50 ;spriteId high-low
    ld [hl], e ;C80x+1 set sprite Id $50
    inc hl
    ld [hl], d ;C80x+2
    inc hl
    pop de ;C3x2
    ld a, [de]
    ld [hl], a ;C80x+3 sprite X pos Low
    inc hl
    inc de
    ld a, [de]
    ld [hl], a ;C80x+4
    inc hl
    inc de
    ld a, $08
    ld [hl], a ;C80x+5 X scale
    inc hl
    inc de
    ld a, $10
    ld [hl], a ;C80x+6 Y scale
    inc hl
    ld a, e
    add a, $04 ;de + 04 -> C3x9 sprite facing
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ld a, [de]
    ld [hl], a ;C80x+7 facing
    ld c, a ;store facing in c
    inc hl
    ld a, e
    add a, $03 ;de + 03 -> C3xC firegun sprite frame
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ld a, [de]
    ld [hl], a ;C80x+8 sprite anim frame id
    inc hl
    ld [hl], $00 ;C80x+9 sprite anim id
    inc hl
    ld [hl], $00
    ld a, l
    ld [wSprtPriorityTblLow], a
    ld a, h
    ld [wSprtPriorityTblHigh], a
    pop hl
    pop de
    push hl
    ld hl, Label12C9 ;$12C9
    ld a, [wSpriteAnimationId]
    cp a, GUN_AIM_ANIM ;$03
    jr z, Label1211 ;jump if anim Id is $03
    ld hl, Label12E9 ;$12E9
Label1211
    ld a, [wCameraFacing]
    ld b, a
    ld a, c
    add a, b
    and a, $1F
    srl a
    srl a
    add a
    add a
    add a, l ;apply facing offset
    ld l, a
    ld a, $00
    adc a, h
    ld h, a
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    push hl
    push de
    ld hl, wSpriteXscale - wCharSpritesData ;$4
    add hl, de
    ld l, [hl]
    ld h, $00
    ld e, c
    ld d, b
    call func6F11
    ld bc, $20
    call func6FBC
    ld c, e
    pop de
    ld hl, wSpriteXPosLowBuffer - wCharSpritesData ;$2
    add hl, de
    ld a, [hl]
    add a, $0C
    add a, c
    ld c, a
    ld a, [wSprtPriorityTblLow]
    sub a, $07
    ld l, a
    ld a, [wSprtPriorityTblHigh]
    sbc a, $00
    ld h, a
    ld [hl], c
    pop hl
    ld c, [hl]
    ld a, [wSprtPriorityTblLow]
    sub a, $0A
    ld l, a
    ld a, [wSprtPriorityTblHigh]
    sbc a, $00
    ld h, a
    ld a, [hl]
    add a, c
    ld [hl], a
    push de
    ld hl, wSpriteYscale - wCharSpritesData ;$5
    add hl, de
    ld l, [hl]
    ld h, $00
    ld a, [wSpriteAnimationId]
    cp a, $03
    jr z, Label128E
;firegun z-position
    ld de, $000C
    ld a, [wButtonPressId]
    and a, UP_INPUT ;$40
    jr nz, Label12A5
    ld de, $0013
    ld a, [wButtonPressId]
    and a, DOWN_INPUT ;$80
    jr z, Label12A5
    ld de, $001D
    jr Label12A5
Label128E ;firegun sprite Y position
    ld de, $0000
    ld a, [wButtonPressId]
    and a, UP_INPUT ;$40
    jr nz, Label12A5
    ld de, $000A
    ld a, [wButtonPressId]
    and a, DOWN_INPUT ;$80
    jr z, Label12A5
    ld de, $0013
Label12A5
    call func6F11
    ld bc, $30
    call func6FBC
    ld c, e
    pop de
    ld hl, wSpriteZPosLowBuffer - wCharSpritesData ;$3
    add hl, de
    ld a, [hl]
    sub a, $08
    add a, c
    ld c, a
    ld a, [wSprtPriorityTblLow]
    sub a, $06
    ld l, a
    ld a, [wSprtPriorityTblHigh]
    sbc a, $00
    ld h, a
    ld [hl], c
    pop hl
    pop bc
    ret
;12C9

Label12C9: ;12C9
	db $F9, $FF, $FF, $FF, $07, $00, $FF, $FF, $0C, $00, $00, $00, $0C, $00, $01, $00
	db $07, $00, $01, $00, $F6, $FF, $01, $00, $F3, $FF, $00, $00, $F2, $FF, $FF, $FF
Label12E9: ;12E9
	db $F9, $FF, $FF, $FF, $0B, $00, $FF, $FF, $0E, $00, $00, $00, $0C, $00, $01, $00
	db $07, $00, $01, $00, $F6, $FF, $01, $00, $F0, $FF, $00, $00, $F2, $FF, $FF, $FF
;1309

loadRoomItemSpriteData: ;00:1309
    ld a, [wSprtPriorityTblLow]
    ld l, a
    ld a, [wSprtPriorityTblHigh]
    ld h, a
    ld a, [de]
    ld [hli], a ;Y pos
    inc de
    ld a, [de]
    ld [hli], a ;sprite ID
    inc de
    ld a, [de]
    ld [hli], a ;C80x+2
    inc de
    ld a, [de]
    ld [hli], a ;X pos
    inc de
    ld a, [de]
    push bc
    ld c, a
    ld a, [wScreenYPos]
    ld b, a
    ld a, c
    sub a, b
    pop bc
    ld [hli], a ;Y pos
    inc de
    ld a, [de]
    ld [hli], a ; h-scale
    inc de
    ld a, [de]
    ld [hli], a ;v-scale
    inc de
    ld a, [de]
    ld [hli], a ;facing
    inc de
    ld a, [de]
    ld [hli], a ;frame Id
    inc de
    ld a, [de]
    ld [hli], a ;amin Id
    ld [hl], $00
    ld a, l
    ld [wSprtPriorityTblLow], a
    ld a, h
    ld [wSprtPriorityTblHigh], a
    ret

initSprtBufferAddr:: ;00:1342
    ld hl, wSpriteTilesBuffer ;$CB00
    ld a, l
    ld [wSpriteTilesBufferLow], a
    ld a, h
    ld [wSpriteTilesBufferHigh], a
    ld hl, spritePriorityTable ;c800
    ld a, l
    ld [wSprtPriorityTblLow], a
    ld a, h
    ld [wSprtPriorityTblHigh], a
    ld [hl], $00
    xor a
    ld [wSpriteC165], a
    ld [wSpriteC1F1], a
    ret

loadAllSpritesTilesData:: ;00:1362
    ld de, spritePriorityTable
loop1365
    ld a, [de] ;return if there are no sprites
    or a
    ret z
    push de
    inc de
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld h, a
    inc de
    ld a, h
    or a
    jr nz, .Label1387
    ld a, l
    cp a, $08
    jr c, .Label1381
    ld [spriteIdBuffer], a
    ld hl, loadSpriteTilesData ;$2BE9
    jr .Label1387
.Label1381
    ld [roomItemSpriteIdBuffer], a
    ld hl, loadRoomItemSpriteTilesData ;$2A86
.Label1387
    ld bc, Label138C ;set return pointer
    push bc
    jp [hl]
Label138C:
    pop de
    ld a, e
    add a, $0A ;to next sprite priority data
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    jr loop1365

;1397
INCLUDE "engine/scaling/verticalScalingLookupTable.asm" ;1397
INCLUDE "engine/scaling/verticalScalingTable.asm"

loadSpriteTilesBuffer: ;00:2687
;hl: spriteTilesbuffer
;de: sprite frame pointer
    ld a, [wSprtPriorHeight]
    ld c, a
    and a, $0F ;mask Y scale low nibble
    jr z, .Label2695 ;jump if masking is zero
	;else mask high nibble and add $10
    ld a, c
    and a, $F0
    add a, $10
    ld c, a
.Label2695
    ld a, c
    add a
    ld [wSpriteVRAMTilesNumberRelative], a ;set number of tiles to store
    ld a, [wSprtPriorWidth]
    push af ;store X scale value
    ld b, $02 ;sprite sides
.loop26A0
    push bc
    push hl
    call loadAndScaleSpriteTileData
    ld a, [wSprtPriorWidth]
    or a, %00010000 ;$10 ;set h-scale high nibble
    ld [wSprtPriorWidth], a
    ld a, [wSprtPriorHeight]
    and a, $0F
    jr z, .Label26D9
    ld c, a
    ld a, %00010000 ;$10
    sub a, c
    jr z, .Label26D9
    ld c, a
    ld b, a
    push hl
.Label26BD
    ld [hl], $00
    inc hl
    ld [hl], $00
    inc hl
    dec c
    jr nz, .Label26BD
    pop hl
    ld a, [wSpriteVRAMTilesNumberRelative]
    add a, l
    ld l, a
    ld a, $00
    adc a, h
    ld h, a
.Label26D0
    ld [hl], $00
    inc hl
    ld [hl], $00
    inc hl
    dec b
    jr nz, .Label26D0
.Label26D9
    pop hl
    ld a, [wSprtPriorHeight]
    ld c, a
    and a, $0F
    jr z, .Label26E8
    ld a, c
    and a, $F8
    add a, $10
    ld c, a
.Label26E8
    srl c
    srl c
    srl c
    srl c
    sla c
    sla c
    sla c
    sla c
    sla c
    ld b, $00
    add hl, bc
    add hl, bc
    inc de
    inc de
    inc de
    inc de
    pop bc
    dec b
    jr nz, .loop26A0
    pop af
    ld [wSprtPriorWidth], a
    ret

INCLUDE "engine/scaling/scalingFunctions.asm" ;00:270B

loadAndScaleSpriteTileData:: ;00:299F
;hl: spriteTilesbuffer
;de: sprite frame pointer
    push hl ;store spriteTilesBuffer
    ld hl, _verticalScalingLookupTable ;$1397
    ld a, [wSprtPriorHeight]
    dec a
    add a
    add a, l ;VScaleLookupTable + ((Yscale - 1) * 2)
    ld l, a
    ld a, $00
    adc a, h
    ld h, a
    ld c, [hl]
    inc hl
    ld b, [hl] ;load v-scale pointer to bc
    pop hl ;restore spriteTilesBuffer
loop29B2:
    push bc ;store v-scale pointer
	;store sprite tile pointed data into bc
    ld a, [de] ;
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    inc de
    push de ;store sprite tile pointer
    push hl ; store spriteTilesBuffer
    ld a, [wCurrentRomBank]
    push af
    ld a, $0A
    call BankSwitch
    ld hl, _horizontalScalingTable ;$4000
    ld a, [wSprtPriorWidth]
    and a, $0F ;mask h-scale
    add a, h ;add h-scale offset to high byte
    ld h, a
    ld l, c ; set low byte from sprite tile low byte
    ld c, [hl] ;get h-scale value
    ld l, b ; set high byte from sprite tile high byte
    ld b, [hl] ;get h-scale value
    pop af
    call BankSwitch
    ld a, h
    add a, $0D
    ld h, a
    push bc
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld b, a
    ld a, [wCurrentRomBank]
    push af
    ld a, $0A
    call BankSwitch
    ld l, c
    ld c, [hl]
    ld l, b
    ld b, [hl]
    pop af
    call BankSwitch ;back to home bank
    pop de
    ld hl, Label2A07 ;$2A07 set return address
    push hl
    ld hl, _scalingFuncionTable ;$270B
    ld a, [wSprtPriorWidth]
    add a
    add a, l
    ld l, a
    ld a, $00
    adc a, h
    ld h, a ;scaling function pointer offset hl + (h-scale * 2)
    ld a, [hli]
    ld h, [hl]
    ld l, a ;set scaling funtion pointer to HL
    jp [hl]
Label2A07:
    pop hl ;restore sprt tiles buffer
	;load sprite tile data into buffer
    ld [hl], e
    inc hl
    ld [hl], d
    dec hl
    ld a, [wSpriteVRAMTilesNumberRelative]
    add a, l
    ld l, a
    ld a, $00
    adc a, h
    ld h, a ;add sprite buffer offset
	;load sprite tile data into buffer
    ld [hl], c
    inc hl
    ld [hl], b
    inc hl
    ld a, [wSpriteVRAMTilesNumberRelative]
    ld e, a
    ld a, l
    sub a, e
    ld l, a
    ld a, h
	sbc a, $00 ;substract sprite buffer offset
	ld h, a
	pop de
	dec de
	dec de
	pop bc ;restore v-scale pointer
	ld a, [bc]
	cp a, $FF
	ret z ;return if v-scale data is FF
	add a
	add a, e
	ld e, a
	ld a, $00
	adc a, d
	ld d, a
	inc bc
	jp loop29B2

Function2A37:: ;00:2A37
    push bc
    ld a, [wSprtPriorWidth]
    srl a
    srl a
    srl a
    ld b, a
Loop2A42:
    ld a, [wSprtPriorHeight]
    srl a
    srl a
    srl a
    ld c, a
Loop2A4C:
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    dec c
    jp nz, Loop2A4C
    dec b
    jp nz, Loop2A42
    pop bc
    ret

loadRoomItemSpriteTilesData:: ;00:2A86
    dec de
    dec de
    dec de
    ld a, [de] ;sprite Y-sort pos
    cp a, $01
    jr z, .Label2A9B
    cp a, $FE ;-2
    jr z, .Label2A9B
    inc a
    ld l, a
    ld a, [wSpriteYPosLowBuffer]
    cp a, l
    jp c, .Label2B4B ;jump if player y-sort < item y-sort
.Label2A9B
    ld a, [de] ;y-sort
    ld h, a
    inc de
    inc de
    inc de
    ld a, [de] ;sprite X-pos
    ld [roomItemSpriteXPos], a
    inc de
    ld a, [de] ;sprite Y-pos
    ld [roomItemSpriteYPos], a
    inc de
    ld a, [de]
    ld [wSprtPriorWidth], a
    inc de
    ld a, [de]
    ld [wSprtPriorHeight], a
    inc de
    ld a, [de] ;sprite bank
    call BankSwitch
    inc de
    ld a, [de]
    ld l, a
    inc de
    ld a, [de]
    ld d, a
    ld e, l
    ld a, h
    cp a, $01
    jr z, .Label2AF3
    cp a, $FE
    jr z, .Label2AF3
    ld a, [wSpriteXPosLowBuffer]
    add a, $10
    ld l, a
    ld a, [wSpriteXscale]
    srl a
    add a, l
    ld l, a
    ld a, [roomItemSpriteXPos]
    cp a, l
    jr nc, .Label2B4B
    ld a, [wSpriteXscale]
    srl a
    ld l, a
    ld a, [wSpriteXPosLowBuffer]
    add a, $10
    sub a, l
    ld l, a
    ld a, [roomItemSpriteXPos]
    ld h, a
    ld a, [wSprtPriorWidth]
    add a, h
    cp a, l
    jr c, .Label2B4B
.Label2AF3
    ld a, [wSpriteTilesBufferLow]
    ld l, a
    ld a, [wSpriteTilesBufferHigh]
    ld h, a
    call Function2A37
    ld a, l
    ld [wSpriteTilesBufferLow], a
    ld a, h
    ld [wSpriteTilesBufferHigh], a
    ld a, $01
    call BankSwitch
    ld a, [wSpriteC165]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld de, wOAMBufferC9 ;$C900
    add hl, de
    ld a, [roomItemSpriteXPos]
    ld e, a
    ld a, [roomItemSpriteYPos]
    ld d, a
    call selectOAMDataDest
    ld a, [wSpriteC1F1]
    add a
    ld [wVramBankSubBuffer], a
    ld a, [roomItemSpriteIdBuffer]
    ld [wVramBankBuffer], a
    ld a, [wSprtPriorHeight]
    srl a
    srl a
    srl a
    srl a
    ld c, a
    ld a, [wSprtPriorWidth]
    srl a
    srl a
    srl a
    ld b, a
    call funcOAMSprt2D4A
    jp loadSprtOAMBuffer
.Label2B4B
    ld a, $01
    jp BankSwitch
;2B50

Label2B50: ;00:2B50
    ld a, [de]
    ld [roomItemSpriteXPos], a
    inc de
    ld a, [de]
    ld [roomItemSpriteYPos], a
    inc de
    ld a, [de]
    ld [wSprtPriorWidth], a
    inc de
    ld a, [de]
    ld [wSprtPriorHeight], a
    inc de
    inc de
    ld a, [de]
    ld c, a
    ld a, [wSpriteC165]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld de, wOAMBufferC9
    add hl, de
    ld a, [roomItemSpriteXPos]
    ld e, a
    ld a, [roomItemSpriteYPos]
    ld d, a
    call selectOAMDataDest
    ld a, c
    and a, $0F
    srl a
    srl a
    add a
    add a, $74
    ld [wVramBankSubBuffer], a
    ld a, $06
    ld [wVramBankBuffer], a
    ld a, [wSpriteC165]
    inc a
    ld [wSpriteC165], a
    ld bc, $101
    jp loadSprtOAMBuffer
    ld a, [de]
    ld [roomItemSpriteXPos], a
    inc de
    ld a, [de]
    ld [roomItemSpriteYPos], a
    inc de
    ld a, [de]
    ld [wSprtPriorWidth], a
    inc de
    ld a, [de]
    ld [wSprtPriorHeight], a
    inc de
    ld a, [de]
    ld c, a
    ld a, [wSpriteC165]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld de, wOAMBufferC9
    add hl, de
    ld a, [roomItemSpriteXPos]
    ld e, a
    ld a, [roomItemSpriteYPos]
    ld d, a
    call selectOAMDataDest
    ld a, c
    and a, $0F
    srl a
    srl a
    add a
    add a, $7A
    ld [wVramBankSubBuffer], a
    ld a, $05
    ld [wVramBankBuffer], a
    ld a, [wSpriteC165]
    inc a
    ld [wSpriteC165], a
    ld bc, $101
    jp loadSprtOAMBuffer
;2BE9

loadSpriteTilesData: ;00:2BE9
    dec de
    dec de
    dec de ;C800 Sprite Y Pos Low
    ld a, [de]
    ld [wSprtPriorYaxis], a
    inc de
    inc de
    inc de ;C803 Sprite X Pos Low
    ld a, [de]
    ld [wSprtPriorXaxis], a
    inc de ;C804 Sprite Y Pos Low
    ld a, [de]
    ld [wSprtPriorY2axis], a
    inc de ;C805 Sprite X scale
    ld a, [de]
    ld [wSprtPriorWidth], a
    inc de ;C806 Sprite Y scale
    ld a, [de]
    ld [wSprtPriorHeight], a
    inc de ;C807 Sprite facing
    ld a, [de]
    ld c, a ;store facing in c
    inc de ;C808 Sprite frame id
    ld a, [de]
    push af ;store frameId
    inc de ;C809 Sprite animation ID
    ld a, [de]
    ld l, a ;store animId in l
    ld e, $00 ;set temp X scale to $00
    ld a, [wSprtPriorWidth]
    cp a, $21
    jr nc, .Label2C25 ;jump if current X scale is >= $21
    ld d, a
    ld a, $20
    sub a, d
    srl a
    ld e, a ; set X scale ($20 - xScale) / 2
    cp a, $0D
    jr c, .Label2C25 ;jump if result is < $0D
	;else set X scale to $0C
    ld e, $0C
.Label2C25
    ld a, e ;set final X scale result
    ld [wSprtPriorWidth], a
    ld h, $00
	;offset animationId by x64 bytes
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld de, _chrisSpritesTable ;$52EB
    ld a, [spriteIdBuffer]
    cp a, CHRIS
    jr z, Label2C65
    ld de, _jillSpritesTable ;$598B
    cp a, JILL
    jr z, Label2C65
    ld de, _rebeccaSpritesTable ;$62FB
    cp a, REBECCA
    jr z, Label2C65
    ld de, _weskerBarrySpritesTable ;$602B
    cp a, WESKER
    jr z, Label2C65
    cp a, BARRY
    jr z, Label2C65
    ld de, _zombieSpritesTable ;$64EB
    cp a, ZOMBIE
    jr z, Label2C65
    ld de, _yawnSpritesTable ;$684B
    cp a, YAWN
    jr z, Label2C65
	;else objects
    ld de, _objectsSpritesTable ;$676B
Label2C65
    ld a, [wCameraType]
    or a
    jr z, Label2C6F ;jump if camera type is $00 (normal)
	;if overhead camera type apply a 4 byte offset
    inc de
    inc de
    inc de
    inc de
Label2C6F
    add hl, de ;apply animation offset
    ld a, [wCameraFacing]
    ld e, a
    ld a, c ;sprite facing
    add a, e
    and a, $1F
    ld [wPlayerCamFacing], a ; (camFacing + SprtFacing) & $1F
    srl a
    srl a
    add a
    add a
    add a
    ld e, a
    ld d, $00 ;facing offset ( PlayerCamFacing / 2 ) * 8
    add hl, de ;apply facing offset
    ld a, $FD
    call BankSwitch
    ld a, [hli]
    ld c, a ;sprite bank
    inc hl
    ld a, [hli]
    ld h, [hl]
    ld l, a ;sprite pointer
    pop af ;restore frame id
    srl a
    srl a
    srl a
    add a
    ld e, a ; ( frameId / 8 ) * 2
    ld d, $00
    add hl, de ;apply frame offset
    ld e, [hl]
    inc hl
    ld d, [hl] ;store sprite frame pointer in de
    ld a, c
    call BankSwitch
    ld a, [wSpriteTilesBufferLow]
    ld l, a
    ld a, [wSpriteTilesBufferHigh]
    ld h, a
    push hl
    call loadSpriteTilesBuffer
    ld a, l
    ld [wSpriteTilesBufferLow], a
    ld a, h
    ld [wSpriteTilesBufferHigh], a
    ld a, $01
    call BankSwitch
    pop hl
    push hl
    call callSprtFloodEfect
    pop hl
    call callRoomOverlapSprt
    ld a, [wSpriteC165]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld de, wOAMBufferC9 ;$C900
    add hl, de
    ld a, [wSprtPriorXaxis]
    ld e, a
    ld a, [wSprtPriorY2axis]
    ld d, a
    call selectOAMDataDest
    ld a, [wSpriteC1F1]
    add a
	;set vram chars sprite positions
    ld [wVramBankSubBuffer], a
    ld c, $00
    ld a, [spriteIdBuffer]
    cp a, CHRIS
    jr z, Label2D13
    ld c, $01
    cp a, JILL
    jr z, Label2D13
    ld c, $02
    cp a, REBECCA
    jr z, Label2D13
    ld c, $00
    cp a, BARRY
    jr z, Label2D13
    ld c, $02
    cp a, WESKER
    jr z, Label2D13
    ld c, $07
    cp a, ZOMBIE
    jr z, Label2D13
    ld c, $04
    cp a, YAWN
    jr z, Label2D13
	;else objects
    ld c, $04
Label2D13
    ld a, c
    ld [wVramBankBuffer], a
    ld a, [wSprtPriorHeight]
    ld c, a
    and a, $0F
    jr z, Label2D25
    ld a, c
    and a, $F0
    add a, $10
    ld c, a
Label2D25
    srl c
    srl c
    srl c
    srl c
    ld b, $04
    call funcOAMSprt2D4A
    ld a, [wSprtPriorWidth]
    cp a, $08
    jr c, Label2D47
    ld a, e
    add a, $08
    ld e, a
    ld b, $02
    ld a, [wVramBankSubBuffer]
    add a, c
    add a, c
    ld [wVramBankSubBuffer], a
Label2D47
    jp jumpToSprtOAMBufferLoad


funcOAMSprt2D4A: ;00:2D4A
    push de
    xor a
    ld e, b
.loop2D4D
    add a, c
    dec e
    jr nz, .loop2D4D
    ld e, a
    ld a, [wSpriteC165]
    add a, e
    ld [wSpriteC165], a
    ld a, [wSpriteC1F1]
    add a, e
    ld [wSpriteC1F1], a
    pop de
    ret

;00:2D62

loadDoorSpriteData: ;00:2D62
    ld a, BANK(doorsSpritesheet) ;$0B
    call BankSwitch
    ld a, [wDoorSprtTileBufferOffset]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld de, wSpriteTilesBuffer ;$CB00
    add hl, de
    ld a, [wDoorSpriteAddressLow]
    ld e, a
    ld a, [wDoorSpriteAddressHigh]
    ld d, a
    call loadSpriteTilesBuffer
    ld a, $01
    call BankSwitch
    ld a, [wDoorSprtTileBufferOffset]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld de, wOAMBufferC9 ;$C900
    add hl, de
    ld a, [wDoorSpriteYPos]
    ld e, a
    ld a, [wDoorSpriteXPos]
    ld d, a
    call selectOAMDataDest
    ld a, [wDoorSprtTileBufferOffset]
    add a
    ld [wVramBankSubBuffer], a
    ld a, [wc161]
    ld [wVramBankBuffer], a
    ld a, [wSprtPriorHeight]
    ld c, a
    and a, $0F
    jr z, Label2DB8
    ld a, c
    and a, $F0
    add a, $10
    ld c, a
Label2DB8
    srl c
    srl c
    srl c
    srl c
    ld a, c
    add a
    add a
    ld b, a
    ld a, [wDoorSprtTileBufferOffset]
    add a, b
    ld [wDoorSprtTileBufferOffset], a
    ld b, $04
    jp loadSprtOAMBuffer

loadSaveGameMenu:: ;00:2DD0
;a: mode (00: load game, 01:save game)
    ld [wLoadOrSave], a
    ld hl, LoadSaveScrnTable ;$2F10 ;
    ld a, $16
    call loadTileMap ;load typewriter BG @0D:5740
    ld a, BANK(ArrowCursor) ;$02
    call BankSwitch
    ld de, ArrowCursor ;$6C7C
    ld hl, wSpriteTilesBuffer ;$cb00
    ld bc, $20 ; bytes count
    call loadSprtTilesToBuffer
    ld a, $01
    call BankSwitch
    ld de, LoadGameText ;$5701
    ld a, [wLoadOrSave]
    cp a, LOAD_GAME_MODE ;$00
    jr z, .Label2DFE
    ld de, SaveGameText ;$570E
.Label2DFE
    call printTypewriterText
    call goToPrintSavedText
    ld de, DoNotLoadText ;$57BF
    ld a, [wLoadOrSave]
    cp a, LOAD_GAME_MODE ;$00
    jr z, .Label2E11 ;jump if load mode
	;if save mode
    ld de, DoNotSaveText ;$57CD
.Label2E11
    call printTypewriterText
    call hideSprites
    call enableHDMA
    xor a
    ld [wCursorPosId], a
    ld a, $20
    ld [wLCDUpdate], a
loop2E23: ;load/save menu loop
    call haltCPU
    call setTWArrowOAMData
    ld hl, wCursorPosId
    ld a, [wButtonPressId]
    and a, UP_INPUT ;$40
    jr z, .Label2E4A
    ld a, [wUpKeyPressDown]
    or a
    jr nz, .Label2E4E
    ld a, [hl]
    or a
    jr z, .Label2E4E
    dec [hl] ;dec cursor position
    ld a, $01
    ld [wUpKeyPressDown], a
    ld a, SAVE_TYPING_SFX ;$16
    call playSFX
    jr .Label2E4E
.Label2E4A
    xor a
    ld [wUpKeyPressDown], a
.Label2E4E
    ld hl, wCursorPosId
    ld a, [wButtonPressId]
    and a, DOWN_INPUT ;$80
    jr z, .Label2E70
    ld a, [wDownKeyPressDown]
    or a
    jr nz, .Label2E74
    ld a, [hl]
    cp a, $04
    jr z, .Label2E74
    inc [hl] ;inc cursor position
    ld a, $01
    ld [wDownKeyPressDown], a
    ld a, SAVE_TYPING_SFX ;$16
    call playSFX
    jr .Label2E74
.Label2E70
    xor a
    ld [wDownKeyPressDown], a
.Label2E74
    ld a, [wLCDUpdate]
    cp a, $5E ;where exit from save menu, return when screen completly fade-out
    ret z
    or a
    jr nz, applyFadePallete
    ld a, [wButtonPressId]
    and a, AB_START_INPUT ;$0B
    jr z, applyFadePallete
    ld a, [wCursorPosId]
    cp a, $04 ;do not save/load position
    jr z, .Label2EC2
    ld a, [wLoadOrSave]
    cp a, LOAD_GAME_MODE ;$00
    jr z, .Label2E97 ;if load mode
	;if save mode
    call saveGame
    jr .Label2EC2
;load game action
.Label2E97
    ld a, [wCursorIdBuffer]
    push af
    call loadGame
    ld c, a
    pop af
    ld [wCursorIdBuffer], a ;restore cursor id buffer
    ld a, LOAD_GAME_MODE ;$00
    ld [wLoadOrSave], a ;set to load mode
    ld a, c
    or a
    jr z, applyFadePallete
    pop hl
    call ResetPal
    call hideSprites
    ld de, $023C ;first stack value after load game
    push de
    call displayLoadGameWelcomeMsg ;$439A
    ld a, $01
    ld [wLCDUpdate], a
    jp gameLoopWithEventCheck
;save game action
.Label2EC2
    ld a, $40
    ld [wLCDUpdate], a
    ld a, [wLoadOrSave]
    cp a, LOAD_GAME_MODE ;$00
    jr nz, applyFadePallete
    ld a, [wCursorPosId]
    cp a, $04
    jr z, applyFadePallete
    ld a, START_GAME_SFX ;$17
    call playSFX
applyFadePallete:
    call swapOAMDMAopcode
    ld hl, LoadSaveScrnPalTable ;$2F18
    call loadBGPallete
    jp loop2E23

;00:2EE6
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop

;00;2EEE
;Images Tilemap Lookup table
INCLUDE  "engine/ImagesTilemapsTable.asm"

loadTileMap:: ;00:2FDC
;load a tilemap from a lookup table in hl
;lookup table format (lil endian 16bit each value)
;[tilesAddress] [tilemapIndexes] [bank] [palleteIndexes]
    push af
    ld a, l
    ld [wTilemapLookupTableLow], a
    ld a, h
    ld [wTilemapLookupTableHigh], a
    ld e, [hl] ;store tiles addres in de
    inc hl
    ld d, [hl]
    inc hl
    ld bc, $0002 ;get tilemap bank
    add hl, bc
    ld a, [hl]
    call BankSwitch
    push hl
    ld hl, _VRAM+$800
    ld bc, $1000
    call loadDataToRam
    ld a, $01
    ld [vramBank], a ;vram bank select
    ld hl, _VRAM+$800
    ld bc, $1000
    call loadDataToRam
    xor a
    ld [vramBank], a ;vram bank select
    pop hl
    ld bc, $FFFE ;-2
    add hl, bc
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld hl, _SCRN0 ;$9800
    pop bc
.loop3017
    push hl
    ld c, $12
.loop301A
    call VBlankWait
    ld a, [de]
    add a, $80
    ld [hl], a
    call loadTilePalVRAM1
    inc de
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec c
    jr nz, .loop301A
    pop hl
    inc l
    dec b
    jr nz, .loop3017
    ld a, $01
    jp BankSwitch

loadTilePalVRAM1:: ;00:303A
    push bc
    push hl
    push de
	;get stored tilemap lookup table
    ld a, [wTilemapLookupTableLow]
    ld l, a
    ld a, [wTilemapLookupTableHigh]
    ld h, a
    ld bc, $0002 ;offset to pallete index tabl(de)
    add hl, bc
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld bc, $0002 ;offset to pallete data (bc)
    add hl, bc
    ld c, [hl]
    inc hl
    ld b, [hl]
    dec hl
    ld a, c
    sub a, e
    ld c, a
    ld a, b
    sbc a, d
    ld b, a
    pop de
    pop hl
    push de
    ld a, e
    add a, c
    ld e, a
    ld a, d
    adc a, b
    ld d, a
    ld a, $01
    ld [vramBank], a ;vram bank select
    call VBlankWait
    ld a, [de]
    ld [hl], a
    xor a
    ld [vramBank], a ;vram bank select
    pop de
    pop bc
    ret

loadRoomBGMask:: ;00:3073
    ld a, [wCurrentRomBank]
    push af
    ld a, $01
    call BankSwitch
    xor a
    push hl
    jr label308D

loadRoomBG:: ;00:3080
    ld a, [wCurrentRomBank]
    push af
    ld a, $01
    call BankSwitch
    push hl
    ld a, [wRoomScreen]
label308D:
    ld l, a
    ld h, $00
    push hl
    add hl, hl
    pop de
    add hl, de
    pop de
    add hl, de
    ld c, [hl] ;get room bg bank
    inc hl
    ld e, [hl] ;load screen bg addres to de
    inc hl
    ld d, [hl]
    inc hl
    ld a, c
    ld [wRoomBGBankId], a
    call BankSwitch
    ld hl, $280 ;offset to BG tiles data
    add hl, de
    call checkBgAddrOverflow
	;store bg data addr
    ld a, l
    ld [wBGDataAddrLow], a
    ld a, h
    ld [wBGDataAddrHigh], a
    ld a, [wCurrentRomBank]
    ld [wBGDataAddrBank], a
    xor a
    ld [wVramBankSubBuffer], a
    ld [wVramBankBuffer], a
    ld bc, $140 ; set number of room BG tiles
.loop30C2
    push bc
    push de
    ld a, [wRoomBGBankId]
    call BankSwitch
    ld a, [wVramBankSubBuffer]
    and a, $0F
    inc a
    ld l, a
    ld a, [wLowColliderBottomY]
    cp a, l
    jr nc, .Label314B
    ld a, [wLowColliderTopY]
    cp a, l
    jr c, .Label314B
    ld a, [wVramBankSubBuffer]
    ld l, a
    ld a, [wVramBankBuffer]
    ld h, a
    srl h
    rr l
    ld a, l
    srl a
    srl a
    srl a
    inc a
    ld l, a
    ld a, [wLowColliderRightX]
    cp a, l
    jr nc, .Label314B
    ld a, [wLowColliderLeftX]
    cp a, l
    jr c, .Label314B
    ld a, [wVramBankSubBuffer]
    and a, $0F
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, h
    add a, $98 ;bg tilemap offset
    ld h, a
    ld a, [wVramBankSubBuffer]
    ld c, a
    ld a, [wVramBankBuffer]
    ld b, a
    srl b
    rr c
    srl b
    rr c
    srl b
    rr c
    srl b
    rr c
    add hl, bc
    push hl ;store BG tilemap addr
    ld hl, $140 ;bg tile id offset
    add hl, de
    call checkBgAddrOverflow
    ld a, [hl]
    pop hl
    and a, $F7 ; mask tile ID
    ld c, a
    call VBlankWait
    ld a, [wVramBankSubBuffer]
    ld [hl], a
    ld a, $01
    ld [vramBank], a ;vram bank select
    ld a, [wVramBankBuffer]
    add a
    add a
    add a
    or a, c
    ld [hl], a
    xor a
    ld [vramBank], a ;vram bank select
.Label314B
    ld a, [wRoomBGBankId]
    call BankSwitch
    ld a, [wVramBankSubBuffer]
    and a, $0F
    inc a
    ld l, a
    ld a, [wLowColliderBottomY]
    cp a, l
    jr nc, .Label31CF
    ld a, [wLowColliderTopY]
    cp a, l
    jr c, .Label31CF
    ld a, [wVramBankSubBuffer]
    ld l, a
    ld a, [wVramBankBuffer]
    ld h, a
    srl h
    rr l
    ld a, l
    srl a
    srl a
    srl a
    inc a
    ld l, a
    ld a, [wLowColliderRightX]
    cp a, l
    jr nc, .Label31CF
    ld a, [wLowColliderLeftX]
    cp a, l
    jr c, .Label31CF
    ld a, [de]
    ld c, a
    ld hl, $140
    add hl, de
    call checkBgAddrOverflow
    ld a, [hl]
    and a, $08
    srl a
    srl a
    srl a
    ld h, a
    ld l, c
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, [wBGDataAddrBank]
    call BankSwitch
    ld a, [wBGDataAddrLow]
    ld e, a
    ld a, [wBGDataAddrHigh]
    ld d, a
    add hl, de
    ld e, l
    ld d, h
    call checkCurrentBgAddr
    ld a, [wVramBankSubBuffer]
    add a, $80
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld a, h
    add a, $88
    ld h, a
    ld a, [wVramBankBuffer]
    ld [vramBank], a ;vram bank select
    ld bc, $2
    call loadBGTilesData
    xor a
    ld [vramBank], a ;vram bank select
.Label31CF
    ld a, [wVramBankSubBuffer]
    add a, $01
    ld [wVramBankSubBuffer], a
    ld a, [wVramBankBuffer]
    adc a, $00
    ld [wVramBankBuffer], a
    pop de
    inc de
    call checkTileMapAddr
    pop bc
    dec bc
    ld a, b
    or a, c
    jp nz, .loop30C2
    pop af
    jp BankSwitch

checkCurrentBgAddr:: ;00:31EF
    ld a, d
    cp a, $80
    ret c
    sub a, $40
    ld d, a
    ld a, [wCurrentRomBank]
    inc a
    jp BankSwitch

checkBgAddrOverflow:: ;00:31FD
	ld a, h
    cp a, $80
    ret c
    sub a, $40
    ld h, a
    ld a, [wCurrentRomBank]
    inc a
    jp BankSwitch

checkTileMapAddr:: ;00:320B
    ld a, d
    cp a, $80
    ret c
    sub a, $40
    ld d, a
    ld a, [wRoomBGBankId]
    inc a
    ld [wRoomBGBankId], a
    jp BankSwitch

loadSprtTilesToBuffer:: ;00:321C
;params:
;de: sprite pointer
;hl: buffer address
;bc: bytes to copy
    ld a, [de]
    ld [hli], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, loadSprtTilesToBuffer
    ret

function3225: ;00:3225
    ld a, [rSTAT]  ;lcd status
    and a, $03
    jr z, function3225
.loop322B
    ld a, [rSTAT]  ;lcd status
    and a, $03
    jr nz, .loop322B
    ld a, [de]
    add a, $80
    ld [hli], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, function3225
    ret

loadDataToRam: ;00:323C
    ld a, [rSTAT]  ;lcd status
    and a, $03
    jr z, loadDataToRam
.loop3242
    ld a, [rSTAT]  ;lcd status
    and a, $03
    jr nz, .loop3242
    ld a, [de]
    ld [hli], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, loadDataToRam
    ret

loadBGTilesData:: ;00:3251
    ld a, [rSTAT]  ;lcd status
    and a, $03
    jr z, loadBGTilesData
.loop3257
    ld a, [rSTAT]  ;lcd status
    and a, $03
    jr nz, .loop3257
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, d
    cp a, $80
    jr c, .Label3284
    sub a, $40
    ld d, a
    ld a, [wCurrentRomBank]
    inc a
    call BankSwitch
.Label3284
    dec bc
    ld a, b
    or a, c
    jr nz, loadBGTilesData
    ret


VBlankWait:: ;00:328A
    ld a, [rSTAT]  ;lcd status
    and a, $03
    jr z, VBlankWait
.vBlankLoop
    ld a, [rSTAT]  ;lcd status
    and a, $03
    jr nz, .vBlankLoop
    ret


loadPallete:: ;00:3297
;parameters:
;a:  pallete bank
;hl: bg pal pointer
;de: obj pal pointer
    call BankSwitch
    push de ;store obj pallete pointer
	;load BG pallete
    ld c, $00
    ld b, $20
.loop329F
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld a, [wLCDUpdate]
    and a, $1F
    call changePalTone
    call VBlankWait
    ld a, c
    ld [BgPalSel], a ;bg color index
    ld a, e
    ld [BgPalData], a ;bg color data
    inc c
    call VBlankWait
    ld a, c
    ld [BgPalSel], a ;bg color index
    ld a, d
    ld [BgPalData], a ;bg color data
    inc c
    dec b
    jr nz, .loop329F
    pop hl
	;load OBJ pallete
    ld c, $00
    ld b, $20
.loop32C7
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld a, [wLCDUpdate]
    and a, $1F
    call changePalTone
    call VBlankWait
    ld a, c
    ld [ObjPalSel], a ;obj color index
    ld a, e
    ld [ObjPalData], a ;obj color data
    inc c
    call VBlankWait
    ld a, c
    ld [ObjPalSel], a ;obj color index
    ld a, d
    ld [ObjPalData], a ;obj color data
    inc c
    dec b
    jr nz, .loop32C7
    ld a, $01
    jp BankSwitch

changePalTone:: ;00:32EF
    push bc
    push hl
    ld l, a
    ld a, e
    and a, $1F
    sub a, l
    jr nc, .label32F9
    xor a
.label32F9
    ld c, a
    ld a, e
    and a, $E0
    srl a
    srl a
    srl a
    srl a
    srl a
    ld h, a
    ld a, d
    and a, $03
    add a
    add a
    add a
    or a, h
    sub a, l
    jr nc, .label3313
    xor a
.label3313
    ld h, a
    and a, $07
    add a
    add a
    add a
    add a
    add a
    or a, c
    ld c, a
    ld a, h
    and a, $18
    srl a
    srl a
    srl a
    ld b, a
    ld a, d
    and a, $7C
    srl a
    srl a
    sub a, l
    jr nc, .label3332
    xor a
.label3332
    add a
    add a
    or a, b
    ld b, a
    ld e, c
    ld d, b
    pop hl
    pop bc
    ret

loadTitleScreen:: ;00:333B
    ld hl, TitleLookupTable ;$2EF4 ;title screen lookup table
    ld a, $14
    call loadTileMap ; load title screen tilemap
    xor a
    ld [wCursorPosId], a
    call hideSprites
    ld a, $20
    ld [wLCDUpdate], a
    ld hl, $300
    ld a, l
    ld [wTimer], a
    ld a, h
    ld [wc1c5], a
.titleLoop
    call haltCPU
    ld a, [wLCDUpdate]
    or a
    call z, goToCheckTitleCursor
    ld a, [wLCDUpdate]
    or a
    jr nz, .Label3383
    ld a, [wTimer]
    dec a
    ld [wTimer], a
    cp a, $FF
    jr nz, .Label3383
    ld a, [wc1c5]
    dec a
    ld [wc1c5], a
    cp a, $FF
    jr nz, .Label3383
    jp loadTitleSlideRooms ;$478F ;loadTitleSlideRooms
.Label3383
    ld a, [wLCDUpdate]
    cp a, $5E
    ret z
    or a
    jr nz, .Label339D
    ld a, [wButtonPressId]
    and a, START_INPUT ;$08
    jr z, .Label339D
    ld a, $40
    ld [wLCDUpdate], a
    ld a, FIREGUN_SFX ;$0F
    call playSFX
.Label339D
    ld a, [wLCDUpdate]
    push af
    ld hl, TitlePalLookupTable ;$2EFC ; pallete pointer
    call loadBGPallete
    pop af
    ld c, a
    ld a, [wLCDUpdate]
    or a
    jr nz, .titleLoop
    ld a, c
    cp a, $01
    jr nz, .titleLoop
    di
    ld hl, ResidentSample ;$409C "resident" sample audio
    ld de, $480
    ld bc, $C3 ;sample lenght
    ld a, $FF
    call BankSwitch
    call playSample
    ld a, $01
    call BankSwitch
    ld bc, $1388 ;wait delay
    call waitDelay
    ld hl, EvilSample ;$4D1A "evil" sample audio
    ld de, $480
    ld bc, $CC ;sample lenght
    ld a, $FF
    call BankSwitch
    call playSample
    ld a, $01
    call BankSwitch
    ei
    jp .titleLoop

loadPlayerSelectMenu:: ;00:33EB
    ld hl, PlayerSelectScrnMapTable ;$2F02
    ld a, $14
    call loadTileMap
    ld a, $02
    call BankSwitch
    ld de, StarsPoliceCardExtraColors ;$6AFC
    ld hl, wSpriteTilesBuffer ;$cb00
    ld bc, $180
    call loadSprtTilesToBuffer
    ld de, ChrisAndJillPoliceCardFaces ;$67FC
    ld hl, wSpriteTilesBufferCC+$80 ;$cc80
    ld bc, $300
    call loadSprtTilesToBuffer
    ld de, ArrowCursor ;$6C7C
    ld hl, wSpriteTilesBufferCF+$80 ;$cf80
    ld bc, $20
    call loadSprtTilesToBuffer
    ld a, $01
    call BankSwitch
    call enableHDMA
    xor a
    ld [wCursorPosId], a ;set cursor id $00 (chris)
    ld a, $28
    ld [policeCardXpos], a ;init police card x pos
    ld a, $38
    ld [policeCardYpos], a ;init police card y pos
    ld a, $20
    ld [wLCDUpdate], a
.loop3437
    call updatePolicecardFacePosition ;$48EA
    call updatePolicecardLogoColorsPosition ;$493A
    call updatePolicecardCursors ;$48BD
    call haltCPU
    call updatePolicecardTilesPosition ;$3C37
    call swapOAMDMAopcode ;$4457
    call hideOAM ;4494
    ld a, [wLCDUpdate]
    or a
    jr nz, .Label3480
    ld a, [policeCardXpos]
    cp a, $28
    jr z, .Label346C
    sub a, $08
    ld [policeCardXpos], a
    cp a, $C0
    jr nz, .Label3480
    ld a, [wCursorPosId]
    xor a, $01 ;swap selected player id (0 or 1)
    ld [wCursorPosId], a
    jr .Label3480
.Label346C
    ld a, [wButtonPressId]
    and a, LEFT_RIGHT_INPUT ;$30
    jr z, .Label3480
	;if left/right input press
    ld a, [policeCardXpos]
    sub a, $08
    ld [policeCardXpos], a
    ld a, SELECT_MENU_SFX ;$00
    call playSFX
.Label3480
    ld a, [policeCardXpos]
    cp a, $28
    jr nz, .Label34A1
    ld a, [wLCDUpdate]
    cp a, $5E
    ret z
    or a
    jr nz, .Label34A1
    ld a, [wButtonPressId]
    and a, A_START_INPUT ;$09
    jr z, .Label34A1
	;if player selected
    ld a, $40
    ld [wLCDUpdate], a
    ld a, START_GAME_SFX ;$17
    call playSFX
.Label34A1
    ld hl, PlayerSelectScrnMapTable+8 ;$2F0A
    call loadBGPallete
    jr .loop3437

;00:34A9

clearItemDetailWindowMap:: ;00:34A9
    ld hl, _SCRN0+$41 ;start item detail window tilemap
    ld e, $00
    ld d, $0F
    ld b, $0B
Loop34B2
    push hl
    ld c, $08
Loop34B5
    call VBlankWait
    ld [hl], e
    ld a, $01
    ld [vramBank], a ;vram bank select
    ld [hl], d
    xor a
    ld [vramBank], a ;vram bank select
    push bc
    ld bc, $20
    add hl, bc
    pop bc
    inc e
    dec c
    jr nz, Loop34B5
    pop hl
    inc l
    dec b
    jr nz, Loop34B2
    ret
;34D1

loadMenuDetailWindowPalIds: ;00:34D1
    ld hl, _SCRN0+$41 ;start item detail window tilemap
    ld b, $0B
Loop34D6
    push hl
    ld c, $08
Loop34D9
    call VBlankWait
    ld a, $01
    ld [vramBank], a ;vram bank select
    ld a, [de]
    or a, $08
    ld [hl], a
    xor a
    ld [vramBank], a ;vram bank select
    push bc
    ld bc, $20
    add hl, bc
    pop bc
    inc de
    dec c
    jr nz, Loop34D9
    pop hl
    inc l
    dec b
    jr nz, Loop34D6
    ret
;34F7

clearItemDetailWindowTiles: ;00:34F7
    ld a, $01
    ld [vramBank], a ;vram bank select
    ld hl, _VRAM+$1000 ;item detail window vram
    ld b, $B0 ;tiles number
Label3500
    ld a, [rSTAT]  ;lcd status
    and a, $03
    jr z, Label3500
Loop3506
    ld a, [rSTAT]  ;lcd status
    and a, $03
    jr nz, Loop3506
    ld a, $FF
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    dec b
    jr nz, Label3500
    xor a
    ld [vramBank], a ;vram bank select
    ret
;351D

loadRoomsMapDetail: ;00:351D
    ld a, BANK(Room_00_map) ;$05
    call BankSwitch
    ld hl, Room_00_map ;$5EE7
    ld b, $2D ;room maps count
drawRoomMapLoop
    push bc
    call drawRoomMap ;$603D
    pop bc
    dec b
    jr nz, drawRoomMapLoop
    ld a, $01
    call BankSwitch
    ld a, BANK(mapDetailPallete) ;$09
    ld hl, mapDetailPallete ;$4040
    jp loadBGPal
;353C

loadBGPal: ;00:353C
;paranms
;a: pallete bank
;hl: pallete pointer
    call BankSwitch
    ld c, $00
    ld b, $20
.loop3543
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld a, [wLCDUpdate]
    and a, $1F
    call changePalTone
    call VBlankWait
    ld a, c
    ld [BgPalSel], a ;bg color index
    ld a, e
    ld [BgPalData], a ;bg color data
    inc c
    call VBlankWait
    ld a, c
    ld [BgPalSel], a ;bg color index
    ld a, d
    ld [BgPalData], a ;bg color data
    inc c
    dec b
    jr nz, .loop3543
    ld a, $01
    jp BankSwitch

INCLUDE "main/mainMenuSubmenusPointers.asm" ;356B
;35BF

loadFileBooksMenu: ;00:35BF
    ld hl, fileBook01TilesDataPointers ;$3577
    ld a, [wFileBookId]
    or a ;$00
    jr z, Label35D5
    ld hl, fileBook02TilesDataPointers ;$3583
    ld a, [wFileBookId]
    cp a, $01
    jr z, Label35D5
	;filebook 03
    ld hl, fileBook03TilesDataPointers ;$358F
Label35D5
    jr loadSubmenuTilesData
;35D7

loadItemSubmenu: ;35D7
    ld hl, itemUseEquipOptionDataPointers ;$35B3
    ld a, [wMenuSelGridId]
    cp a, $80
    jr z, Label35EB ;use/equip option
    ld hl, itemCheckOptionDataPointers ;$359B
    cp a, $81 ;check option
    jr z, Label35EB
	;combine
    ld hl, itemCombineOptionDataPointers ;$35A7
Label35EB
    jr loadSubmenuTilesData

loadMapSubmenu: ;35ED
    ld hl, mapSubmenuTilesDataPointers ;$356B
    jr loadSubmenuTilesData

loadSubmenuTilesData:
    ld c, [hl] ;submenu bank
    inc hl
    inc hl
    ld e, [hl]
    inc hl
    ld d, [hl] ;submenu tiles id
    inc hl
    ld a, [hli]
    ld [wBGDataAddrLow], a
    ld a, [hli]
    ld [wBGDataAddrHigh], a ;submenu tiles data
    push bc
    push hl
    ld a, c
    call BankSwitch
    ld a, $01
    ld [vramBank], a ;vram bank select
    ld hl, _VRAM+$1000 ;menu detail window address
    ld b, $58 ;menu detail windows tiles count
Label3610
    push bc
    push hl
    ld a, [de] ;load tile id
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl ;get tile id offset
    ld a, [wBGDataAddrLow]
    ld c, a
    ld a, [wBGDataAddrHigh]
    ld b, a
    add hl, bc ;get tile data
    ld c, l
    ld b, h ;store tile data addr in bc
    pop hl ;restore vram tile address
    ld a, $04
loadItemSubmenuTileDataLoop
    push af
    call VBlankWait
    ld a, [bc]
    ld [hli], a
    inc bc
    ld a, [bc]
    ld [hli], a
    inc bc
    ld a, [bc]
    ld [hli], a
    inc bc
    ld a, [bc]
    ld [hli], a
    inc bc
    pop af
    dec a
    jr nz, loadItemSubmenuTileDataLoop
    inc de ;next tile id
    pop bc
    dec b
    jr nz, Label3610
;loadItemsubmenuPalleteIds
    xor a
    ld [vramBank], a ;vram bank select
    pop hl ;restore submenu pallete id adddress
    pop bc ;restore bank
    ld a, $01
    call BankSwitch
    ld e, [hl]
    inc hl
    ld d, [hl] ;get palIds address
    inc hl
    push hl
    ld a, c
    call BankSwitch
    call loadMenuDetailWindowPalIds
;loadItemSubmenuPallete
    pop hl
    ld a, $01
    call BankSwitch
    ld c, [hl] ;pal bank
    inc hl
    inc hl
    ld a, [hli]
    ld h, [hl]
    ld l, a ;get pallete address
    ld a, c
    jp loadBGPal
;3667

loadMainMenuPallete: ;3667
    ld a, BANK(MainMenuPallete) ;$0C
    ld hl, MainMenuPallete
    jp loadBGPal
;366F


includeItemMenu: ;00:366F
    call ResetPal
    xor a
    call loadMainMenuTileMap
    ld a, $01
    ld [wLCDUpdate], a
    ld a, $FF
    ld [wMenuSelGridId], a
    ld hl, MainMenuMapTable+8 ;$2F26
    call loadBGPallete
    call goToLoadItemBigSprite
    ld a, BANK(getItemTextPointers) ;$FA
    call BankSwitch
    ld a, [selectedItemId]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    ld de, getItemTextPointers ;$459B
    add hl, de
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, $01
    call BankSwitch
    ld hl, $0F00
    ld a, BANK(getItemTextPointers) ;$FA
    call printMessage ;print get item text
Loop36AB
    call haltCPU
    call updateHealthMeter
    call loadMainMenuFaceOAMData
    ld c, $00
    call goToLoadMenuItemCursors
    call goToLoadMenuItemsSprtData
    call goToLoadEquipedSpriteData
    call printChoiceArrow
    call enableHDMA
    call swapOAMDMAopcode
    ld a, [wButtonPressId]
    and a, A_START_INPUT ;$09
    jp nz, includeFoundItem
    jr Loop36AB
;36D2

showMenuItemName: ;00:36D2
    ld bc, ClearTextboxText ;$63EE
    ld hl, $0F00
    ld a, BANK(ClearTextboxText) ;$FA
    call printMessage
    ld de, itemsNamesPointer ;$4597
    ld a, [wMenuSelGridId]
    cp a, ITEM_SLOT_1 ;$04
    jr c, noItemNameToPrint ;return if selected grid is not item grid
    cp a, FILE_MENU ;$0C
    jr c, getItemNameIndex ;inside item grid
    cp a, COMBINE_GRID_MODE ;$E0
    jr c, Label36F3 ;not combine item grid
	;if in combine item grid
    sub a, COMBINE_GRID_MODE ;$E0 ;get item slot grid id
    jr getItemNameIndex
Label36F3
    cp a, CHECK_ITEM_CURSOR ;$81
    jr nz, noItemNameToPrint ;ret if not check option
    ld de, itemsNamesPointer+2 ;$4599
    ld a, [selectedGridId]
getItemNameIndex
    sub a, $04 ;get slot id
    ld l, a
    ld h, $00
    ld bc, ItemIdSlot1
    add hl, bc ;get slot item id
    ld a, [hl]
    cp a, EMPTY ;$00
    jr z, noItemNameToPrint
    ld a, BANK(itemsNamesPointer) ;$FA
    call BankSwitch
    ld l, [hl]
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, de ;get item name pointer
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, $01
    call BankSwitch
    ld hl, $0F00
    ld a, BANK(itemsNamesPointer) ;$FA
    jp printMessage ;print item name
noItemNameToPrint
    ret
;3728

loadMainMenuTileMap: ;00:3728
;a: menu mode (00: main menu, FF: itembox)
    or a
    jr z, mainMenuMode
    ld hl, ItemBoxMapTable ;$2FAA
    ld a, $20
    call loadTileMap
    jr Label3743
mainMenuMode
    ld hl, MainMenuMapTable ;$2F1E
    ld a, $20
    call loadTileMap
    call clearItemDetailWindowMap
    call clearItemDetailWindowTiles
Label3743
    ld a, BANK(MainMenuFaces) ;$0C
    call BankSwitch
    ld de, MainMenuFaces ;$4E84
    ld hl, wSpriteTilesBuffer ;$CB00
    ld bc, $80
    call loadDataToRam
    ld a, $01
    call BankSwitch
    call loadFontTiles
    ld a, [wSelectedPlayer]
    or a
    jr z, Label37B1 ;jump if chris
	;if jill, extend item slots
    ld de, _SCRN0+$EC ;first chris item slot row top tiles
    ld hl, _SCRN0+$AC ;first jill item slot row top tiles
    ld bc, $8
    call loadDataToRam
    ld de, _SCRN0+$10C ;first chris item slot row middle tiles
    ld hl, _SCRN0+$CC
    ld bc, $8
    call loadDataToRam
    ld de, _SCRN0+$12C ;first chris item slot row bottom tiles
    ld hl, _SCRN0+$EC
    ld bc, $8
    call loadDataToRam
	;repeat in vram bank 01
    ld a, $01
    ld [vramBank], a ;vram bank select
    ld de, _SCRN0+$EC
    ld hl, _SCRN0+$AC
    ld bc, $8
    call loadDataToRam
    ld de, _SCRN0+$10C
    ld hl, _SCRN0+$CC
    ld bc, $8
    call loadDataToRam
    ld de, _SCRN0+$12C
    ld hl, _SCRN0+$EC
    ld bc, $8
    call loadDataToRam
    xor a
    ld [vramBank], a ;vram bank select
Label37B1
    call enableHDMA
    call hideSprites
    ret
;37B8

loadFontTiles:: ;00:37B8
    ld de, mainFonts ;$4CB0
    jr Label37C0
loadmainFontsBold: ;37BD
    ld de, mainFontsBold ;$5430
Label37C0:
    ld a, $01
    ld [vramBank], a ;vram bank select
    ld a, BANK(mainFontsBold) ;$0F
    call BankSwitch
    ld hl, _VRAM+$800
    ld bc, $0800
    call loadDataToRam
    ld a, $01
    call BankSwitch
    xor a
    ld [vramBank], a ;vram bank select
    ret

goToScrolldownTypoingMsg:: ;00:37DB
	ld a, $05
	ld hl, ScrolldownTypingMessage ;$6149
	jp jumToFunctionHL3 ;$02A0
;37E3



checkMenuInputPress:: ;00:37E3
    ld a, [wMenuSelGridId]
    cp a, FILE_MENU ;$0C
    jr nc, Label3814 ;if filebook cursor, map, radio, item options or combine grid
;items and top option grid
    call checkMenuLeftKeyPress
    call checkMenuRightKeyPress
    call checkMenuUpKeyPress
    call checkMenuDownKeyPress
    call checkMenuAKeyPress
    ld a, [wButtonPressId]
    and a, B_INPUT
    jr z, resetMenuBInputPress
    ld a, [wBButtonPressDown]
    or a
    ret nz ;return if B input press
    dec a ;enable B button press
    ld [wBButtonPressDown], a
    ld a, $5C
    ld [wLCDUpdate], a ;set fade-out
    ret
resetMenuBInputPress ;00:380F
    xor a
    ld [wBButtonPressDown], a
    ret
Label3814 ;00:3814
    cp a, COMBINE_GRID_MODE ;$E0
    jr c, checkSubmenuInputs ;not combine grid
;combineGridInputs
    call checkMenuLeftKeyPress
    call checkMenuRightKeyPress
    call checkCombineGridUpInput
    call checkCombineGridDownInput
    call checkCombineGridAInput
    jp checkSubmenuBInput
checkSubmenuInputs ;382A
    call checkSubmenuLeftInput
    call checkSubmenuRightInput
    call checkSubmenuUpInput
    call checkSubmenuDownInput
    call checkSubmenuAInput
    jp checkSubmenuBInput

;383C
checkSubmenuUpInput: ;383C
    ld a, [wButtonPressId]
    and a, UP_INPUT
    jr z, Label386D
    ld a, [wUpKeyPressDown]
    or a
    ret nz
    ld a, $FF
    ld [wUpKeyPressDown], a
    ld a, [wMenuSelGridId]
    cp a, FILE_MENU ;$0C
    jr z, checkFilebookSubmenuUpInput
    cp a, CHECK_ITEM_CURSOR ;$81
    ret c ;ret if top submenu
    dec a ;move to use/equip
    ld [wMenuSelGridId], a
    call loadItemSubmenu
    ld a, SELECT_MENU_SFX ;$00
    jp playSFX
checkFilebookSubmenuUpInput
    ld a, [wFileBookmarkCursorPos]
    or a
    ret z ;return if top bookmark
    dec a
    ld [wFileBookmarkCursorPos], a
    ret
Label386D ;00:386D
    xor a
    ld [wUpKeyPressDown], a
    ret
;3872

checkSubmenuDownInput: ;00:3872
    ld a, [wButtonPressId]
    and a, $80
    jr z, Label38A7
    ld a, [wDownKeyPressDown]
    or a
    ret nz
    ld a, $FF
    ld [wDownKeyPressDown], a
    ld a, [wMenuSelGridId]
    cp a, FILE_MENU ;$0C
    jr z, checkFilebookSubmenuDownInput
    cp a, USE_EQUIP_CURSOR ;$80
    ret c
    cp a, COMBINE_CURSOR ;$82
    ret nc
    inc a ;move to combine submenu
    ld [wMenuSelGridId], a
    call loadItemSubmenu
    ld a, SELECT_MENU_SFX ;$00
    jp playSFX
checkFilebookSubmenuDownInput
    ld a, [wFileBookmarkCursorPos]
    cp a, FILE_MENU ;$0C
    ret z ;return if bottom bookmark
    inc a
    ld [wFileBookmarkCursorPos], a
    ret
Label38A7 ;00:38A7
    xor a
    ld [wDownKeyPressDown], a
    ret
;38AC

checkSubmenuLeftInput: ;00:38AC
    ld a, [wButtonPressId]
    and a, LEFT_INPUT
    ret z
    ld a, [wMenuSelGridId]
    cp a, FILE_MENU ;$0C
    ret nz ;return if not filebook menu
    ld a, [wFileBookId]
    or a
    ret z ;ret if first filebook
    dec a
    ld [wFileBookId], a
    ld a, SELECT_MENU_SFX ;$00
    call playSFX
    call loadFileBooksMenu
    call loadFileBookmarksCursors
    ld b, $20
    jp routineDelay
;38D1
checkSubmenuRightInput: ;38D1
    ld a, [wButtonPressId]
    and a, RIGHT_INPUT
    ret z
    ld a, [wMenuSelGridId]
    cp a, FILE_MENU ;$0C
    ret nz
    ld a, [wFileBookId]
    cp a, $02
    ret z ;return if last filebook
    inc a
    ld [wFileBookId], a
    ld a, SELECT_MENU_SFX ;$00
    call playSFX
    call loadFileBooksMenu
    call loadFileBookmarksCursors
    ld b, $20
    jp routineDelay
;38F7

checkSubmenuBInput: ;01:38F7
    ld a, [wButtonPressId]
    and a, B_INPUT
    jr z, Label3934
    ld a, [wBButtonPressDown]
    or a
    ret nz
    dec a
    ld [wBButtonPressDown], a
    ld a, [wMenuSelGridId]
    cp a, FILE_MENU ;$0C
    jr z, exitFilebookSubmenu
    cp a, MAP_MENU ;$0E
    jr z, exitMapSelectionSubmenu
    cp a, MAP_DETAIL_MENU ;$12
    jr z, exitMapDetailSubmenu
    cp a, USE_EQUIP_CURSOR ;$80
    ret c
    ld a, ITEM_SLOT_1 ;$04
    ld [wMenuSelGridId], a
    call clearItemDetailWindowMap
    call loadMainMenuPallete
    call clearItemDetailWindowTiles
    call showMenuItemName
    ld a, CANCEL_SFX ;$03
    call playSFX
    ld b, $10
    jp routineDelay
Label3934
    xor a
    ld [wBButtonPressDown], a ;reset B input press
    ret
exitFilebookSubmenu ;00:3939
    call loadMainMenuPallete
    call clearItemDetailWindowMap
    call clearItemDetailWindowTiles
    ld a, ITEM_SLOT_1 ;$04
    ld [wMenuSelGridId], a
    call loadFileBookmarksCursors
    ld a, CANCEL_SFX ;$03
    jp playSFX
exitMapSelectionSubmenu
    call loadMainMenuPallete
    call clearItemDetailWindowTiles
    ld a, ITEM_SLOT_1 ;$04
    ld [wMenuSelGridId], a
    ld a, CANCEL_SFX ;$03
    jp playSFX
exitMapDetailSubmenu
    call loadMainMenuPallete
    call clearItemDetailWindowTiles
    call loadMapSubmenu
    ld a, MAP_MENU ;$0E
    ld [wMenuSelGridId], a ;set map selection menu
    ld a, CANCEL_SFX ;$03
    call playSFX
    ld b, $20
    jp routineDelay
;3977

checkCombineGridAInput: ;3977
    ld a, [wButtonPressId]
    and a, A_INPUT
    ret z
    jp checkCombiningItems

checkSubmenuAInput:
    ld a, [wButtonPressId]
    and a, A_INPUT
    jp z, resetSubmenuAInputPress
    ld a, [wAButtonPressDown]
    or a
    ret nz
    ld a, $FF
    ld [wAButtonPressDown], a
    ld a, [wMenuSelGridId]
    cp a, USE_EQUIP_CURSOR ;$80
    jr z, checkUseEquipSubmenuAInputPress
    cp a, CHECK_ITEM_CURSOR ;$81
    jp z, checkItemCheckSubmenuAInputPress
    cp a, COMBINE_CURSOR ;$82
    jp z, checkItemCombineSubmenuAInputPress
    cp a, FILE_MENU ;$0C
    jp z, checkFilebooksSubmenuAInputPress
    cp a, MAP_MENU ;$0E
    ret nz
    cp a, ITEM_DESC_MODE ;$84
    jp z, checkItemDescriptionAInputPress
;checkMapSelectionAInput
    call clearItemDetailWindowTiles
    call clearItemDetailWindowMap
    call loadRoomsMapDetail
    ld a, MAP_DETAIL_MENU ;$12
    ld [wMenuSelGridId], a ;set map detail mode
    ld a, CONFIRM_SFX ;$02
    jp playSFX

checkUseEquipSubmenuAInputPress:
    ld a, [selectedGridId]
    sub a, ITEM_SLOT_1 ;$04
    ld e, a
    ld d, $00
    ld hl, ItemIdSlot1
    add hl, de
    ld a, [hl] ;get selected item id
    cp a, BERRETTA
    jr z, equipWeapon
    cp a, COMBAT_KNIFE
    jr z, equipWeapon
    cp a, SHOTGUN
    jr z, equipWeapon
;use item
    jp checkItemUsage
equipWeapon
    ld c, a
    ld a, [equipedItemId]
    cp a, c
    jr nz, Label39E8
	;if the same weapon, unequip it
    ld c, EMPTY
Label39E8
    ld a, c
    ld [equipedItemId], a
    ld a, CONFIRM_SFX ;$02
    call playSFX
    ld a, ITEM_SLOT_1 ;$04
    ld [wMenuSelGridId], a ;return tu item gris
    call clearItemDetailWindowMap
    call loadMainMenuPallete
    call clearItemDetailWindowTiles
    call goToLoadEquipedSpriteData
    ld b, $10
    jp routineDelay
;3A07
checkItemCheckSubmenuAInputPress: ;3A07
    call clearItemDetailWindowMap
    call clearItemDetailWindowTiles
    call goToLoadItemBigSprite
    call showMenuItemName
    ld a, CONFIRM_SFX ;$02
    call playSFX
    ld a, ITEM_DESC_MODE ;$84
    ld [wMenuSelGridId], a ;set item description mode
    ld a, [selectedGridId]
    sub a, ITEM_SLOT_1 ;$04
    ld e, a
    ld d, $00
    ld hl, ItemIdSlot1
    add hl, de
    ld a, [hl] ;get selected item id
    cp a, DOOM_BOOK_1
    jr z, checkDoomBook1
    cp a, DOOM_BOOK_2
    jr z, checkDoomBook2
Label3A32
    ld b, $08
    jp routineDelay
checkDoomBook1
    ld [hl], EAGLE_MEDAL
    jr Label3A32
checkDoomBook2
    ld [hl], WOLF_MEDAL
    jr Label3A32
;3A3F
checkItemDescriptionAInputPress: ;3A3F
    ret
;3A40

checkItemCombineSubmenuAInputPress: ;00:3A40
    call clearItemDetailWindowMap
    call loadMainMenuPallete
    call clearItemDetailWindowTiles
    ld a, CONFIRM_SFX ;$02
    call playSFX
    ld a, [selectedGridId]
    add a, COMBINE_GRID_MODE ;$E0
    ld [wMenuSelGridId], a ;set combine grid mode
    ld b, $08
    jp routineDelay
;3A5B

resetSubmenuAInputPress: ;00:3A5B
    xor a
    ld [wAButtonPressDown], a
    ret
;3A60

checkFilebooksSubmenuAInputPress: ;00:3A60
    ld a, [wFileBookId]
    ld c, a
    add a
    add a
    ld b, a
    add a
    add a, b
    add a, c
    ld c, a
    ld b, $00
    ld hl, wTriggerFile01
    add hl, bc ;get start filebook file trigger id
    ld a, [wFileBookmarkCursorPos]
    ld c, a
    ld b, $00
    add hl, bc
    ld a, [hl] ;get file trigger
    or a
    ret z ;return if disabled
    call displayFile
    xor a
    call loadMainMenuTileMap ;reset tilemap
    ld a, $01
    ld [wLCDUpdate], a
    ld a, BANK(MainMenuPallete) ;$0C
    ld hl, MainMenuPallete ;$4DC4
    call loadBGPal
    jp loadFileBooksMenu
;3A92

checkMenuAKeyPress: ;3A92
    ld a, [wButtonPressId]
    and a, A_INPUT
    jp z, resetAInputPress
    ld a, [wAButtonPressDown]
    or a
    ret nz
    ld a, $FF
    ld [wAButtonPressDown], a
    ld a, [wLCDUpdate]
    or a
    ret nz
;if A input is pressed
    ld a, [wMenuSelGridId]
    cp a, ITEM_SLOT_1 ;$04
    jr nc, checkItemGridAInputPress
    cp a, EXIT_TOP_GRID ;$03
    jr nz, checkTopMenu
;exit main menu
    ld a, $5C
    ld [wLCDUpdate], a
    ld a, CONFIRM_SFX ;$02
    jp playSFX

;3ABE
checkTopMenu: ;3ABE
    cp a, FILE_TOP_GRID ;$02
    jr nz, Label3AD6
;file option
    ld a, [wMenuFileEnable]
    or a
    jp z, returnFromAInputPress
    call loadFileBooksMenu
    ld a, FILE_MENU ;$0C
    ld [wMenuSelGridId], a ;set filebook menu mode
    ld a, CONFIRM_SFX ;$02
    jp playSFX
Label3AD6
    cp a, RADIO_TOP_GRID ;$01
    jr nz, Label3AEA
;radio option
    ld a, [wMenuRadioEnable]
    or a
    jr z, returnFromAInputPress
    ld a, RADIO_SELECTED ;$0D
    ld [wMenuSelGridId], a ;set radio menu mode
    ld a, CONFIRM_SFX ;$02
    jp playSFX
Label3AEA
    ld a, [wMenuMapEnable]
    or a ;$00 map
    jr z, returnFromAInputPress
;map option
    call loadMainMenuPallete
    call loadMapSubmenu
    ld a, MAP_MENU ;$0E
    ld [wMenuSelGridId], a ;set map menu mode
    ld a, CONFIRM_SFX ;$02
    call playSFX
    ld b, $20
    jp routineDelay
;3B05

checkItemGridAInputPress: ;3B05
    ld a, [wMenuSelGridId]
    sub a, ITEM_SLOT_1 ;$04
    ld l, a
    ld h, $00
    ld de, ItemIdSlot1
    add hl, de
    ld a, [hl] ;get selected item id
    cp a, EMPTY
    jr z, emptyItemSlotSelected
    ld [selectedItemId], a ;store selected item id
    ld a, [wMenuSelGridId]
    ld [selectedGridId], a ;store selected item slot
    ld a, USE_EQUIP_CURSOR ;$80
    ld [wMenuSelGridId], a ;set item submenu mode
    ld a, SELECT_MENU_SFX ;$00
    call playSFX
    ld c, $00
    call goToLoadMenuItemCursors
    call loadItemSubmenu
    ld b, $20
    jp routineDelay
emptyItemSlotSelected
    ret
;3B37

returnFromAInputPress: ;00:3B37
    ld a, CANCEL_SFX ;$03
    jp playSFX
;3B3C

resetAInputPress: ;3B3C
    xor a
    ld [wAButtonPressDown], a
    ret
;3B41

checkMenuLeftKeyPress: ;00:3B41
    ld a, [wButtonPressId]
    and a, LEFT_INPUT
    ret z
    ld a, [wMenuSelGridId]
    and a, $01
    ret z ;ret if is already in left column
    ld a, [wMenuSelGridId]
    and a, $FE ;move cursor to left
    ld [wMenuSelGridId], a
    call showMenuItemName
    ld a, CURSOR_SFX ;$01
    jp playSFX
;3B5D

checkMenuRightKeyPress: ;3B5D
    ld a, [wButtonPressId]
    and a, RIGHT_INPUT
    ret z
    ld a, [wMenuSelGridId]
    and a, $01 ;return if is already in right column
    ret nz
    ld a, [wMenuSelGridId]
    or a, $01 ;move to right column cursor
    ld [wMenuSelGridId], a
    call showMenuItemName
    ld a, CURSOR_SFX ;$01
    jp playSFX
;3B79

checkMenuUpKeyPress: ;3B79
    ld a, [wButtonPressId]
    and a, UP_INPUT
    jr z, Label3B9D
    ld a, [wUpKeyPressDown]
    or a
    ret nz
    ld a, $FF
    ld [wUpKeyPressDown], a
    ld a, [wMenuSelGridId]
    cp a, FILE_TOP_GRID ;$02
    ret c ;return if is already in top row (map-radio row)
    sub a, $02 ;move cursor to top row
    ld [wMenuSelGridId], a
    call showMenuItemName
    ld a, CURSOR_SFX ;$01
    jp playSFX
Label3B9D
    xor a
    ld [wUpKeyPressDown], a ;reset A input press
    ret
;3BA2

checkMenuDownKeyPress: ;00:3BA2
    ld a, [wButtonPressId]
    and a, DOWN_INPUT
    jr z, Label3BCF
    ld a, [wDownKeyPressDown]
    or a
    ret nz
    ld a, $FF
    ld [wDownKeyPressDown], a
    ld c, ITEM_SLOT_5 ;$08 chris items bottom row
    ld a, [wSelectedPlayer]
    or a
    jr z, Label3BBD
    ld c, ITEM_SLOT_7 ;$0A jill items bottom row
Label3BBD
    ld a, [wMenuSelGridId]
    cp a, c
    ret nc ;return if is already in bottom row
    add a, $02 ;move cursor to bottom row
    ld [wMenuSelGridId], a
    call showMenuItemName
    ld a, CURSOR_SFX ;$01
    jp playSFX
Label3BCF
    xor a
    ld [wDownKeyPressDown], a
    ret
;3BD4

checkCombineGridUpInput: ;00:3BD4
    ld a, [wButtonPressId]
    and a, UP_INPUT
    jr z, Label3BF8
    ld a, [wUpKeyPressDown]
    or a
    ret nz
    ld a, $FF
    ld [wUpKeyPressDown], a
    ld a, [wMenuSelGridId]
    cp a, COMBINE_SLOT_3 ;$E6
    ret c ;return if is already in top row
    sub a, $02 ;move cursor to top row
    ld [wMenuSelGridId], a
    call showMenuItemName
    ld a, CURSOR_SFX ;$01
    jp playSFX
Label3BF8
    xor a
    ld [wUpKeyPressDown], a
    ret
;3BFD

checkCombineGridDownInput: ;00:3BFD
    ld a, [wButtonPressId]
    and a, DOWN_INPUT
    jr z, Label3C2A
    ld a, [wDownKeyPressDown]
    or a
    ret nz
    ld a, $FF
    ld [wDownKeyPressDown], a
    ld c, COMBINE_SLOT_5 ;$E8 chris botton row
    ld a, [wSelectedPlayer]
    or a
    jr z, Label3C18
    ld c, COMBINE_SLOT_7 ;$EA jill bottom row
Label3C18
    ld a, [wMenuSelGridId]
    cp a, c
    ret nc ;return if is already in bottom row
    add a, $02 ;move cursor to bottom row
    ld [wMenuSelGridId], a
    call showMenuItemName
    ld a, CURSOR_SFX ;$01
    jp playSFX
Label3C2A
    xor a
    ld [wDownKeyPressDown], a
    ret
;3C2F




goToLoadMenuItemCursors: ;00:3C2F
    ld hl, loadMenuItemCursors ;$4DBA
    ld a, BANK(loadMenuItemCursors) ;$FC
    jp jumpToFunctionHL1

updatePolicecardTilesPosition: ;00:3C37
    ld a, BANK(PlayerSelectScreenIndexes) ;$02
    call BankSwitch
    ld hl, PlayerSelectScreenIndexes+$168 ;$6440 chris police card info tilesIds
    ld de, PlayerSelectScreenIndexes+$3BA ;$6692 ;pal indexes
    ld a, [wCursorPosId]
    or a
    jr z, .Label3C4E
    ld hl, PlayerSelectScreenIndexes+$16F ;$6447 jill police card info tilesIds
    ld de, PlayerSelectScreenIndexes+$3C1 ;$6699 ;pal indexes
.Label3C4E
    ld a, l
    ld [wVramBankSubBuffer], a
    ld a, h
    ld [wVramBankBuffer], a
    ld a, e
    ld [wRoomBGBankId], a
    ld a, d
    ld [wBGDataAddrBank], a
    ld a, [policeCardYpos]
    sub a, $10
    srl a
    srl a
    srl a
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld de, _SCRN0 ;$9800
    add hl, de
    ld a, [policeCardXpos]
    sub a, $08
    srl a
    srl a
    srl a
    add a, l
    ld l, a
    ld bc, $070D ;police card size (0D x 07 tiles)
    call updatePolicecardTiles
    ld a, $01
    jp BankSwitch

updatePolicecardTiles:: ;00:3C8D
    push bc
    push hl
.loop3C8F
    push bc
    ld a, [wVramBankSubBuffer]
    ld e, a
    ld a, [wVramBankBuffer]
    ld d, a
    ld a, [wRoomBGBankId]
    ld c, a
    ld a, [wBGDataAddrBank]
    ld b, a
    call VBlankWait
    ld a, [de]
    add a, $80
    ld [hl], a
    ld a, $01
    ld [vramBank], a ;vram bank select
    ld a, [bc]
    ld [hl], a
    xor a
    ld [vramBank], a ;vram bank select
    inc de
    ld a, e
    ld [wVramBankSubBuffer], a
    ld a, d
    ld [wVramBankBuffer], a
    inc bc
    ld a, c
    ld [wRoomBGBankId], a
    ld a, b
    ld [wBGDataAddrBank], a
    ld a, l
    add a, $20
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    cp a, $9C
    jr c, .Label3CD0
    ld h, $98
.Label3CD0
    pop bc
    dec b
    jr nz, .loop3C8F
    ld a, [wVramBankSubBuffer]
    add a, $0B
    ld [wVramBankSubBuffer], a
    ld a, [wVramBankBuffer]
    adc a, $00
    ld [wVramBankBuffer], a
    ld a, [wRoomBGBankId]
    add a, $0B
    ld [wRoomBGBankId], a
    ld a, [wBGDataAddrBank]
    adc a, $00
    ld [wBGDataAddrBank], a
    pop hl
    ld a, l
    and a, $E0
    ld c, a
    ld a, l
    inc a
    and a, $1F
    or a, c
    ld l, a
    pop bc
    dec c
    jr nz, updatePolicecardTiles ;3C8D
    ret

loadSprtOAMBuffer:: ;00:3D04
    push bc
    push de
.Label3D06
    ld a, e
    cp a, $A8
    jr nc, .Label3D1D
    ld a, d
    cp a, $90
    jr nc, .Label3D1D
    ld [hli], a
    ld [hl], e
    inc l
    ld a, [wVramBankSubBuffer]
    ld [hl], a
    inc l
    ld a, [wVramBankBuffer]
    ld [hl], a
    inc l
.Label3D1D
    ld a, [wVramBankSubBuffer]
    add a, $02
    ld [wVramBankSubBuffer], a
    ld a, d
    add a, $10
    ld d, a
    dec c
    jr nz, .Label3D06
    pop de
    ld a, e
    add a, $08
    ld e, a
    pop bc
    dec b
    jr nz, loadSprtOAMBuffer
    ret

jumpToSprtOAMBufferLoad:: ;00:3D36
    push bc
    ld a, [wScreenYPos]
    ld c, a
    ld a, d
    sub a, c
    ld d, a
    pop bc
    ld a, [wVramBankBuffer]
    and a, $20
    jr z, loadSprtOAMBuffer
    ld a, b
    dec a
    add a
    add a
    add a
    dec a
    add a, e
    ld e, a
.loop3D4E
    push bc
    push de
.Label3D50
    ld a, e
    cp a, $A8
    jr nc, .Label3D66
    ld a, d
    cp a, $90
    jr nc, .Label3D66
    ld [hli], a
    ld [hl], e
    inc l
    ld a, [wVramBankSubBuffer]
    ld [hli], a
    ld a, [wVramBankBuffer]
    ld [hl], a
    inc l
.Label3D66
    ld a, [wVramBankSubBuffer]
    add a, $02
    ld [wVramBankSubBuffer], a
    ld a, d
    add a, $10
    ld d, a
    dec c
    jr nz, .Label3D50
    pop de
    ld a, e
    sub a, $08
    ld e, a
    pop bc
    dec b
    jr nz, .loop3D4E
    ret

waitDelay:: ;00:3D7F
	dec bc
	ld a, b
	or c
	jr nz, waitDelay
	ret

selectOAMDataDest:: ;00:3D85
    push af
    ld a, [wOAMDMAretOpcode]
    or a
    jr nz, .Label3D8D
    inc h
.Label3D8D
    pop af
    ret


printItemBoxSelectedSlot:: ;00:3D8F
    call BankSwitch
    xor a
    ld [wTypingCharsTrigger], a
    ld a, $08 ;selected slot pallete
    jr Label3DE3

printAutoTypingMessage::
    call BankSwitch
    ld a, $FF ;enable auto typing text
    jr printMessageWithBankSwitched ; Label3DDE

ShowAutomaticText:: ;00:3DA1
    ld a, BANK(textPointers) ;$FA
    call BankSwitch
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, $01
    call BankSwitch
    ld hl, $0F00
    ld a, BANK(textPointers) ;$FA
    jr printMessage

printTextAtPosition:: ;00:3DB5
;de: text position
;hl: text pointer
    ld a, BANK(textPointers) ;$FA
    call BankSwitch
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld a, [hl]
    ld l, e
    ld h, d
    jr printMessage

printHighlightedText:: ;00:3DC3
    ld a, BANK(textPointers) ;$FA
    call BankSwitch
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld a, [hl]
    ld l, e
    ld h, d
    call BankSwitch
    xor a
    ld [wTypingCharsTrigger], a ;disable typing chars mode
    ld a, $08 ;selected text pallete
    jr Label3DE3

printMessage:: ;00:3DDA
;params:
;a: text bank
;bc: text pointer
;hl: text start position h: y-tile l: x-tile
    call BankSwitch
    xor a
printMessageWithBankSwitched:
    ld [wTypingCharsTrigger], a ;disable/enable typing chars mode
    ld a, $09 ;font pallete id
Label3DE3:
    ld [wVramBankSubBuffer], a
    ld a, l
    ld [wc1f6], a
    ld a, h
    ld [wc1f7], a
    call Function3EA3 ;set text position?
loop3DF1:
	;check for special characters
    ld a, [bc]
    cp a, $01 ;end of string
    jp z, EndOfString ;$3E54
    cp a, $00 ;new line
    jp z, NewLine ;$3E65
    cp a, $02 ;file next page
    jp z, FileNextPage ;3E82
    cp a, $03 ;not skipable typing text
    jp z, NotSkipableTypingText ;3E74
    cp a, $04
    jp z, ScrollDownTypingText ;3E7B
	;normal characters
    sub a, $20
    cp a, $28
    jr c, .Label3E29
    cp a, $50
    jr c, .Label3E1F
    sub a, $50
    ld e, a
    add a
    add a, e
    add a, $82
    ld d, a
    jr .Label3E2F
.Label3E1F
    sub a, $28
    ld e, a
    add a
    add a, e
    add a, $81
    ld d, a
    jr .Label3E2F
.Label3E29
    ld e, a
    add a
    add a, e
    add a, $80
    ld d, a
.Label3E2F
    call VBlankWait
    ld [hl], d
    ld a, $01
    ld [vramBank], a ;vram bank select
    ld a, [wVramBankSubBuffer]
    ld [hl], a
    xor a
    ld [vramBank], a ;vram bank select
    ld a, [wTypingCharsTrigger]
    or a
    jr z, .Label3E50 ;skip type delay
	;type delay
    push bc
    ld b, $03
.loop3E47
    push bc
    call haltCPU
    pop bc
    dec b
    jr nz, .loop3E47
    pop bc
.Label3E50
    inc bc
    inc hl
    jr loop3DF1
EndOfString:
    ld a, [wc1f7]
    ld [wMsgCharYpos], a
    ld a, l
    and a, $1F
    ld [wMsgCharXpos], a
    ld a, $01
    jp BankSwitch ;return
NewLine:
    ld hl, wc1f7
    inc [hl]
    xor a
    ld [wc1f6], a
NextChar: ;00:3E6D
    inc bc
    call Function3EA3
    jp loop3DF1

NotSkipableTypingText:
	ld a, $FF
    ld [wTypingCharsTrigger], a ;enable typing text
    jr NextChar

ScrollDownTypingText: ;00:3E7B
    push bc ;store current char pos
    call goToScrolldownTypoingMsg ;$37DB
    pop bc
    jr NextChar

FileNextPage: ;00:3E82
    call msgInputPressWaitLoop
    xor a
    ld [wc1f6], a
    ld [wc1f7], a
    push bc
    push hl
    ld hl, _SCRN0
    ld bc, $0400
.loop3E94
    call VBlankWait
    ld [hl], $80
    inc hl
    dec bc
    ld a, b
    or a, c
    jr nz, .loop3E94
    pop hl
    pop bc
    jr NextChar

Function3EA3: ;00:3EA3
    ld a, [wc1f7]
    add a
    add a
    add a
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    ld a, h
    add a, $98
    ld h, a
    ld a, [wc1f6]
    add a, l
    ld l, a
    ret

GetFirstEmptyNPCDataSlot:: ;00:3EB8
;cycle throw all NPC data structure and return (de) the first avariable slot
    push bc
    ld de, wNPCSpritesData ;lwrod
    ld b, $07 ;npcs sprites count
.loop3EBE
    ld a, [de]
    and a, %10000000 ;$80
    jr z, .Label3ED0 ;return if NPC sprite is disabled
    ld a, e
    add a, $20 ;go to next NPCs sprite data
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


haltCPU:: ;00:3ED2
    ld a, $FF
    ld [wc103], a
.haltLoop
    halt
    ;nop
	ld a, [wc103]
	or a
	jr nz, .haltLoop
	ret

deleteTypewriterBGText:: ;00:3EE0
    ld a, BANK(loadSaveMenuIndexes) ;$0D
    call BankSwitch
    ld a, [wCursorPosId]
    add a
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld de, _SCRN0+$93 ;$9893
    add hl, de
    ld b, $14
.loop3EF7
    push bc
    push hl
    ld a, b
    dec a
    ld l, a
    ld h, $00
    add hl, hl
    push hl
    add hl, hl
    add hl, hl
    add hl, hl
    pop de
    add hl, de
    push hl
    ld de, loadSaveMenuIndexes ;$6930
    ld a, [wCursorPosId]
    add a
    add a, $04
    add a, e
    ld e, a
    ld a, $00
    adc a, d
    ld d, a
    add hl, de
    ld a, [hl]
    add a, $80
    ld b, a
    ld de, loadSaveMenuIndexes+$18C ;$6ABC
    ld a, [wCursorPosId]
    add a
    add a, $04
    add a, e
    ld e, a
    ld a, $00
    adc a, d
    ld d, a
    pop hl
    add hl, de
    ld c, [hl]
    pop hl
    call VBlankWait
    ld [hl], b
    ld a, $01
    ld [vramBank], a ;vram bank select
    ld [hl], c
    xor a
    ld [vramBank], a ;vram bank select
    dec hl
    pop bc
    dec b
    jr nz, .loop3EF7
    ld a, $01
    jp BankSwitch
;3F43

printItemboxList: ;00:3F43
    ld b, $03 ;itemBox slots to print
Loop3F45
    push bc
    ld a, [wSelectedItemBoxSlotId]
    add a, b ;get slot item id
    sub a, $02
    and a, $1F ;limit slot id
    ld e, a
    ld d, $00
    ld hl, wItemBoxSlot01
    add hl, de
    ld a, [hl] ;get item id
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    ld de, itemsNamesPointer ;$4597
    add hl, de ;get item name address
    ld a, BANK(itemsNamesPointer) ;$FA
    call BankSwitch
    ld e, [hl]
    inc hl
    ld d, [hl] ;store name address in de
    ld a, $01
    call BankSwitch
;get item name position
    ld h, b ;get y-pos
    dec h
    ld l, $00 ;x-pos
    ld a, b
    cp a, $02
    jr nz, printItemBoxItemName
    ld a, [wMenuSelGridId]
    cp a, $0C
    jr c, printItemBoxItemName
    ld c, e
    ld b, d
    ld a, BANK(itemsNamesPointer) ;$FA
    call printItemBoxSelectedSlot
    jr Label3F8D
printItemBoxItemName
    ld c, e
    ld b, d
    ld a, BANK(itemsNamesPointer) ;$FA
    call printMessage
Label3F8D
    pop bc
    dec b
    jr nz, Loop3F45
    ret
;3F92

checkCombiningItems: ;00:3F92
    ld a, [selectedGridId]
    sub a, $04 ;get slot id
    ld e, a
    ld d, $00
    ld hl, ItemIdSlot1
    add hl, de
    push hl ;store selected item slot id
    ld a, [wMenuSelGridId]
    sub a, $E4 ;get target slot id
    ld e, a
    ld d, $00
    ld hl, ItemIdSlot1
    add hl, de ;get target item slot id
    pop de ;restore selected item id
    ld a, [de]
    cp a, WATER_BOTTLE
    jp z, checkWaterBottleCombine
    cp a, UMB_NO2
    jp z, checkUMBNo2Combine
    cp a, NP_003
    jp z, checkNP003Combine
    cp a, UMB_NO4
    jp z, checkUMBNo4Combine
    cp a, YELLOW_6
    jp z, checkYellow6Combine
    cp a, UMB_NO7
    jp z, checkUMBNo7Combine
    cp a, UMB_NO13
    jp z, checkUMBNo13Combine
    ret
;3FD1
checkWaterBottleCombine: ;00:3FD1
    ld a, [hl]
    cp a, UMB_NO2
    jp z, waterAndUMBNo2Combine
    jp combineNotMatch

checkUMBNo2Combine:
    ld a, [hl]
    cp a, WATER_BOTTLE
    jp z, waterAndUMBNo2Combine
    cp a, UMB_NO4
    jp z, UMBNo2AndUMBNo4Combine
    jp combineNotMatch

checkNP003Combine:
    ld a, [hl]
    cp a, UMB_NO4
    jp z, NP003AndUMBNo4Combine
    cp a, UMB_NO13
    jp z, NP003AndUMBNo13Combine
    jp combineNotMatch

checkUMBNo4Combine:
    ld a, [hl]
    cp a, NP_003
    jp z, NP003AndUMBNo4Combine
    cp a, UMB_NO2
    db $CA, $27 ;end of home bank, but routine continue to bank 1
   ;jp z, UMBNo2AndUMBNo4Combine next instruccion between bank0 & bank1


