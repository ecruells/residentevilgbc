INCLUDE "constants.asm"

INCLUDE "home.asm"

SECTION "bank1",ROMX,BANK[$1]
    db $40 ;jp z, UMBNo2AndUMBNo4Combine instruccion between bank0 & bank1
    jp combineNotMatch

checkYellow6Combine:
    ld a, [hl]
    cp a, UMB_NO7
    jp z, Yellow6AndUMBNo7Combine
    jp combineNotMatch

checkUMBNo7Combine:
    ld a, [hl]
    cp a, YELLOW_6
    jp z, Yellow6AndUMBNo7Combine
    jp combineNotMatch

checkUMBNo13Combine:
    ld a, [hl]
    cp a, NP_003
    jp z, NP003AndUMBNo13Combine
    jp combineNotMatch

waterAndUMBNo2Combine:
    ld a, NP_003
    ld [hl], a ;set target item as combining result
    ld a, EMPTY_BOTTLE
    ld [de], a
    jr finishCombine

UMBNo2AndUMBNo4Combine:
    ld a, YELLOW_6
    ld [hl], a
    ld a, EMPTY_BOTTLE
    ld [de], a
    jr finishCombine

NP003AndUMBNo4Combine:
    ld a, UMB_NO7
    ld [hl], a
    ld a, EMPTY_BOTTLE
    ld [de], a
    jr finishCombine

Yellow6AndUMBNo7Combine:
    ld a, UMB_NO13
    ld [hl], a
    ld a, EMPTY_BOTTLE
    ld [de], a
    jr finishCombine

NP003AndUMBNo13Combine:
    ld a, V_JOLT
    ld [hl], a
    ld a, EMPTY_BOTTLE
    ld [de], a

finishCombine:
    ld a, SAVE_TYPING_SFX ;$16
    call playSFX
    ld a, [wMenuSelGridId]
    sub a, $E0
    ld [wMenuSelGridId], a ;return to item grid
    call showMenuItemName
    ld b, $20
    jp routineDelay
;405A

combineNotMatch: ;405A
    ld a, [hl] ;target item id
    cp a, WATER_BOTTLE
    jr z, Label4078
    cp a, UMB_NO2
    jr z, Label4078
    cp a, NP_003
    jr z, Label4078
    cp a, UMB_NO4
    jr z, Label4078
    cp a, YELLOW_6
    jr z, Label4078
    cp a, UMB_NO7
    jr z, Label4078
    cp a, UMB_NO13
    jr z, Label4078
    ret
Label4078 ;01:4078
    ld a, [de] ;selected item id
    cp a, WATER_BOTTLE ;water + water = water & empty bottle
    jr z, Label408A
    ld a, [hl] ;target item id
    cp a, WATER_BOTTLE
    jr z, Label408A
    ld a, EMPTY_BOTTLE
    ld [de], a
    ld a, EMPTY_BOTTLE
    ld [hl], a
    jr Label4090
Label408A
    ld a, WATER_BOTTLE
    ld [de], a
    ld a, EMPTY_BOTTLE
    ld [hl], a
Label4090
    ld a, CANCEL_SFX ;$03
    call playSFX
    ld a, [wMenuSelGridId]
    sub a, $E0
    ld [wMenuSelGridId], a ;return to item grid
    call showMenuItemName
    ld b, $20
    jp routineDelay
;40A5

mainMenuRoutine: ;01:40A5
    xor a ;main menu mode
    call loadMainMenuTileMap
    xor a
    ld [wCursorPosId], a
    ld a, $04
    ld [wMenuSelGridId], a
    ld a, $28
    ld [policeCardXpos], a
    ld a, $38
    ld [policeCardYpos], a
    ld a, $01
    ld [wLCDUpdate], a
    call showMenuItemName
mainMenuLoop
    call haltCPU
    call updateHealthMeter
    call loadMainMenuFaceOAMData
    ld c, $00
    call goToLoadMenuItemCursors
    call goToLoadMenuItemsSprtData
    call goToLoadEquipedSpriteData
    call loadFileBookmarksCursors
    ld a, [wLCDUpdate]
    or a
    call z, checkMenuInputPress
    call enableHDMA
    call swapOAMDMAopcode
    ld a, [wLCDUpdate]
    cp a, $5E
    ret z
    ld hl, MainMenuMapTable+8 ;$2F26
    call loadBGPallete
    jr mainMenuLoop


itemBoxMenuRoutine: ;01:40F6
    ld a, $FF ;item box mode
    call loadMainMenuTileMap
    xor a
    ld [wCursorPosId], a
    ld a, $04 ;item 1 selected
    ld [wMenuSelGridId], a
    ld a, $28
    ld [policeCardXpos], a
    ld a, $38
    ld [policeCardYpos], a
    ld a, $01
    ld [wLCDUpdate], a ;set fade-in
    call showMenuItemName
    call printItemboxList
itemboxMenuLoop
    call haltCPU
    call updateHealthMeter
    call loadMainMenuFaceOAMData
    ld c, $FF ;enable item cursors
    call goToLoadMenuItemCursors
    call goToLoadMenuItemsSprtData
    call goToLoadEquipedSpriteData
    call goToLoadSelectedItemboxItemSprite
    call goToLoadItemboxCursor
    ld a, [wLCDUpdate]
    or a
    call z, checkItemboxMenuInputs
    call enableHDMA
    call swapOAMDMAopcode
    ld a, [wLCDUpdate]
    cp a, $5E
    ret z
    ld hl, ItemBoxMapTable+8 ;$2FB2
    call loadBGPallete
    jr itemboxMenuLoop

checkItemboxMenuInputs:
    ld a, [wMenuSelGridId]
    cp a, $80 ;itembox cursor mode
    jr nc, itemBoxCursorInput
;item grid cursor
    call itemboxItemGridCursorLeftInput
    call itemboxItemGridCursorRightInput
    call itemboxItemGridCursorUpInput
    call itemboxItemGridCursorDownInput
    call itemboxItemGridCursorBInput
    call itemboxItemGridCursorAInput
    ret
itemBoxCursorInput
    call itemboxCursorUpInput
    call itemboxCursorDownInput
    call itemboxCursorBInput
    call itemboxCursorAInput ;swap items
    ret
;4175

itemboxItemGridCursorAInput: ;01:4175
    ld a, [wButtonPressId]
    and a, A_INPUT
    ret z
    ld a, [wMenuSelGridId]
    ld [selectedGridId], a ;store item grid selected cursor
    ld a, $80
    ld [wMenuSelGridId], a ;set grid in itembox cursor mode
    ld a, CONFIRM_SFX ;$02
    call playSFX
    call printItemboxList
    ld b, $10
    jp routineDelay
;4193

itemboxCursorAInput: ;01:4193
    ld a, [wButtonPressId]
    and a, A_INPUT
    ret z
    ld a, [selectedGridId]
    sub a, $04 ;get slot id offset
    ld e, a
    ld d, $00
    ld hl, ItemIdSlot1
    add hl, de
    ld e, l
    ld d, h ;set selected item slot id in de
    ld a, [wSelectedItemBoxSlotId]
    ld c, a
    ld b, $00
    ld hl, wItemBoxSlot01
    add hl, bc
;swap items
    ld a, [de]
    push af ;store item id to store
    ld a, [hl] ;get selected itembox item id
    ld [de], a ;set item from itembox
    pop af
    ld [hl], a ;store item
    ld a, [selectedGridId]
    ld [wMenuSelGridId], a ;return to item grid
    call printItemboxList
    call showMenuItemName
    ld a, CONFIRM_SFX ;$02
    call playSFX
    ld b, $10
    jp routineDelay

itemboxItemGridCursorBInput: ;41CD
    ld a, [wButtonPressId]
    and a, B_INPUT
    ret z
    ld a, $5C
    ld [wLCDUpdate], a ;set fade-out to exit menu
    ret
;41D9

itemboxCursorBInput: ;01:41D9
    ld a, [wButtonPressId]
    and a, B_INPUT
    ret z
    ld a, [selectedGridId]
    ld [wMenuSelGridId], a ;restore to item slot cursor
    ld a, CANCEL_SFX ;$03
    call playSFX
    call printItemboxList
    ld b, $10
    jp routineDelay

itemboxItemGridCursorLeftInput: ;01:41F2
    ld a, [wButtonPressId]
    and a, LEFT_INPUT
    ret z
    ld a, [wMenuSelGridId]
    and a, $01
    ret z ;return if is already in left column
    ld a, [wMenuSelGridId]
    and a, $FE ;move cursor tu left
    ld [wMenuSelGridId], a
    call showMenuItemName
    ld a, CURSOR_SFX ;$01
    jp playSFX

itemboxItemGridCursorRightInput: ;01:420E
    ld a, [wButtonPressId]
    and a, RIGHT_INPUT
    ret z
    ld a, [wMenuSelGridId]
    and a, $01
    ret nz ;return if is already in right column
    ld a, [wMenuSelGridId]
    or a, $01 ;move cursor tu right
    ld [wMenuSelGridId], a
    call showMenuItemName
    ld a, CURSOR_SFX ;$01
    jp playSFX

itemboxItemGridCursorUpInput: ;01:422A
    ld a, [wButtonPressId]
    and a, UP_INPUT
    jr z, Label424E
    ld a, [wUpKeyPressDown]
    or a
    ret nz
    ld a, $FF
    ld [wUpKeyPressDown], a
    ld a, [wMenuSelGridId]
    cp a, $06
    ret c ;return if is already in top grid row
    sub a, $02 ;move cursor up
    ld [wMenuSelGridId], a
    call showMenuItemName
    ld a, CURSOR_SFX ;$01
    jp playSFX
Label424E
    xor a
    ld [wUpKeyPressDown], a
    ret
;4253

itemboxItemGridCursorDownInput: ;01:4253
    ld a, [wButtonPressId]
    and a, DOWN_INPUT
    jr z, Label4280
    ld a, [wDownKeyPressDown]
    or a
    ret nz
    ld a, $FF
    ld [wDownKeyPressDown], a
    ld c, $08 ;chris bottom row
    ld a, [wSelectedPlayer]
    or a
    jr z, Label426E ;jump if chris
    ld c, $0A ;jill bottom row
Label426E
    ld a, [wMenuSelGridId]
    cp a, c
    ret nc ;return if is already in bottom row
    add a, $02 ;move to bottom row
    ld [wMenuSelGridId], a
    call showMenuItemName
    ld a, CURSOR_SFX ;$01
    jp playSFX
Label4280
    xor a
    ld [wDownKeyPressDown], a
    ret
;4285


itemboxCursorUpInput: ;01:4285
    ld a, [wButtonPressId]
    and a, UP_INPUT ;$40
    jr z, Label42A7
    ld a, [wUpKeyPressDown]
    or a
    ret nz
    ld a, $FF
    ld [wUpKeyPressDown], a
    ld a, [wSelectedItemBoxSlotId]
    dec a
    and a, $1F
    ld [wSelectedItemBoxSlotId], a
    call printItemboxList
    ld a, ITEM_BOX_CURSOR_SFX ;$0E
    jp playSFX
Label42A7
    xor a
    ld [wUpKeyPressDown], a
    ret
;42AC

itemboxCursorDownInput: ;01:42AC
    ld a, [wButtonPressId]
    and a, DOWN_INPUT
    jr z, Label42CE
    ld a, [wDownKeyPressDown]
    or a
    ret nz
    ld a, $FF
    ld [wDownKeyPressDown], a
    ld a, [wSelectedItemBoxSlotId]
    inc a
    and a, $1F
    ld [wSelectedItemBoxSlotId], a
    call printItemboxList
    ld a, ITEM_BOX_CURSOR_SFX ;$0E
    jp playSFX
Label42CE
    xor a
    ld [wDownKeyPressDown], a
    ret
;42D3

loadFileBookmarksCursors: ;01:42D3
    ld c, $C0 ;filebookMark xpos (hidden)
    ld a, [wMenuSelGridId]
    cp a, $0C
    jr nz, Label42DE ;if not filebook grid mode
	;if filebook grid
    ld c, $49 ;set pos x visible
Label42DE
    ld hl, wOAMBufferC9+$50 ;$C950
    call selectOAMDataDest
    call loadFileBookmarksOAM
    ld a, [wFileBookId]
    ld l, a
    ld h, $00 ;get filebook offset (3 filebook with 13 files per book)
    push hl
    add hl, hl
    add hl, hl
    push hl
    add hl, hl
    pop de
    add hl, de
    pop de
    add hl, de
    ld de, wTriggerFile01
    add hl, de ;get filebook start file address
    ld e, l
    ld d, h
    ld hl, wSpriteTilesBufferCF ;$cf00 ;bookmark sprites buffer
    ld b, $0D ;bookmarks count
loadFileBookmarkLoop
    ld a, [wFileBookmarkCursorPos]
    ld c, a
    ld a, $0D
    sub a, c
    cp a, b
    jr z, loadSelectedFileBookmark
;loadFileBookmark
    ld a, [de]
    or a
    jr z, loadDisabledFileBookmark
    ld [hl], $00
    inc hl
    ld [hl], $1C
    inc hl
    ld [hl], $00
    inc hl
    ld [hl], $1C
    inc hl
    ld [hl], $FC
    inc hl
    ld [hl], $FC
    inc hl
    jr loadNextFileBookmark
loadDisabledFileBookmark
    ld [hl], $00
    inc hl
    ld [hl], $00
    inc hl
    ld [hl], $00
    inc hl
    ld [hl], $00
    inc hl
    ld [hl], $00
    inc hl
    ld [hl], $00
    inc hl
    jr loadNextFileBookmark
loadSelectedFileBookmark
    ld a, [de] ;filebook file triggers start address
    or a
    jr nz, loadSelectedDisabledBookmark ; if file is enabled
    ld [hl], $04
    inc hl
    ld [hl], $00
    inc hl
    ld [hl], $04
    inc hl
    ld [hl], $00
    inc hl
    ld [hl], $FC
    inc hl
    ld [hl], $FC
    inc hl
    jr loadNextFileBookmark
loadSelectedDisabledBookmark
    ld [hl], $1C
    inc hl
    ld [hl], $00
    inc hl
    ld [hl], $1C
    inc hl
    ld [hl], $00
    inc hl
    ld [hl], $FC
    inc hl
    ld [hl], $FC
    inc hl
loadNextFileBookmark
    inc de ;next bookmark
    dec b
    jr nz, loadFileBookmarkLoop
    jp enableHDMA
;4368

loadFileBookmarksOAM ;01:4368
;bookmarks part 1
    ld [hl], $2C ;y-pos
    inc l
    ld [hl], c ;x-pos
    inc l
    ld [hl], $40 ;tileId
    inc l
    ld [hl], $07 ;palId
    inc l
;bookmarks part 2
    ld [hl], $3C
    inc l
    ld [hl], c
    inc l
    ld [hl], $42
    inc l
    ld [hl], $07
    inc l
;bookmarks part 3
    ld [hl], $4C
    inc l
    ld [hl], c
    inc l
    ld [hl], $44
    inc l
    ld [hl], $07
    ret
;4389




enableExtRAM:: ;01:4389
	ld a, $00
	ld [$4000], a
	ld a, $0A
	ld [$0000], a
	ret

disableExtRAM:: ;01:4394
	ld a, $00
	ld [$0000], a
	ret

displayLoadGameWelcomeMsg:: ;01:439A
;display the welcome message just after saved game loading
    call ResetPal
    call hideSprites
    call loadFontTiles
    ld a, $01
    ld [wLCDUpdate], a
    ld hl, _NewGameWelcomeMsgPointer ;$458B
    ld a, [wCursorIdBuffer]
    or a
    jr z, .Label43B4 ;if cursor id is $00
	;if saved game loaded
    ld hl, _LoadGameWelcomeMsgPointer ;$4591
.Label43B4
    ld b, $03
.loop43B6
    push bc
    push hl
    ld hl, $0000
    ld b, $07
.loop43BD ;clear screen loop with debug messages at top
    push bc
    push hl
    ld bc, ClearTextboxText ;$63EE
    ld a, BANK(ClearTextboxText) ;$FA
    call printMessage
    ld hl, _SCRN0
    ld de, $3F92 ;print debug word "3F92"
    call printDebugWord
    ld hl, _SCRN0+$20
    ld de, $7BE6 ;print debug word "7BE6"
    call printDebugWord
    pop hl
    inc h
    inc h
    inc h
    pop bc
    dec b
    jp nz, .loop43BD
    call haltCPU
    ld a, BANK(GreyPallete) ;$0C ;pallete bank
    ld hl, GreyPallete ;$4E44
    call loadBGPal
    pop hl
    push hl
    call ShowAutomaticText ;$3DA1
    ld b, $80
;text delay
.loop43F4
    push bc
    call haltCPU
    pop bc
    dec b
    jr nz, .loop43F4
    pop hl
    inc hl
    inc hl
    pop bc
    dec b
    jp nz, .loop43B6
    call ResetPal
    ret


printDebugWord:: ;01:4408
;parameters
;hl: tilemap address
;de: word to print
    ld a, d
    srl a
    srl a
    srl a
    srl a
    ld c, a
    call printDebugChar
    ld a, d
    and a, $0F
    ld c, a
    call printDebugChar
    ld a, e
    srl a
    srl a
    srl a
    srl a
    ld c, a
    call printDebugChar
    ld a, e
    and a, $0F
    ld c, a
    call printDebugChar
    ret

printDebugChar:: ;01:4431
    ld a, c
    cp a, $0A
    jr c, .Label4440
    sub a, $0A
    ld c, a
    add a
    add a, c
    add a, $E3
    ld c, a
    jr .Label4445
.Label4440
    add a
    add a, c
    add a, $B0
    ld c, a
.Label4445
    call VBlankWait
    ld [hl], c
    ld a, $01
    ld [vramBank], a ;vram bank select
    call VBlankWait
    ld [hl], $09
    inc hl
    xor a
    ld [vramBank], a ;vram bank select
    ret


swapOAMDMAopcode:: ;01:4457
;swap OAM DMA opcode between C8 AND C9 by xor it by 01
    ld a, [wOAMDMAretOpcode]
    xor a, $01
    ld [wOAMDMAretOpcode], a
    ret

copyOAMBufferC9toCA:: ;01:4460
	ld hl, wOAMBufferC9
	ld de, wOAMBufferCA
	ld b, $A0
.loop4468
	ld a, [hli]
	ld [de], a
	inc e
	dec b
	jr nz, .loop4468
	ret

initOAMDMARoutine:: ;01:446F
;copy OAM DMA transfer routine to hram
    ld hl, OAMDMARoutine ;$447E
    ld de, OAMDMATransfer
    ld b, $0A ;bytes to copy
.loop4477
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .loop4477
    ret

OAMDMARoutine: ;01:447E
	ld a, $C9
	ld [rDMA], a
	ld a, $2C
.loop4484
	dec a
	jr nz, .loop4484
	ret

hideSprites:: ;01:4488
;hide sprites by setting Y pos to $C0
    call swapOAMDMAopcode
    call hideOAM
    call swapOAMDMAopcode
    jp hideOAM

hideOAM:: ;01:4494
    ld hl, wOAMBufferC9 ;$C900
    call selectOAMDataDest
    ld de, $4
    ld b, $28
    ld a, $C0
.loop44A1
    ld [hl], a
    add hl, de
    dec b
    jr nz, .loop44A1
    ret

loadBGPallete:: ;01:44A7
    ld a, [wLCDUpdate]
    or a
    ret z
    cp a, $60
    ret nc
    cp a, $40
    jr nc, .fadeOutPallete
	;fadeInPallete
    dec a
    jr .Label44B7
.fadeOutPallete
    inc a
.Label44B7
    ld [wLCDUpdate], a
    cp a, $5E
    jp nc, ResetPal
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld a, [hl]
    push bc
    pop hl
    jp loadPallete

checkAndLoadRoomPal:: ;01:44CD
    ld a, [wLCDUpdate]
    or a
    ret z
    cp a, $60
    ret nc
    cp a, $40
    jr nc, .Label44DC
    dec a ; fade-in
    jr .Label44DD
.Label44DC
    inc a ;fade-out
.Label44DD
    ld [wLCDUpdate], a
    cp a, $5E
    jp nc, ResetPal
    ld a, [wRoomId]
    ld l, a
    ld a, [wRoomIdHigh]
    ld h, a
    add hl, hl
    add hl, hl
    ld de, RoomsBgLookupTable+2 ;$71B7 room pallete pointer
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld a, [wRoomId]
    cp a, ARMORS_ROOM ;$23
    jr z, .Label450A
.loop44FD
    ld e, l
    ld d, h
    ld a, e
    add a, $40
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    jp callLoadRoomPal
.Label450A
    ld a, [wPoisonGasActivationByte]
    or a
    jr z, .loop44FD
    ld hl, room_23_gas_pallete ;$5200
    jr .loop44FD


ResetPal:: ;01:4515
    ld c, $00
    ld b, $40
.loop4519
    call VBlankWait
    ld a, c
    ld [BgPalSel], a ;bg color index
    xor a
    ld [BgPalData], a ;bg color data
    inc c
    dec b
    jr nz, .loop4519
    ld c, $00
    ld b, $40
.loop452A
    call VBlankWait
    ld a, c
    ld [ObjPalSel], a ;obj color index
    xor a
    ld [ObjPalData], a ;obj color data
    inc c
    dec b
    jr nz, .loop452A
    ret
;4538

showDeathScreen: ;01:4538
    call ResetPal
    call hideSprites
    ld a, $20
    ld [wLCDUpdate], a
    ld hl, ChrisDeathScrnMapTable ;$2F3A
    ld a, $20
    call loadTileMap
    ld a, [wSpriteId]
    cp a, CHRIS
    jr z, Label4582
	;jill death screen
    ld hl, _SCRN0+$B4 ;$98B4
    ld de, _SCRN0+$106 ;$9906
    ld bc, $507
Label455B
    push bc
    push de
    push hl
Label455E
    call VBlankWait
    ld a, [hl]
    ld [de], a
    ld a, $01
    ld [vramBank], a ;vram bank select
    ld a, [hli]
    ld [de], a
    inc e
    xor a
    ld [vramBank], a ;vram bank select
    dec c
    jr nz, Label455E
    pop hl
    ld de, $20
    add hl, de
    pop de
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop bc
    dec b
    jr nz, Label455B
Label4582
    call haltCPU
    ld a, [wLCDUpdate]
    cp a, $5E
    ret z
    ld a, [wButtonPressId]
    and a, A_START_INPUT ;$09
    jr z, Label45A1
    ld a, [wLCDUpdate]
    or a
    jr z, Label459C
    cp a, $40
    jr nc, Label45A1
Label459C
    ld a, $40
    ld [wLCDUpdate], a
Label45A1
    ld hl, ChrisDeathScrnMapTable+8 ;$2F42
    call loadBGPallete
    jr Label4582
;45A9

showPauseMenu: ;45A9
    call enableExtRAM
    ld a, $53
    ld [wQuickSaveFlagB9], a
    ld a, $50
    ld [wQuickSaveFlagBA], a
    ld a, $41
    ld [wQuickSaveFlagBC], a
    ld hl, wWorkRamStart+$100
    ld de, sSRamStart ;$A000
    ld bc, SAVE_SLOT_LENGTH ;$600
Label45C4
    ld a, [hli]
    ld [de], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, Label45C4
    call disableExtRAM
restorePauseMenu: ;45CF when restore from quick save, it starts here
    call ResetPal
    call hideSprites
    xor a
    call playMusic ;stop music
    ld a, $01
    ld [wLCDUpdate], a
    ld hl, PauseScreenMapTable ;$2F48
    ld a, $14
    call loadTileMap
    ld hl, PauseScreenMapTable+8 ;$2F50
    call loadBGPallete
Label45EC
    call haltCPU
    ld a, [wButtonPressId]
    and a, START_INPUT
    jr nz, Label45EC
Label45F6
    call haltCPU
    ld a, [wButtonPressId]
    and a, START_INPUT
    jr z, Label45F6
Label4600
    call haltCPU
    ld a, [wButtonPressId]
    and a, START_INPUT
    jr nz, Label4600
;erase quick save flags and exit
    call enableExtRAM
    xor a
    ld [sQuickSaveFlagB9], a
    ld [sQuickSaveFlagBA], a
    ld [sQuickSaveFlagBC], a
    call disableExtRAM
    ld a, [wCurrentMusicId]
    call playMusic ;restore music
    ld a, $01
    ld [wLCDUpdate], a
    call ResetPal
    jp gameLoopWithEventCheck
;462B

loadHotGenStudiosLogoScreen: ;462B Label462B unused
    call hideSprites
    ld hl, HotGenStudiosSplashMaptable ;$2F2C
    ld a, $14
    call loadTileMap
    ld a, $20
    ld [wLCDUpdate], a
    ld a, $80
    ld [wBgTransitionDirCounter], a
logoFadeOutLoop
    call haltCPU
    ld a, [wLCDUpdate]
    cp a, $5E
    ret z
    ld a, [wBgTransitionDirCounter]
    dec a
    ld [wBgTransitionDirCounter], a
    jr nz, Label4657
    ld a, $40
    ld [wLCDUpdate], a
Label4657
    ld hl, HotGenStudiosSplashMaptable+8 ;$2F34
    call loadBGPallete
    jr logoFadeOutLoop
;465F

loadBgTypeDoorTransitions: ;01:465F
    call ResetPal
    call hideSprites
    ld a, [wDoorAnimationType]
    cp a, $88
    jr c, loadBgDoorType
    ld c, $80
    cp a, $88
    jr z, loadElevatorEvent
    ld c, $81
    cp a, $89
    jr z, loadElevatorEvent
    ld c, $82
    cp a, $8A
    jr z, loadElevatorEvent
    ld c, $83
    cp a, $8B
    jr z, loadElevatorEvent
    ld c, $84
    cp a, $8C
    jr z, loadElevatorEvent
    ld c, $85
loadElevatorEvent
    ld a, c
    ld [wEventId], a
    pop de
    jp gameLoopWithEventCheck
loadBgDoorType
    ld a, [wDoorAnimationType]
    ld hl, Stairs1TransitionMapTable ;$2F56
    cp a, STAIRS_TYPE_2_UPWARD ;$7E mansion stairs 1
    jr c, Label46BD
    ld hl, Stairs2TransitionMapTable ;$2F64
    cp a, STAIRS_TYPE_3_UPWARD ;$80 mansion stairs 2
    jr c, Label46BD
    ld hl, Stairs3TransitionMapTable ;$2F72
    cp a, LADDER_1_UPWARD ;$82 mansion stairs 3
    jr c, Label46BD
    ld hl, Ladder1TransitionMapTable ;$2F80
    cp a, ROPE_UPWARD ;$84 ladder
    jr c, Label46BD
    ld hl, RopeTransitionMapTable ;$2F8E
    cp a, LADDER_2_UPWARD ;$86 rope
    jr c, Label46BD
    ld hl, Ladder2TransitionMapTable ;$2F9C
Label46BD
    ld a, $14 ;ladder 2
    call loadTileMap
    xor a
    ld [vramBank], a ;vram bank select
    ld hl, _SCRN0+$240 ;$9A40
    ld de, _SCRN0 ;$9800
    ld bc, $01C0
    call loadDataToRam
    ld a, $01
    ld [vramBank], a ;vram bank select
    ld hl, _SCRN0+$240 ;$9A40
    ld de, _SCRN0 ;$9800
    ld bc, $01C0
    call loadDataToRam
    xor a
    ld [vramBank], a ;vram bank select
    xor a
    ld [wScreenYPos], a
    ld a, $20
    ld [wLCDUpdate], a ;fade-in
    ld a, $80
    ld [wBgTransitionDirCounter], a
roomBgTransitionLoop
    call haltCPU
    call haltCPU
    ld a, [wLCDUpdate]
    cp a, $5E
    jr z, finishBgTransition ;return when finish fade-out
    ld a, [wBgTransitionDirCounter]
    dec a
    ld [wBgTransitionDirCounter], a
    jr nz, Label470D
    ld a, $40
    ld [wLCDUpdate], a
Label470D
    ld a, [wDoorAnimationType]
    and a, $01 ;mask first bit to get transition direction (00: upward, 01:downward)
    jr z, upwardTransition
;downwardTransition
    ld a, [wBgTransitionDirCounter]
    and a, $0F
    ld e, a
    ld d, $00
    ld hl, downwardTransitionValues ;$477F
    add hl, de
    ld a, [wScreenYPos]
    add a, [hl]
    ld [wScreenYPos], a
    jr loadBgTransitionPallete
upwardTransition
    ld a, [wBgTransitionDirCounter]
    and a, $0F
    ld e, a
    ld d, $00
    ld hl, upwardTransitionValues ;$476F
    add hl, de
    ld a, [wScreenYPos]
    add a, [hl]
    ld [wScreenYPos], a
loadBgTransitionPallete
    ld a, [wDoorAnimationType]
    ld hl, Stairs1TransitionMapTable+8 ;$2F5E
    cp a, STAIRS_TYPE_2_UPWARD ;$7E
    jr c, Label4765
    ld hl, Stairs2TransitionMapTable+8 ;$2F6C
    cp a, STAIRS_TYPE_3_UPWARD ;$80
    jr c, Label4765
    ld hl, Stairs3TransitionMapTable+8 ;$2F7A
    cp a, LADDER_1_UPWARD ;$82
    jr c, Label4765
    ld hl, Ladder1TransitionMapTable+8 ;$2F88
    cp a, ROPE_UPWARD ;$84
    jr c, Label4765
    ld hl, RopeTransitionMapTable+8 ;$2F96
    cp a, LADDER_2_UPWARD ;$86
    jr c, Label4765
    ld hl, Ladder2TransitionMapTable+8 ;$2FA4
Label4765
    call loadBGPallete
    jr roomBgTransitionLoop
finishBgTransition
    xor a
    ld [wScreenYPos], a
    ret
;476F

upwardTransitionValues: ;01:476F
	db $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FE, $FE, $FD, $FC, $FB

downwardTransitionValues: ;01:477F
	db $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $01, $02, $02, $03, $04, $05


loadTitleSlideRooms: ;01:478F
    call ResetPal
    call hideSprites
    ld hl, $07FF ;set slide demo frame counter & timer
    ld a, l
    ld [wFrameRateCounter], a
    ld a, h
    ld [wc1c5], a
    ld a, $20
    ld [wLCDUpdate], a
.loop47A5
    call haltCPU
    ld a, [wc1c5]
    add a
    ld l, a
    ld h, $00
    ld de, SlideRoomsBGDemo ;$4836
    add hl, de
    ld a, [hli]
    ld [wRoomId], a
    ld a, [hli]
    ld [wRoomScreen], a
    xor a
    ld [wRoomIdHigh], a
    ld a, [wc1c5]
    push af
    ld a, [wFrameRateCounter]
    push af
    ld a, [wFrameRateCounter]
    cp a, $FF
    call z, loadAllRoomBgData
    pop af
    ld [wFrameRateCounter], a
    pop af
    ld [wc1c5], a
    ld a, [wButtonPressId]
    and a, START_INPUT
    jr z, .Label47FA ;if not start input press
    ld a, [wc1c5]
    or a
    jr nz, .Label47F1
    ld a, [wFrameRateCounter]
    cp a, $20
    jr nc, .Label47F1
    call ResetPal
    jp InitGame
.Label47F1
    xor a
    ld [wc1c5], a
    ld a, $1F
    ld [wFrameRateCounter], a
.Label47FA
    ld a, [wFrameRateCounter]
    dec a
    ld [wFrameRateCounter], a
    cp a, $FF
    jr nz, .Label4813
    ld a, [wc1c5]
    dec a
    ld [wc1c5], a
    cp a, $FF
    jr nz, .Label4813
    jp InitGame
.Label4813
	ld a, [wFrameRateCounter]
    cp a, $E0
    jr nc, .Label4820
    cp a, $20
    jr c, .Label4827
    jr .Label4830
.Label4820
    sub a, $E0
    ld [wLCDUpdate], a
    jr .Label4830
.Label4827
    ld c, a
    ld a, $1F
    sub a, c
    add a, $40
    ld [wLCDUpdate], a
.Label4830
    call checkAndLoadRoomPal ;01:44CD
    jp .loop47A5

SlideRoomsBGDemo::
	;  roomId 				screenId
	db UNDERGROUND_PASSAGE_2, 		$04
	db HALLWAY_TO_EAST_TERRACE, 		$02
	db EAST_STAIRCASE_2F, 		$01
	db TREVORS_TOMB, 			$02
	db COURTYARD_FLOODGATE, 		$03
	db AQUA_TANK_STOREROOM, 	$00
	db VISUAL_DATA_ROOM, 	$01
	db EAST_STOREROOM, 	$00
;4846

healthMeterTilesPointers: ;4846
	dw badHealthMeterTilesAddr
	dw badHealthMeterTilesAddr
	dw poorHealthMeterTilesAddr
	dw fineHealthMeterTilesAddr
	dw goodHealthMeterTilesAddr

badHealthMeterTilesAddr: ;4850
	dw _SCRN0+$14
	dw _SCRN0+$16
	dw _SCRN0+$54
	dw _SCRN0+$56
poorHealthMeterTilesAddr: ;4858
	dw _SCRN0+$18
	dw _SCRN0+$1A
	dw _SCRN0+$58
	dw _SCRN0+$5A
fineHealthMeterTilesAddr: ;4860
	dw _SCRN0+$1C
	dw _SCRN0+$1E
	dw _SCRN0+$5C
	dw _SCRN0+$5E
goodHealthMeterTilesAddr: ;4868
	dw _SCRN0+$94
	dw _SCRN0+$96
	dw _SCRN0+$D4
	dw _SCRN0+$D6
;4870

updateHealthMeter: ;01:4870
    ld a, [wCharHealth]
    srl a
    srl a
    srl a
    cp a, $05
    jr c, Label487F
	;set limit if greater than 4
    ld a, $04
Label487F
    add a
    ld e, a
    ld d, $00
    ld hl, healthMeterTilesPointers ;$4846
    add hl, de ;get health meter tile address
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld a, [wFrameRate] ;get framerate
    srl a
    srl a
    srl a
    and a, $06
    ld e, a
    ld d, $00
    add hl, de ;get healthe meter frame
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld de, _SCRN0+$165 ;$9965 ;health meter position
    ld c, $02 ;tile rows
Loop48A1
    call VBlankWait
    ld a, [hli]
    ld [de], a
    inc e
    ld a, [hl]
    ld [de], a
    ld a, l
    add a, $1F
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, e
    add a, $1F
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    dec c
    jr nz, Loop48A1
    ret
;48BD

updatePolicecardCursors: ;01:48BD
    ld hl, wOAMBufferC9+$60 ;$C960
    call selectOAMDataDest
    ld de, $1C4E ;cursor 1 pos x,y
    ld bc, $8C4E ;cursor 2 pos x,y
    ld a, [policeCardXpos]
    cp a, $28
    jr z, .Label48D6
;if card is moving, hide cursors
    ld de, $0
    ld bc, $0
.Label48D6
    ld [hl], e
    inc l
    ld [hl], d
    inc l
    ld [hl], $48
    inc l
    ld [hl], $02
    inc l
    ld [hl], c
    inc l
    ld [hl], b
    inc l
    ld [hl], $48
    inc l
    ld [hl], $22
    ret

updatePolicecardFacePosition:: ;01:48EA
    ld a, [policeCardYpos]
    and a, $F8
    add a, $16 ;face sprite y pos
    ld d, a
    ld a, [policeCardXpos]
    and a, $F8
    add a, $24 ;face sprite x pos
    ld e, a
    ld hl, wOAMBufferC9 ;$C900
    call selectOAMDataDest
    ld c, $30
    ld a, [wCursorPosId]
    or a
    jr z, .Label490A
    ld c, $18
.Label490A
    ld a, c
    ld [wVramBankSubBuffer], a
    xor a
    ld [wVramBankBuffer], a
    ld bc, $0403 ;sprites pieces count
    jp loadSprtOAMBuffer

loadMainMenuFaceOAMData:: ;01:4918
    ld de, $6810 ;face sprite position (y,x)
    ld hl, wOAMBufferC9 ;$C900
    call selectOAMDataDest
    ld c, $00 ;chris face tile id
    ld a, [wSelectedPlayer]
    or a
    jr z, .Label492B ;if chris
	;if jill
    ld c, $04 ;jill face tile id
.Label492B
    ld a, c
    ld [wVramBankSubBuffer], a
    ld a, $07
    ld [wVramBankBuffer], a
    ld bc, $0201
    jp loadSprtOAMBuffer

updatePolicecardLogoColorsPosition:: ;01:493A
    ld a, [policeCardYpos]
    and a, $F8
    add a, $0D ;sprite y pos
    ld d, a
    ld a, [policeCardXpos]
    and a, $F8
    add a, $02 ;sprite x pos
    ld e, a
    ld hl, wOAMBufferC9+$30 ;$C930
    call selectOAMDataDest
    xor a
    ld [wVramBankSubBuffer], a
    ld a, $01
    ld [wVramBankBuffer], a
    ld bc, $0403
    jp loadSprtOAMBuffer

checkBloodFramesIdValue:: ;01:495F
;de: charData addr
    ld hl, wBloodFramesId - wCharSpritesData ;$000D
    add hl, de
    ld a, [hl]
    or a
    jr z, .Label4973
    and a, $7F
    inc a
    cp a, $0C
    jr c, .Label4971
    xor a
    jr .Label4973
.Label4971
    or a, $80
.Label4973
    ld [hl], a
    ret
;01:4975

printChoiceArrow: ;01:4975
    ld hl, wChoiceId
    ld a, [wButtonPressId]
    and a, LEFT_INPUT
    jr nz, choiceLeftInputPressed
    ld a, [wButtonPressId]
    and a, RIGHT_INPUT
    jr nz, choiceRightInputPressed
    jr Label498E
choiceLeftInputPressed
    ld [hl], $00 ;Yes
    jr Label498E
choiceRightInputPressed
    ld [hl], $01 ;no
Label498E
    ld a, [wMsgCharXpos]
    push af
    ld a, [wMsgCharYpos]
    push af
    ld a, [hl]
    or a
    jr z, yesChoice
;noChoice
    ld a, [wMsgCharYpos]
    ld h, a
    ld a, [wMsgCharXpos]
    sub a, $08
    ld l, a
    ld a, BANK(emptySpaceChar) ;$FA
    ld bc, emptySpaceChar ;$642F
    call printMessage
    ld a, [wMsgCharYpos]
    ld h, a
    ld a, [wMsgCharXpos]
    add a, $03
    ld l, a
    ld a, BANK(choiceArrowChar) ;$FA
    ld bc, choiceArrowChar ;$642D
    call printMessage
    jr Label49E4
yesChoice
    ld a, [wMsgCharYpos]
    ld h, a
    ld a, [wMsgCharXpos]
    sub a, $08
    ld l, a
    ld a, BANK(choiceArrowChar) ;$FA
    ld bc, choiceArrowChar ;$642D
    call printMessage
    ld a, [wMsgCharYpos]
    ld h, a
    ld a, [wMsgCharXpos]
    add a, $03
    ld l, a
    ld a, BANK(emptySpaceChar) ;$FA
    ld bc, emptySpaceChar ;$642F
    call printMessage
Label49E4
    pop af
    ld [wMsgCharYpos], a
    pop af
    ld [wMsgCharXpos], a
    ret
;49ED

includeFoundItem: ;01:49ED
    ld a, [wChoiceId]
    or a
    jp nz, getItemCanceled
    ld hl, $0F00 ;text position
    ld bc, ClearTextboxText ;$63EE
    ld a, BANK(ClearTextboxText) ;$FA
    call printMessage
    ld hl, ItemIdSlot1
    ld b, $06 ;chris item slots
    ld a, [wSpriteId]
    cp a, CHRIS ;$92
    jr z, findEmptySlotLoop
    ld b, $08 ;jill item slots
findEmptySlotLoop
    ld a, [hl]
    cp a, EMPTY ;$00
    jr z, emptySlotFound
    inc hl
    dec b
    jr nz, findEmptySlotLoop
;noEmptySlotFound
    ld hl, $0F00
    ld bc, text_3EA3CE ;You can't carry more items
    ld a, BANK(text_3EA3CE) ;$FA
    call printMessage
    jp Label4A99
emptySlotFound
    ld a, [selectedItemId]
    cp a, NOTHING_ITEM_1 ;$06
    jp z, fileFound
    cp a, NOTHING_ITEM_2 ;$11
    jp z, fileFound
    cp a, NOTHING_ITEM_3 ;$3A
    jp z, fileFound
    cp a, NOTHING_ITEM_5 ;$49
    jp z, fileFound
    cp a, BOTANY_BOOK ;$4A
    jp z, fileFound
    cp a, NOTHING_ITEM_6 ;$4B
    jp z, fileFound
    cp a, NOTHING_ITEM_7 ;$4C
    jp z, fileFound
    cp a, NOTHING_ITEM_8 ;$51
    jp z, fileFound
    cp a, NOTHING_ITEM_9 ;$52
    jp z, fileFound
    cp a, NOTHING_ITEM_10 ;$53
    jp z, fileFound
    cp a, MAP_1 ;$46
    jp z, mapFound
    cp a, MAP_2 ;$48
    jp z, mapFound
    cp a, MAP_3 ;$4F
    jp z, mapFound
    cp a, MAP_4 ;$50
    jp z, mapFound
;normal item found
    ld [hl], a ;set found item in empty slot
    cp a, WIND_CREST ;$47
    jr nz, Label4A79
    ld a, $8A ;tiger statue closing
    ld [wEventId], a
    jr Label4A79
Label4A79
    ld a, [wItemTriggerId]
    ld e, a
    ld d, $00
    ld hl, wRoomItemsTriggers
    add hl, de
    ld [hl], $00 ;unset item trigger
    ld hl, $0F00
    ld bc, text_3EA3C0 ;ITEM INCLUDED
    ld a, BANK(text_3EA3C0) ;$FA
    call printMessage
    call goToLoadMenuItemsSprtData
    call enableHDMA
    call swapOAMDMAopcode
Label4A99
    ld b, $80
    call routineDelay
getItemCanceled
    call ResetPal
    ret
;4AA2

fileFound: ;01:4AA2
    ld a, [wItemTriggerId]
    ld e, a
    ld d, $00
    ld hl, wRoomItemsTriggers
    add hl, de
    ld [hl], $00 ;unset file trigger
    ld hl, $F00
    ld bc, text_3EA3C0 ;ITEM INCLUDED
    ld a, BANK(text_3EA3C0) ;$FA
    call printMessage
    call goToLoadMenuItemsSprtData
    call enableHDMA
    call swapOAMDMAopcode
    ld a, $FF
    ld [wMenuFileEnable], a
    ld b, $80
    call routineDelay
    call ResetPal
    ret
;4AD0

mapFound: ;01:4AD0
    ld a, [wItemTriggerId]
    ld e, a
    ld d, $00
    ld hl, wRoomItemsTriggers ;$C500
    add hl, de
    ld [hl], $00 ;unset map trigger
    ld hl, $F00
    ld bc, text_3EA3C0 ;ITEM INCLUDED
    ld a, BANK(text_3EA3C0) ;$FA
    call printMessage
    call goToLoadMenuItemsSprtData
    call enableHDMA
    call swapOAMDMAopcode
    ld a, $FF
    ld [wMenuMapEnable], a
    ld b, $80
    call routineDelay
    call ResetPal
    ret
;4AFE

showRoomAnimation:: ;01:4AFE
    ld a, [wRoomId]
    cp a, GREENHOUSE
    jp z, showPlantAnimRoom06
    cp a, WATERFALL_GARDEN ;cascade
    jp z, showCascadeAnimRoom38
    cp a, UNDERGROUND_WAREHOUSE
    jp z, showSpiderwebRoom45
    ret

showPlantAnimRoom06:: ;01:4B11
    ld a, [wTriggerShieldKeyPlant]
    or a
    ret nz
    ld a, [wRoomScreen]
    cp a, $01
    jr z, .Label4B22
    cp a, $02
    jr z, .Label4B53
    ret
.Label4B22 ;01:4B22
    ld a, $00
    ld [wLowColliderRightX], a
    ld a, $12
    ld [wLowColliderLeftX], a
    ld a, $0A
    ld [wLowColliderBottomY], a
    ld a, $10
    ld [wLowColliderTopY], a
    ld hl, room06_01_masks_pointers ;$7A96
    ld a, [wFrameRateCounter]
    ld c, a
    and a, $07
    ret nz
    ld a, c
    and a, $1F
    srl a
    srl a
    srl a
    ld c, a
    add a
    add a, c
    ld c, a
    ld b, $00
    add hl, bc
    jp loadRoomBGMask
.Label4B53
    ld a, $03
    ld [wLowColliderRightX], a
    ld a, $10
    ld [wLowColliderLeftX], a
    ld a, $08
    ld [wLowColliderBottomY], a
    ld a, $0B
    ld [wLowColliderTopY], a
    ld hl, room06_02_masks_pointers ;$7AA2
    ld a, [wFrameRateCounter]
    ld c, a
    and a, $07
    ret nz
    ld a, c
    and a, $1F
    srl a
    srl a
    srl a
    ld c, a
    add a
    add a, c
    ld c, a
    ld b, $00
    add hl, bc
    jp loadRoomBGMask

showCascadeAnimRoom38:: ;01:4B84
    ld a, [wTriggerCourtyardCascade]
    or a
    ret z
    ld a, [wRoomScreen]
    cp a, $02
    jr z, .Label4B91
    ret
.Label4B91 ;01:4B91
    ld a, $09
    ld [wLowColliderRightX], a
    ld a, $0F
    ld [wLowColliderLeftX], a
    ld a, $00
    ld [wLowColliderBottomY], a
    ld a, $09
    ld [wLowColliderTopY], a
    ld hl, room38_02_masks_pointers ;$7B20
    ld a, [wFrameRateCounter]
    ld c, a
    and a, $07
    ret nz
    ld a, c
    and a, $1F
    ld c, a
    ld a, $1F
    sub a, c
    srl a
    srl a
    srl a
    ld c, a
    add a
    add a, c
    ld c, a
    ld b, $00
    add hl, bc
    jp loadRoomBGMask

showSpiderwebRoom45:: ;014BC6
    ld a, [wSpriteFacing]
    cp a, $0D
    ret nc
    cp a, $04
    ret c
    ld a, [wSpritePositionXHigh]
    cp a, $01
    ret nz
    ld a, [wSpritePositionXLow]
    cp a, $40
    ret c
    ld a, [wSpritePositionZHigh]
    cp a, $FF
    jr z, .Label4BEA
    ld a, [wSpritePositionZLow]
    cp a, $70
    ret nc
    jr .Label4BF0
.Label4BEA
    ld a, [wSpritePositionZLow]
    cp a, $B0
    ret c
.Label4BF0
    ld a, [wSpriteAnimationId]
    cp a, $05
    ret nz
    ld a, [wSpriteAnimationFrameId] ;PlayerAnimationLoopTimer
    cp a, $14
    jr z, .Label4C06
    cp a, $1C
    jr z, .Label4C06
    cp a, $24
    jr z, .Label4C06
    ret
.Label4C06 ;01:4C06
    ld a, [wc1b2]
    cp a, $03
    ret nc
    inc a
    ld [wc1b2], a
    cp a, $03
    jr nc, .Label4C17
    jp goToLoadRoomBgMask
.Label4C17
    ld a, $FF
    ld [wc450], a
    ld a, [wRoomId]
    ld l, a
    ld a, [wRoomIdHigh]
    ld h, a
    add hl, hl
    add hl, hl
    ld de, RoomsBgLookupTable ;71B5
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
    xor a
    ld [wLowColliderBottomY], a
    ld a, $10
    ld [wLowColliderTopY], a
    xor a
    ld [wLowColliderRightX], a
    ld a, $14
    ld [wLowColliderLeftX], a
    jp loadRoomBG

;01:4C42

loadPreviewComputerScrnMask: ;01:4C42
    ld a, $02
    ld [wLowColliderBottomY], a
    ld a, $08
    ld [wLowColliderTopY], a
    ld a, $07
    ld [wLowColliderRightX], a
    ld a, $0D
    ld [wLowColliderLeftX], a
    ld hl, lab_computer_startup_bg_mask ;$7BC5
    jp loadRoomBGMask

loadComputerKeyboardBg: ;01:4C5C
    ld a, $00
    ld [wLowColliderBottomY], a
    ld a, $10
    ld [wLowColliderTopY], a
    ld a, $00
    ld [wLowColliderRightX], a
    ld a, $14
    ld [wLowColliderLeftX], a
    ld hl, computer_keyboard_bg ;$7BBF
    call loadRoomBGMask
updateSelectedKeyboardKey:
    ld a, [wComputerKeyboardKeyId]
    ld c, a
    ld a, [wCompKeyboardKeyIdUpdated]
    cp a, c
    jr z, loadSelectedKeyTile
    ld bc, computer_keyboard_bg ;$7BBF
    call loadKeyTileMask
loadSelectedKeyTile
    ld a, [wComputerKeyboardKeyId]
    ld bc, selected_keyboard_keys_bg ;$7BC2
    jp loadKeyTileMask

loadKeyTileMask: ;01:4C8F
;a: key id
;bc: tile data address
    add a
    add a
    ld e, a
    ld d, $00
    ld hl, keyboardKeyPositions ;$4CAD
    add hl, de
    ld a, [hli]
    ld [wLowColliderRightX], a
    ld a, [hli]
    ld [wLowColliderLeftX], a
    ld a, [hli]
    ld [wLowColliderBottomY], a
    ld a, [hli]
    ld [wLowColliderTopY], a
    ld l, c
    ld h, b
    jp loadRoomBGMask

keyboardKeyPositions: ;4CAD
;right | left | bottom | top
	db $02, $04, $07, $09
	db $04, $06, $07, $09
	db $06, $08, $07, $09
	db $08, $0A, $07, $09
	db $0A, $0C, $07, $09
	db $0C, $0E, $07, $09
	db $0E, $10, $07, $09
	db $10, $12, $07, $09
	db $02, $04, $09, $0B
	db $04, $06, $09, $0B
	db $06, $08, $09, $0B
	db $08, $0A, $09, $0B
	db $0A, $0C, $09, $0B
	db $0C, $0E, $09, $0B
	db $0E, $10, $09, $0B
	db $10, $12, $09, $0F
	db $02, $04, $0B, $0D
	db $04, $06, $0B, $0D
	db $06, $08, $0B, $0D
	db $08, $0A, $0B, $0D
	db $0A, $0C, $0B, $0D
	db $0C, $0E, $0B, $0D
	db $0E, $10, $0B, $0D
	db $10, $12, $09, $0F
	db $02, $04, $0D, $0F
	db $04, $06, $0D, $0F
	db $06, $08, $0D, $0F
	db $08, $0A, $0D, $0F
	db $0A, $0C, $0D, $0F
	db $0C, $10, $0D, $0F
	db $0C, $10, $0D, $0F
	db $10, $12, $09, $0F
;4D2D

loadProjectorSlide1: ;01:4D2D
    ld hl, projector_slide_01_mask ;$7BE3
    jr Label4D44
loadProjectorSlide2:
    ld hl, projector_slide_02_mask ;$7BD7
    jr Label4D44
loadProjectorSlide3:
    ld hl, projector_slide_03_mask ;$7BDA
    jr Label4D44
loadProjectorSlide4:
    ld hl, projector_slide_04_mask ;$7BDD
    jr Label4D44
loadProjectorSlide5:
    ld hl, projector_slide_05_mask ;$7BE0
Label4D44
;generate a bg mask of $12,$0E tiles, at $02,$02
    ld a, $02
    ld [wLowColliderBottomY], a
    ld a, $0E
    ld [wLowColliderTopY], a
    ld a, $02
    ld [wLowColliderRightX], a
    ld a, $12
    ld [wLowColliderLeftX], a
    call loadRoomBGMask
    jp msgInputPressWaitLoop
;4D5E

goToLoadRoomBgData: ;01:4D5E
	;set bg draw canvas of 14,10 tiles, at 0,0
    xor a
    ld [wLowColliderBottomY], a
    ld a, $10
    ld [wLowColliderTopY], a
    xor a
    ld [wLowColliderRightX], a
    ld a, $14
    ld [wLowColliderLeftX], a
    call loadRoomBG ;3080
    xor a
    ld [wFrameRateCounter], a
    call goToLoadRoomBgMask ;942
    jp showRoomAnimation ;4AFE
;4D7D

checkItemUsage:: ;;01:4D7D
;get current player position
    ld a, [wSpritePositionXLow]
    ld e, a
    ld a, [wSpritePositionXHigh]
    ld d, a
    call div8SignedWord
    ld c, e
    ld b, d
    ld a, [wSpritePositionZLow]
    ld e, a
    ld a, [wSpritePositionZHigh]
    ld d, a
    call div8SignedWord
;check selected item usage
    ld a, [selectedItemId]
    cp a, SHEET_MUSIC
    jp z, checkMusicSheetUsage
    cp a, F_AID_SPRAY
    jp z, checkFAidSprayUsage
    cp a, CHEMICAL
    jp z, checkHerbicideUsage
    cp a, GOLD_EMBLEM
    jp z, checkGoldEmblemUsage
    cp a, WOODEN_EMBLEM
    jp z, checkWoodEmblemUsage
    cp a, BLUE_JEWEL
    jp z, checkBlueJewelUsage
    cp a, RED_JEWEL
    jp z, checkRedJewelUsage
    cp a, GREEN_HERB
    jp z, checkGreenHerbUsage
    cp a, RED_HERB
    jp z, checkRedHerbUsage
    cp a, BLUE_HERB
    jp z, checkBlueHerbUsage
    cp a, STAR_CREST
    jp z, checkCrestUsage
    cp a, MOON_CREST
    jp z, checkCrestUsage
    cp a, SUN_CREST
    jp z, checkCrestUsage
    cp a, WIND_CREST
    jp z, checkCrestUsage
    cp a, SQUARE_CRANK
    jp z, checkSquareCrankUsage
    cp a, RED_BOOK
    jp z, checkRedbookUsage
    cp a, COURTYARD_BATTERY
    jp z, checkCourtyardBatteryUsage
    cp a, FLAMETHROWER
    jp z, checkFlameThrowerUsage
    cp a, HEX_CRANK
    jp z, checkHexCrankUsage
    cp a, MO_DISK_1
    jp z, checkMODiskUsage
    cp a, MO_DISK_2
    jp z, checkMODiskUsage
    cp a, MO_DISK_3
    jp z, checkMODiskUsage
    cp a, LAB_BATTERY
    jp z, checkLabBatteryUsage
    cp a, BROKEN_SHOTGUN
    jp z, checkBrokenShotgunUsage
    cp a, LIGHTER
    jp z, checkLighterUsage
    cp a, WOLF_MEDAL
    jp z, checkWolfMedalUsage
    cp a, EAGLE_MEDAL
    jp z, checkEagleMedalUsage
    cp a, SLIDES_2
    jp z, checkSlideUsage
    cp a, V_JOLT
    jp z, checkVJotlUsage
    ret
;4E2A
checkVJotlUsage: ;01:4E2A
;bc: xpos
;de: ypos
    ld a, [wRoomId]
    cp a, PLANT_42_ROOTS_ROOM
    ret nz
    ld a, b
    or a ;$00
    ret nz
    ld a, c
    cp a, $27
    ret nz
    ld a, d
    cp a, $FF
    jr z, Label4E42
    ld a, e
    cp a, $09
    ret nc
    jr Label4E46
Label4E42
    ld a, e
    cp a, $E5
    ret c
Label4E46
    ld a, [wSpriteFacing]
    cp a, FACING_SOUTH
    ret nc
    ld [hl], $00 ;remove item
    ld a, $FF
    ld [wPlant42RootsTrigger], a
    jp finishItemUsage

checkSlideUsage: ;4E56
    ld a, [wRoomId]
    cp a, VISUAL_DATA_ROOM
    ret nz
    ld a, b
    cp a, $FF
    jr z, Label4E67
    ld a, c
    cp a, $06
    ret nc
    jr Label4E6B
Label4E67
    ld a, c
    cp a, $FA
    ret c
Label4E6B
    ld a, d
    cp a, $FF
    ret nz
    ld a, e
    cp a, $D8
    ret nc
    cp a, $D4
    ret c
    ld a, [wSpriteFacing]
    cp a, FACING_WEST
    jr c, Label4E80
    cp a, FACING_EAST
    ret c
Label4E80
    ld [hl], $00
    ld a, $FF
    ld [wProjectorSlidePlaced], a
    jp finishItemUsage

checkWolfMedalUsage: ;4E8A
    ld a, [wRoomId]
    cp a, FOUNTAIN
    ret nz
    ld a, b
    or a
    ret nz
    ld a, c
    cp a, $7E
    ret c
    cp a, $80
    ret nc
    ld a, d
    or a
    ret nz
    ld a, e
    cp a, $1C
    ret c
    cp a, $24
    ret nc
    ld a, [wSpriteFacing]
    cp a, FACING_SOUTH
    ret c
    ld [hl], $00
    ld a, $FF
    ld [wWolfMedalPlaced], a
    ld a, [wEagleMedalPlaced]
    or a
    jp z, finishItemUsage
    ld a, $FF
    ld [wLaboratoryEntranceOpened], a
    jp finishItemUsage

checkEagleMedalUsage:
    ld a, [wRoomId]
    cp a, FOUNTAIN
    ret nz
    ld a, b
    or a
    ret nz
    ld a, c
    cp a, $03
    ret nc
    ld a, d
    or a
    ret nz
    ld a, e
    cp a, $29
    ret c
    cp a, $30
    ret nc
    ld a, [wSpriteFacing]
    cp a, FACING_SOUTH
    ret nc
    ld [hl], $00
    ld a, $FF
    ld [wEagleMedalPlaced], a
    ld a, [wWolfMedalPlaced]
    or a
    jp z, finishItemUsage
    ld a, $FF
    ld [wLaboratoryEntranceOpened], a
    jp finishItemUsage

checkLighterUsage: ;4EF3
    ld a, [wRoomId]
    cp a, LOUNGE_ROOM
    jp z, checkLighterUsageOnMapFireplace
    cp a, SMALL_DINNING_ROOM
    jp z, checkLighterUsageOnCandle
    ret

checkLighterUsageOnMapFireplace: ;01:4F01
    ld a, b
    cp a, $FF
    jr z, Label4F0C
    ld a, c
    cp a, $04
    ret nc
    jr Label4F10
Label4F0C
    ld a, c
    cp a, $F4
    ret c
Label4F10
    ld a, d
    cp a, $FF
    ret nz
    ld a, e
    cp a, $F5
    ret nc
    ld a, [wSpriteFacing]
    cp a, FACING_WEST
    ret c
    cp a, FACING_EAST
    ret nc
    ld a, [wLoungeFireplaceLitted]
    or a
    ret nz
    ld a, $FF
    ld [wLoungeFireplaceLitted], a
    ld [wFireplace2FMapEnabled], a
    jp finishItemUsage

checkLighterUsageOnCandle:
    ld a, b
    cp a, $FF
    ret nz
    ld a, c
    cp a, $F0
    ret c
    ld a, d
    cp a, $FF
    ret nz
    ld a, e
    cp a, $E9
    ret c
    cp a, $F0
    ret nc
    ld a, [wSpriteFacing]
    cp a, FACING_EAST
    jr nc, Label4F4E
    cp a, FACING_WEST
    ret nc
Label4F4E
    ld a, [wCandleRoomLight]
    or a
    ret nz
    ld a, $FF
    ld [wCandleRoomLight], a
    ld [wc545], a
    ld [wc546], a
    jp finishItemUsage

checkBrokenShotgunUsage: ;4F61
    ld a, [wRoomId]
    cp a, LIVING_ROOM
    ret nz
    ld a, b
    cp a, $FF
    jr z, Label4F72
    ld a, c
    cp a, $08
    ret nc
    jr Label4F76
Label4F72
    ld a, c
    cp a, $F0
    ret c
Label4F76
    ld a, d
    or a
    ret nz
    ld a, e
    cp a, $20
    ret c
    ld a, [wSpriteFacing]
    cp a, FACING_WEST
    jr c, Label4F87
    cp a, FACING_EAST
    ret c
Label4F87
    ld a, [wLivingRoomShotgunPlaced]
    or a
    ret nz
    ld [hl], $00
    ld a, $FF
    ld [wBrokenShotgunPlaced], a
    ld a, [wSelectedPlayer]
    or a
    jr z, Label4FA1
    ld a, $FF
    ld [wc413], a
    jp finishItemUsage
Label4FA1
    ld a, $FF
    ld [wc41f], a
    jp finishItemUsage

checkLabBatteryUsage: ;4FA9
    ld a, [wRoomId]
    cp a, EMERGENCY_TUNNEL
    jp z, Label4FB2
    ret
;4FB2
Label4FB2: ;01:4FB2
    ld a, b
    cp a, $FF
    ret nz
    ld a, c
    cp a, $8A
    ret c
    cp a, $90
    ret nc
    ld a, d
    cp a, $FF
    ret nz
    ld a, e
    cp a, $82
    ret c
    cp a, $8A
    ret nc
    ld a, [wSpriteFacing]
    cp a, FACING_WEST
    ret c
    cp a, FACING_EAST
    ret nc
    ld [hl], $00
    ld a, $FF
    ld [wHeliportElevatorPowered], a
    call scrollDownScreen
    ld hl, text_pointer_4003 ;Something has happened!
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    call scrollUpScreen
    jp finishItemUsage

checkMODiskUsage: ;4FED
    ld a, [wRoomId]
    cp a, OPERATING_MORGE_ROOM
    jp z, checkMODiskUsageOnMorgue
    cp a, POWER_ROOM_PASSAGE_2
    jp z, checkMODiskUsageOnPowerRoomPassage
    cp a, LAB_RESEARCHER_ROOM
    jp z, checkMODiskUsageOnResearcherRoom
    ret
;5000
checkMODiskUsageOnMorgue: ;01:5000
    ld a, b
    cp a, $FF
    ret nz
    ld a, c
    cp a, $92
    ret c
    cp a, $9A
    ret nc
    ld a, d
    cp a, $FF
    ret nz
    ld a, e
    cp a, $E8
    ret c
    cp a, $F0
    ret nc
    ld a, [wSpriteFacing]
    cp a, FACING_WEST
    jp c, Label5021
    cp a, FACING_EAST
    ret c
Label5021
    ld a, [wMoDiskPasscode01Filed]
    or a
    ret nz
    ld [hl], $00
    call scrollDownScreen
    ld hl, text_pointer_411A ;PASS CODE 01 has been filed.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld a, $FF
    ld [wMoDiskPasscode01Filed], a
    call scrollUpScreen
    jp finishItemUsage

checkMODiskUsageOnPowerRoomPassage:
    ld a, b
    or a
    ret nz
    ld a, c
    cp a, $57
    ret c
    cp a, $5F
    ret nc
    ld a, d
    or a
    ret nz
    ld a, e
    cp a, $4D
    ret c
    cp a, $55
    ret nc
    ld a, [wSpriteFacing]
    cp a, FACING_WEST
    jp c, Label5061
    cp a, FACING_SOUTH_EAST ;should be FACING_EAST for easy use %fix
    ret c
Label5061
    ld a, [wMoDiskPasscode02Filed]
    or a
    ret nz
    ld [hl], $00
    call scrollDownScreen
    ld hl, text_pointer_411D ;PASS CODE 02 has been filed.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld a, $FF
    ld [wMoDiskPasscode02Filed], a
    call scrollUpScreen
    jp finishItemUsage

checkMODiskUsageOnResearcherRoom:
    ld a, b
    or a
    ret nz
    ld a, c
    cp a, $29
    ret c
    cp a, $31
    ret nc
    ld a, d
    or a
    ret nz
    ld a, e
    cp a, $0B
    ret c
    cp a, $13
    ret nc
    ld a, [wSpriteFacing]
    cp a, FACING_WEST
    jp c, Label50A1
    cp a, FACING_EAST
    ret c
Label50A1
    ld a, [wMoDiskPasscode03Filed]
    or a
    ret nz
    ld [hl], $00
    call scrollDownScreen
    ld hl, text_pointer_4120 ;PASS CODE 03 has been filed.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld a, $FF
    ld [wMoDiskPasscode03Filed], a
    call scrollUpScreen
    jp finishItemUsage

checkHexCrankUsage: ;50C2
    ld a, [wRoomId]
    cp a, UNDGRND_STATUE_ROOM
    jp z, HexCrankUsageOnUndergndStatue
    cp a, BOULDER_ROOM_2
    jp z, HexCrankUsageOnBoulder2Floor
    cp a, UNDERGROUND_ENTRY
    jr z, HexCrankUsageOnUndergndEntranceFloor
    ret
;50D4
HexCrankUsageOnUndergndEntranceFloor: ;01:50D4
    ld a, b
    cp a, $FF
    ret nz
    ld a, c
    cp a, $D8
    ret c
    cp a, $DC
    ret nc
    ld a, d
    cp a, $FF
    ret nz
    ld a, e
    cp a, $E7
    ret c
    cp a, $F4
    ret nc
    ld a, [wSpriteFacing]
    cp a, FACING_SOUTH
    ret nc
    ld a, [wRotateFloor1AnimId]
    or a
    ret nz
    ld a, $05
    ld [wRoomScreen], a
    push hl
    call haltCPU
    call ResetPal
    call loadAllRoomBgData
    call loadAndCalcEventSpritesData
    ld a, $01
    ld [wLCDUpdate], a
    call checkAndLoadRoomPal
    pop hl
    ld b, $30
    call routineDelay
    ld b, $04
rotateEntranceFloorLoop
    push bc
    push hl
    call haltCPU
    ld hl, wRotateFloor1AnimId
    inc [hl]
    call goToLoadRoomBgMask
    ld b, $30
    call routineDelay
    pop hl
    pop bc
    dec b
    jr nz, rotateEntranceFloorLoop
    jp finishItemUsage

HexCrankUsageOnBoulder2Floor: ;5130
    ld a, b
    or a
    ret nz
    ld a, c
    cp a, $0C
    ret c
    cp a, $14
    ret nc
    ld a, d
    cp a, $FF
    ret nz
    ld a, e
    cp a, $C0
    ret c
    cp a, $C8
    ret nc
    ld a, [wSpriteFacing]
    cp a, FACING_WEST
    jp c, Label5150
    cp a, FACING_EAST
    ret c
Label5150
    ld a, [wRotateFloor2AnimId]
    or a
    ret nz
    ld a, $05
    ld [wRoomScreen], a
    push hl
    call haltCPU
    call ResetPal
    call loadAllRoomBgData
    call loadAndCalcEventSpritesData
    ld a, $01
    ld [wLCDUpdate], a
    call checkAndLoadRoomPal
    pop hl
    ld b, $30
    call routineDelay
    ld b, $02
rotateBoulder2FloorLoop
    push bc
    push hl
    call haltCPU
    ld hl, wRotateFloor2AnimId
    inc [hl]
    call goToLoadRoomBgMask
    ld b, $30
    call routineDelay
    pop hl
    pop bc
    dec b
    jr nz, rotateBoulder2FloorLoop
    jp finishItemUsage

HexCrankUsageOnUndergndStatue: ;5190
    ld a, [wCatacombStatueWallTrigger]
    xor a, $FF
    ld [wCatacombStatueWallTrigger], a
    cp a, $FF
    jp nz, finishItemUsage
    ld de, wNPCSpritesData
    ld b, $07
findStatueLoop
    ld hl, wSpriteId - wCharSpritesData ;$B
    add hl, de
    ld a, [hl]
    cp a, UNDERGROUND_STATUE
    jr z, statueFound
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    dec b
    jr nz, findStatueLoop
statueNotFound ;infinite loop
    jr statueNotFound
statueFound
;move statue
    ld hl, wSpritePositionXHigh - wCharSpritesData ;$12
    add hl, de
    ld a, [hld]
    cp a, $80
    jp c, finishItemUsage
    cp a, $FF
    jr c, Label51CC
    ld a, [hl]
    cp a, $48
    jp nc, finishItemUsage
Label51CC
    ld bc, $FFB8 ;set statue position
    ld [hl], c
    inc hl
    ld [hl], b
    jp finishItemUsage

checkFlameThrowerUsage: ;51D5
    ld a, [wRoomId]
    cp a, WAY_TO_BREAK_ROOM
    jp z, flamethrowerUsage1
    cp a, BOULDER_ROOM_1
    jp z, flamethrowerUsage2
    ret
;51E3
flamethrowerUsage1: ;01:51E3
    ld a, b
    or a
    ret nz
    ld a, c
    cp a, $65
    ret c
    cp a, $6D
    ret nc
    ld a, d
    or a
    ret nz
    ld a, e
    cp a, $0C
    ret c
    ld a, [wSpriteFacing]
    cp a, FACING_WEST
    jp c, Label51FF
    cp a, FACING_EAST
    ret c
Label51FF
    ld a, $FF
    ld [wc583], a
    ld [wBoulderPassage1DoorLock], a
    xor a
    ld [wBoulderPassage2DoorLock], a
    ld [hl], $00
    jp finishItemUsage

flamethrowerUsage2:
    ld a, b
    or a
    ret nz
    ld a, c
    cp a, $10
    ret nc
    ld a, d
    cp a, $FF
    ret nz
    ld a, e
    cp a, $C2
    ret c
    ld a, e
    cp a, $CA
    ret nc
    ld a, [wSpriteFacing]
    cp a, $10
    ret c
    ld a, $FF
    ld [wc574], a
    ld [wBoulderPassage2DoorLock], a
    xor a
    ld [wBoulderPassage1DoorLock], a
    ld [hl], $00 ;remove flamethrower
    jp finishItemUsage

checkCourtyardBatteryUsage: ;523A
    ld a, [wRoomId]
    cp a, WATERFALL_GARDEN
    ret nz
    ld a, b
    or a
    ret nz
    ld a, c
    cp a, $13
    ret c
    cp a, $1A
    ret nc
    ld a, d
    or a
    ret nz
    ld a, e
    cp a, $58
    ret c
    ld a, [wSpriteFacing]
    cp a, FACING_EAST
    jr nc, Label525B
    cp a, FACING_WEST
    ret nc
Label525B
    ld [hl], $00
    ld a, $FF
    ld [wCourtyardElevatorPowered], a
    call scrollDownScreen
    ld hl, text_pointer_4003 ;Something has happened!
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    call scrollUpScreen
    jp finishItemUsage

checkSquareCrankUsage: ;5277
    ld a, [wRoomId]
    cp a, COURTYARD_FLOODGATE
    ret nz
    ld a, b
    or a
    ret nz
    ld a, c
    cp a, $1A
    ret nc
    ld a, d
    cp a, $FF
    ret nz
    ld a, e
    cp a, $E6
    ret c
    cp a, $F0
    ret nc
    ld a, [wSpriteFacing]
    cp a, FACING_WEST
    ret c
    cp a, FACING_SOUTH_EAST+1 ;$15 ;%fix?
    ret nc
    ld a, $03
    ld [wRoomScreen], a
    call loadEventRoomScreen
    ld a, [wTriggerCourtyardCascade]
    or a
    jr z, Label52BF
    call scrollDownScreen
    xor a
    ld [wTriggerCourtyardCascade], a
    ld hl, text_pointer_40A2 ;There's a square hole.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    call scrollUpScreen
    jp finishItemUsage
Label52BF
    call scrollDownScreen
    ld a, $FF
    ld [wTriggerCourtyardCascade], a
    ld hl, text_pointer_40A8 ;The water is running down the opposite side.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    call scrollUpScreen
    jp finishItemUsage

checkCrestUsage: ;52D9
    ld a, [wRoomId]
    cp a, SHED_PASSAGE
    ret nz
    ld a, b
    or a
    ret nz
    ld a, c
    cp a, $10
    ret nc
    ld a, d
    cp a, $FF
    ret nz
    ld a, e
    cp a, $88
    ret nc
    ld a, [wSpriteFacing]
    cp a, FACING_WEST
    ret c
    cp a, FACING_SOUTH_EAST+1 ;$15
    ret nc
    ld a, [selectedItemId]
    cp a, STAR_CREST
    jr z, putStarCrest
    cp a, MOON_CREST
    jr z, putMoonCrest
    cp a, SUN_CREST
    jr z, putSunCrest
;putWindCrest
    ld a, $FF
    ld [wWindCrestPlaced], a
    ld [hl], $00
    jp checkAllCrestsPlaced
putStarCrest
    ld a, $FF
    ld [wStarCrestPlaced], a
    ld [hl], $00
    jp checkAllCrestsPlaced
putSunCrest
    ld a, $FF
    ld [wSunCrestPlaced], a
    ld [hl], $00
    jp checkAllCrestsPlaced
putMoonCrest
    ld a, $FF
    ld [wMoonCrestPlaced], a
    ld [hl], $00

checkAllCrestsPlaced:
    ld a, [wMoonCrestPlaced]
    cp a, $FF
    jr nz, allCrestNotPlaced
    ld a, [wSunCrestPlaced]
    cp a, $FF
    jr nz, allCrestNotPlaced
    ld a, [wStarCrestPlaced]
    cp a, $FF
    jr nz, allCrestNotPlaced
    ld a, [wWindCrestPlaced]
    cp a, $FF
    jr nz, allCrestNotPlaced
    ld a, $FF
    ld [wShedDoorLock], a
    ld a, CREST_PANEL_SCREEN ;$04
    ld [wRoomScreen], a
    call loadEventRoomScreen
    ld hl, text_pointer_4078 ;The sun sets in the  west, the moon rises in the east
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld hl, text_pointer_4003 ;Something has happened!
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    jp finishItemUsage
allCrestNotPlaced
    ld a, CREST_PANEL_SCREEN ;$04
    ld [wRoomScreen], a
    call loadEventRoomScreen
    call msgInputPressWaitLoop
    jp finishItemUsage

checkRedbookUsage: ;537D %fix incomplete redbook usage
    ld a, [wDorm003WhiteBookRemoved]
    or a
    ret
;5382

NotUsedRedBookUsageEvent: ;01:5382 not use usage event
    ld a, [wRoomId]
    cp a, GUARDHOUSE_DORM_003
    ret nz
    ld a, b
    cp a, $FF
    ret nz
    ld a, c
    cp a, $EA
    ret nc
    ld a, d
    cp a, $FF
    ret nz
    ld a, e
    cp a, $E0
    ret c
    ld a, [wSpriteFacing]
    cp a, FACING_SOUTH
    ret c
    ld [hl], $00 ;remove item
    ld a, $FF
    ld [wDorm003RedBookPlaced], a
    ld [wc462], a
    call scrollDownScreen
    ld hl, text_pointer_4003 ;Something has happened!
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    call scrollUpScreen
;find NPC
    ld de, wNPCSpritesData
    ld b, $07
findClosetLoop
    ld hl, wSpriteId - wCharSpritesData ;$B
    add hl, de
    ld a, [hl]
    cp a, DORM_003_CLOSET_F1
    jr z, closetFound
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld e, a
    dec b
    jr nz, findClosetLoop
closetNotFound ;01:53D3
    jr closetNotFound
closetFound
    ld hl, wSpritePositionXLow - wCharSpritesData ;$11
    add hl, de
    ld bc, $150
    ld [hl], c
    inc hl
    ld [hl], b
    xor a
    ld [wc6fa], a
    ld a, $FF
    ld [wc6fb], a
    jp finishItemUsage

checkBlueJewelUsage: ;53EB
    ld a, [wRoomId]
    cp a, TIGER_STATUE_ROOM
    ret nz
    ld a, b
    cp a, $FF
    jr z, Label53FC
    ld a, c
    cp a, $10
    ret nc
    jr Label5400
Label53FC
    ld a, c
    cp a, $F0
    ret c
Label5400
    ld a, d
    or a
    ret nz
    ld a, e
    cp a, $08
    ret c
    ld a, [wSpriteFacing]
    cp a, FACING_WEST
    jp c, Label5412
    cp a, FACING_EAST
    ret c
Label5412:
    ld a, $00
    ld [hl], a
    ld a, $89
    ld [wEventId], a ;set tiger statue event
    ld a, $FF
    ld [wBlueJewelPlaced], a
    jp finishItemUsage

checkRedJewelUsage: ;5422
    ld a, [wRoomId]
    cp a, TIGER_STATUE_ROOM
    ret nz
    ld a, b
    cp a, $FF
    jr z, Label5433
    ld a, c
    cp a, $10
    ret nc
    jr Label5437
Label5433
    ld a, c
    cp a, $F0
    ret c
Label5437
    ld a, d
    or a
    ret nz
    ld a, e
    cp a, $08
    ret c
    ld a, [wSpriteFacing]
    cp a, FACING_WEST
    jp c, Label5449
    cp a, FACING_EAST
    ret c
Label5449:
    ld a, $00
    ld [hl], a
    ld a, $8A
    ld [wEventId], a ;set red jewel tiger statue event
    ld a, $FF
    ld [wRedJewelPlaced], a
    jp finishItemUsage

checkGoldEmblemUsage: ;5459
    ld a, [wRoomId]
    cp a, DINNING_ROOM_1F
    jr z, checkGoldEmblemUsageInDinningRoom
;checkGoldEmblemInPianoRoom
    cp a, PIANO_ROOM
    ret nz
    ld a, b
    cp a, $FF
    ret nz
    ld a, c
    cp a, $84
    ret nc
    ld a, d
    or a
    jp z, Label5476
    ld a, e
    cp a, $F8
    ret c
    jr Label547A
Label5476:
    ld a, e
    cp a, $08
    ret nc
Label547A
    ld a, [wSpriteFacing]
    cp a, FACING_SOUTH
    ret c
    ld a, [wPianoRoomWoodEmblemTrigger]
    or a
    ret nz
    ld a, $FF
    ld [wPianoRoomGoldEmblemTrigger], a
    ld a, EMPTY
    ld [hl], a
    jp finishItemUsage
checkGoldEmblemUsageInDinningRoom
    ld a, b
    or a
    ret nz
    ld a, c
    cp a, $70
    ret c
    ld a, d
    or a
    jp z, Label54A2
    ld a, e
    cp a, $F8
    ret c
    jr Label54A6
Label54A2:
    ld a, e
    cp a, $08
    ret nc
Label54A6
    ld a, [wSpriteFacing]
    cp a, FACING_SOUTH
    ret nc
    ld a, [wTriggerGoldenShieldDRoom]
    or a
    ret nz
    ld a, $FF
    ld [wDinningRoomGoldEmblemPlaced], a
    ld a, EMPTY
    ld [hl], a
;findClock
    ld de, wNPCSpritesData
    ld b, $07
findClockLoop
    ld hl, wSpriteId - wCharSpritesData ;$B
    add hl, de
    ld a, [hl]
    cp a, DINNING_ROOM_CLOCK
    jr z, clockFound
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld e, a
    dec b
    jr nz, findClockLoop
clockNotFound ;54D2
    jr clockNotFound
clockFound
    ld hl, wSpritePositionXLow - wCharSpritesData ;$11
    add hl, de
    ld bc, $D8
    ld [hl], c
    inc hl
    ld [hl], b
    inc hl
    ld bc, $150
    ld [hl], c
    inc hl
    ld [hl], b
    xor a
    ld [wc6f2], a
    ld a, $FF
    ld [wc6f3], a
    jp finishItemUsage

checkWoodEmblemUsage: ;54F1
    ld a, [wRoomId]
    cp a, DINNING_ROOM_1F
    jr z, checkWoodEmblemUsageInDinningRoom
    cp a, PIANO_ROOM
    ret nz
    ld a, b
    cp a, $FF
    ret nz
    ld a, c
    cp a, $84
    ret nc
    ld a, d
    or a
    jp z, Label550E
    ld a, e
    cp a, $F8
    ret c
    jr Label5512
Label550E
    ld a, e
    cp a, $08
    ret nc
Label5512
    ld a, [wSpriteFacing]
    cp a, FACING_SOUTH
    ret c
    ld a, [wPianoRoomGoldEmblemTrigger]
    or a
    ret nz
    ld a, $FF
    ld [wPianoRoomWoodEmblemTrigger], a
    ld a, EMPTY
    ld [hl], a
    jp finishItemUsage
checkWoodEmblemUsageInDinningRoom
    ld a, b
    or a
    ret nz
    ld a, c
    cp a, $70
    ret c
    ld a, d
    or a
    jp z, Label553A
    ld a, e
    cp a, $F8
    ret c
    jr Label553E
Label553A
    ld a, e
    cp a, $08
    ret nc
Label553E
    ld a, [wSpriteFacing]
    cp a, FACING_SOUTH
    ret nc
    ld a, [wDinningRoomGoldEmblemPlaced]
    or a
    ret nz
    ld a, $FF
    ld [wTriggerGoldenShieldDRoom], a
    ld a, EMPTY
    ld [hl], a
    jp finishItemUsage

checkMusicSheetUsage: ;5554
    ld a, [wRoomId]
    cp a, PIANO_ROOM
    ret nz
    ld a, b
    cp a, $FF
    ret nz
    ld a, c
    cp a, $E0
    ret c
    cp a, $F8
    ret nc
    ld a, d
    or a
    ret nz
    ld a, e
    cp a, $05
    ret nc
    ld a, [wSpriteFacing]
    cp a, FACING_SOUTH_EAST+1 ;$15
    ret nc
    cp a, $0C
    ret c
    ld a, [wSpriteId]
    cp a, CHRIS
    jr z, checkChrisPianoEvent
	;jill
    ld a, EMPTY
    ld [hl], a
    ld a, $FF
    ld [wPianoRoomSecretDoorTrigger], a ;no piano interpretation %fix
    jp finishItemUsage
checkChrisPianoEvent
    ld a, $08
    ld [wEventId], a
    ld a, EMPTY
    ld [hl], a
    ld a, $FF
    ld [wEventBackToMainHallJill], a
    jp finishItemUsage

checkFAidSprayUsage: ;5597
    ld a, EMPTY
    ld [hl], a
    ld a, $20 ;full health
    ld [wCharHealth], a
    jp finishHealItemUsage

checkGreenHerbUsage: ;55A2
    ld a, EMPTY
    ld [hl], a
    ld c, $0C
    call applyHeal
    jp finishHealItemUsage

checkRedHerbUsage: ;55AD
    ld a, EMPTY
    ld [hl], a
    ld c, $0C
    call applyHeal
    jp finishHealItemUsage

checkBlueHerbUsage: ;55B8
    ld a, EMPTY
    ld [hl], a
    ld c, $0C
    call applyHeal
    jp finishHealItemUsage

applyHeal: ;55C3
;c: heal value
    ld a, [wCharHealth]
    add a, c
    ld [wCharHealth], a
    cp a, $21
    ret c
;limit health value
    ld a, $20
    ld [wCharHealth], a
    ret
;55D3

checkHerbicideUsage: ;01:55D3
    ld a, [wRoomId]
    cp a, GREENHOUSE
    ret nz
    ld a, b
    cp a, $FF
    ret nz
    ld a, c
    cp a, $B6
    ret nc
    ld a, d
    or a
    ret nz
    ld a, e
    cp a, $05
    ret nc
    ld a, [wSpriteFacing]
    cp a, FACING_EAST
    jp nc, Label55F3
    cp a, FACING_WEST+1 ;$09
    ret nc
Label55F3
    push hl
    ld a, $04
    ld [wRoomScreen], a
    call loadEventRoomScreen
    call scrollDownScreen
    ld hl, text_pointer_4003 ;Something has happened!
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    call scrollUpScreen
    pop hl
    ld a, EMPTY
    ld [hl], a
    ld a, $FF
    ld [wTriggerShieldKeyPlant], a
    ld [wEastStoreroomFAidSpray], a
    ld [wEastStoreroomShells], a
    ld [wEastStoreroomClip], a
    jp finishItemUsage

finishItemUsage:
    pop hl
    pop hl
    pop hl
    call ResetPal
    call hideSprites
    ld a, $01
    ld [wLCDUpdate], a
    jp gameLoopWithEventCheck

finishHealItemUsage:
    ld a, $04
    ld [wMenuSelGridId], a ;return to item grid
    call clearItemDetailWindowMap
    call loadMainMenuPallete
    call clearItemDetailWindowTiles
    call goToLoadEquipedSpriteData
    ld b, $10
    jp routineDelay
;564A

initSpecialCameraAngles:: ;01:564A
    ld hl, $38
    ld de, $2E
    ld bc, $41
    ld a, [wRoomId]
    cp a, PIANO_ROOM
    jp z, Label5681
    cp a, NORTH_EAST_CORRIDOR_1F
    jp z, Label568A
    cp a, WEST_STAIRCASE_2F
    jp z, Label5693
    cp a, WAY_TO_GUARDHOUSE
    jp z, Label569F
    cp a, AQUA_TANK_ENTRANCE
    jp z, Label56A7
    cp a, LAB_CENTRAL_CLOISTER
    jp z, Label56B9
    cp a, EMERGENCY_TUNNEL
    jp z, Label56B0
    cp a, OPERATING_MORGE_ROOM
    jp z, Label56C2
    jp applyBaseCameraAngles

Label5681:
    ld a, [wRoomScreen]
    cp a, $01
    jr nz, applyBaseCameraAngles
    jr Label56CB
Label568A:
    ld a, [wRoomScreen]
    cp a, $06
    jr nz, applyBaseCameraAngles
    jr Label56CB
Label5693:
    ld a, [wRoomScreen]
    or a
    jr z, Label569D
    cp a, $02
    jr nz, applyBaseCameraAngles
Label569D
    jr Label56CB
Label569F:
    ld a, [wRoomScreen]
    or a
    jr nz, applyBaseCameraAngles
    jr Label56CB
Label56A7:
    ld a, [wRoomScreen]
    cp a, $04
    jr nz, applyBaseCameraAngles
    jr Label56CB
Label56B0:
    ld a, [wRoomScreen]
    cp a, $05
    jr nz, applyBaseCameraAngles
    jr Label56CB
Label56B9:
    ld a, [wRoomScreen]
    cp a, $04
    jr nz, applyBaseCameraAngles
    jr Label56CB
Label56C2:
    ld a, [wRoomScreen]
    cp a, $04
    jr nz, applyBaseCameraAngles
    jr Label56CB
Label56CB:
    ld hl, $2E

applyBaseCameraAngles:: ;01:56CE
    ld a, l
    ld [wSpriteBaseXScaleLow], a
    ld a, h
    ld [wSpriteBaseXScaleHigh], a
    ld a, e
    ld [wSpriteBaseZScaleLow], a
    ld a, d
    ld [wSpriteBaseZScaleHigh], a
    ld a, c
    ld [wSpriteBaseYScaleLow], a
    ld a, b
    ld [wSpriteBaseYScaleHigh], a
    ret

setTWArrowOAMData:: ;01:56E7
;set load/save menu cursor arrow sprite OAM data
    ld hl, wOAMBufferC9
    call selectOAMDataDest
    ld a, [wCursorPosId]
    add a
    add a
    add a
    add a
    add a, $30
    ld [hl], a ;set arrow Y position
    inc l
    ld [hl], $08 ; set arrow X position
    inc l
    ld [hl], $00
    inc l
    ld [hl], $20
    ret

INCLUDE	"text/loadSaveMenuText.asm" ;01:5701

SavesCounterNumberTable: ;01:5797
	dw SavesCounterText
	dw SavesCounterText+3
	dw SavesCounterText+6
	dw SavesCounterText+9
	dw SavesCounterText+12
	dw SavesCounterText+15
	dw SavesCounterText+18
	dw SavesCounterText+21
	dw SavesCounterText+24
	dw SavesCounterText+27
	dw SavesCounterText+30
	dw SavesCounterText+33
	dw SavesCounterText+36
	dw SavesCounterText+39
	dw SavesCounterText+42
	dw SavesCounterText+45
	dw SavesCounterText+48
	dw SavesCounterText+51
	dw SavesCounterText+54
	dw SavesCounterText+57


INCLUDE	"text/loadSaveMenuText2.asm"

printSavingChars:: ;01:57DB
	ld a, $FF
	ld [wTypingCharsTrigger], a ;enable saving chars mode
	jr loop57F8
printTypewriterText:: ;01:57E2
    ld a, [de]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld bc, _SCRN0 ;tileMap address
    add hl, bc
    inc de
    ld a, [de]
    add a, l
    ld l, a
    inc de
printSavedText: ;$01:57F4
    xor a
    ld [wTypingCharsTrigger], a ;reset trigger to only print normal chars
loop57F8:
    ld a, [de]
    or a ; a = $00 check if char is end of string
    ret z
    cp a, $20 ;if char is space
    jr z, .Label5865
    cp a, $39
    jr c, .Label582F
    cp a, $49
    jr c, .Label581B
    sub a, $49
    push hl ;store tilemap pos
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld bc, _SCRN0+$15 ;set second tilemap fonts column
    add hl, bc
    ld c, l
    ld b, h
    pop hl
    jr .Label5843
.Label581B
    sub a, $41
    push hl
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld bc, _SCRN0+$154 ;start of alphabet
    add hl, bc
    ld c, l
    ld b, h
    pop hl
    jr .Label5843
.Label582F
    sub a, $30
    push hl
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld bc, _SCRN0+$14 ;$9814
    add hl, bc
    ld c, l
    ld b, h
    pop hl
    jr .Label5843
;print char
.Label5843
    call VBlankWait
    ld a, [bc]
    ld [hl], a
    ld a, $01
    ld [vramBank], a ;vram bank select
    ld a, [bc]
    ld [hl], a
    xor a
    ld [vramBank], a ;vram bank select
    ld a, [wTypingCharsTrigger]
    or a
    jr z, .Label5865 ;if not typing chars
    push de
    push hl
    ld a, SAVE_TYPING_SFX ;$16
    call playSFX
    ld b, $10
    call routineDelay
    pop hl
    pop de
.Label5865
    inc hl
    inc de
    jp loop57F8

goToPrintSavedText:: ;01:586A
    ld de, sSaveSlot1Trigger ;$BF00
    ld b, $04
.loop586F
    push bc
    push de
    call enableExtRAM
    ld a, [de]
    or a
    jr z, .Label589F ;if save slot is empty
    ld a, $04
    sub a, b
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld de, _SCRN0+$82
    add hl, de
    ld a, $04
    sub a, b
    add a
    add a
    ld c, a
    add a
    add a
    add a, c
    ld de, sSaveSlot1Info ;$BF14
    add a, e
    ld e, a
    ld a, $00
    adc a, d
    ld d, a
    call printSavedText
    jr .Label58B5
.Label589F
    ld a, $04
    sub a, b
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld de, _SCRN0+$82
    add hl, de
    ld de, EmptySlotText ;$5727
    call printSavedText
.Label58B5
    call disableExtRAM
    pop de
    inc de
    inc de
    inc de
    inc de
    pop bc
    dec b
    jr nz, .loop586F
    ret

clearExtRAM: ;01:58C2
    call enableExtRAM
;check if sram is already initialized
    ld a, [sExtRamInitFC]
    cp a, $4E
    jr nz, .Label58E4
    ld a, [sExtRamInitFD]
    cp a, $53
    jr nz, .Label58E4
    ld a, [sExtRamInitFE]
    cp a, $50
    jr nz, .Label58E4
    ld a, [sExtRamInitFF]
    cp a, $41
    jr nz, .Label58E4
    jp disableExtRAM
;otherwise clear ext RAM
.Label58E4
    ld hl, sSRamStart ;$A000 ext ram start
    ld bc, $1FFC ;bytes to clear
.loop58EA
    xor a
    ld [hli], a
    dec bc
    ld a, b
    or a, c
    jr nz, .loop58EA
;initialize sram
    ld a, $4E
    ld [sExtRamInitFC], a
    ld a, $53
    ld [sExtRamInitFD], a
    ld a, $50
    ld [sExtRamInitFE], a
    ld a, $41
    ld [sExtRamInitFF], a
    jp disableExtRAM

saveGame:: ;01:5908
    call deleteTypewriterBGText
    ld a, [wCursorPosId]
    add a
    add a
    ld e, a
    ld d, $00
    ld hl, sSaveSlot1Trigger ;$BF00
    add hl, de
    call enableExtRAM
    ld [hl], $FF
    ld a, [wCursorPosId]
    add a
    add a
    ld c, a
    add a
    add a
    add a, c
    ld c, a
    ld b, $00
    ld hl, sSaveSlot1Info ;$BF14
    add hl, bc ;apply cursor offset
    push hl
    ld de, ChrisName ;$571B
    ld a, [wSpriteId]
    cp a, CHRIS
    jr z, .Label593A
	;if JILL
    ld de, JillName ;$5721
.Label593A
    ld bc, $0006
    call loadSprtTilesToBuffer ; copy player name tiles to ext ram
    ld de, MainHall1FSaveText ;$572E
    ld a, [wRoomId]
    or a ;if roomId is $00 (main hall)
    jr z, .Label594C
	;if any other save room
    ld de, StorSaveText ;$5737
.Label594C
    ld bc, $0009
    call loadSprtTilesToBuffer ; copy room name to ext ram
    push hl
    ld a, [wSavesNumber]
    add a
    ld e, a
    ld d, $00
    ld hl, SavesCounterNumberTable ;$5797
    add hl, de
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, [wSavesNumber]
    inc a ;increase saves counter
    ld [wSavesNumber], a
    pop hl
    ld bc, $3
    call loadSprtTilesToBuffer ; copy saves number to ext ram
    ld [hl], $00
    ld a, [wCursorPosId]
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld de, _SCRN0+$82
    add hl, de
    pop de
    call printSavingChars
    ld de, sSRamStart+SAVE_SLOT_LENGTH ;$A600
    ld a, [wCursorPosId]
    add a
    ld c, a
    add a
    add a, c
    add a, d
    ld d, a
	;set save flags
    ld a, $53
    ld [wQuickSaveFlagB9], a
    ld a, $50
    ld [wQuickSaveFlagBA], a
    ld a, $41
    ld [wQuickSaveFlagBC], a
    ld hl, wButtonPressId ; start of wram
    ld bc, SAVE_SLOT_LENGTH ;$600
.loop59A6
    ld a, [hli]
    ld [de], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, .loop59A6
    call disableExtRAM
    ld b, $40
    jp routineDelay

loadGame: ;01:59B6
    ld a, [wCursorPosId]
    add a
    add a
    ld e, a
    ld d, $00
    ld hl, sSaveSlot1Trigger ;$BF00
    add hl, de
    call enableExtRAM
    ld a, [hl]
    or a
    jr z, .Label59F8
    ld de, sSRamStart+SAVE_SLOT_LENGTH ;$A600
    ld a, [wCursorPosId]
    add a
    ld c, a
    add a
    add a, c
    add a, d
    ld d, a
    ld a, $53
    ld [wQuickSaveFlagB9], a
    ld a, $50
    ld [wQuickSaveFlagBA], a
    ld a, $41
    ld [wQuickSaveFlagBC], a
    ld hl, wButtonPressId ;start of wram
    ld bc, SAVE_SLOT_LENGTH ;$600
.loop59EA
    ld a, [de]
    ld [hli], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, .loop59EA
    call disableExtRAM
    ld a, $FF
    ret
.Label59F8
	call disableExtRAM
	xor a
	ret
;59FD

checkButtonActionEvents: ;01:59FD
;check normal actions events, like pick items, check and interact with objects, etc.
    ld a, [wCheckEventIdA]
    cp a, $FF
    jp z, showDoorActionMessages
;items messages
    ld a, [wCheckEventIdA]
    cp a, $02
    jp z, showDinningRoomEmblemMsg ;wood emblem fireplace
    cp a, $05 ;serum (safe room)
    jp z, showSerumShelfMessage
    cp a, $09 ;clip 1 (kenneth corpse)
    jp z, showKennethCorpseMsg
    cp a, $0A ;clip 2 (kenneth corpse)
    jp z, showKennethCorpseMsg
    cp a, $20 ;small key 1 (mansion bathroom)
    jp z, showMansionBathroomTubChoice
    cp a, $2E ;shotgun (shotgun room)
    jp z, showReturnShotgunChoice
    cp a, $42 ;green herb, but it should be 41 (2f map) %fix
    jp z, showLoungeFireplaceMessage ;lounge (fireplace map 2F)
    cp a, $92 ;c.room key, dorm 001 bathroom
    jp z, showDorm001BathroomTubChoice
;room normal check actions (no item)
    cp a, $F0
    jp nc, roomNormalCheckActions
    ret
;5A36
showLoungeFireplaceMessage: ;01:5A36
    ld a, [wLoungeFireplaceLitted]
    or a
    ret nz
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4090 ;Firewood.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld hl, text_pointer_4093 ;There's a map above it.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    jp scrollUpScreen

showMansionBathroomTubChoice:
    ld a, [wMansionBathroomTubUnplug]
    or a
    ret nz ;return if tub is empty
    ld a, MANSION_BATHROOM_TUB ;$03
    ld [wRoomScreen], a
    call loadEventRoomScreen
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_417D ;The bathtub is filled with muddy water.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld hl, text_pointer_4180 ;Will you unplug it?  Yes No
    call getMsgPointerAndShow
Label5A81
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, Label5A81
    call clearMessageBox
    ld a, [wChoiceId]
    or a
    jp nz, scrollUpScreen ;no unplug bathtub
	;unplug bathtub
    ld a, $FF
    ld [wMansionBathroomTubUnplug], a
    ld [wc520], a
    call loadAllRoomBgData
    jp scrollUpScreen

showDorm001BathroomTubChoice:
    ld a, [wDorm001BathroomTubUnplug]
    or a
    ret nz
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_417D ;The bathtub is filled with muddy water.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld hl, text_pointer_4180 ;Will you unplug it?  Yes No
    call getMsgPointerAndShow
Label5AC0
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, Label5AC0
    call clearMessageBox
    ld a, [wChoiceId]
    or a
    jp nz, scrollUpScreen ;no unplug bathtub
	;unplug bathtub
    ld a, $FF
    ld [wDorm001BathroomTubUnplug], a
    ld [wc592], a
    call loadAllRoomBgData
    jp scrollUpScreen

showReturnShotgunChoice:
    ld a, [wBrokenShotgunPlaced]
    or a
    ret nz
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4051 ;Will you put the shotgun back?  Yes No
    call getMsgPointerAndShow
Label5AF3
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, Label5AF3
    call clearMessageBox
    ld a, [wChoiceId]
    or a
    jp nz, scrollUpScreen ;return if shotgun isn't putted back
	;remove shotgun from inventory if it's putted back
    ld hl, ItemIdSlot1
    ld b, $06
    ld a, [wSelectedPlayer]
    or a
    jr z, Loop5B14 ;jump if chris
	;if jill
    ld b, $08
Loop5B14
    ld a, [hl]
    cp a, SHOTGUN
    jr z, shotgunFound
    inc hl
    dec b
    jr nz, Loop5B14
	;return if shotgun not found
    jp scrollUpScreen
shotgunFound
    ld [hl], EMPTY
    ld a, $FF
    ld [wLivingRoomShotgunPlaced], a
    ld a, [wSelectedPlayer]
    or a
    jr z, Label5B35 ;chris
	;if jill
    ld a, $FF
    ld [wc413], a
    jp scrollUpScreen
Label5B35
    ld a, $FF
    ld [wc41f], a
    jp scrollUpScreen

showKennethCorpseMsg:
    ld a, KENNETH_CORPSE_SCREEN ;$05
    ld [wRoomScreen], a
    call loadEventRoomScreen
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4009 ;He's Kenneth from the S.T.A.R.S. Bravo team...!
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld hl, text_pointer_400C ;Now he's become a mere shadow of his former self.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    jp scrollUpScreen

showSerumShelfMessage:
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4006 ;Vitamins and serums.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    jp scrollUpScreen

showDinningRoomEmblemMsg:
    ld a, [wDinningRoomGoldEmblemPlaced]
    or a
    jr nz, dinningRoomGoldEmblemPlaced
	;load dinning room wood emblem chinmey screen
    ld a, EMBLEM_CHINMEY_SCREEN ;$06
    ld [wRoomScreen], a
    call loadEventRoomScreen
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4024 ;It looks like a hollow to put something in.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    jp scrollUpScreen
dinningRoomGoldEmblemPlaced
    ld a, EMBLEM_CHINMEY_SCREEN ;$06
    ld [wRoomScreen], a
    call loadEventRoomScreen
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4027 ;An emblem is in place.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    jp scrollUpScreen

roomNormalCheckActions:
    ld a, [wRoomId]
    cp a, DINNING_ROOM_1F
    jp z, showDinningRoom1FActionMsg
    cp a, WEST_STOREROOM
    jp z, showSafeRoomActionMsg
    cp a, EXHIBITION_ROOM
    jp z, showExhibitionRoomActionMsg
    cp a, REST_STOP_CORRIDOR
    jp z, showRestStopCorridorActionMsg
    cp a, FIREARMS_ROOM
    jp z, checkFirearmsRoomDesk
    cp a, L_SHAPED_CORRIDOR
    jp z, showLShapedCorridorActionMsg
    cp a, EAST_STAIRS_CORRIDOR_1F
    jp z, showEastStairsCorridor1FActionMsg
    cp a, KEEPERS_ROOM
    jp z, showKeepersRoomActionMsg
    cp a, MANSION_BATHROOM
    jp z, showMansionBathroomActionMsg
    cp a, SHED_PASSAGE
    jp z, checkCrestPanelAction
    cp a, TIGER_STATUE_ROOM
    jp z, showTigerStatueActionMsg
    cp a, SHED_ROOM
    jp z, showShedActionMsg
    cp a, LIVING_ROOM
    jp z, showShotgunRoomActionMsg
    cp a, HALLWAY_TO_EAST_TERRACE
    jp z, showHallwayToEastTerraceActionMsg
    cp a, SMALL_DINNING_ROOM
    jp z, showSmallDinningRoomActionMsg
    cp a, ARMORS_ROOM
    jp z, showArmorsRoomActionMsg
    cp a, SMALL_LIBRARY
    jp z, showSmallLibraryActionMsg
    cp a, RESEARCHERS_PRIVATE_ROOM
    jp z, showResearchersRoomActionMsg
    cp a, TAXIDERMY_ROOM
    jp z, checkTaxidermyRoomLighs
    cp a, HIDDEN_LIBRARY
    jp z, checkHiddenLibraryLights
    cp a, COURTYARD_FLOODGATE
    jp z, showCourtyardFloodgateActionMsg
    cp a, WATERFALL_GARDEN
    jp z, showWaterfallGardenActionMsg
    cp a, DORM_001_BATHROOM
    jp z, showDorm001BathroomActionMsg
    cp a, AQUA_TANK_CONTROL_ROOM
    jp z, showAquaTankControlRoomActionMsg
    cp a, GUARDHOUSE_DORM_002
    jp z, showDorm002ActionMsg
    cp a, DORM_002_BATHROOM
    jp z, showDorm002BathroomActionMsg
    cp a, CHEMISTRY_ROOM
    jp z, showChemistryRoomActionMsg
    cp a, GUARDHOUSE_DORM_003
    jp z, checkDorm003ActionMsg
    cp a, AQUA_TANK_STOREROOM
    jp z, checkAquaTankStoreroomActionMsg
    cp a, VISUAL_DATA_ROOM
    jp z, checkVisualDataRoomActionbMsg
    cp a, SMALL_LAB
    jp z, checkLabComputer
    cp a, LAB_B3F_WEST_CORRIDOR
    jp z, checkLabPasscodePanel
    cp a, XRAY_ROOM
    jp z, checkXrayRoomActionMsg
    cp a, LAB_ELEVATOR_ENTRY
    jp z, Label647B
    cp a, POWER_ROOM_PASSAGE_1
    jp z, checkLabElevator
    cp a, LAB_POWER_ROOM
    jp z, checkPowerRoomActionMsg
    cp a, MAIN_LABORATORY
    jp z, checkTyrantRoomDoorSwitch
    cp a, LARGE_GALLERY
    jp z, checkLargeGalleryPaintings
    cp a, COURTYARD_STUDY
    jp z, checkMansionStudyLightSwitch
    ret
;5C82

showDinningRoom1FActionMsg: ;01:5C82
    ld a, [wCheckEventIdA]
    cp a, $F0
    jr z, Label5C9A
    cp a, $F1
    jr z, Label5CA0
    cp a, $F2
    jr z, Label5CA6
    cp a, $F3
    jr z, Label5CAC
    cp a, $F4
    jr z, Label5CB2
    ret
Label5C9A: ;01:5C9A
    ld hl, text_pointer_401B ;A grandfather clock is ticking.
    jp displayActionMessage
Label5CA0
    ld hl, text_pointer_402D ;There's nothing inside.
    jp displayActionMessage
Label5CA6
    ld hl, text_pointer_4021 ;It's dark outside and as silent as death.
    jp displayActionMessage
Label5CAC
    ld hl, text_pointer_4018 ;A picture of beautiful scenery.
    jp displayActionMessage
Label5CB2
    ld hl, text_pointer_4015 ;A picture of a woman.
    jp displayActionMessage

showSafeRoomActionMsg:
    ld a, [wCheckEventIdA]
    cp a, $F0
    jr z, Label5CC0
    ret
Label5CC0: ;01:5CC0
    ld hl, text_pointer_4006 ;Vitamins and serums.
    jp displayActionMessage

showExhibitionRoomActionMsg:
    ld a, [wCheckEventIdA]
    cp a, $F0
    jr z, Label5CE6
    cp a, $F1
    jr z, Label5CEC
    cp a, $F2
    jr z, Label5CF2
    cp a, $F3
    jr z, Label5CF8
    cp a, $F4
    jr z, Label5CFE
    cp a, $F5
    jr z, Label5D04
    cp a, $F6
    jr z, Label5D0A
    ret
Label5CE6: ;01:5CE6
    ld hl, text_pointer_4036 ;A picture of a fat woman.
    jp displayActionMessage
Label5CEC
    ld hl, text_pointer_400F ;Nothing unusual.
    jp displayActionMessage
Label5CF2
    ld hl, text_pointer_4030 ;A picture of a beautiful woman.
    jp displayActionMessage
Label5CF8
    ld hl, text_pointer_4033 ;A picture of steep scenery.
    jp displayActionMessage
Label5CFE
    ld hl, text_pointer_4039 ;Nothing special about this picture.
    jp displayActionMessage
Label5D04
    ld hl, text_pointer_403C ;A beautiful picture. That's all.
    jp displayActionMessage
Label5D0A
    ld hl, text_pointer_403F ;Incoherent pictures.
    jp displayActionMessage

showRestStopCorridorActionMsg:
    ld a, [wCheckEventIdA]
    cp a, $F0
    jr z, Label5D18
    ret
Label5D18: ;01:5D18
    ld hl, text_pointer_4012 ;It's ominously quiet outside.
    jp displayActionMessage

checkFirearmsRoomDesk:
    ld a, [wFirearmsRoomDeskEmpty]
    or a
    ret z
    ld a, [wFirearmsRoomDeskUnlocked]
    or a
    jr nz, Label5D75 ;jump is desk is unlocked
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4177 ;The desk is locked.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    call searchSmallKeyInInventory
    or a
    jp z, scrollUpScreen ;return if small key isn't found
    push hl ;store item slot id
    ld hl, text_pointer_417A ;Will you use the SMALL KEY Yes No
    call getMsgPointerAndShow
    pop hl
Label5D4A
    push hl
    call printChoiceArrow
    pop hl ;restore item slot id
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, Label5D4A
    call clearMessageBox
    ld a, [wChoiceId]
    or a
    jp nz, scrollUpScreen
	;remove small key
    ld [hl], EMPTY
    ld a, $FF
    ld [wFirearmsRoomDeskUnlocked], a
    ld hl, text_pointer_4174 ;You unlocked it.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    jr getFirearmsRoomDeskItem
Label5D75
    call scrollDownScreen
getFirearmsRoomDeskItem
    ld a, FIREARMS_ROOM_DESK_SCRN ;$03
    ld [wRoomScreen], a
    call loadEventRoomScreen
    ld hl, applyRoomOverlapToSprt
    call getMsgPointerAndShow
Label5D86
    push hl
    call printChoiceArrow
    pop hl
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, Label5D86
    push hl
    call clearMessageBox
    pop hl
    ld a, [wChoiceId]
    or a
    jp nz, scrollUpScreen
    xor a
    ld [wFirearmsRoomDeskEmpty], a
    jp scrollUpScreen

showLShapedCorridorActionMsg:
    ld a, [wCheckEventIdA]
    cp a, $F0
    jr z, Label5DB5
    cp a, $F1
    jr z, Label5DB5
    cp a, $F2
    jr z, Label5DB5
    ret
Label5DB5
    ld hl, text_pointer_4042 ;Creepy stuff.
    jp displayActionMessage

showEastStairsCorridor1FActionMsg:
    ld a, [wCheckEventIdA]
    cp a, $F0
    jr z, Label5DC3
    ret
Label5DC3: ;01:5DC3
    ld hl, text_pointer_4045 ;I wish I had time to enjoy these pictures...
    jp displayActionMessage

showKeepersRoomActionMsg:
    ld a, [wCheckEventIdA]
    cp a, $F0
    jr z, Label5DD5
    cp a, $F1
    jr z, Label5DDB
    ret
Label5DD5 ;01:5DD5
    ld hl, text_pointer_404B ;None of them looks useful.
    jp displayActionMessage
Label5DDB
    ld hl, text_pointer_400F ;Nothing unusual.
    jp displayActionMessage

showMansionBathroomActionMsg:
    ld a, [wCheckEventIdA]
    cp a, $F0
    jr z, Label5DE9
    ret
Label5DE9 ;01:5DE9
    ld hl, text_pointer_400F ;Nothing unusual.
    jp displayActionMessage

checkCrestPanelAction:
    ld a, CREST_PANEL_SCREEN ;$04
    ld [wRoomScreen], a
    call loadEventRoomScreen
    ld a, [wMoonCrestPlaced]
    or a
    jr z, crestsNotPlaced
    ld a, [wSunCrestPlaced]
    or a
    jr z, crestsNotPlaced
    ld a, [wStarCrestPlaced]
    or a
    jr z, crestsNotPlaced
    ld a, [wWindCrestPlaced]
    or a
    jr z, crestsNotPlaced
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_407E ;Crests are placed in all the hollows.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    jp scrollUpScreen
crestsNotPlaced
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4078 ;The sun sets in the  west, the moon rises in the east
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld hl, text_pointer_407B ;And when the stars begin to appear in the sky...
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    jp scrollUpScreen

showTigerStatueActionMsg:
    ld a, TIGER_STATUE_SCREEN ;$01
    ld [wRoomScreen], a
    call loadEventRoomScreen
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4048 ;It reads 'A tiger has red light and blue light.'
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    jp scrollUpScreen

showShedActionMsg:
    ld a, [wCheckEventIdA]
    cp a, $F2
    jr c, Label5E6C
    jr z, Label5E72
    ret
Label5E6C ;01:5E6C
    ld hl, text_pointer_4081 ;An old barrel.
    jp displayActionMessage
Label5E72
    ld hl, text_pointer_400F ;Nothing unusual.
    jp displayActionMessage

showShotgunRoomActionMsg:
    ld a, [wCheckEventIdA]
    cp a, $F0
    jr z, Label5E84
    cp a, $F1
    jr z, Label5E8A
    ret
Label5E84: ;01:5E84
    ld hl, text_pointer_404E ;A tapestry.
    jp displayActionMessage
Label5E8A
    ld hl, text_pointer_4054 ;An urn with a beautiful picture on it.
    jp displayActionMessage

showHallwayToEastTerraceActionMsg:
    ld a, [wCheckEventIdA]
    cp a, $F0
    jr z, Label5E98
    ret
Label5E98
    ld a, PICK_ITEM_ANIM ;$07
    ld [wSpriteAnimationId], a
    xor a
    ld [wSpriteAnimationFrameId], a
    call loadAndCalcEventSpritesData
    ld b, $80
    call routineDelay
    ld hl, text_pointer_409C ;I hope this blood isn't from my teammates...
    call displayActionMessage
    ld a, IDLE_ANIM ;$00
    ld [wSpriteAnimationId], a
    ret
;5EB5

showSmallDinningRoomActionMsg: ;01:5EB5
    ld a, [wCheckEventIdA]
    cp a, $F8
    jr z, Label5EBD
    ret
Label5EBD
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4096 ;A candle.
    ld a, [wCandleRoomLight]
    or a
    jr z, Label5ECF ;candle not litted
    ld hl, text_pointer_4099 ;The candle is lit.
Label5ECF
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    jp scrollUpScreen

showArmorsRoomActionMsg:
    ld a, [wCheckEventIdA]
    cp a, $FE
    jr z, Label5EE8
    ld hl, text_pointer_4087 ;Heavy-looking suits of armor.
    jp displayActionMessage
Label5EE8
    ld a, [wArmorsRoomGasButtonPushed]
    or a
    ret nz
    ld a, ARMORS_ROOM_BUTTON_SCRN ;$03
    ld [wRoomScreen], a
    call loadEventRoomScreen
    ld b, $40
    call routineDelay
    call clearMessageBox
    call scrollDownScreen
    call showSwitchBelowChoice
    or a
    jp nz, scrollUpScreen ;button not pushed
	;button pushed
    ld c, ARMORS_ROOM_STATUE_1 ;$E7
    call FindNPC
    or a
    jp z, scrollUpScreen ;return if statue not found
	;check statue position (x-pos $FEF0)
    ld hl, wSpritePositionXLow - wCharSpritesData ;$11
    add hl, de
    ld a, [hli]
    cp a, $F0
    jp nz, activateArmorsRoomPoisonGas
    ld a, [hl]
    cp a, $FE
    jp nz, activateArmorsRoomPoisonGas
    ld c, ARMORS_ROOM_STATUE_2 ;$E8
    call FindNPC
    or a
    jp z, scrollUpScreen ;return if statue not found
	;check statue position (y-pos $0000)
    ld hl, wSpritePositionZLow - wCharSpritesData ;$13
    add hl, de
    ld a, [hli]
    or a ;$00
    jp nz, activateArmorsRoomPoisonGas
    ld a, [hl]
    or a ;$00
    jp nz, activateArmorsRoomPoisonGas
    jr sunCrestShowcaseOpened
activateArmorsRoomPoisonGas
    ld a, $FF
    ld [wPoisonGasActivationByte], a
    ld a, $01
    ld [wLCDUpdate], a
    ld hl, text_pointer_4003 ;Something has happened!
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    jp scrollUpScreen
sunCrestShowcaseOpened
    ld hl, text_pointer_4003 ;Something has happened!
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld a, $FF
    ld [wArmorsRoomGasButtonPushed], a
    ld [wSunCrestShowcaseOpened], a
    jp scrollUpScreen

showSmallLibraryActionMsg:
    ld a, [wCheckEventIdA]
    cp a, $F0
    jr z, Label5F7D
    cp a, $F1
    jr z, Label5F83
    cp a, $F2
    jr z, Label5F89
    cp a, $F2
    jr z, Label5F89
    ret
Label5F7D ;01:5F7D
    ld hl, text_pointer_400F ;Nothing unusual.
    jp displayActionMessage
Label5F83
    ld hl, text_pointer_400F ;Nothing unusual.
    jp displayActionMessage
Label5F89
    ld hl, text_pointer_408D ;It's well arranged.
    jp displayActionMessage

showResearchersRoomActionMsg:
    ld a, [wCheckEventIdA]
    cp a, $F0
    jr z, Label5F9B
    cp a, $F8
    jr z, checkBugCollectionButton
    ret
Label5F9B
    ld hl, text_pointer_408D ;It's well arranged.
    jp displayActionMessage
checkBugCollectionButton
    ld a, [wBugCollectionButtonPushed]
    or a
    ret nz
    ld a, BUG_COLLECTION_SCREEN ;$02
    ld [wRoomScreen], a
    call loadEventRoomScreen
    ld b, $80
    call routineDelay
    call clearMessageBox
    call scrollDownScreen
    call showSwitchChoice
    or a
    jp nz, scrollUpScreen ;switch not pushed
    ld a, $FF
    ld [wBugCollectionButtonPushed], a
;find shelf sprite and movie it
    ld de, wNPCSpritesData
    ld b, $07
findShelfLoop
    ld hl, wSpriteId - wCharSpritesData ;$B
    add hl, de
    ld a, [hl]
    cp a, RESEARCHER_ROOM_SHELF ;$E6
    jr z, shelfFound
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld e, a
    dec b
    jr nz, findShelfLoop
;if shelf is not found, enter in an infinite loop
Label5FDE ;
    jr Label5FDE
shelfFound
;move shelf
    ld hl, wSpritePositionZLow - wCharSpritesData ;$13
    add hl, de
    ld bc, $FF60 ;shelf position
    ld [hl], c
    inc hl
    ld [hl], b
    xor a
    ld [wResearcherRoomShelfNotMoved], a
    ld a, $FF
    ld [wResearcherRoomShelfMoved], a
    ret
;5FF4

checkTaxidermyRoomLighs: ;01:5FF4
    ld a, [wCheckEventIdA]
    cp a, $F8
    jr z, Label5FFC
    ret
Label5FFC ;01:5FFC
    call clearMessageBox
    call scrollDownScreen
    call showSwitchChoice
    or a
    jp nz, scrollUpScreen
	;switch room light
    ld a, [wTaxidermyRoomLight]
    xor a, $FF
    ld [wTaxidermyRoomLight], a
    ld a, $01
    ld [wLCDUpdate], a
    jp scrollUpScreen

checkHiddenLibraryLights:
    ld a, [wCheckEventIdA]
    cp a, $F8
    jr z, Label6021
    ret
Label6021
    call clearMessageBox
    call scrollDownScreen
    call showSwitchChoice
    or a
    jp nz, scrollUpScreen
	;switch library lights
    ld a, [wLibraryStatueLightTrigger]
    xor a, $FF
    ld [wLibraryStatueLightTrigger], a
    jp scrollUpScreen

showCourtyardFloodgateActionMsg:
    ld a, [wRoomScreen]
    cp a, $01
    jr z, Label604E
    ld a, $03
    ld [wRoomScreen], a
    call loadEventRoomScreen
    ld hl, text_pointer_40A2 ;There's a square hole.
    jp displayActionMessage
Label604E
    ld a, [wTriggerCourtyardCascade]
    or a
    ret nz
    ld hl, text_pointer_40A5 ;A water passage. There's a ladder here.
    jp displayActionMessage

showWaterfallGardenActionMsg:
    ld a, [wCheckEventIdA]
    cp a, $F9
    jr z, Label6081
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_40AB ;The water is running from the upper water passage.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld hl, text_pointer_40AE ;There's something at the back.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    jp scrollUpScreen
Label6081
    ld hl, text_pointer_40B1 ;The battery is pulled out.
    jp displayActionMessage

showDorm001BathroomActionMsg:
    ld a, [wCheckEventIdA]
    cp a, $F0
    jr z, Label608F
    ret
Label608F
    ld hl, text_pointer_400F ;Nothing unusual.
    jp displayActionMessage

showAquaTankControlRoomActionMsg:
    ld a, [wCheckEventIdA]
    cp a, $F0
    jr z, Label60A7
    cp a, $F8
    jp z, checkControlRoomWaterLever
    cp a, $F9
    jp z, checkStoreroomDoorSwitch
    ret
Label60A7
    ld hl, text_pointer_400F ;Nothing unusual.
    jp displayActionMessage

checkControlRoomWaterLever:
    ld a, [wFloodedRoomsTrigger]
    or a
    ret nz
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_40EA ;There's a lever. Will you move it?  Yes No
    call getMsgPointerAndShow
Label60BE
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, Label60BE
    call clearMessageBox
    ld a, [wChoiceId]
    or a
    jp nz, scrollUpScreen
    ld a, $FF
    ld [wFloodedRoomsTrigger], a
    call loadEventRoomScreen
    jp scrollUpScreen

checkStoreroomDoorSwitch:
    ld a, [wFloodedRoomsTrigger]
    or a
    ret z
    ld a, [wAquaTankStoreroomDoorUnlocked]
    or a
    ret nz
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_40ED ;There's a button. Will you push it?  Yes No
    call getMsgPointerAndShow
Label60F3
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, Label60F3
    call clearMessageBox
    ld a, [wChoiceId]
    or a
    jp nz, scrollUpScreen
    ld hl, text_pointer_40F0 ;There was a sound from the room netxt door.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld a, $FF
    ld [wAquaTankStoreroomDoorUnlocked], a
    jp scrollUpScreen

showDorm002ActionMsg:
    ld hl, text_pointer_4075 ;It's too dark to see anything.
    jp displayActionMessage

showDorm002BathroomActionMsg:
    ld a, [wCheckEventIdA]
    cp a, $F0
    jr z, Label612D
    cp a, $F1
    jr z, Label6133
    ret
Label612D
    ld hl, text_pointer_400F ;Nothing unusual.
    jp displayActionMessage
Label6133
    ld hl, text_pointer_40BD ;No water is left.
    jp displayActionMessage

showChemistryRoomActionMsg:
    ld a, [wCheckEventIdA]
    cp a, $F8
    jp z, checkChemicalUMB2
    cp a, $F9
    jp z, checkChemicalUMB4
    cp a, $FA
    jp z, checkWaterSink
    cp a, $FB
    jp z, checkWallFormula
    ret

checkWallFormula: ;01:6151
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_40D2 ;Something is written on the wall.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld hl, text_pointer_40D5 ;Water=1 Red=2 Purple=3 Green=4
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld hl, text_pointer_40D8 ;1+2=3, 3+4=7, 2+4=6 6+7=13, 13+3=16
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    jp scrollUpScreen

checkWaterSink:
    call findEmptyBottle
    or a
    jp z, emptyBottleNotFound
    push hl
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_40C6 ;Will you put WATER to the empty bottle?  Yes No
    call getMsgPointerAndShow
Label6192
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, Label6192
    pop hl
    ld a, [wChoiceId]
    or a
    jp nz, scrollUpScreen
    ld [hl], WATER_BOTTLE ;$05
    call clearMessageBox
    jp scrollUpScreen

checkChemicalUMB2:
    call findEmptyBottle
    or a
    jp z, emptyBottleNotFound
    push hl
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_40C9 ;Will you put UMB2 to the empty bottle?  Yes No
    call getMsgPointerAndShow
Label61C0
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, Label61C0
    pop hl
    ld a, [wChoiceId]
    or a
    jp nz, scrollUpScreen
    ld [hl], UMB_NO2 ;$10
    call clearMessageBox
    jp scrollUpScreen

checkChemicalUMB4:
    call findEmptyBottle
    or a
    jp z, emptyBottleNotFound
    push hl
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_40CC ;Will you put UMB4 to the empty bottle?  Yes No
    call getMsgPointerAndShow
Label61EE
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, Label61EE
    pop hl
    ld a, [wChoiceId]
    or a
    jp nz, scrollUpScreen
    ld [hl], UMB_NO4 ;$21
    call clearMessageBox
    jp scrollUpScreen

emptyBottleNotFound:
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_40CF ;You need a container to obtain it.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    jp scrollUpScreen

findEmptyBottle: ;01:621D
    ld hl, ItemIdSlot1
    ld b, $06
    ld a, [wSelectedPlayer]
    or a
    jr z, Label622A
    ld b, $08
Label622A
    ld a, [hl]
    cp a, EMPTY_BOTTLE
    jr z, emptyBottleFound
    inc hl
    dec b
    jr nz, Label622A
;emptyBottleNotFound
    xor a
    ret
emptyBottleFound
    ld a, $FF
    ret
;6238

checkDorm003ActionMsg: ;01:6238
    ld a, [wCheckEventIdA]
    cp a, $F8
    jr z, Label6240
    ret
Label6240
    ld a, [wDorm003WhiteBookRemoved]
    or a
    jr z, Label6260
    ld a, [wDorm003RedBookPlaced] ;wDorm003RedBookPlaced
    or a
    ret nz
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_40E4 ;I wonder where the missing book is...
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    jp scrollUpScreen
Label6260
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_40DB ;A row of red books.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld hl, text_pointer_40DE ;There's one white book. Will you take it?  Yes No
    call getMsgPointerAndShow
Label6278
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, Label6278
    call clearMessageBox
    ld a, [wChoiceId]
    or a
    jp nz, scrollUpScreen
    ld a, $FF
    ld [wDorm003WhiteBookRemoved], a
    ld hl, text_pointer_40E1 ;Now a book is missing.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    jp scrollUpScreen

checkAquaTankStoreroomActionMsg:
    ld hl, text_pointer_40E7 ;They are all wet and useless.
    jp displayActionMessage

checkVisualDataRoomActionbMsg:
    ld a, [wCheckEventIdA]
    cp a, $F8
    jp z, checkPilarPushButton
    cp a, $F9
    jp z, checkProjector
    cp a, $FA
    jp z, checkWhiteboard
    ret
;62B9

checkPilarPushButton: ;01:62B9
    ld a, [wVisualDataRoomPanelButtonOpened]
    or a
    jr nz, Label62EA
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_40F3 ;There's a panel. Will you open it?  Yes No
    call getMsgPointerAndShow
Label62CB
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, Label62CB
    call clearMessageBox
    ld a, [wChoiceId]
    or a
    jp nz, scrollUpScreen
    ld a, $FF
    ld [wVisualDataRoomPanelButtonOpened], a
    call loadAndCalcEventSpritesData ;it should be reload room bg? %fix
    jp scrollUpScreen
Label62EA
    ld a, [wLabSlideRoomPillarMoved]
    or a
    ret nz
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_40F6 ;There's a switch. Will you push it?  Yes No
    call getMsgPointerAndShow
Label62FB
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, Label62FB
    call clearMessageBox
    ld a, [wChoiceId]
    or a
    jp nz, scrollUpScreen
    ld a, $FF
    ld [wLabSlideRoomPillarMoved], a
    ld [wc5b9], a
    call loadAndCalcEventSpritesData
    jp scrollUpScreen

checkProjector:
    ld a, [wProjectorSlidePlaced]
    or a
    jr z, Label633D
    ld a, WHITEBOARD_SCREEN ;$04
    ld [wRoomScreen], a
    call loadEventRoomScreen
	;load projector slides. glitched, unfinished %fix
    call loadProjectorSlide1 ;umbrella inc slide ?
    call loadProjectorSlide2 ;cerberus slide ?
    call loadProjectorSlide3 ;neptune slide ?
    call loadProjectorSlide4 ;hunter slide ?
    call loadProjectorSlide5 ;tyrant slide ?
				   ;research stall slide ?
    jp loadAndCalcEventSpritesData
Label633D
    ld hl, text_pointer_40F9 ;A projector.
    jp displayActionMessage

checkWhiteboard:
    ld a, WHITEBOARD_SCREEN ;$04
    ld [wRoomScreen], a
    call loadEventRoomScreen
    ld hl, text_pointer_40FC ;A screen.
    jp displayActionMessage

checkLabComputer:
    ld a, [wCheckEventIdA]
    cp a, $F8
    jp z, Label635A
    ret
Label635A: ;01:635A
    ld a, LAB_COMPUTER_SCREEN ;$04
    ld [wRoomScreen], a
    call loadEventRoomScreen
    ld b, $50
    call routineDelay
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_40FF ;This computer is used to unlock the electronic key.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld hl, text_pointer_4102 ;Will you turn it on?  Yes No
    call getMsgPointerAndShow
Label637F
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, Label637F
    call clearMessageBox
    ld a, [wChoiceId]
    or a
    jp nz, scrollUpScreen
    call scrollUpScreen
    ld a, COMPUTER_STARTUP_SFX ;$28
    call playSFX
    ld b, $0A
    call routineDelay
    call loadPreviewComputerScrnMask
    ld b, $50
    call routineDelay
    jp checkComputerLogin

checkLabPasscodePanel:
    ld a, [wCheckEventIdA]
    cp a, $F8
    jp z, checkPasscode01
    ret
checkPasscode01 ;01:63B4
    ld a, [wMoDiskPasscode01Filed]
    or a
    jr z, checkPasscode02
    ld a, [wPasscode01Enter]
    or a
    jr nz, checkPasscode02
    ld a, $FF
    ld [wPasscode01Enter], a
    jr showPasscodeEnteredMsg
checkPasscode02
    ld a, [wMoDiskPasscode02Filed]
    or a
    jr z, checkPasscode03
    ld a, [wPasscode02Enter]
    or a
    jr nz, checkPasscode03
    ld a, $FF
    ld [wPasscode02Enter], a
    jr showPasscodeEnteredMsg
checkPasscode03
    ld a, [wMoDiskPasscode03Filed]
    or a
    ret z
    ld a, [wPasscode03Enter]
    or a
    ret nz
    ld a, $FF
    ld [wPasscode03Enter], a
showPasscodeEnteredMsg
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_410E ;You've entered the pass code.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    call scrollUpScreen
;verify all passcodes
    ld a, [wPasscode01Enter]
    or a
    ret z
    ld a, [wPasscode02Enter]
    or a
    ret z
    ld a, [wPasscode03Enter]
    or a
    ret z
;unlock detention chamber passage door
    ld a, $FF
    ld [wDetentionChamberPassageDoorLock], a
    ret
;6413

checkXrayRoomActionMsg: ;01:6413
    ld a, [wCheckEventIdA]
    cp a, $F8
    jr z, checkBlueLightSwitch
    cp a, $F9
    jr z, checkNormalLightSwitch
    cp a, $FA
    jr z, checkXrayRoomPainting
    ret
checkBlueLightSwitch: ;01:6423
    ld a, [wXrayRoomBlueLight]
    or a
    ret nz ;ret if blue light is on
    call clearMessageBox
    call scrollDownScreen
    call showSwitchChoice
    or a
    jp nz, scrollUpScreen
	;turn on blue light
    ld a, $FF
    ld [wXrayRoomBlueLight], a
    ld a, $01
    ld [wLCDUpdate], a
    jp scrollUpScreen
checkNormalLightSwitch
    ld a, [wXrayRoomNormalLight]
    or a
    ret nz ;ret if normal light is on
    call clearMessageBox
    call scrollDownScreen
    call showSwitchChoice
    or a
    jp nz, scrollUpScreen
	;turn on normal light
    ld a, $FF
    ld [wXrayRoomNormalLight], a
    ld a, $01
    ld [wLCDUpdate], a
    jp scrollUpScreen
checkXrayRoomPainting
    ld c, XRAY_ROOM_PAINTING_REVEALED ;$03
    ld a, [wXrayRoomBlueLight]
    or a
    jr z, showXrayRoomPainting
    ld a, [wXrayRoomNormalLight]
    or a
    jr z, showXrayRoomPainting
    ld c, XRAY_ROOM_PAINTING ;$04
showXrayRoomPainting
    ld a, c
    ld [wRoomScreen], a
    call loadEventRoomScreen
    jp msgInputPressWaitLoop

Label647B:
    ld a, [wCheckEventIdA]
    cp a, $F8
    jp z, Label6484
    ret
Label6484: ;01:6484
    ld a, [wLabElevatorLock]
    or a
    ret nz
    call clearMessageBox
    call scrollDownScreen
    call showSwitchChoice
    or a
    jp nz, scrollUpScreen
    ld a, [wBlackOutAreasPowered]
    or a
    jr z, labElevatorNotPowered
    ld a, [wLabElevatorPowered]
    or a
    jr z, labElevatorNotPowered
    ld hl, text_pointer_4003 ;Something has happened!
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld a, $FF
    ld [wLabElevatorLock], a
    jp scrollUpScreen
labElevatorNotPowered
    ld hl, text_pointer_4111 ;There's no reaction. It has no power.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    jp scrollUpScreen

checkLabElevator:
    ld a, [wCheckEventIdA]
    cp a, $F8
    jp z, Label64CE
    ret
;64CE
Label64CE: ;01:64CE
    ld a, [wBlackOutAreasPowered]
    or a
    jr nz, Label650B
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4123 ;A power panel. Some areas do not get power.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld hl, text_pointer_4126 ;Will you activate the blacked-out areas? Yes No
    call getMsgPointerAndShow
Label64EC
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, $03
    jr z, Label64EC
    call clearMessageBox
    ld a, [wChoiceId]
    or a
    jp nz, scrollUpScreen
    ld a, $FF
    ld [wBlackOutAreasPowered], a
    call loadAndCalcEventSpritesData
    jp scrollUpScreen
Label650B
    ld hl, text_pointer_4129
    jp displayActionMessage

checkPowerRoomActionMsg:
    ld a, [wCheckEventIdA]
    cp a, $F8
    jp z, showSystemActivatorMsg
    cp a, $F9
    jp z, checkElevatorPowerSwitch
    ret
;651F
checkElevatorPowerSwitch: ;01:651F
    call clearMessageBox
    call scrollDownScreen
    ld a, [wLabElevatorPowered]
    or a
    jr nz, Label6556
    ld hl, text_pointer_4132 ;A power connection switch. The elevator power is off.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld hl, text_pointer_4135 ;Will you connect it?  Yes No
    call getMsgPointerAndShow
Label653D
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, Label653D
    call clearMessageBox
    ld a, [wChoiceId]
    or a
    jp nz, scrollUpScreen
    ld a, $FF
    ld [wLabElevatorPowered], a
Label6556
    ld hl, text_pointer_4138 ;The power to the elevator is on.
    jp displayActionMessage

showSystemActivatorMsg:
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_412C ;It's a triggering system activator.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld hl, text_pointer_412F ;It's quite big.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    jp scrollUpScreen

checkTyrantRoomDoorSwitch:
    ld a, [wCheckEventIdA]
    cp a, $F8
    jp z, Label6586
    ret
;6586
Label6586: ;01:6586
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_413E ;It looks like the control device for this room.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld a, [wTyrantRoomDoorLock] ;C47E
    or a
    jp nz, scrollUpScreen
    ld hl, text_pointer_4144 ;A door lock device. Will you unlock it?  Yes No
    call getMsgPointerAndShow
Label65A5
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, Label65A5
    call clearMessageBox
    ld a, [wChoiceId]
    or a
    jp nz, scrollUpScreen
    ld hl, text_pointer_4003 ;Something has happened!
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld a, $FF
    ld [wTyrant1Defeated], a
    ld [wTyrantRoomDoorLock], a
    jp scrollUpScreen

Label65D0:
    ld a, [wTyrantRoomDoorLock]
    or a
    jp nz, scrollUpScreen
    ld hl, text_pointer_4141 ;But there's no time to operate it!
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    jp scrollUpScreen

checkLargeGalleryPaintings:
    ld a, [wCheckEventIdA]
    cp a, $F8
    jr z, CheckTitlePainting
    cp a, $F9
    jr z, checkMidleAgeManPainting
    cp a, $FA
    jr z, checkNewbornBabyPainting
    cp a, $FB
    jr z, checkYoungManPainting
    cp a, $FC
    jp z, checkInfantPainting
    cp a, $FD
    jp z, checkLivelyBoyPainting
    cp a, $FE
    jp z, checkOldManPainting
    cp a, $F7
    jp z, checkFinalPainting
    ret
CheckTitlePainting ;01:660E
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4057 ;The title is 'Give me peaceful sleep'.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    jp scrollUpScreen
checkMidleAgeManPainting
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_405A ;A picture of a tired middle-aged man.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld hl, text_pointer_4072 ;There's a switch below. Will you push it?  Yes/No
    call getMsgPointerAndShow
    call checkPaintingSwitch
    call clearMessageBox
    jp scrollUpScreen
checkNewbornBabyPainting
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_405D ;A picture of a newborn baby.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld hl, text_pointer_4072 ;There's a switch below. Will you push it?  Yes/No
    call getMsgPointerAndShow
    call checkPaintingSwitch
    call clearMessageBox
    jp scrollUpScreen
checkYoungManPainting
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4060 ;A picture of a young man.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld hl, text_pointer_4072 ;There's a switch below. Will you push it?  Yes/No
    call getMsgPointerAndShow
    call checkPaintingSwitch
    call clearMessageBox
    jp scrollUpScreen

checkInfantPainting:
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4063 ;A picture of an infant.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld hl, text_pointer_4072 ;There's a switch below. Will you push it?  Yes/No
    call getMsgPointerAndShow
    call checkPaintingSwitch
    call clearMessageBox
    jp scrollUpScreen

checkLivelyBoyPainting:
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4066 ;A picture of a lively boy.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld hl, text_pointer_4072 ;There's a switch below. Will you push it?  Yes/No
    call getMsgPointerAndShow
    call checkPaintingSwitch
    call clearMessageBox
    jp scrollUpScreen

checkOldManPainting:
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4069 ;A picture of a bold-looking old man.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld hl, text_pointer_4072 ;There's a switch below. Will you push it?  Yes/No
    call getMsgPointerAndShow
    call checkPaintingSwitch
    call clearMessageBox
    jp scrollUpScreen

checkFinalPainting:
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_406C ;There's a message.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld hl, text_pointer_406F ;'Give me the peace of death, and I'll give you the joy of life...'
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld hl, text_pointer_4072 ;There's a switch below. Will you push it?  Yes/No
    call getMsgPointerAndShow
    call checkPaintingSwitch
    call clearMessageBox
    jp scrollUpScreen

checkPaintingSwitch:
    call haltCPU
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, checkPaintingSwitch
    ld a, [wChoiceId]
    or a
    ret nz
    ld a, [wCheckEventIdA]
    cp a, $F9
    jp z, midleAgeManPaintingSwitchOn
    cp a, $FA
    jp z, newBornPaintingSwitchOn
    cp a, $FB
    jp z, youngManPaintingSwitchOn
    cp a, $FC
    jp z, infantPaintingSwitchOn
    cp a, $FD
    jp z, livelyBoyPaintingSwitchOn
    cp a, $FE
    jp z, oldManPaintingSwitchOn
    cp a, $F7
    jp z, finalPaintingSwitchOn
    ret
;674F
midleAgeManPaintingSwitchOn: ;01:674F
    ld a, $FF
    ld [wMidleAgeManPaintingSwitch], a
    ld a, SWITCH_SFX ;$29
    jp playSFX
newBornPaintingSwitchOn:
    ld a, $FF
    ld [wNewBornBabyPaintingSwitch], a
    ld a, SWITCH_SFX ;$29
    jp playSFX
youngManPaintingSwitchOn:
    ld a, $FF
    ld [wYoungManPaintingSwitch], a
    ld a, SWITCH_SFX ;$29
    jp playSFX
infantPaintingSwitchOn:
    ld a, $FF
    ld [wInfantPaintingSwitch], a
    ld a, SWITCH_SFX ;$29
    jp playSFX
livelyBoyPaintingSwitchOn:
    ld a, $FF
    ld [wLivelyBoyPaintingSwitch], a
    ld a, SWITCH_SFX ;$29
    jp playSFX
oldManPaintingSwitchOn:
    ld a, $FF
    ld [wOldManPaintingSwitch], a
    ld a, SWITCH_SFX ;$29
    jp playSFX

finalPaintingSwitchOn:
    ld a, [wPaintingPuzzleSwitch]
    or a
    ret nz
;check all painting switches on, there's no order checking
    ld a, [wMidleAgeManPaintingSwitch]
    cp a, $FF
    jr nz, resetPaintingsSwitches
    ld a, [wNewBornBabyPaintingSwitch]
    cp a, $FF
    jr nz, resetPaintingsSwitches
    ld a, [wYoungManPaintingSwitch]
    cp a, $FF
    jr nz, resetPaintingsSwitches
    ld a, [wInfantPaintingSwitch]
    cp a, $FF
    jr nz, resetPaintingsSwitches
    ld a, [wLivelyBoyPaintingSwitch]
    cp a, $FF
    jr nz, resetPaintingsSwitches
    ld a, [wOldManPaintingSwitch]
    cp a, $FF
    jr nz, resetPaintingsSwitches
    ld a, $FF
    ld [wPaintingPuzzleSwitch], a
    ld a, $FF
    ld [wPaintingsRoomStarCrest], a
    ld a, [wRoomId]
    ld l, a
    ld a, [wRoomIdHigh]
    ld h, a
    add hl, hl
    add hl, hl
    ld de, RoomsBgLookupTable
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
    xor a
    ld [wLowColliderBottomY], a
    ld a, $10
    ld [wLowColliderTopY], a
    xor a
    ld [wLowColliderRightX], a
    ld a, $14
    ld [wLowColliderLeftX], a
    jp loadRoomBG
resetPaintingsSwitches
    xor a
    ld [wMidleAgeManPaintingSwitch], a
    ld [wNewBornBabyPaintingSwitch], a
    ld [wYoungManPaintingSwitch], a
    ld [wInfantPaintingSwitch], a
    ld [wLivelyBoyPaintingSwitch], a
    ld [wOldManPaintingSwitch], a
    ret
;67FE

checkMansionStudyLightSwitch: ;01:67FE
    ld a, [wCheckEventIdA]
    cp a, $F8
    jr z, Label6806
    ret
Label6806: ;01:6806
    ld a, [wMansionStudyLights]
    or a
    ret nz
    call clearMessageBox
    call scrollDownScreen
    call showSwitchChoice
    or a
    jp nz, scrollUpScreen
    ld a, $FF
    ld [wMansionStudyLights], a
    ld [wc5cc], a
    ld [wc5cd], a
    ld a, $01
    ld [wLCDUpdate], a
    jp scrollUpScreen

searchSmallKeyInInventory:
    ld hl, ItemIdSlot1
    ld b, $06 ;chris item slots
    ld a, [wSelectedPlayer]
    or a
    jr z, searchSmallKeyLoop
	;jill item slots
    ld b, $08
searchSmallKeyLoop
    ld a, [hl]
    cp a, SMALL_KEY_1
    jr z, smallKeyFound
    cp a, SMALL_KEY_2
    jr z, smallKeyFound
    cp a, SMALL_KEY_3
    jr z, smallKeyFound
    cp a, SMALL_KEY_4
    jr z, smallKeyFound
    cp a, SMALL_KEY_5
    jr z, smallKeyFound
    cp a, SMALL_KEY_6
    jr z, smallKeyFound
    inc hl
    dec b
    jr nz, searchSmallKeyLoop
	;small key not found
    xor a
    ret
smallKeyFound
    ld a, $FF
    ret
;685A

showDoorActionMessages: ;01:685A
    ld a, [wCheckEventIdB]
    cp a, $00
    jp z, dinningRoomDoorInvestigationMsg
    cp a, $20
    jp z, Label688C ;switch below message
    cp a, $35
    jp z, showPasscodePanel
    cp a, $3F
    jp z, showCourtyardElevatorMsg
    cp a, $5C
    jp z, showDorm002DoorEventMsg
    cp a, $60
    jp z, checkNumericPanel
    cp a, $72
    jp z, showNoPowerElevatorMsg
    cp a, $80
    jp z, checkTypewriter
    ret
;6886

dinningRoomDoorInvestigationMsg: ;01:6886
    ld hl, text_pointer_402A ;Investigation here is not over yet.
    jp displayActionMessage

Label688C:
    ld a, [wSelectedPlayer]
    or a ;chris
    jr z, Label6898
	;jill
    ld a, $FF
    ld [wc4db], a
    ret
Label6898: ;01:6898
    call clearMessageBox
    call scrollDownScreen
    call showSwitchBelowChoice
    or a
    jp nz, scrollUpScreen ;return if switch not pushed
	;if switch pushed
    ld a, $FF
    ld [wc420], a
    call goToLoadRoomBgMask
    ld hl, text_pointer_4003 ;Something has happened!
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    jp scrollUpScreen

showPasscodePanel:
    ld a, PASSCODE_PANEL_SCREEN ;$07
    ld [wRoomScreen], a
    call loadEventRoomScreen
    call scrollUpScreen ;it should be scrollDownScreen %fix
    call clearMessageBox
    ld hl, text_pointer_4108 ;A pass code panel.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld a, [wSelectedPlayer]
    or a
    jr z, dontHavePasscode ;chris
	;jill
    ld a, [wPasscodeTrigger]
    or a
    jr z, dontHavePasscode
    ld hl, text_pointer_410E ;You've entered the passcode
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld a, $FF
    ld [wPasscodeTrigger], a
    ld [wc435], a
    jp scrollUpScreen
dontHavePasscode
    ld hl, text_pointer_410B ;You don't have the passcode
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    jp scrollUpScreen

showCourtyardElevatorMsg:
    ld a, [wRoomId]
    cp a, WATERFALL_GARDEN
    jr z, Label6915
    ld hl, text_pointer_409F ;.A winch for the elevator. The elevator is down.
    jp displayActionMessage
Label6915
    ld hl, text_pointer_40B4 ;I've got to get power to the elevator.
    jp displayActionMessage

showDorm002DoorEventMsg:
    ld a, [wDorm002EventTrigger]
    or a
    jp nz, showDorm002LockedDoorMsg
    ld a, [wSelectedPlayer]
    or a
    jp z, showDorm002LockedDoorMsg ;if chris
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_40BA ;Voices can be heard from the other side of the door.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld a, $10
    ld [wEventId], a
    ld a, $FF
    ld [wDorm002EventTrigger], a
    jp scrollUpScreen

showBrokenNumericPanelMsg: ;6948
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4084 ;A numeric key panel.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld hl, text_pointer_40B7 ;It's broken.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    jp scrollUpScreen

checkNumericPanel: ;6969
    ld a, [wSelectedPlayer]
    or a ;chris
    jr z, showBrokenNumericPanelMsg
	;jill
    xor a
    ld [wNumericPanelKeyId], a
    ld a, NUMERIC_PANEL_SCREEN ;$05
    ld [wRoomScreen], a
    call loadEventRoomScreen
    ld de, wNumericPanelKey01Value
    ld b, $1B
    ld hl, defaultNumericPanelValues ;$69C0
setNumericPanelDefaultValues
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, setNumericPanelDefaultValues
    call goToLoadNumericPanelSprites
    call enableHDMA
    call swapOAMDMAopcode
    ld hl, text_pointer_40C0 ;There's a panel with number keys.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld hl, text_pointer_40C3 ;Will you push the keys?  Yes No
    call getMsgPointerAndShow
Label69A4
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, A_INPUT
    jr z, Label69A4
Label69AE
    ld a, [wButtonPressId]
    and a, A_INPUT
    jr nz, Label69AE
    ld a, [wChoiceId]
    or a
    ret nz
    call clearMessageBox
    jp numericPanelPuzzle
;69C0

defaultNumericPanelValues: ;69C0
	db $FF, $24, $44 ;key 1 value, posY, posX
	db $00, $24, $53 ;key 2
	db $00, $24, $62 ;key 3
	db $FF, $35, $44 ;key 4
	db $FF, $35, $53 ;key 5
	db $00, $35, $62 ;key 6
	db $FF, $45, $44 ;key 7
	db $00, $45, $53 ;key 8
	db $FF, $45, $62 ;key 9
;69DB

showDorm002LockedDoorMsg: ;01:69DB
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_416E ;It's locked.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld hl, text_pointer_4171 ;The plate says 002.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    jp scrollUpScreen

showNoPowerElevatorMsg:
    ld hl, text_pointer_4111 ;There's no reaction. It has no power.
    jp displayActionMessage

checkTypewriter: ;01:6A02
    call clearMessageBox
    call scrollDownScreen
    ld hl, text_pointer_4183 ;It's an old typewriter.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld hl, text_pointer_4189 ;You can save your progress with this.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    ld hl, text_pointer_418C ;Will you use the ink ribbon? Yes No
    call getMsgPointerAndShow
Label6A26
    call haltCPU
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, Label6A26
    ld a, [wChoiceId]
    or a
    jp nz, Label6A3F
    ld a, LOAD_SAVE_MENU_ACTION ;$02
    ld [wButtonAEventId], a
Label6A3F
    call clearMessageBox
    call scrollUpScreen
    ret
;6A46

clearComputerLogin: ;01:6A46
    ld hl, wComputerLoginChar01 ;wComputerLoginChar01
    jr Label6A4E
clearComputerPassword:
    ld hl, wComputerPasswordChar01 ;wComputerPasswordChar01
Label6A4E
    ld a, $20 ;space
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hl], $01
    xor a
    ld [wLoginPasswordLastCharId], a
    ret
;6A5B

checkComputerLogin: ;01:6A5B
    call loadmainFontsBold
    ld hl, wComputerKeyboardKeyId
    xor a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    call clearComputerLogin
    call clearComputerPassword
    call loadComputerKeyboardBg
    ld hl, text_pointer_4105 ;Accessing computer.
    call getMsgPointerAndShow
    ld hl, text_pointer_4147 ;$ Umbrella Corp.
    ld de, $0101
    ld a, BANK(text_pointer_4147) ;$FA
    call printTextAtPosition
    ld hl, text_pointer_414A ;Login:
    ld de, $0201
    ld a, BANK(text_pointer_414A) ;$FA
    call printTextAtPosition
Label6A8D
    call haltCPU
    call updateSelectedKeyboardKey
    ld a, [wComputerKeyboardKeyId]
    ld [wCompKeyboardKeyIdUpdated], a
    call checkKeySelectionInput
    ld a, [wComputerLoginEntered]
    or a
    jr z, printLogin
;printPassword
    ld bc, wComputerPasswordChar01
    ld hl, $030A
    ld a, $FA
    call printMessage
printLogin
    ld bc, wComputerLoginChar01
    ld hl, $0207
    ld a, $FA
    call printMessage
    ld a, [wButtonPressId]
    and a, B_INPUT
    jr z, Label6A8D
    call ResetPal
    call loadFontTiles
    ret
;6AC6

checkKeySelectionInput: ;01:6AC6
    call goToCheckKeyboardKeyInput
    ld a, [wButtonPressId]
    and a, A_INPUT
    jp nz, Label6AD6
    xor a
    ld [wAButtonPressDown], a
    ret
;6AD6

Label6AD6: ;01:6AD6
    ld hl, wAButtonPressDown
    ld a, [hl]
    or a
    ret nz
    ld [hl], $FF
    ld a, [wComputerKeyboardKeyId]
    ld e, a
    ld d, $00
    ld hl, keyboardLetters ;$6C41
    add hl, de ;add selected key offset
    ld a, [hl] ;get key value
    cp a, $00 ;ESC key
    jp z, keyboardESCKeySelected
    cp a, $01 ;ENTER key
    jp z, keyboardEnterKeySelected
    cp a, $02 ;Backspace key
    jp z, keyboardBackspaceKeySelected
	;if letter is input
    ld c, a
    ld a, [wLoginPasswordLastCharId]
    ld e, a
    ld d, $00
    call getCurrentKeyboardInputAddr
    add hl, de
    ld [hl], c ;set current input char
    ld a, [wLoginPasswordLastCharId]
    cp a, $03
    jr z, Label6B0F ;jump if last char
	;else, increment char id
    inc a
    ld [wLoginPasswordLastCharId], a
Label6B0F
    ld a, CONFIRM_SFX ;$02
    jp playSFX
;6B14

computerLogin: ;01:6B14
    db "JOHN"
computerPassword: ;01:6B18
	db "ADA "
ElectronicLocksPassword: ;01:6B1C
	db "MOLE"
;6B20

keyboardEnterKeySelected: ;01:6B20
    ld a, [wComputerLoginEntered]
    or a
    jp z, printEnterPasswordInput ;jump if login is not enter yet
	;if login & password are entered
;checkLogin
    ld hl, wComputerLoginChar01
    ld de, computerLogin ;$6B14
    ld b, $04
Label6B2F
    ld a, [de]
    cp a, [hl]
    jp nz, computerLoginIncorrect
    inc de
    inc hl
    dec b
    jr nz, Label6B2F
;checkComputerPassword
    ld hl, wComputerPasswordChar01
    ld de, computerPassword ;$6B18
    ld b, $04
Label6B41
    ld a, [de]
    cp a, [hl]
    jp nz, computerPasswordIncorrect
    inc de
    inc hl
    dec b
    jr nz, Label6B41
    xor a ;$00
    ld [wComputerPasswordMode], a
    jr computerLoginOkeyed
computerPasswordIncorrect:
    ld hl, wComputerPasswordChar01
    ld de, ElectronicLocksPassword ;$6B1C
    ld b, $04
Label6B59
    ld a, [de]
    cp a, [hl]
    jp nz, eLocksPasswordIncorrect
    inc de
    inc hl
    dec b
    jr nz, Label6B59
    ld a, $01
    ld [wComputerPasswordMode], a
    jr eLocksLoginOkeyed
computerLoginOkeyed
    ld a, [wElectronicLockUnlock1]
    or a
    jr nz, Label6BA4
    ld hl, text_pointer_4153 ;   LOGIN OKAYED
    ld de, $0401
    ld a, BANK(text_pointer_4153) ;$FA
    call printTextAtPosition
    call msgInputPressWaitLoop
    call clearComputerLoginText
    call clearComputerPassword
    jp checkFloorLocksSelection
eLocksLoginOkeyed
    ld a, [wElectronicLockUnlock2]
    or a
    jr nz, Label6BA4
    ld hl, text_pointer_4153 ;   LOGIN OKAYED
    ld de, $0401
    ld a, BANK(text_pointer_4153) ;$FA
    call printTextAtPosition
    call msgInputPressWaitLoop
    call clearComputerLoginText
    call clearComputerPassword
    jp checkFloorLocksSelection
Label6BA4
    ld hl, text_pointer_4159 ;      ERROR
    ld de, $0401
    ld a, BANK(text_pointer_4159) ;$FA
    call printTextAtPosition
    call msgInputPressWaitLoop
    call clearLoginResponse
    call clearComputerPassword
    ld a, OPEN_DOOR_SFX ;$04
    jp playSFX

printEnterPasswordInput:
    inc a
    ld [wComputerLoginEntered], a
    xor a
    ld [wLoginPasswordLastCharId], a
    ld hl, text_pointer_414D ;Password:
    ld de, $0301
    ld a, BANK(text_pointer_414D) ;$FA
    call printTextAtPosition
    ld a, OPEN_DOOR_SFX ;$04
    jp playSFX

eLocksPasswordIncorrect:
    ld hl, text_pointer_4156 ;      DENIED
    ld de, $401
    ld a, BANK(text_pointer_4156) ;$FA
    call printTextAtPosition
    call msgInputPressWaitLoop
    call clearLoginResponse
    call clearComputerPassword
    ld a, CURSOR_SFX ;$01
    jp playSFX

computerLoginIncorrect:
    ld hl, text_pointer_4150 ;   LOGIN DENIED
    ld de, $0401
    ld a, BANK(text_pointer_4150) ;$FA
    call printTextAtPosition
    call msgInputPressWaitLoop
    call clearComputerLoginText
    ld a, CONFIRM_SFX ;$02
    call playSFX
    pop hl
    jp checkComputerLogin

keyboardBackspaceKeySelected:
    ld a, [wLoginPasswordLastCharId]
    ld e, a
    ld d, $00
    call getCurrentKeyboardInputAddr
    add hl, de ;get last input char
    ld a, [hl]
    cp a, $20
    jr z, deletePreviousChar ;jump if last char is space
	;delete last char
    ld [hl], $20
    jr Label6C2A
deletePreviousChar
    ld a, [wLoginPasswordLastCharId]
    or a
    ret z ;return if first login-password char
	;else, delete previous input char
    dec hl
    ld [hl], $20
    ld a, [wLoginPasswordLastCharId]
    dec a
    ld [wLoginPasswordLastCharId], a
Label6C2A
    ld a, CLOSE_DOOR_SFX ;$05 ;(it should be a del or cancel sound %fix)
    jp playSFX

keyboardESCKeySelected:
    pop hl
    ld a, CANCEL_SFX ;$03
    jp playSFX

getCurrentKeyboardInputAddr:
;get current keyboard input
    ld hl, wComputerLoginChar01
    ld a, [wComputerLoginEntered]
    or a
    ret z ;return Login chars addr. if login is not enter
	;else, return password chars addr
    ld hl, wComputerPasswordChar01
    ret
;6C41

keyboardLetters: ;01:6C41
;00: ESC
;01: ENTER
;02: BS
	db $00
	db "ABCDEFGHIJKLMN"
	db $01
	db "OPQRSTU"
	db $01
	db "VWXYZ"
	db $02, $02, $01
;6C61

checkFloorLocksSelection: ;01:6C61
    xor a
    ld [wElectronicUnlockFloorSelectId], a
    ld hl, text_pointer_415C ;Select Floor
    ld de, $0101
    ld a, BANK(text_pointer_415C) ;$FA
    call printTextAtPosition
Label6C70
    call goToCheckELocksFloorSelectInput
    call haltCPU
    ld hl, text_pointer_415F ; B2
    ld de, $0301
    ld c, BANK(text_pointer_415F) ;$FA
    ld b, $00 ;B2 id
    call printFloorSelectionOption
    ld hl, text_pointer_4162 ; B3
    ld de, $0401
    ld c, BANK(text_pointer_4162) ;$FA
    ld b, $01 ;B3 id
    call printFloorSelectionOption
    ld hl, text_pointer_4165 ; Cancel
    ld de, $0501
    ld c, BANK(text_pointer_4165) ;$FA
    ld b, $02 ;cancel id
    call printFloorSelectionOption
    ld a, [wButtonPressId]
    and a, A_INPUT
    jr nz, Label6CB6
    ld a, [wButtonPressId]
    and a, B_INPUT
    jr z, Label6C70
Label6CAB
    call haltCPU
    ld a, [wButtonPressId]
    and a, A_INPUT
    jr nz, Label6CAB
    ret
Label6CB6: ;01:6CB6
    ld a, [wElectronicUnlockFloorSelectId]
    cp a, $02 ;cancel
    jp z, cancelFloorSelectionChoice ;$6D64
    cp a, $01 ;B3
    jr z, B3ChoiceSelected
B2ChoiceSelected
    call haltCPU
    ld a, [wButtonPressId]
    and a, A_INPUT
    jr nz, B2ChoiceSelected
    ld a, [wVisualDataRoomDoorLock]
    or a
    jp nz, Label6D70 ;jump if door is unlock
    ld a, [wComputerPasswordMode]
    or a
    jr z, Label6CE7 ;jump if password is "ADA" mode
	;if password is "MOLE" mode
    ld a, [wElectronicLockUnlock2]
    or a
    jp nz, Label6D70
    ld a, $FF
    ld [wElectronicLockUnlock2], a
    jr unlockVisualDataRoomDoor
Label6CE7
    ld a, [wElectronicLockUnlock1]
    or a
    jp nz, Label6D70
    ld a, $FF
    ld [wElectronicLockUnlock1], a
unlockVisualDataRoomDoor
    ld a, $FF
    ld [wVisualDataRoomDoorLock], a
    ld hl, text_pointer_4168 ;     Unlocked
    ld de, $401
    ld a, BANK(text_pointer_4168) ;$FA
    call printTextAtPosition
    call msgInputPressWaitLoop
    ld hl, text_pointer_416B
    ld de, $401
    ld a, BANK(text_pointer_416B) ;$FA
    call printTextAtPosition
    jr reloadPasswordInputTextbox
B3ChoiceSelected
    call haltCPU
    ld a, [wButtonPressId]
    and a, A_INPUT
    jr nz, B3ChoiceSelected
    ld a, [wLabResearcherRoomDoorLock]
    or a
    jp nz, Label6D70 ;jump if door is unlock
    ld a, [wComputerPasswordMode]
    or a
    jr z, Label6D38 ;jump if password is "ADA" mode
	;if password is "MOLE" mode
    ld a, [wElectronicLockUnlock2]
    or a
    jp nz, Label6D70
    ld a, $FF
    ld [wElectronicLockUnlock2], a
    jr unlockLabResearcherRoomDoor
Label6D38
    ld a, [wElectronicLockUnlock1]
    or a
    jp nz, Label6D70
    ld a, $FF
    ld [wElectronicLockUnlock1], a
unlockLabResearcherRoomDoor
    ld a, $FF
    ld [wLabResearcherRoomDoorLock], a
    ld hl, text_pointer_4168 ;     Verified
    ld de, $401
    ld a, BANK(text_pointer_4168) ;$FA
    call printTextAtPosition
    call msgInputPressWaitLoop
    ld hl, text_pointer_416B ;     Unlocked
    ld de, $401
    ld a, BANK(text_pointer_416B) ;$FA
    call printTextAtPosition
    jr reloadPasswordInputTextbox
cancelFloorSelectionChoice:
    call haltCPU
    ld a, [wButtonPressId]
    and a, A_INPUT
    jr nz, cancelFloorSelectionChoice
    jr reloadPasswordInputTextbox
Label6D70
    ld hl, text_pointer_4159 ;      ERROR
    ld de, $0101
    ld a, BANK(text_pointer_4159) ;$FA
    call printTextAtPosition
    call msgInputPressWaitLoop
reloadPasswordInputTextbox
    call clearComputerLoginText
    ld hl, text_pointer_4105 ;Accessing computer.
    call getMsgPointerAndShow
    ld hl, text_pointer_4147 ;$ Umbrella Corp.
    ld de, $101
    ld a, BANK(text_pointer_4147) ;$FA
    call printTextAtPosition
    ld hl, text_pointer_414A ;Login:
    ld de, $201
    ld a, BANK(text_pointer_414A) ;$FA
    call printTextAtPosition
    ld hl, text_pointer_414D ;Password:
    ld de, $301
    ld a, BANK(text_pointer_414D) ;$FA
    call printTextAtPosition
    ret
;6DA9

clearComputerLoginText: ;01:6DA9
    ld b, $05 ;lines to clear
Label6DAB
    push bc
    ld h, b
    ld l, $01
    ld bc, ClearOneTextLine ;$6486
    ld a, BANK(ClearOneTextLine) ;$FA
    call printMessage
    pop bc
    dec b
    jr nz, Label6DAB
    ret
;6DBC

clearLoginResponse: ;01:6DBC
    ld b, $02
Label6DBE
    push bc
    ld h, b
    inc h
    inc h
    inc h
    ld l, $01
    ld bc, ClearOneTextLine ;$6486
    ld a, BANK(ClearOneTextLine) ;$FA
    call printMessage
    pop bc
    dec b
    jr nz, Label6DBE
    ret
;6DD2

printFloorSelectionOption: ;01:6DD2
;b: option to eval
;c: text bank
    ld a, [wElectronicUnlockFloorSelectId]
    cp a, b
    jr z, printSelectedOption
;printUnselectedOption
    ld a, c
    jp printTextAtPosition
printSelectedOption
    ld a, c
    jp printHighlightedText

numericPanelPuzzle:
    call haltCPU
    call goToCheckNumericPanelInput
    call goToLoadNumericPanelSprites
    call enableHDMA
    call swapOAMDMAopcode
    ld a, [wButtonPressId]
    and a, B_INPUT
    ret nz ;retur if B input press
    ld hl, wNumericPanelKey01Value
    ld de, $3 ;key value offset
    ld b, $09
Label6DFD
    ld a, [hl]
    cp a, $FF
    jr nz, numericPanelPuzzle ;keep looping until all panel lights are on
    add hl, de
    dec b
    jr nz, Label6DFD
	;if numeric panel puzzle is solved
    ld a, $FF
    ld [wNumericPanelDoorUnlocked], a
    ld b, $32
    call routineDelay
    ld a, PANEL_PUZZLE_SOLVED_SFX ;$27
    call playSFX
    ld hl, text_pointer_4174 ;You unlocked it.
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    jp clearMessageBox

displayActionMessage: ;01:6E21
;hl: message table pointer
    push hl
    call clearMessageBox
    call scrollDownScreen
    pop hl
    call getMsgPointerAndShow
    call msgInputPressWaitLoop
    call clearMessageBox
    jp scrollUpScreen

displayFile: ;6E35
    call ResetPal
    call hideSprites
    call loadFontTiles
    ld a, $01
    ld [wLCDUpdate], a
    ld hl, $0000
    ld b, $07
clearScreenLoop
    push bc
    push hl
    ld bc, ClearTextboxText ;$63EE
    ld a, BANK(ClearTextboxText) ;$FA
    call printMessage
    pop hl
    inc h
    inc h
    inc h
    pop bc
    dec b
    jp nz, clearScreenLoop
    call haltCPU
    ld a, BANK(GreyPallete) ;$0C
    ld hl, GreyPallete ;$4E44
    call loadBGPal
    ld hl, FileTextsPointers ;$4877
    ld a, [wFileBookId]
    ld c, a
    add a
    add a
    ld b, a
    add a
    add a, b
    add a, c
    ld c, a
    ld a, [wFileBookmarkCursorPos]
    add a, c
    ld b, a
    add a
    add a, b
    ld c, a
    ld b, $00
    add hl, bc ;get file text address
    call printFileText
    call msgInputPressWaitLoop
    call ResetPal
    ret
;6E89

printFileText: ;01:6E89
    ld de, $0000
    call printTextAtPosition
    ret
;6E90

;switch choice messages, return choice value
showSwitchBelowChoice: ;01:6E90
    ld hl, text_pointer_4072 ;There's a switch below. Will you push it?  Yes/No
    jr Label6E98
showSwitchChoice:
    ld hl, text_pointer_408A ;There's a switch. Will you push it?. Yes No .
Label6E98
    call getMsgPointerAndShow
Label6E9B
    call printChoiceArrow
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr z, Label6E9B
Label6EA5
    ld a, [wButtonPressId]
    and a, AB_INPUT
    jr nz, Label6EA5
    call clearMessageBox
    ld a, [wChoiceId]
    ret
;6EB3

FindNPC: ;01:6EB3
;c: sprite id
    ld de, wNPCSpritesData
    ld b, $07
findNextNPC
    ld hl, wSpriteId - wCharSpritesData ;$B
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
    jr nz, findNextNPC
;NPCNotFound
    xor a
    ret
NPCFound
    ld a, $FF
    ret
;6ED0


INCLUDE "engine/multiplyDivision.asm"


RoomsBgLookupTable:: 	INCLUDE "engine/roomsBgLookupTable.asm" ;71B5
ScreensBgLookupTable:: 	INCLUDE "engine/screenBgLookupTable.asm" ;7385


SECTION "title",ROMX,BANK[$2]

TitleScreen:         INCBIN "gfx/title.2bpp" ;4000
TitleScreenPal:      INCBIN "gfx/title.pal" ;5790


PlayerSelectScreen:				INCBIN "gfx/tilemaps/PlayerSelectScreen.2bpp" ;57D8

ChrisAndJillPoliceCardInfo:		INCBIN "gfx/ChrisAndJillPoliceCardInfo.2bpp" ;5FE8

PlayerSelectScreenIndexes:		INCBIN "gfx/tilemaps/PlayerSelectScreenIndexes.2bpp" ;62D8

PlayerSelectScreenPallete:		INCBIN "gfx/tilemaps/PlayerSelectScreen.pal" ;677C

ChrisAndJillPoliceCardFaces:	INCBIN "gfx/ChrisAndJillPoliceCardFaces.2bpp" ;67FC
StarsPoliceCardExtraColors:		INCBIN "gfx/StarsPoliceCardExtraColors.2bpp" ;6AFC

ArrowCursor:		 			INCBIN "gfx/arrow_cursor.2bpp"	;00:6C7C
;6C9C
SaveMenuFontsTiles:				INCBIN "gfx/save_menu_fonts.2bpp" ;6C9C

;6EF1

SECTION "RoomsBgPalletes",ROMX,BANK[$3]

room_00_pallete:		INCBIN "gfx/rooms_pal/room_00_pallete.pal" ;4000
room_01_pallete:		INCBIN "gfx/rooms_pal/room_01_pallete.pal" ;4080
room_02_pallete:		INCBIN "gfx/rooms_pal/room_02_pallete.pal" ;4100
room_03_pallete:		INCBIN "gfx/rooms_pal/room_03_pallete.pal" ;4180
room_04_pallete:		INCBIN "gfx/rooms_pal/room_04_pallete.pal" ;4200
room_05_pallete:		INCBIN "gfx/rooms_pal/room_05_pallete.pal" ;4280
room_06_pallete:		INCBIN "gfx/rooms_pal/room_06_pallete.pal" ;4300
room_07_pallete:		INCBIN "gfx/rooms_pal/room_07_pallete.pal" ;4380
room_08_pallete:		INCBIN "gfx/rooms_pal/room_08_pallete.pal" ;4400
room_09_pallete:		INCBIN "gfx/rooms_pal/room_09_pallete.pal" ;4480
room_0A_pallete:		INCBIN "gfx/rooms_pal/room_0A_pallete.pal" ;4500
room_0B_pallete:		INCBIN "gfx/rooms_pal/room_0B_pallete.pal" ;4580
room_0C_pallete:		INCBIN "gfx/rooms_pal/room_0C_pallete.pal" ;4600
room_0D_pallete:		INCBIN "gfx/rooms_pal/room_0D_pallete.pal" ;4680
room_0E_pallete:		INCBIN "gfx/rooms_pal/room_0E_pallete.pal" ;4700
room_0F_pallete:		INCBIN "gfx/rooms_pal/room_0F_pallete.pal" ;4780
room_10_pallete:		INCBIN "gfx/rooms_pal/room_10_pallete.pal" ;4800
room_11_pallete:		INCBIN "gfx/rooms_pal/room_11_pallete.pal" ;4880
room_12_pallete:		INCBIN "gfx/rooms_pal/room_12_pallete.pal" ;4900
room_13_pallete:		INCBIN "gfx/rooms_pal/room_13_pallete.pal" ;4980
room_14_pallete:		INCBIN "gfx/rooms_pal/room_14_pallete.pal" ;4A00
room_15_pallete:		INCBIN "gfx/rooms_pal/room_15_pallete.pal" ;4A80
room_16_pallete:		INCBIN "gfx/rooms_pal/room_16_pallete.pal" ;4B00
room_17_pallete:		INCBIN "gfx/rooms_pal/room_17_pallete.pal" ;4B80
room_18_pallete:		INCBIN "gfx/rooms_pal/room_18_pallete.pal" ;4C00
room_19_pallete:		INCBIN "gfx/rooms_pal/room_19_pallete.pal" ;4C80
room_1A_pallete:		INCBIN "gfx/rooms_pal/room_1A_pallete.pal" ;4D00
room_1B_pallete:		INCBIN "gfx/rooms_pal/room_1B_pallete.pal" ;4D80
room_1C_pallete:		INCBIN "gfx/rooms_pal/room_1C_pallete.pal" ;4E00
room_1D_pallete:		INCBIN "gfx/rooms_pal/room_1D_pallete.pal" ;4E80
room_1E_pallete:		INCBIN "gfx/rooms_pal/room_1E_pallete.pal" ;4F00
room_1F_pallete:		INCBIN "gfx/rooms_pal/room_1F_pallete.pal" ;4F80
room_20_pallete:		INCBIN "gfx/rooms_pal/room_20_pallete.pal" ;5000
room_21_pallete:		INCBIN "gfx/rooms_pal/room_21_pallete.pal" ;5080
room_22_pallete:		INCBIN "gfx/rooms_pal/room_22_pallete.pal" ;5100
room_23_pallete:		INCBIN "gfx/rooms_pal/room_23_pallete.pal" ;5180
room_23_gas_pallete:	INCBIN "gfx/rooms_pal/room_23_gas_pallete.pal" ;5200
room_24_pallete:		INCBIN "gfx/rooms_pal/room_24_pallete.pal" ;5280
room_25_pallete:		INCBIN "gfx/rooms_pal/room_25_pallete.pal" ;5300
room_26_pallete:		INCBIN "gfx/rooms_pal/room_26_pallete.pal" ;5380
room_27_pallete:		INCBIN "gfx/rooms_pal/room_27_pallete.pal" ;5400
room_28_pallete:		INCBIN "gfx/rooms_pal/room_28_pallete.pal" ;5480
room_29_pallete:		INCBIN "gfx/rooms_pal/room_29_pallete.pal" ;5500
room_2A_pallete:		INCBIN "gfx/rooms_pal/room_2A_pallete.pal" ;5580
room_2B_pallete:		INCBIN "gfx/rooms_pal/room_2B_pallete.pal" ;5600
room_2C_pallete:		INCBIN "gfx/rooms_pal/room_2C_pallete.pal" ;5680
room_2D_pallete:		INCBIN "gfx/rooms_pal/room_2D_pallete.pal" ;5700
room_2E_pallete:		INCBIN "gfx/rooms_pal/room_2E_pallete.pal" ;5780
room_2F_pallete:		INCBIN "gfx/rooms_pal/room_2F_pallete.pal" ;5800
room_30_pallete:		INCBIN "gfx/rooms_pal/room_30_pallete.pal" ;5880
room_31_pallete:		INCBIN "gfx/rooms_pal/room_31_pallete.pal" ;5900
room_32_pallete:		INCBIN "gfx/rooms_pal/room_32_pallete.pal" ;5980
room_33_pallete:		INCBIN "gfx/rooms_pal/room_33_pallete.pal" ;5A00
room_34_pallete:		INCBIN "gfx/rooms_pal/room_34_pallete.pal" ;5A80
room_35_pallete:		INCBIN "gfx/rooms_pal/room_35_pallete.pal" ;5B00
room_36_pallete:		INCBIN "gfx/rooms_pal/room_36_pallete.pal" ;5B80
room_37_pallete:		INCBIN "gfx/rooms_pal/room_37_pallete.pal" ;5C00
room_38_pallete:		INCBIN "gfx/rooms_pal/room_38_pallete.pal" ;5C80
room_39_pallete:		INCBIN "gfx/rooms_pal/room_39_pallete.pal" ;5D00
room_3A_pallete:		INCBIN "gfx/rooms_pal/room_3A_pallete.pal" ;5D80
room_3B_pallete:		INCBIN "gfx/rooms_pal/room_3B_pallete.pal" ;5E00
room_3C_pallete:		INCBIN "gfx/rooms_pal/room_3C_pallete.pal" ;5E80
room_3D_pallete:		INCBIN "gfx/rooms_pal/room_3D_pallete.pal" ;5F00
room_3E_pallete:		INCBIN "gfx/rooms_pal/room_3E_pallete.pal" ;5F80
room_3F_pallete:		INCBIN "gfx/rooms_pal/room_3F_pallete.pal" ;6000
room_40_pallete:		INCBIN "gfx/rooms_pal/room_40_pallete.pal" ;6080
room_41_pallete:		INCBIN "gfx/rooms_pal/room_41_pallete.pal" ;6100
room_42_pallete:		INCBIN "gfx/rooms_pal/room_42_pallete.pal" ;6180
room_43_pallete:		INCBIN "gfx/rooms_pal/room_43_pallete.pal" ;6200
room_44_pallete:		INCBIN "gfx/rooms_pal/room_44_pallete.pal" ;6280
room_45_pallete:		INCBIN "gfx/rooms_pal/room_45_pallete.pal" ;6300
room_46_pallete:		INCBIN "gfx/rooms_pal/room_46_pallete.pal" ;6380
room_47_pallete:		INCBIN "gfx/rooms_pal/room_47_pallete.pal" ;6400
room_48_pallete:		INCBIN "gfx/rooms_pal/room_48_pallete.pal" ;6480
room_49_pallete:		INCBIN "gfx/rooms_pal/room_49_pallete.pal" ;6500
room_4A_pallete:		INCBIN "gfx/rooms_pal/room_4A_pallete.pal" ;6580
room_4B_pallete:		INCBIN "gfx/rooms_pal/room_4B_pallete.pal" ;6600
room_4C_pallete:		INCBIN "gfx/rooms_pal/room_4C_pallete.pal" ;6680
room_4D_pallete:		INCBIN "gfx/rooms_pal/room_4D_pallete.pal" ;6700
room_4E_pallete:		INCBIN "gfx/rooms_pal/room_4E_pallete.pal" ;6780
room_4F_pallete:		INCBIN "gfx/rooms_pal/room_4F_pallete.pal" ;6800
room_50_pallete:		INCBIN "gfx/rooms_pal/room_50_pallete.pal" ;6880
room_51_pallete:		INCBIN "gfx/rooms_pal/room_51_pallete.pal" ;6900
room_52_pallete:		INCBIN "gfx/rooms_pal/room_52_pallete.pal" ;6980
room_53_pallete:		INCBIN "gfx/rooms_pal/room_53_pallete.pal" ;6A00
room_54_pallete:		INCBIN "gfx/rooms_pal/room_54_pallete.pal" ;6A80
room_55_pallete:		INCBIN "gfx/rooms_pal/room_55_pallete.pal" ;6B00
room_56_pallete:		INCBIN "gfx/rooms_pal/room_56_pallete.pal" ;6B80
room_57_pallete:		INCBIN "gfx/rooms_pal/room_57_pallete.pal" ;6C00
room_58_pallete:		INCBIN "gfx/rooms_pal/room_58_pallete.pal" ;6C80
room_59_pallete:		INCBIN "gfx/rooms_pal/room_59_pallete.pal" ;6D00
room_5A_pallete:		INCBIN "gfx/rooms_pal/room_5A_pallete.pal" ;6D80
room_5B_pallete:		INCBIN "gfx/rooms_pal/room_5B_pallete.pal" ;6E00
room_5C_pallete:		INCBIN "gfx/rooms_pal/room_5C_pallete.pal" ;6E80
room_5D_pallete:		INCBIN "gfx/rooms_pal/room_5D_pallete.pal" ;6F00
room_5E_pallete:		INCBIN "gfx/rooms_pal/room_5E_pallete.pal" ;6F80
room_5F_pallete:		INCBIN "gfx/rooms_pal/room_5F_pallete.pal" ;7000
room_60_pallete:		INCBIN "gfx/rooms_pal/room_60_pallete.pal" ;7080
room_61_pallete:		INCBIN "gfx/rooms_pal/room_61_pallete.pal" ;7100
room_62_pallete:		INCBIN "gfx/rooms_pal/room_62_pallete.pal" ;7180
room_63_pallete:		INCBIN "gfx/rooms_pal/room_63_pallete.pal" ;7200
room_64_pallete:		INCBIN "gfx/rooms_pal/room_64_pallete.pal" ;7280
room_65_pallete:		INCBIN "gfx/rooms_pal/room_65_pallete.pal" ;7300
room_66_pallete:		INCBIN "gfx/rooms_pal/room_66_pallete.pal" ;7380
room_67_pallete:		INCBIN "gfx/rooms_pal/room_67_pallete.pal" ;7400
room_68_pallete:		INCBIN "gfx/rooms_pal/room_68_pallete.pal" ;7480
room_69_pallete:		INCBIN "gfx/rooms_pal/room_69_pallete.pal" ;7500
room_6A_pallete:		INCBIN "gfx/rooms_pal/room_6A_pallete.pal" ;7580
room_6B_pallete:		INCBIN "gfx/rooms_pal/room_6B_pallete.pal" ;7600
room_6C_pallete:		INCBIN "gfx/rooms_pal/room_6C_pallete.pal" ;7680
room_6D_pallete:		INCBIN "gfx/rooms_pal/room_6D_pallete.pal" ;7700
room_6E_pallete:		INCBIN "gfx/rooms_pal/room_6E_pallete.pal" ;7780
room_6F_pallete:		INCBIN "gfx/rooms_pal/room_6F_pallete.pal" ;7800
room_70_pallete:		INCBIN "gfx/rooms_pal/room_70_pallete.pal" ;7880
room_71_pallete:		INCBIN "gfx/rooms_pal/room_71_pallete.pal" ;7900
room_72_pallete:		INCBIN "gfx/rooms_pal/room_72_pallete.pal" ;7980
room_73_pallete:		INCBIN "gfx/rooms_pal/room_73_pallete.pal" ;7A00
;7A80


loadRoomPallete: ;03:7A80
;hl: pallete pointer
    push de
    ld c, $00
    ld b, $20  ; pal counter
.loopFA85
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
	;check dark rooms
    ld a, [wRoomId]
    cp a, SMALL_DINNING_ROOM
    jp z, .setCandleRoomDarkTone ;LabelFAA7
    cp a, TAXIDERMY_ROOM
    jp z, .setRedJewelRoomDarkTone ;LabelFAC1
    cp a, COURTYARD_STUDY
    jp z, .setWolfMedalRoomDarkTone ;LabelFADB
    cp a, XRAY_ROOM
    jp z, .setLabPaintingRoomDarkTone ;LabelFAF5
;default pallete tone
.LabelFAA0
    ld a, [wLCDUpdate]
    and a, $1F
    jr .LabelFB16
.setCandleRoomDarkTone ;LabelFAA7
    ld a, [wCandleRoomLight]
    or a
    jp nz, .LabelFAA0 ;if candle room light is on, set default light
    ld a, [wLCDUpdate]
    and a, $1F
    push hl
    ld l, a
    srl a
    srl a
    ld h, a
    ld a, l
    sub a, h
    add a, $08
    pop hl
    jr .LabelFB16
.setRedJewelRoomDarkTone ;LabelFAC1
    ld a, [wTaxidermyRoomLight]
    or a
    jp z, .LabelFAA0 ;if red jewel room light is on, set default light
    ld a, [wLCDUpdate]
    and a, $1F
    push hl
    ld l, a
    srl a
    srl a
    ld h, a
    ld a, l
    sub a, h
    add a, $08
    pop hl
    jr .LabelFB16
.setWolfMedalRoomDarkTone ;LabelFADB
    ld a, [wMansionStudyLights]
    or a
    jp nz, .LabelFAA0 ;if wolf medal room light is on, set default light
    ld a, [wLCDUpdate]
    and a, $1F
    push hl
    ld l, a
    srl a
    srl a
    ld h, a
    ld a, l
    sub a, h
    add a, $08
    pop hl
    jr .LabelFB16
.setLabPaintingRoomDarkTone ;LabelFAF5
    ld a, [wXrayRoomBlueLight]
    or a
    jp z, .LabelFB03
    ld a, [wXrayRoomBlueLight]
    or a
    jp nz, .LabelFAA0
.LabelFB03
    ld a, [wLCDUpdate]
    and a, $1F
    push hl
    ld l, a
    srl a
    srl a
    ld h, a
    ld a, l
    sub a, h
    add a, $08
    pop hl
    jr .LabelFB16
.LabelFB16
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
    jp nz, .loopFA85
    pop hl
    ld c, $00
    ld b, $20
.loopFB36
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
    jr nz, .loopFB36
    ret

	db "BANK3"

;7B5A end of bank

SECTION "bank4", ROMX,BANK[$4]

room_item_sprite_01:		INCBIN "gfx/room_items_sprites/room_item_sprite_01.2bpp" ;4000
room_item_sprite_02:		INCBIN "gfx/room_items_sprites/room_item_sprite_02.2bpp" ;4040
room_item_sprite_03:		INCBIN "gfx/room_items_sprites/room_item_sprite_03.2bpp" ;4080
room_item_sprite_04:		INCBIN "gfx/room_items_sprites/room_item_sprite_04.2bpp" ;40A0
room_item_sprite_05:		INCBIN "gfx/room_items_sprites/room_item_sprite_05.2bpp" ;40C0
room_item_sprite_06:		INCBIN "gfx/room_items_sprites/room_item_sprite_06.2bpp" ;40E0
room_item_sprite_07:		INCBIN "gfx/room_items_sprites/room_item_sprite_07.2bpp" ;4100
room_item_sprite_08:		INCBIN "gfx/room_items_sprites/room_item_sprite_08.2bpp" ;4120
room_item_sprite_09:		INCBIN "gfx/room_items_sprites/room_item_sprite_09.2bpp" ;4140
room_item_sprite_10:		INCBIN "gfx/room_items_sprites/room_item_sprite_10.2bpp" ;4180
room_item_sprite_11:		INCBIN "gfx/room_items_sprites/room_item_sprite_11.2bpp" ;41A0
room_item_sprite_12:		INCBIN "gfx/room_items_sprites/room_item_sprite_12.2bpp" ;41C0
room_item_sprite_13:		INCBIN "gfx/room_items_sprites/room_item_sprite_13.2bpp" ;41E0
room_item_sprite_14:		INCBIN "gfx/room_items_sprites/room_item_sprite_14.2bpp" ;4200
room_item_sprite_15:		INCBIN "gfx/room_items_sprites/room_item_sprite_15.2bpp" ;4220
room_item_sprite_16:		INCBIN "gfx/room_items_sprites/room_item_sprite_16.2bpp" ;4260
room_item_sprite_17:		INCBIN "gfx/room_items_sprites/room_item_sprite_17.2bpp" ;42A0
room_item_sprite_18:		INCBIN "gfx/room_items_sprites/room_item_sprite_18.2bpp" ;42C0
room_item_sprite_19:		INCBIN "gfx/room_items_sprites/room_item_sprite_19.2bpp" ;43A0
room_item_sprite_20:		INCBIN "gfx/room_items_sprites/room_item_sprite_20.2bpp" ;43C0
room_item_sprite_21:		INCBIN "gfx/room_items_sprites/room_item_sprite_21.2bpp" ;43E0
room_item_sprite_22:		INCBIN "gfx/room_items_sprites/room_item_sprite_22.2bpp" ;4420
room_item_sprite_23:		INCBIN "gfx/room_items_sprites/room_item_sprite_23.2bpp" ;4440
room_item_sprite_24:		INCBIN "gfx/room_items_sprites/room_item_sprite_24.2bpp" ;4460
room_item_sprite_25:		INCBIN "gfx/room_items_sprites/room_item_sprite_25.2bpp" ;4500
room_item_sprite_26:		INCBIN "gfx/room_items_sprites/room_item_sprite_26.2bpp" ;4540
room_item_sprite_27:		INCBIN "gfx/room_items_sprites/room_item_sprite_27.2bpp" ;4580
room_item_sprite_28:		INCBIN "gfx/room_items_sprites/room_item_sprite_28.2bpp" ;45C0
room_item_sprite_29:		INCBIN "gfx/room_items_sprites/room_item_sprite_29.2bpp" ;4600
room_item_sprite_30:		INCBIN "gfx/room_items_sprites/room_item_sprite_30.2bpp" ;4640
room_item_sprite_31:		INCBIN "gfx/room_items_sprites/room_item_sprite_31.2bpp" ;4680
room_item_sprite_32:		INCBIN "gfx/room_items_sprites/room_item_sprite_32.2bpp" ;46C0
room_item_sprite_33:		INCBIN "gfx/room_items_sprites/room_item_sprite_33.2bpp" ;4700
room_item_sprite_34:		INCBIN "gfx/room_items_sprites/room_item_sprite_34.2bpp" ;4720
room_item_sprite_35:		INCBIN "gfx/room_items_sprites/room_item_sprite_35.2bpp" ;4740
room_item_sprite_36:		INCBIN "gfx/room_items_sprites/room_item_sprite_36.2bpp" ;4760
;4780

REPT $280
	db $00
ENDR

;4A00

loadItemboxCursor: ;04:4A00
    ld hl, wOAMBufferC9+$60 ;$C960
    call selectOAMDataDest
    ld a, [wSelectedItemBoxSlotId]
    add a, $2C ;add cursor x-pos offset
    ld c, a
    ld [hl], $58 ;y-pos
    inc l
    ld [hl], c ;x-pos
    inc l
    ld [hl], $38 ;tileId
    inc l
    ld [hl], $01 ;palId
    inc l
;create cursor sprite
    ld hl, wSpriteTilesBufferCE+$80 ;$ce80
    ld c, $05
Label10A1C
    ld [hl], $C0
    inc hl
    ld [hl], $00
    inc hl
    inc de
    dec c
    jr nz, Label10A1C
    ld c, $0B
Label10A28
    ld [hl], $00
    inc hl
    ld [hl], $00
    inc hl
    inc de
    dec c
    jr nz, Label10A28
    ret
;4A33

applySprtWaterEffect: ;04:4A33
    ld a, [wFloodedRoomsTrigger]
    or a
    ret nz ;return if flooded rooms trigger is off
    ld a, [wRoomId]
    cp a, AQUA_TANK_ROOM
    jr z, .Label10A48
    cp a, AQUA_TANK_CONTROL_ROOM
    jr z, .Label10A48
    cp a, PLANT_42_ROOTS_ROOM
    jr z, .Label10A48
    ret
.Label10A48
    ld a, [wSprtPriorHeight]
    srl a
    ld b, a
    ld a, [wSprtPriorHeight]
    sub a, b
    add a
    add a, l
    ld l, a
    ld a, $00
    adc a, h
    ld h, a
    ld c, $04
.loop10A5B
    push bc
    push hl
    ld a, [wSprtPriorHeight]
    srl a
    ld b, a
    ld c, $AA
.loop10A65
    ld a, [hl]
    and a, c
    ld [hli], a
    ld a, [hl]
    and a, c
    ld [hli], a
    ld a, c
    xor a, $FF
    ld c, a
    dec b
    jr nz, .loop10A65
    pop hl
    ld a, [wSprtPriorHeight]
    and a, $F0
    ld c, a
    ld a, [wSprtPriorHeight]
    and a, $0F
    jr z, .Label10A84
    ld a, c
    add a, $10
    ld c, a
.Label10A84
    sla c
    ld b, $00
    add hl, bc
    pop bc
    dec c
    jr nz, .loop10A5B
    ret
;4A8E

checkELocksFloorSelectInput: ;04:4A8E
    ld a, [wButtonPressId]
    and a, UP_INPUT
    jp nz, checkELocksFloorSelectUpInput
    xor a
    ld [wUpKeyPressDown], a
    ld a, [wButtonPressId]
    and a, DOWN_INPUT
    jp nz, checkELocksFloorSelectDownInput
    xor a
    ld [wDownKeyPressDown], a
    ret
;4AA7

checkELocksFloorSelectUpInput: ;04:4AA7
    ld hl, wUpKeyPressDown
    ld a, [hl]
    or a
    ret nz
    ld [hl], $FF
    ld a, [wElectronicUnlockFloorSelectId]
    or a
    ret z
    dec a
    ld [wElectronicUnlockFloorSelectId], a
    ld a, SWITCH_SFX ;$29
    jp playSFX

checkELocksFloorSelectDownInput:
    ld hl, wDownKeyPressDown
    ld a, [hl]
    or a
    ret nz
    ld [hl], $FF
    ld a, [wElectronicUnlockFloorSelectId]
    cp a, $02
    ret z
    inc a
    ld [wElectronicUnlockFloorSelectId], a
    ld a, SWITCH_SFX ;$29
    jp playSFX
;4AD4

checkKeyboardKeyInput: ;04:4AD4
    ld a, [wButtonPressId]
    and a, LEFT_INPUT
    jp nz, checkKeyboardLeftInput
    xor a
    ld [wTurnLeftTimer], a
    ld a, [wButtonPressId]
    and a, RIGHT_INPUT
    jp nz, checkKeyboardRightInput
    xor a
    ld [wTurnRightTimer], a
    ld a, [wButtonPressId]
    and a, UP_INPUT
    jp nz, checkKeyboardUpInput
    xor a
    ld [wUpKeyPressDown], a
    ld a, [wButtonPressId]
    and a, DOWN_INPUT
    jp nz, checkKeyboardDownInput
    xor a
    ld [wDownKeyPressDown], a
    ret
;4B05

checkKeyboardLeftInput: ;04:4B05
    ld hl, wTurnLeftTimer
    ld a, [hl]
    or a
    ret nz
    ld [hl], $FF
    ld hl, wComputerKeyboardKeyId
    ld a, [hl]
    and a, $07 ;limit left border
    ret z
    dec [hl]
    ld a, [hl]
    cp a, $1D ;del key dec 1 extra
    jr nz, Label10B1B
    dec [hl]
Label10B1B
    ld a, SWITCH_SFX ;$29
    jp playSFX

checkKeyboardRightInput:
    ld hl, wTurnRightTimer
    ld a, [hl]
    or a
    ret nz
    ld [hl], $FF
    ld hl, wComputerKeyboardKeyId
    ld a, [hl]
    and a, $07
    cp a, $07 ;limit right border
    ret z
    inc [hl]
    ld a, [hl]
    cp a, $1E ;del key add 1 extra
    jr nz, Label10B38
    inc [hl]
Label10B38
    ld a, SWITCH_SFX ;$29
    jp playSFX

checkKeyboardUpInput:
    ld hl, wUpKeyPressDown
    ld a, [hl]
    or a
    ret nz
    ld [hl], $FF
    ld hl, wComputerKeyboardKeyId
    ld a, [hl]
    cp a, $08 ;limit top border
    ret c
    ld a, [hl]
    sub a, $08
    ld [hl], a
    cp a, $17 ;check enter key
    jr z, Label10B58
    cp a, $0F ;check enter key
    jr nz, Label10B5A
Label10B58
    ld [hl], $07
Label10B5A
    ld a, SWITCH_SFX ;$29
    jp playSFX

checkKeyboardDownInput:
    ld hl, wDownKeyPressDown
    ld a, [hl]
    or a
    ret nz
    ld [hl], $FF
    ld hl, wComputerKeyboardKeyId
    ld a, [hl]
    cp a, $18 ;limit bottom border
    ret nc
	;check enter key
    cp a, $0F
    ret z
    cp a, $17
    ret z
    cp a, $1F
    ret z
    ld a, [hl]
    add a, $08
    ld [hl], a
    ld a, SWITCH_SFX ;$29
    jp playSFX
;4B80

loadSpritePriorityData:: ;04:4B80
    push de
    push hl
    ld a, [wSprtPriorityTblLow]
    ld l, a
    ld a, [wSprtPriorityTblHigh]
    ld h, a
    inc de ; 01 Sprite Y Pos Low Buffer
    ld a, [de]
    ld [hli], a
    inc de ; 02 Sprite X Pos Low Buffer
    push de
    ld a, [spriteIdBuffer]
    ld [hl], a
    inc hl
    ld [hl], $00
    inc hl
    pop de
    ld a, [de]
    ld [hl], a
    inc hl
    inc de
    ld a, [de]
    ld [hl], a
    inc hl
    inc de
    ld a, [de]
    ld [hl], a
    inc hl
    inc de
    ld a, [de]
    ld [hl], a
    inc hl
    inc de
    inc de
    inc de
    inc de
    ld a, [de]
    ld [hl], a
    inc hl
    dec de
    dec de
    ld a, [de]
    ld [hl], a
    inc hl
    dec de
    ld a, [de]
    ld [hl], a
    inc hl
    ld [hl], $00
    ld a, l
    ld [wSprtPriorityTblLow], a
    ld a, h
    ld [wSprtPriorityTblHigh], a
    pop hl
    pop de
    ret

loadEnemyBloodSprite: ;04:4BC4
    push bc
    push de
    push hl
    ld a, [wSprtPriorityTblLow]
    ld l, a
    ld a, [wSprtPriorityTblHigh]
    ld h, a
    inc de
    ld a, [de]
    dec a
    ld [hl], a ;y-sort
    inc hl
    inc de
    push de
    ld de, $2B9D ;blood sprite id low-high
    ld [hl], e ;sprite id
    inc hl
    ld [hl], d ;sprite id high
    inc hl
    pop de
    ld a, [de]
    add a, $0C
    ld [hl], a
    inc hl
    inc de
    ld a, [de]
    ld [hl], a
    inc hl
    inc de
    ld a, $08
    ld [hl], a
    inc hl
    inc de
    ld a, $10
    ld [hl], a
    inc hl
    ld a, e
    add a, $08
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ld a, [de]
    ld [hl], a
    inc hl
    ld [hl], $00
    inc hl
    ld [hl], $00
    inc hl
    ld [hl], $00
    ld a, l
    ld [wSprtPriorityTblLow], a
    ld a, h
    ld [wSprtPriorityTblHigh], a
    pop hl
    pop de
    push hl
    ld hl, wSpriteHeight - wCharSpritesData ;$5
    add hl, de
    ld a, [hl]
    srl a
    srl a
    srl a
    srl a
    ld c, a
    ld hl, wSpriteScreenPosY - wCharSpritesData ;$3
    add hl, de
    ld a, [hl]
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

;4C34

checkGasRooms: ;04:4C34
    ld a, [wRoomId]
    cp a, OPERATING_MORGE_ROOM
    jr z, Label10C40
    cp a, ARMORS_ROOM
    jr z, Label10C40
    ret
Label10C40 ;04:4C40
    ld a, [wPoisonGasActivationByte]
    or a
    ret z
    ld a, [wFrameRateCounter]
    and a, $03
    ret nz
    ld a, [wCharHealth]
    or a
    ret z ;return if player health is zero
    dec a
    ld [wCharHealth], a ;decrease player health by 1
    or a
    ret nz
    ld a, $40
    ld [wLCDUpdate], a ;fade-out if player is dead by gas
    ret
;4C5C

InitSelectedPlayerData:: ;04:4C5C
    ld a, $03
    ld [wTigerStatueRotateDirection], a
    ld a, [wSelectedPlayer]
    or a
    jp nz, initJillData
	;init chris data
	;init items
    ld a, COMBAT_KNIFE
    ld [ItemIdSlot1], a
    ld a, F_AID_SPRAY
    ld [ItemIdSlot2], a
    ld a, EMPTY
    ld [equipedItemId], a
    ld a, EMPTY
    ld [wSpriteAnimationId], a
    ld a, $80
    ld [wCharSpritesData], a
    ld a, CHRIS ;sprite id
    ld [wSpriteId], a
    xor a
    ld [wSpriteAnimationFrameId], a
    ld [wFiregunFramesId], a
    ld [wBloodFramesId], a
    ld a, $20
    ld [wCharHealth], a ;set health
    xor a
    ld [wMenuRadioEnable], a ;disable radio
    ld [wMenuMapEnable], a ;disable maps
    ld a, $FF
    ld [wMenuFileEnable], a ;enable files
    ld [wMenuExitEnable], a ;enable exit menu
    ret
initJillData: ;04:4CA5
    ld a, BERRETTA
    ld [ItemIdSlot1], a
    ld a, COMBAT_KNIFE
    ld [ItemIdSlot2], a
    ld a, F_AID_SPRAY
    ld [ItemIdSlot3], a
    ld a, EMPTY
    ld [equipedItemId], a
    ld a, EMPTY
    ld [wSpriteAnimationId], a
    ld a, $80
    ld [wCharSpritesData], a
    ld a, JILL
    ld [wSpriteId], a
    xor a
    ld [wSpriteAnimationFrameId], a
    ld [wFiregunFramesId], a
    ld [wBloodFramesId], a
    ld a, $20
    ld [wCharHealth], a
    xor a
    ld [wMenuRadioEnable], a
    ld [wMenuMapEnable], a
    ld a, $FF
    ld [wMenuFileEnable], a
    ld [wMenuExitEnable], a
    ret

;applyRoomBgMask::
INCLUDE "engine/loadRoomBgMask.asm"

;04:55FD rest of bank 4 space is empty

SECTION "bank5",ROMX,BANK[$5]

item_00_spriteA:		INCBIN "gfx/item_sprites/item_00_spriteA.2bpp" ;4000
item_01_spriteA:		INCBIN "gfx/item_sprites/item_01_spriteA.2bpp" ;4020
item_02_spriteA:		INCBIN "gfx/item_sprites/item_02_spriteA.2bpp" ;4040
item_03_spriteA:		INCBIN "gfx/item_sprites/item_03_spriteA.2bpp" ;4060
item_04_spriteA:		INCBIN "gfx/item_sprites/item_04_spriteA.2bpp" ;4080
item_05_spriteA:		INCBIN "gfx/item_sprites/item_05_spriteA.2bpp" ;40A0
item_00_spriteB:		INCBIN "gfx/item_sprites/item_00_spriteB.2bpp" ;40C0
item_01_spriteB:		INCBIN "gfx/item_sprites/item_01_spriteB.2bpp" ;40E0
item_02_spriteB:		INCBIN "gfx/item_sprites/item_02_spriteB.2bpp" ;4100
item_03_spriteB:		INCBIN "gfx/item_sprites/item_03_spriteB.2bpp" ;4120
item_04_spriteB:		INCBIN "gfx/item_sprites/item_04_spriteB.2bpp" ;4140
item_05_spriteB:		INCBIN "gfx/item_sprites/item_05_spriteB.2bpp" ;4160
item_06_spriteA:		INCBIN "gfx/item_sprites/item_06_spriteA.2bpp" ;4180
item_07_spriteA:		INCBIN "gfx/item_sprites/item_07_spriteA.2bpp" ;41A0
item_08_spriteA:		INCBIN "gfx/item_sprites/item_08_spriteA.2bpp" ;41C0
item_09_spriteA:		INCBIN "gfx/item_sprites/item_09_spriteA.2bpp" ;41E0
item_0A_spriteA:		INCBIN "gfx/item_sprites/item_0A_spriteA.2bpp" ;4200
item_0B_spriteA:		INCBIN "gfx/item_sprites/item_0B_spriteA.2bpp" ;4220
item_06_spriteB:		INCBIN "gfx/item_sprites/item_06_spriteB.2bpp" ;4240
item_07_spriteB:		INCBIN "gfx/item_sprites/item_07_spriteB.2bpp" ;4260
item_08_spriteB:		INCBIN "gfx/item_sprites/item_08_spriteB.2bpp" ;4280
item_09_spriteB:		INCBIN "gfx/item_sprites/item_09_spriteB.2bpp" ;42A0
item_0A_spriteB:		INCBIN "gfx/item_sprites/item_0A_spriteB.2bpp" ;42C0
item_0B_spriteB:		INCBIN "gfx/item_sprites/item_0B_spriteB.2bpp" ;42E0
item_0C_spriteA:		INCBIN "gfx/item_sprites/item_0C_spriteA.2bpp" ;4300
item_0D_spriteA:		INCBIN "gfx/item_sprites/item_0D_spriteA.2bpp" ;4320
item_0E_spriteA:		INCBIN "gfx/item_sprites/item_0E_spriteA.2bpp" ;4340
item_0F_spriteA:		INCBIN "gfx/item_sprites/item_0F_spriteA.2bpp" ;4360
item_10_spriteA:		INCBIN "gfx/item_sprites/item_10_spriteA.2bpp" ;4380
item_11_spriteA:		INCBIN "gfx/item_sprites/item_11_spriteA.2bpp" ;43A0
item_0C_spriteB:		INCBIN "gfx/item_sprites/item_0C_spriteB.2bpp" ;43C0
item_0D_spriteB:		INCBIN "gfx/item_sprites/item_0D_spriteB.2bpp" ;43E0
item_0E_spriteB:		INCBIN "gfx/item_sprites/item_0E_spriteB.2bpp" ;4400
item_0F_spriteB:		INCBIN "gfx/item_sprites/item_0F_spriteB.2bpp" ;4420
item_10_spriteB:		INCBIN "gfx/item_sprites/item_10_spriteB.2bpp" ;4440
item_11_spriteB:		INCBIN "gfx/item_sprites/item_11_spriteB.2bpp" ;4460
item_12_spriteA:		INCBIN "gfx/item_sprites/item_12_spriteA.2bpp" ;4480
item_13_spriteA:		INCBIN "gfx/item_sprites/item_13_spriteA.2bpp" ;44A0
item_14_spriteA:		INCBIN "gfx/item_sprites/item_14_spriteA.2bpp" ;44C0
item_15_spriteA:		INCBIN "gfx/item_sprites/item_15_spriteA.2bpp" ;44E0
item_16_spriteA:		INCBIN "gfx/item_sprites/item_16_spriteA.2bpp" ;4500
item_17_spriteA:		INCBIN "gfx/item_sprites/item_17_spriteA.2bpp" ;4520
item_12_spriteB:		INCBIN "gfx/item_sprites/item_12_spriteB.2bpp" ;4540
item_13_spriteB:		INCBIN "gfx/item_sprites/item_13_spriteB.2bpp" ;4560
item_14_spriteB:		INCBIN "gfx/item_sprites/item_14_spriteB.2bpp" ;4580
item_15_spriteB:		INCBIN "gfx/item_sprites/item_15_spriteB.2bpp" ;45A0
item_16_spriteB:		INCBIN "gfx/item_sprites/item_16_spriteB.2bpp" ;45C0
item_17_spriteB:		INCBIN "gfx/item_sprites/item_17_spriteB.2bpp" ;45E0
item_18_spriteA:		INCBIN "gfx/item_sprites/item_18_spriteA.2bpp" ;4600
item_19_spriteA:		INCBIN "gfx/item_sprites/item_19_spriteA.2bpp" ;4620
item_1A_spriteA:		INCBIN "gfx/item_sprites/item_1A_spriteA.2bpp" ;4640
item_1B_spriteA:		INCBIN "gfx/item_sprites/item_1B_spriteA.2bpp" ;4660
item_1C_spriteA:		INCBIN "gfx/item_sprites/item_1C_spriteA.2bpp" ;4680
item_1D_spriteA:		INCBIN "gfx/item_sprites/item_1D_spriteA.2bpp" ;46A0
item_18_spriteB:		INCBIN "gfx/item_sprites/item_18_spriteB.2bpp" ;46C0
item_19_spriteB:		INCBIN "gfx/item_sprites/item_19_spriteB.2bpp" ;46E0
item_1A_spriteB:		INCBIN "gfx/item_sprites/item_1A_spriteB.2bpp" ;4700
item_1B_spriteB:		INCBIN "gfx/item_sprites/item_1B_spriteB.2bpp" ;4720
item_1C_spriteB:		INCBIN "gfx/item_sprites/item_1C_spriteB.2bpp" ;4740
item_1D_spriteB:		INCBIN "gfx/item_sprites/item_1D_spriteB.2bpp" ;4760
item_1E_spriteA:		INCBIN "gfx/item_sprites/item_1E_spriteA.2bpp" ;4780
item_1F_spriteA:		INCBIN "gfx/item_sprites/item_1F_spriteA.2bpp" ;47A0
item_20_spriteA:		INCBIN "gfx/item_sprites/item_20_spriteA.2bpp" ;47C0
item_21_spriteA:		INCBIN "gfx/item_sprites/item_21_spriteA.2bpp" ;47E0
item_22_spriteA:		INCBIN "gfx/item_sprites/item_22_spriteA.2bpp" ;4800
item_23_spriteA:		INCBIN "gfx/item_sprites/item_23_spriteA.2bpp" ;4820
item_1E_spriteB:		INCBIN "gfx/item_sprites/item_1E_spriteB.2bpp" ;4840
item_1F_spriteB:		INCBIN "gfx/item_sprites/item_1F_spriteB.2bpp" ;4860
item_20_spriteB:		INCBIN "gfx/item_sprites/item_20_spriteB.2bpp" ;4880
item_21_spriteB:		INCBIN "gfx/item_sprites/item_21_spriteB.2bpp" ;48A0
item_22_spriteB:		INCBIN "gfx/item_sprites/item_22_spriteB.2bpp" ;48C0
item_23_spriteB:		INCBIN "gfx/item_sprites/item_23_spriteB.2bpp" ;48E0
item_24_spriteA:		INCBIN "gfx/item_sprites/item_24_spriteA.2bpp" ;4900
item_25_spriteA:		INCBIN "gfx/item_sprites/item_25_spriteA.2bpp" ;4920
item_26_spriteA:		INCBIN "gfx/item_sprites/item_26_spriteA.2bpp" ;4940
item_27_spriteA:		INCBIN "gfx/item_sprites/item_27_spriteA.2bpp" ;4960
item_28_spriteA:		INCBIN "gfx/item_sprites/item_28_spriteA.2bpp" ;4980
item_29_spriteA:		INCBIN "gfx/item_sprites/item_29_spriteA.2bpp" ;49A0
item_24_spriteB:		INCBIN "gfx/item_sprites/item_24_spriteB.2bpp" ;49C0
item_25_spriteB:		INCBIN "gfx/item_sprites/item_25_spriteB.2bpp" ;49E0
item_26_spriteB:		INCBIN "gfx/item_sprites/item_26_spriteB.2bpp" ;4A00
item_27_spriteB:		INCBIN "gfx/item_sprites/item_27_spriteB.2bpp" ;4A20
item_28_spriteB:		INCBIN "gfx/item_sprites/item_28_spriteB.2bpp" ;4A40
item_29_spriteB:		INCBIN "gfx/item_sprites/item_29_spriteB.2bpp" ;4A60
item_2A_spriteA:		INCBIN "gfx/item_sprites/item_2A_spriteA.2bpp" ;4A80
item_2B_spriteA:		INCBIN "gfx/item_sprites/item_2B_spriteA.2bpp" ;4AA0
item_2C_spriteA:		INCBIN "gfx/item_sprites/item_2C_spriteA.2bpp" ;4AC0
item_2D_spriteA:		INCBIN "gfx/item_sprites/item_2D_spriteA.2bpp" ;4AE0
item_2E_spriteA:		INCBIN "gfx/item_sprites/item_2E_spriteA.2bpp" ;4B00
item_2F_spriteA:		INCBIN "gfx/item_sprites/item_2F_spriteA.2bpp" ;4B20
item_2A_spriteB:		INCBIN "gfx/item_sprites/item_2A_spriteB.2bpp" ;4B40
item_2B_spriteB:		INCBIN "gfx/item_sprites/item_2B_spriteB.2bpp" ;4B60
item_2C_spriteB:		INCBIN "gfx/item_sprites/item_2C_spriteB.2bpp" ;4B80
item_2D_spriteB:		INCBIN "gfx/item_sprites/item_2D_spriteB.2bpp" ;4BA0
item_2E_spriteB:		INCBIN "gfx/item_sprites/item_2E_spriteB.2bpp" ;4BC0
item_2F_spriteB:		INCBIN "gfx/item_sprites/item_2F_spriteB.2bpp" ;4BE0
item_30_spriteA:		INCBIN "gfx/item_sprites/item_30_spriteA.2bpp" ;4C00
item_31_spriteA:		INCBIN "gfx/item_sprites/item_31_spriteA.2bpp" ;4C20
item_32_spriteA:		INCBIN "gfx/item_sprites/item_32_spriteA.2bpp" ;4C40
item_33_spriteA:		INCBIN "gfx/item_sprites/item_33_spriteA.2bpp" ;4C60
item_34_spriteA:		INCBIN "gfx/item_sprites/item_34_spriteA.2bpp" ;4C80
item_35_spriteA:		INCBIN "gfx/item_sprites/item_35_spriteA.2bpp" ;4CA0
item_30_spriteB:		INCBIN "gfx/item_sprites/item_30_spriteB.2bpp" ;4CC0
item_31_spriteB:		INCBIN "gfx/item_sprites/item_31_spriteB.2bpp" ;4CE0
item_32_spriteB:		INCBIN "gfx/item_sprites/item_32_spriteB.2bpp" ;4D00
item_33_spriteB:		INCBIN "gfx/item_sprites/item_33_spriteB.2bpp" ;4D20
item_34_spriteB:		INCBIN "gfx/item_sprites/item_34_spriteB.2bpp" ;4D40
item_35_spriteB:		INCBIN "gfx/item_sprites/item_35_spriteB.2bpp" ;4D60
item_36_spriteA:		INCBIN "gfx/item_sprites/item_36_spriteA.2bpp" ;4D80
item_37_spriteA:		INCBIN "gfx/item_sprites/item_37_spriteA.2bpp" ;4DA0
item_38_spriteA:		INCBIN "gfx/item_sprites/item_38_spriteA.2bpp" ;4DC0
item_39_spriteA:		INCBIN "gfx/item_sprites/item_39_spriteA.2bpp" ;4DE0
item_3A_spriteA:		INCBIN "gfx/item_sprites/item_3A_spriteA.2bpp" ;4E00
item_3B_spriteA:		INCBIN "gfx/item_sprites/item_3B_spriteA.2bpp" ;4E20
item_36_spriteB:		INCBIN "gfx/item_sprites/item_36_spriteB.2bpp" ;4E40
item_37_spriteB:		INCBIN "gfx/item_sprites/item_37_spriteB.2bpp" ;4E60
item_38_spriteB:		INCBIN "gfx/item_sprites/item_38_spriteB.2bpp" ;4E80
item_39_spriteB:		INCBIN "gfx/item_sprites/item_39_spriteB.2bpp" ;4EA0
item_3A_spriteB:		INCBIN "gfx/item_sprites/item_3A_spriteB.2bpp" ;4EC0
item_3B_spriteB:		INCBIN "gfx/item_sprites/item_3B_spriteB.2bpp" ;4EE0
item_3C_spriteA:		INCBIN "gfx/item_sprites/item_3C_spriteA.2bpp" ;4F00
item_3D_spriteA:		INCBIN "gfx/item_sprites/item_3D_spriteA.2bpp" ;4F20
item_3E_spriteA:		INCBIN "gfx/item_sprites/item_3E_spriteA.2bpp" ;4F40
item_3F_spriteA:		INCBIN "gfx/item_sprites/item_3F_spriteA.2bpp" ;4F60
item_40_spriteA:		INCBIN "gfx/item_sprites/item_40_spriteA.2bpp" ;4F80
item_41_spriteA:		INCBIN "gfx/item_sprites/item_41_spriteA.2bpp" ;4FA0
item_3C_spriteB:		INCBIN "gfx/item_sprites/item_3C_spriteB.2bpp" ;4FC0
item_3D_spriteB:		INCBIN "gfx/item_sprites/item_3D_spriteB.2bpp" ;4FE0
item_3E_spriteB:		INCBIN "gfx/item_sprites/item_3E_spriteB.2bpp" ;5000
item_3F_spriteB:		INCBIN "gfx/item_sprites/item_3F_spriteB.2bpp" ;5020
item_40_spriteB:		INCBIN "gfx/item_sprites/item_40_spriteB.2bpp" ;5040
item_41_spriteB:		INCBIN "gfx/item_sprites/item_41_spriteB.2bpp" ;5060
item_42_spriteA:		INCBIN "gfx/item_sprites/item_42_spriteA.2bpp" ;5080
item_43_spriteA:		INCBIN "gfx/item_sprites/item_43_spriteA.2bpp" ;50A0
item_44_spriteA:		INCBIN "gfx/item_sprites/item_44_spriteA.2bpp" ;50C0
item_45_spriteA:		INCBIN "gfx/item_sprites/item_45_spriteA.2bpp" ;50E0
item_46_spriteA:		INCBIN "gfx/item_sprites/item_46_spriteA.2bpp" ;5100
item_47_spriteA:		INCBIN "gfx/item_sprites/item_47_spriteA.2bpp" ;5120
item_42_spriteB:		INCBIN "gfx/item_sprites/item_42_spriteB.2bpp" ;5140
item_43_spriteB:		INCBIN "gfx/item_sprites/item_43_spriteB.2bpp" ;5160
item_44_spriteB:		INCBIN "gfx/item_sprites/item_44_spriteB.2bpp" ;5180
item_45_spriteB:		INCBIN "gfx/item_sprites/item_45_spriteB.2bpp" ;51A0
item_46_spriteB:		INCBIN "gfx/item_sprites/item_46_spriteB.2bpp" ;51C0
item_47_spriteB:		INCBIN "gfx/item_sprites/item_47_spriteB.2bpp" ;51E0
item_48_spriteA:		INCBIN "gfx/item_sprites/item_48_spriteA.2bpp" ;5200
item_49_spriteA:		INCBIN "gfx/item_sprites/item_49_spriteA.2bpp" ;5220
item_4A_spriteA:		INCBIN "gfx/item_sprites/item_4A_spriteA.2bpp" ;5240
item_4B_spriteA:		INCBIN "gfx/item_sprites/item_4B_spriteA.2bpp" ;5260
item_4C_spriteA:		INCBIN "gfx/item_sprites/item_4C_spriteA.2bpp" ;5280
item_4D_spriteA:		INCBIN "gfx/item_sprites/item_4D_spriteA.2bpp" ;52A0
item_48_spriteB:		INCBIN "gfx/item_sprites/item_48_spriteB.2bpp" ;52C0
item_49_spriteB:		INCBIN "gfx/item_sprites/item_49_spriteB.2bpp" ;52E0
item_4A_spriteB:		INCBIN "gfx/item_sprites/item_4A_spriteB.2bpp" ;5300
item_4B_spriteB:		INCBIN "gfx/item_sprites/item_4B_spriteB.2bpp" ;5320
item_4C_spriteB:		INCBIN "gfx/item_sprites/item_4C_spriteB.2bpp" ;5340
item_4D_spriteB:		INCBIN "gfx/item_sprites/item_4D_spriteB.2bpp" ;5360
item_4E_spriteA:		INCBIN "gfx/item_sprites/item_4E_spriteA.2bpp" ;5380
item_4F_spriteA:		INCBIN "gfx/item_sprites/item_4F_spriteA.2bpp" ;53A0
item_50_spriteA:		INCBIN "gfx/item_sprites/item_50_spriteA.2bpp" ;53C0
item_51_spriteA:		INCBIN "gfx/item_sprites/item_51_spriteA.2bpp" ;53E0
item_52_spriteA:		INCBIN "gfx/item_sprites/item_52_spriteA.2bpp" ;5400
item_53_spriteA:		INCBIN "gfx/item_sprites/item_53_spriteA.2bpp" ;5420
item_4E_spriteB:		INCBIN "gfx/item_sprites/item_4E_spriteB.2bpp" ;5440
item_4F_spriteB:		INCBIN "gfx/item_sprites/item_4F_spriteB.2bpp" ;5460
item_50_spriteB:		INCBIN "gfx/item_sprites/item_50_spriteB.2bpp" ;5480
item_51_spriteB:		INCBIN "gfx/item_sprites/item_51_spriteB.2bpp" ;54A0
item_52_spriteB:		INCBIN "gfx/item_sprites/item_52_spriteB.2bpp" ;54C0
item_53_spriteB:		INCBIN "gfx/item_sprites/item_53_spriteB.2bpp" ;54E0
item_54_spriteA:		INCBIN "gfx/item_sprites/item_54_spriteA.2bpp" ;5500
item_55_spriteA:		INCBIN "gfx/item_sprites/item_55_spriteA.2bpp" ;5520
item_56_spriteA:		INCBIN "gfx/item_sprites/item_56_spriteA.2bpp" ;5540
item_57_spriteA:		INCBIN "gfx/item_sprites/item_57_spriteA.2bpp" ;5560
item_58_spriteA:		INCBIN "gfx/item_sprites/item_58_spriteA.2bpp" ;5580
item_59_spriteA:		INCBIN "gfx/item_sprites/item_59_spriteA.2bpp" ;55A0
item_54_spriteB:		INCBIN "gfx/item_sprites/item_54_spriteB.2bpp" ;55C0
item_55_spriteB:		INCBIN "gfx/item_sprites/item_55_spriteB.2bpp" ;55E0
item_56_spriteB:		INCBIN "gfx/item_sprites/item_56_spriteB.2bpp" ;5600
item_57_spriteB:		INCBIN "gfx/item_sprites/item_57_spriteB.2bpp" ;5620
item_58_spriteB:		INCBIN "gfx/item_sprites/item_58_spriteB.2bpp" ;5640
item_59_spriteB:		INCBIN "gfx/item_sprites/item_59_spriteB.2bpp" ;5660
item_5A_spriteA:		INCBIN "gfx/item_sprites/item_5A_spriteA.2bpp" ;5680
item_5B_spriteA:		INCBIN "gfx/item_sprites/item_5B_spriteA.2bpp" ;56A0
item_5C_spriteA:		INCBIN "gfx/item_sprites/item_5C_spriteA.2bpp" ;56C0
item_5D_spriteA:		INCBIN "gfx/item_sprites/item_5D_spriteA.2bpp" ;56E0
item_5E_spriteA:		INCBIN "gfx/item_sprites/item_5E_spriteA.2bpp" ;5700
item_5F_spriteA:		INCBIN "gfx/item_sprites/item_5F_spriteA.2bpp" ;5720
item_5A_spriteB:		INCBIN "gfx/item_sprites/item_5A_spriteB.2bpp" ;5740
item_5B_spriteB:		INCBIN "gfx/item_sprites/item_5B_spriteB.2bpp" ;5760
item_5C_spriteB:		INCBIN "gfx/item_sprites/item_5C_spriteB.2bpp" ;5780
item_5D_spriteB:		INCBIN "gfx/item_sprites/item_5D_spriteB.2bpp" ;57A0
item_5E_spriteB:		INCBIN "gfx/item_sprites/item_5E_spriteB.2bpp" ;57C0
item_5F_spriteB:		INCBIN "gfx/item_sprites/item_5F_spriteB.2bpp" ;57E0

REPT $300 ;5800
	db $FF
ENDR

INCLUDE "main/itemsSpriteTable.asm" ;5B00
INCLUDE "main/itemsPalleteIndexTable.asm" ;5BC0
;5C1C

loadMenuItemsSprtData: ;05:5C1C
;first, load items OAM data
    ld hl, ItemIdSlot1
    ld e, $08
    ld b, $00 ;sprite piece counter?
loadItemsOAMLoop
    ld c, $02 ;item slots columns
columnLoop
    ld a, [hl] ;get item id
    push hl ;store item slot id
    ld hl, itemsPalleteIndexTable
    add a, l
    ld l, a
    ld a, $00
    adc a, h
    ld h, a
    ld d, [hl] ;get pal index
    push de
    ld hl, wOAMBufferC9+8 ;$C908
    call selectOAMDataDest
    ld a, b ;a=0
    add a ;a*2
    ld d, a ;d=0
    ld a, $02 ;a=2
    sub a, c ;a-2 = 0
    add a, d ;a=d = 0
    add a
    add a
    add a ;a*8 = 0
    add a, l ;a+oam address
    ld l, a
    pop de ;palId-itemSlots
    ld a, b
    cp a, $03
    jr c, Label15C50
    ld a, [wSelectedPlayer]
    or a
    jr z, Label15C53 ;jump if chris
Label15C50
    call setMenuItemOAMData
Label15C53
    pop hl ;restore itemId addr
    inc hl ;next itemId
    dec c ;next column
    jr nz, columnLoop
    inc b
    ld a, b
    cp a, $04
    jr c, loadItemsOAMLoop
;load sprite tiles data
    ld de, wSpriteTilesBuffer+$80 ;$CB80
    ld hl, ItemIdSlot1
    ld b, $08
loadItemTileDataLoop
    push bc ;store slots count
    push hl ;store itemid
    push de ;store sprite buffer
    ld l, [hl]
    ld h, $00
    add hl, hl ;get item sprite offset
    ld de, itemsSpriteTable
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a ;get sprite data addr
    pop de
    ld b, $02 ;sprite pieces?
spritePieceLoop
    ld c, $20 ;sprite half bytes (2 tiles)
itemSpriteLoadLoop
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, itemSpriteLoadLoop
    ld a, l
    add a, $A0 ;add offset to next half sprite tiles
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec b
    jr nz, spritePieceLoop
    pop hl
    inc hl
    pop bc
    dec b
    jr nz, loadItemTileDataLoop
    ret
;5C91

setMenuItemOAMData: ;05:5C91
;d: current item palId
;e: itemSlots
;b: slot id
    push de
    ld a, b
    add a
    add a
    add a
    add a
    add a, $40 ;get slot OAM address offset
    pop de
    ld [hl], a ;set sprite y-pos
    ld a, [wSelectedPlayer]
    or a
    jr nz, Label15CA5 ;jump if jill
	;if chris
    ld a, [hl]
    add a, $10 ;item sprite y-pos +$10 offset (+1 row)
    ld [hl], a
Label15CA5
    inc l ;sprite x-pos
    push de
    ld a, $02
    sub a, c ;get xpos by column position
    inc a
    add a
    add a
    add a
    ld e, a
    add a
    add a, e
    add a, $58
    pop de
    ld [hli], a ;set xpos
    ld [hl], e ;set sprite tileId
    inc e
    inc e
    inc l
    ld [hl], d ;set pallete flags
    inc l
    push de
    ld a, b
    add a
    add a
    add a
    add a
    add a, $40 ;get sprite second half OAM addr
    pop de
    ld [hl], a ;y-pos
    ld a, [wSelectedPlayer]
    or a
    jr nz, Label15CCF ;if jill
	;if chris
    ld a, [hl]
    add a, $10 ;+1 row offset
    ld [hl], a
Label15CCF
    inc l
    push de
    ld a, $02
    sub a, c
    inc a
    add a
    add a
    add a
    ld e, a
    add a
    add a, e
    add a, $60
    pop de
    ld [hli], a ;xpos
    ld [hl], e ;tileId
    inc e
    inc e
    inc l
    ld [hl], d ;palId
    inc l
    ret
;5CE6

loadItemBigSprite: ;05:5CE6
    ld a, $01
    ld [vramBank], a ;vram bank select
    ld hl, _VRAM+$1000 ;black tiles
    ld b, $B0
Label15CEF
    ld a, [rSTAT]  ;lcd status
    and a, $03
    jr z, Label15CEF
Label15CF5
    ld a, [rSTAT]  ;lcd status
    and a, $03
    jr nz, Label15CF5
;clear item detail canvas tiles
    xor a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    dec b
    jr nz, Label15CEF
    ld a, [selectedItemId]
    ld l, a
    ld h, $00
    add hl, hl
    ld de, itemsSpriteTable
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld de, _VRAM+$1220 ;$9220 ;item big sprite start tile
    ld b, $04 ;number of sprite pieces
Loop15D1A
    ld c, $10 ;bytes per tile
tileExpansionLoop
    push bc
    ld a, b
    and a, $01
    jr z, Label15D2E ;jump if sprite piece is even
    ld a, [hli]
    call duplicateOddSubpixel
    ld c, a
    ld a, [hli]
    call duplicateOddSubpixel
    ld b, a
    jr Label15D38
Label15D2E
    ld a, [hli]
    call duplicateEvenSubpixel
    ld c, a
    ld a, [hli]
    call duplicateEvenSubpixel
    ld b, a
Label15D38
    call VBlankWait
    ld a, c
    ld [de], a
    inc de
    ld a, b
    ld [de], a
    inc de
    ld a, c
    ld [de], a
    inc de
    ld a, b
    ld [de], a
    inc de
    pop bc
    dec c
    jr nz, tileExpansionLoop
    ld a, b
    and a, $01
    jr z, Label15D5A ;jump if sprite piece is even
    ld a, l
    add a, $A0
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    jr Label15D62
Label15D5A
    ld a, l
    sub a, $20
    ld l, a
    ld a, h
    sbc a, $00
    ld h, a
Label15D62
    ld a, e
    add a, $40
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    dec b
    jr nz, Loop15D1A
    xor a
    ld [vramBank], a ;vram bank select
;get item pallete index
    ld hl, itemsPalleteIndexTable ;5BC0
    ld a, [selectedItemId]
    add a, l
    ld l, a
    ld a, $00
    adc a, h
    ld h, a
    ld l, [hl]
    ld h, $00 ;set pal id in hl
    add hl, hl
    add hl, hl
    add hl, hl
    ld de, itemsPallete ;$5E00
    add hl, de ;get item pallete
;load item obj pallete in last bg pallete index
    ld c, $38 ;target pallete index
    ld b, $04 ;pallete colors count
Loop15D8A
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
    jr nz, Loop15D8A
    ret
;5DAE

duplicateEvenSubpixel: ;05:5DAE
    push de
    ld e, a
    ld d, $00
    ld a, e
    and a, $80 ;10000000
    call nz, d_OR_C0
    ld a, e
    and a, $40 ;01000000
    call nz, d_OR_30
    ld a, e
    and a, $20 ;00100000
    call nz, d_OR_0C
    ld a, e
    and a, $10 ;00010000
    call nz, d_OR_03
    ld a, d
    pop de
    ret
;5DCD

duplicateOddSubpixel: ;05:5DCD
    push de
    ld e, a
    ld d, $00
    ld a, e
    and a, $08 ;00001000
    call nz, d_OR_C0
    ld a, e
    and a, $04 ;00000100
    call nz, d_OR_30
    ld a, e
    and a, $02 ;00000010
    call nz, d_OR_0C
    ld a, e
    and a, $01 ;00000001
    call nz, d_OR_03
    ld a, d
    pop de
    ret
;5DEC

d_OR_C0: ;05:5DEC
    ld a, d
    or a, $C0 ;11000000
    ld d, a
    ret
;5DF1

d_OR_30: ;05:5DF1
    ld a, d
    or a, $30 ;00110000
    ld d, a
    ret
;5DF6

d_OR_0C: ;05:5DF6
    ld a, d
    or a, $0C ;00001100
    ld d, a
    ret
;5DFB

d_OR_03: ;05:5DFB
    ld a, d
    or a, $03 ;00000011
    ld d, a
    ret
;5E00

itemsPallete: ;05:5E00
	db $E0, $00, $DE, $7B, $94, $52, $4A, $29
	db $E0, $00, $1E, $00, $14, $00, $0A, $00
	db $E0, $00, $C0, $03, $80, $02, $40, $01
	db $E0, $00, $C0, $7B, $80, $52, $40, $29
	db $E0, $00, $DE, $03, $94, $02, $4A, $01
	db $E0, $00, $FE, $01, $54, $01, $AA, $00
	db $E0, $00, $1E, $78, $14, $50, $0A, $28
	db $E0, $00, $5F, $5B, $36, $36, $63, $0C
;5E40

loadEquipedSpriteData: ;05:5E40
    ld a, [equipedItemId]
    ld hl, itemsPalleteIndexTable
    add a, l
    ld l, a
    ld a, $00
    adc a, h
    ld h, a
    ld d, [hl] ;get palleteIndex
    ld hl, wOAMBufferC9+$48 ;$C948 set OAM data address
    call selectOAMDataDest
;set OAM data first sprite half
    ld [hl], $68 ;set y-pos
    inc l
    ld [hl], $50 ;set x-pos
    inc l
    ld [hl], $30 ;set tileId
    inc l
    ld [hl], d ;set palId
    inc l
;set OAM data second sprite half
    ld [hl], $68
    inc l
    ld [hl], $58
    inc l
    ld [hl], $32
    inc l
    ld [hl], d
    inc l
;load sprite tile data
    ld a, [equipedItemId]
    ld l, a
    ld h, $00
    add hl, hl
    ld de, itemsSpriteTable
    add hl, de
    ld a, [hli]
    ld h, [hl] ;get sprite address
    ld l, a
    ld de, wSpriteTilesBufferCE ;$ce00
    ld b, $02 ;sprite pieces
Label15E7C
    ld c, $20 ;bytes per piece (2 tiles)
Label15E7E
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, Label15E7E
    ld a, l
    add a, $A0 ;next sprite half tiles
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec b
    jr nz, Label15E7C
    ret
;5E90

loadSelectedItemboxItemSprite: ;05:5E90
    ld a, [wSelectedItemBoxSlotId]
    ld e, a
    ld d, $00 ;get selected slot id
    ld hl, wItemBoxSlot01
    add hl, de
    ld a, [hl] ;get selected itembox item id
    push af
    ld hl, itemsPalleteIndexTable
    add a, l
    ld l, a
    ld a, $00
    adc a, h
    ld h, a
    ld d, [hl] ;get item id pallete id
    ld hl, wOAMBufferC9+$58 ;$C958
    call selectOAMDataDest
;first half sprite OAM
    ld [hl], $40 ;y-pos
    inc l
    ld [hl], $30 ;x-pos
    inc l
    ld [hl], $34 ;tile-id
    inc l
    ld [hl], d ;palId
    inc l
;second half sprite OAM
    ld [hl], $40
    inc l
    ld [hl], $38
    inc l
    ld [hl], $36
    inc l
    ld [hl], d
    inc l
    pop af ;restore item id
;get item sprite data
    ld l, a
    ld h, $00
    add hl, hl
    ld de, itemsSpriteTable
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld de, wSpriteTilesBufferCE+$40 ;$ce40
    ld b, $02
Label15ED3
    ld c, $20
Label15ED5
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, Label15ED5
    ld a, l
    add a, $A0 ;next sprite half
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec b
    jr nz, Label15ED3
    ret
;5EE7

INCLUDE "main/roomMapsData.asm" ;5EE7

drawRoomMap: ;05:603D
;hl: room map table
    ld a, [hli]
    ld [wRoomMapXPosition], a
    ld a, [hli]
    ld [wRoomMapYPosition], a
    ld a, [hli]
    ld [wRoomMapWidth], a
    ld a, [hli]
    ld [wRoomMapHeight], a
    ld a, [hli]
    ld [wRoomMapRoomId], a
    ld a, [hli]
    ld [wRoomMapRoomIdHigh], a
    push hl
drawRoomMapWidthLoop
    ld a, [wRoomMapHeight]
    ld [wRoomMapHeightCounter], a
    call drawMapVerticalLine
    ld a, [wRoomMapXPosition]
    inc a
    ld [wRoomMapXPosition], a
    ld a, [wRoomMapWidth]
    dec a
    ld [wRoomMapWidth], a
    jr nz, drawRoomMapWidthLoop
    pop hl
    ret
;6071

drawMapVerticalLine: ;05:6071
;get map xposition offset to tile buffer
    ld a, [wRoomMapXPosition]
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
    add hl, hl
    add hl, hl
    ld de, _VRAM+$1000 ;$9000
    add hl, de ;add offset
;add ypos offset
    ld a, [wRoomMapYPosition]
    add a
    add a, l
    ld l, a
    ld a, $00
    adc a, h
    ld h, a
    ld de, visitedRoomMapTileData ;$6025
    ld a, [wRoomMapRoomId]
    ld c, a
    ld a, [wRoomMapRoomIdHigh]
    ld b, a
    ld a, [wRoomId]
    cp a, c ;compare current room with roomMap
    jr nz, checkVisitedRoom ;room map not equal to current room
    ld a, [wRoomIdHigh]
    cp a, b
    jr nz, checkVisitedRoom ;room map not equal to current room
	;roomMap is current room
    ld de, currentRoomMapTileData ;$5FF5
checkVisitedRoom
    ld bc, wVisitedRoom00Trigger ;$C200
    ld a, [wRoomMapRoomId]
    add a, c
    ld c, a
    ld a, [wRoomMapRoomIdHigh]
    adc a, b
    ld b, a
    ld a, [bc]
    or a
    jr nz, getRoomMapPixelData ;jump is room is already visited
	;room not visited
    ld de, unvisitedRoomMapTileData ;$600D
getRoomMapPixelData
    ld a, [wRoomMapXPosition]
    and a, $07
    ld b, a ;23 & 7 = 3
    add a ;6
    add a, b ;6 + 3 = 9
    add a, e ;9 + F5
    ld e, a
    ld a, $00
    adc a, d
    ld d, a
drawMapVerticalLineLoop
    ld a, $01
    ld [vramBank], a ;vram bank select
    ld a, [de] ;EF
    ld c, a
    inc de
    call VBlankWait
    ld a, [hl]
    and a, c
    ld b, a
    ld a, [de]
    or a, b
    ld [hli], a
    inc de
    ld a, [hl]
    and a, c
    ld b, a
    ld a, [de]
    or a, b
    ld [hli], a
    dec de
    dec de
    xor a
    ld [vramBank], a ;vram bank select
    ld a, [wRoomMapHeightCounter]
    dec a
    ld [wRoomMapHeightCounter], a
    jr nz, drawMapVerticalLineLoop
    ret
;60F4

checkTitleCursor:: ;05:60F4
    ld a, $01
    ld [vramBank], a ;vram bank select
    ld hl, _SCRN0+$1E0 ;new game tile line
    ld de, $200
    ld a, [wCursorPosId]
    or a
    jr z, .Label16107
    ld de, $0002
.Label16107
    ld b, $20
.loop16109
    call VBlankWait
    ld a, [hl]
    and a, $F8
    or a, d
    ld [hli], a
    dec b
    jr nz, .loop16109
    ld b, $20
.loop16116
    call VBlankWait
    ld a, [hl]
    and a, $F8
    or a, e
    ld [hli], a
    dec b
    jr nz, .loop16116
    xor a
    ld [vramBank], a ;vram bank select
    ld a, [wButtonPressId]
    and a, UP_INPUT ;$40
    jr z, .label16135
    ld a, [wCursorPosId]
    or a
    jr z, .label16135
    xor a
    ld [wCursorPosId], a
.label16135
    ld a, [wButtonPressId]
    and a, DOWN_INPUT ;$80
    jr z, .label16148
    ld a, [wCursorPosId]
    cp a, $01
    jr z, .label16148
    ld a, $01
    ld [wCursorPosId], a
.label16148
    ret

ScrolldownTypingMessage:: ;05:6149
    ld hl, _SCRN0+$200
    ld de, _SCRN0+$220
    ld b, $04
.loop16151
    ld c, $14
.loop16153
    call VBlankWait
    ld a, [de]
    ld [hli], a
    inc e
    dec c
    jr nz, .loop16153
    ld a, e
    add a, $0C
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    ld a, l
    add a, $0C
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    dec b
    jr nz, .loop16151
    ld hl, wc1f7
    dec [hl]
    ld hl, wc1f6
    ld [hl], $00
    ret

;05:6179 rest of bank is empty


SECTION "audio bank",ROMX,BANK[$6]

INCLUDE "audio/audio.asm"


SECTION "RoomsBgCameras",ROMX,BANK[$7]

INCLUDE "main/RoomsBgCamerasLookupTable.asm" ;4000

RoomsBgCamerasData:: INCLUDE "main/RoomsBgCamerasData.asm" ;40E8

;07:6D0E rest of bank empty


SECTION "bank8",ROMX,BANK[$8]

applyRoomOverlapToSprt:: ;08:4000
    ld a, [wRoomId]
    cp a, DINNING_ROOM_1F
    jp z, ApplyDinningRoomOverlap
    cp a, EXHIBITION_ROOM
    jp z, ApplyMapStatueRoomOverlap
    cp a, REST_STOP_CORRIDOR ;first zombie location
    jp z, applyCorridor05RoomOverlap
    cp a, WEST_STAIRCASE_1F ;to mansion safe room
    jp z, applyCorridor08RoomOverlap
    cp a, KEEPERS_ROOM ;$0E
    jp z, ApplyZombieClosetRoomOverlap
    cp a, LARGE_ART_ROOM ;leading to big mirror room
    jp z, ApplyRoom10Overlap
    cp a, SMALL_DINNING_ROOM
    jp z, ApplyCandleRoomOverlap
    cp a, EAST_STAIRCASE_2F ;to chimney 2F Mansion map room
    jp z, ApplyCorridor24Overlap
    cp a, RESEARCHERS_PRIVATE_ROOM
    jp z, ApplyInsectsRoomOverlap
    cp a, ATTIC
    jp z, ApplyYawn1RoomOverlap
    cp a, AQUA_TANK_ENTRANCE ;leading to squarium
    jp z, ApplyCorridor4CRoomOverlap
    cp a, GUARDHOUSE_DORM_003
    jp z, ApplyDorm003RoomOverlap
    ret

ApplyDinningRoomOverlap: ;08:4040
    ld a, [wRoomScreen]
    or a ;$00
    jr z, Label2004B
    cp a, $02
    jr z, Label20057
    ret
Label2004B
    ld de, Room01_00_overlapMaskA ;$439E
    call ApplyRoomOverlapMask
    ld de, Room01_00_overlapMaskB ;$43AA
    jp ApplyRoomOverlapMask
Label20057
    ld de, Room01_02_overlapMaskA ;$43B9
    call ApplyRoomOverlapMask
    ld de, Room01_02_overlapMaskB ;$43C5
    jp ApplyRoomOverlapMask

ApplyMapStatueRoomOverlap: ;08:4063
    ld de, Room04_00_overlapMask ;$43D1
    ld a, [wRoomScreen]
    or a ;$00
    jp z, ApplyRoomOverlapMask
    ld de, Room04_01_overlapMask ;$43E6
    cp a, $01
    jp z, ApplyRoomOverlapMask
    ld de, Room04_02_overlapMask ;$43FB
    cp a, $02
    jp z, ApplyRoomOverlapMask
    ret

applyCorridor05RoomOverlap: ;08:407E
    ld a, [wRoomScreen]
    cp a, $01
    ret nz
    ld de, Room05_01_overlapMask ;$441F
    jp ApplyRoomOverlapMask

applyCorridor08RoomOverlap: ;08:408A
    ld a, [wRoomScreen]
    cp a, $02
    jr z, .Label20096
    cp a, $04
    jr z, .Label2009C
    ret
.Label20096 ;08:4096
    ld de, Room08_02_overlapMask ;$443A
    jp ApplyRoomOverlapMask
.Label2009C
    ld de, Room08_04_overlapMask ;$4446
    jp ApplyRoomOverlapMask

ApplyZombieClosetRoomOverlap: ;08:40A2
    ld de, Room0E_00_overlapMask ;$445B
    ld a, [wRoomScreen]
    or a ;$00
    jp z, ApplyRoomOverlapMask
    ld de, Room0E_01_overlapMask ;$448E
    cp a, $01
    jp z, ApplyRoomOverlapMask
	;screen $02
    ld de, Room0E_02_overlapMask ;$44BB
    jp ApplyRoomOverlapMask

ApplyRoom10Overlap: ;08:40BA
    ld a, [wRoomScreen]
    or a ;$00
    jr z, .Label200C9
    cp a, $01
    jr z, .Label200CF
    cp a, $02
    jr z, .Label200DB
    ret
.Label200C9 ;08:40C9
    ld de, Room10_00_overlapMask ;$44CD
    jp ApplyRoomOverlapMask
.Label200CF
    ld de, Room10_01_overlapMaskA ;$44E2
    call ApplyRoomOverlapMask
    ld de, Room10_01_overlapMaskB ;$44F1
    jp ApplyRoomOverlapMask
.Label200DB
    ld de, Room10_02_overlapMask ;$4503
    jp ApplyRoomOverlapMask

ApplyCandleRoomOverlap: ;08:40E1
    ld a, [wRoomScreen]
    or a ;$00
    jr z, .Label200EC
    cp a, $01
    jr z, .Label200F2
    ret
.Label200EC ;08:40EC
    ld de, Room22_00_overlapMask ;$4518
    jp ApplyRoomOverlapMask
.Label200F2
    ld de, Room22_01_overlapMask ;$4533
    jp ApplyRoomOverlapMask

ApplyCorridor24Overlap ;08:40F8
    ld a, [wRoomScreen]
    or a ;$00
    jr z, .Label20103
    cp a, $04
    jr z, .Label20115
    ret
.Label20103 ;08:4103
    ld de, Room24_00_overlapMaskA ;$454E
    call ApplyRoomOverlapMask
    ld de, Room24_00_overlapMaskB ;$4560
    call ApplyRoomOverlapMask
    ld de, Room24_00_overlapMaskC ;$4572
    jp ApplyRoomOverlapMask
.Label20115
    ld de, Room24_04_overlapMaskA ;$4584
    call ApplyRoomOverlapMask
    ld de, Room24_04_overlapMaskB ;$45A2
    call ApplyRoomOverlapMask
    ld de, Room24_04_overlapMaskC ;$45AB
    jp ApplyRoomOverlapMask

ApplyInsectsRoomOverlap: ;08:4127
    ld a, [wRoomScreen]
    or a
    ret nz
	;screen $00
    ld de, Room29_00_overlapMask ;$45C3
    jp ApplyRoomOverlapMask

ApplyYawn1RoomOverlap: ;08:4132
    ld a, [wRoomScreen]
    cp a, $01
    jr z, .Label2013E
    cp a, $02
    jr z, .Label20150
    ret
.Label2013E ;08:413E
    ld de, Room2C_01_overlapMaskA ;$45E1
    call ApplyRoomOverlapMask
    ld de, Room2C_01_overlapMaskB ;$45F0
    call ApplyRoomOverlapMask
    ld de, Room2C_01_overlapMaskC ;$4602
    jp ApplyRoomOverlapMask
.Label20150
    ld de, Room2C_02_overlapMaskA ;$4611
    call ApplyRoomOverlapMask
    ld de, Room2C_02_overlapMaskB ;$4623
    call ApplyRoomOverlapMask
    ld de, Room2C_02_overlapMaskC ;$4638
    jp ApplyRoomOverlapMask

ApplyCorridor4CRoomOverlap: ;08:4162
    ld a, [spriteIdBuffer]
    cp a, WOODEN_BOX ;$F1
    ret nz ;apply only to wooden box
    ld a, [wRoomScreen]
    cp a, $05
    jr z, .Label20170
    ret
.Label20170 ;08:4170
    ld de, Room4C_05_overlapMask ;$4644
    jp ApplyRoomOverlapMask

ApplyDorm003RoomOverlap: ;08:4176
	ld a, [wRoomScreen]
    cp a, $01
    jr z, .Label2018A
    cp a, $02
    jr z, .Label20196
    cp a, $03
    jr z, .Label201A8
    cp a, $05
    jr z, .Label201AE
    ret
.Label2018A ;08:418A
    ld de, Room54_01_overlapMaskA ;$467A
    call ApplyRoomOverlapMask
    ld de, Room54_01_overlapMaskB ;$469E
    jp ApplyRoomOverlapMask
.Label20196
    ld de, Room54_02_overlapMaskA ;$4665
    call ApplyRoomOverlapMask
    ld de, Room54_02_overlapMaskB ;$4686
    call ApplyRoomOverlapMask
    ld de, Room54_02_overlapMaskC ;$46AD
    jp ApplyRoomOverlapMask
.Label201A8
    ld de, Room54_03_overlapMask ;$46C2
    jp ApplyRoomOverlapMask
.Label201AE
    ld de, Room54_05_overlapMask ;$4650
    jp ApplyRoomOverlapMask

ApplyRoomOverlapMask:: ;08:41B4
    ld a, [de]
    ld c, a
    ld a, [wSprtPriorYaxis]
    cp a, c
    jp c, NotApplyOverlap ;4392 if sprite is over overlap
    inc de
    inc de
    inc de
    ld a, [de]
    ld c, a
    ld a, [wSprtPriorY2axis]
    sub a, c ;Y2axis - [de]
    cp a, $80
    jp c, Label201ED ;jump if positive
	;else change sign
    xor a, $FF
    inc a
    ld [wOverlapC2FD], a
    ld b, a
    ld a, [wSprtPriorHeight]
    sub a, b
    cp a, $80
    jp nc, NotApplyOverlap
    or a
    jp z, NotApplyOverlap
    ld [wOverlapC2FE], a
    xor a
    ld [wOverlapC2FB], a
    ld [wOverlapC2FC], a
    inc de
    inc de
    jr Label20229
Label201ED:
    push hl
    ld l, a
    ld h, $00
    ld a, l
    ld [wOverlapC2FB], a
    ld a, h
    ld [wOverlapC2FC], a
    pop hl
    ld a, [wSprtPriorHeight]
    ld [wOverlapC2FE], a
    xor a
    ld [wOverlapC2FD], a
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    add a, c
    ld c, a
    ld a, [wSprtPriorY2axis]
    ld b, a
    ld a, [wSprtPriorHeight]
    add a, b
    sub a, c
    cp a, $80
    jr nc, .Label20228
    ld c, a
    ld a, [wOverlapC2FE]
    sub a, c
    ld [wOverlapC2FE], a
    cp a, $80
    jp nc, NotApplyOverlap
    or a
    jp z, NotApplyOverlap
.Label20228
    inc de
Label20229
    ld a, [de]
    ld b, a
    inc de
Loop2022C: ;08:422C
    push bc
    push de
    push hl
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld [wOverlapMaskAddrLow], a
    inc de
    ld a, [de]
    ld [wOverlapMaskAddrHigh], a
    push de
    ld a, [wOverlapC2FB]
    ld e, a
    ld a, [wOverlapC2FC]
    ld d, a
    ld a, [wOverlapMaskAddrLow]
    add a, e
    ld [wOverlapMaskAddrLow], a
    ld a, [wOverlapMaskAddrHigh]
    adc a, d
    ld [wOverlapMaskAddrHigh], a
    pop de
    ld a, [wSprtPriorXaxis]
    sub a, c
    cp a, $00
    jr z, .Label20275
    cp a, $80
    jr c, .Label2026C
    ld c, a
    cp a, $E1
    jp c, Label20387
    cp a, $E9
    jp c, Label2032C
    jr .Label20278
.Label2026C
    ld c, a
    cp a, $08
    jp nc, Label20387
    jp Label202F2
.Label20275
    ld c, a
    jr .Label20278
.Label20278
    ld a, c
    xor a, $FF
    inc a
    ld c, a
    and a, $1F
    srl a
    srl a
    srl a
    ld b, a
    ld a, [wSprtPriorHeight]
    and a, $F0
    ld e, a
    ld a, [wSprtPriorHeight]
    and a, $0F
    jr z, .Label20297
    ld a, e
    add a, $10
    ld e, a
.Label20297
    sla e
    ld d, $00
    ld a, b
    or a
    jr z, .Label202A3
.loop2029F
    add hl, de
    dec b
    jr nz, .loop2029F
.Label202A3
    ld a, c
    and a, $07
    ld c, a
    call Label20393
    ld a, [wOverlapC2FE]
    ld b, a
.loop202AE
    push bc
    push de
    push hl
    ld a, [wOverlapMaskAddrLow]
    ld l, a
    ld a, [wOverlapMaskAddrHigh]
    ld h, a
    ld e, [hl]
    ld d, $FF
    inc hl
    ld a, l
    ld [wOverlapMaskAddrLow], a
    ld a, h
    ld [wOverlapMaskAddrHigh], a
    pop hl
    ld a, c
    or a
    jr z, .Label202D5
.loop202CA
    srl e
    rr d
    ld a, e
    or a, $80
    ld e, a
    dec c
    jr nz, .loop202CA
.Label202D5
    ld c, e
    ld b, d
    ld a, [hl]
    and a, c
    ld [hli], a
    ld a, [hl]
    and a, c
    ldd [hl], a
    pop de
    add hl, de
    ld a, [hl]
    and a, b
    ld [hli], a
    ld a, [hl]
    and a, b
    ld [hli], a
    ld a, l
    sub a, e
    ld l, a
    ld a, h
    sbc a, d
    ld h, a
    pop bc
    dec b
    jr nz, .loop202AE
    jp Label20387
Label202F2:
    ld a, c
    and a, $07
    ld c, a
    call Label20393
    ld a, [wOverlapC2FE]
    ld b, a
.loop202FD
    push bc
    push hl
    ld a, [wOverlapMaskAddrLow]
    ld l, a
    ld a, [wOverlapMaskAddrHigh]
    ld h, a
    ld e, [hl]
    inc hl
    ld a, l
    ld [wOverlapMaskAddrLow], a
    ld a, h
    ld [wOverlapMaskAddrHigh], a
    pop hl
    ld a, c
    or a
    jr z, .Label2031F
.loop20316
    sla e
    ld a, e
    or a, $01
    ld e, a
    dec c
    jr nz, .loop20316
.Label2031F
    ld a, [hl]
    and a, e
    ld [hli], a
    ld a, [hl]
    and a, e
    ld [hli], a
    pop bc
    dec b
    jr nz, .loop202FD
    jp Label20387
Label2032C:
    ld a, [wSprtPriorHeight]
    and a, $F0
    ld e, a
    ld a, [wSprtPriorHeight]
    and a, $0F
    jr z, .Label2033D
    ld a, e
    add a, $10
    ld e, a
.Label2033D
    sla e
    ld d, $00
    add hl, de
    add hl, de
    add hl, de
    ld a, c
    xor a, $FF
    inc a
    and a, $07
    ld c, a
    call Label20393
    ld a, [wOverlapC2FE]
    ld b, a
.loop20352
    push bc
    push hl
    ld a, [wOverlapMaskAddrLow]
    ld l, a
    ld a, [wOverlapMaskAddrHigh]
    ld h, a
    ld e, [hl]
    ld d, $FF
    inc hl
    ld a, l
    ld [wOverlapMaskAddrLow], a
    ld a, h
    ld [wOverlapMaskAddrHigh], a
    pop hl
    ld a, c
    or a
    jr z, .Label20378
.loop2036D
    srl e
    rr d
    ld a, e
    or a, $80
    ld e, a
    dec c
    jr nz, .loop2036D
.Label20378
    ld c, e
    ld b, d
    ld a, [hl]
    and a, c
    ld [hli], a
    ld a, [hl]
    and a, c
    ld [hli], a
    pop bc
    dec b
    jr nz, .loop20352
    jp Label20387
Label20387:
    pop hl
    pop de
    inc de
    inc de
    inc de
    pop bc
    dec b
    jp nz, Loop2022C
    ret
NotApplyOverlap: ;08:4392
	ret

Label20393:: ;08:4393
    push de
    ld a, [wOverlapC2FD]
    add a
    ld e, a
    ld d, $00
    add hl, de
    pop de
    ret

;08:439E

INCLUDE "engine/roomsOverlapMaskTable.asm"

;08:46E3

room01_00_olmask_A1:		INCBIN "gfx/rooms_overlap_masks/room01_00_olmask_A1.2bpp" ;46E3
room01_00_olmask_A2:		INCBIN "gfx/rooms_overlap_masks/room01_00_olmask_A2.2bpp" ;470B
room01_00_olmask_B1:		INCBIN "gfx/rooms_overlap_masks/room01_00_olmask_B1.2bpp" ;4733
room01_00_olmask_B2:		INCBIN "gfx/rooms_overlap_masks/room01_00_olmask_B2.2bpp" ;4763
room01_00_olmask_B3:		INCBIN "gfx/rooms_overlap_masks/room01_00_olmask_B3.2bpp" ;4793
room01_02_olmask_A1:		INCBIN "gfx/rooms_overlap_masks/room01_02_olmask_A1.2bpp" ;47C3
room01_02_olmask_A2:		INCBIN "gfx/rooms_overlap_masks/room01_02_olmask_A2.2bpp" ;47EB
room01_02_olmask_B1:		INCBIN "gfx/rooms_overlap_masks/room01_02_olmask_B1.2bpp" ;4813
room01_02_olmask_B2:		INCBIN "gfx/rooms_overlap_masks/room01_02_olmask_B2.2bpp" ;483B
room04_00_olmask_A1:		INCBIN "gfx/rooms_overlap_masks/room04_00_olmask_A1.2bpp" ;4863
room04_00_olmask_A2:		INCBIN "gfx/rooms_overlap_masks/room04_00_olmask_A2.2bpp" ;48D3
room04_00_olmask_A3:		INCBIN "gfx/rooms_overlap_masks/room04_00_olmask_A3.2bpp" ;4943
room04_00_olmask_A4:		INCBIN "gfx/rooms_overlap_masks/room04_00_olmask_A4.2bpp" ;49B3
room04_00_olmask_A5:		INCBIN "gfx/rooms_overlap_masks/room04_00_olmask_A5.2bpp" ;4A23
room04_01_olmask_A1:		INCBIN "gfx/rooms_overlap_masks/room04_01_olmask_A1.2bpp" ;4A93
room04_01_olmask_A2:		INCBIN "gfx/rooms_overlap_masks/room04_01_olmask_A2.2bpp" ;4AF3
room04_01_olmask_A3:		INCBIN "gfx/rooms_overlap_masks/room04_01_olmask_A3.2bpp" ;4B53
room04_01_olmask_A4:		INCBIN "gfx/rooms_overlap_masks/room04_01_olmask_A4.2bpp" ;4BB3
room04_01_olmask_A5:		INCBIN "gfx/rooms_overlap_masks/room04_01_olmask_A5.2bpp" ;4C13
room04_02_olmask_A1:		INCBIN "gfx/rooms_overlap_masks/room04_02_olmask_A1.2bpp" ;4C73
room04_02_olmask_A2:		INCBIN "gfx/rooms_overlap_masks/room04_02_olmask_A2.2bpp" ;4CAB
room04_02_olmask_A3:		INCBIN "gfx/rooms_overlap_masks/room04_02_olmask_A3.2bpp" ;4CE3
room04_02_olmask_A4:		INCBIN "gfx/rooms_overlap_masks/room04_02_olmask_A4.2bpp" ;4D1B
room04_02_olmask_A5:		INCBIN "gfx/rooms_overlap_masks/room04_02_olmask_A5.2bpp" ;4D53
room04_02_olmask_A6:		INCBIN "gfx/rooms_overlap_masks/room04_02_olmask_A6.2bpp" ;4D8B
room04_02_olmask_A7:		INCBIN "gfx/rooms_overlap_masks/room04_02_olmask_A7.2bpp" ;4DC3
room04_02_olmask_A8:		INCBIN "gfx/rooms_overlap_masks/room04_02_olmask_A8.2bpp" ;4DFB
room04_02_olmask_A9:		INCBIN "gfx/rooms_overlap_masks/room04_02_olmask_A9.2bpp" ;4E33
room04_02_olmask_A10:		INCBIN "gfx/rooms_overlap_masks/room04_02_olmask_A10.2bpp" ;4E6B
room05_01_olmask_A1:		INCBIN "gfx/rooms_overlap_masks/room05_01_olmask_A1.2bpp" ;4EA3
room05_01_olmask_A2:		INCBIN "gfx/rooms_overlap_masks/room05_01_olmask_A2.2bpp" ;4EE3
room05_01_olmask_A3:		INCBIN "gfx/rooms_overlap_masks/room05_01_olmask_A3.2bpp" ;4F23
room05_01_olmask_A4:		INCBIN "gfx/rooms_overlap_masks/room05_01_olmask_A4.2bpp" ;4F63
room05_01_olmask_A5:		INCBIN "gfx/rooms_overlap_masks/room05_01_olmask_A5.2bpp" ;4FA3
room05_01_olmask_A6:		INCBIN "gfx/rooms_overlap_masks/room05_01_olmask_A6.2bpp" ;4FE3
room05_01_olmask_A7:		INCBIN "gfx/rooms_overlap_masks/room05_01_olmask_A7.2bpp" ;5023
room08_02_olmask_A1:		INCBIN "gfx/rooms_overlap_masks/room08_02_olmask_A1.2bpp" ;5063
room08_02_olmask_A2:		INCBIN "gfx/rooms_overlap_masks/room08_02_olmask_A2.2bpp" ;509B
room08_04_olmask_A1:		INCBIN "gfx/rooms_overlap_masks/room08_04_olmask_A1.2bpp" ;50D3
room08_04_olmask_A2:		INCBIN "gfx/rooms_overlap_masks/room08_04_olmask_A2.2bpp" ;50FB
room08_04_olmask_A3:		INCBIN "gfx/rooms_overlap_masks/room08_04_olmask_A3.2bpp" ;5123
room08_04_olmask_A4:		INCBIN "gfx/rooms_overlap_masks/room08_04_olmask_A4.2bpp" ;514B
room08_04_olmask_A5:		INCBIN "gfx/rooms_overlap_masks/room08_04_olmask_A5.2bpp" ;5173
room0E_00_olmask_A1:		INCBIN "gfx/rooms_overlap_masks/room0E_00_olmask_A1.2bpp" ;519B
room0E_00_olmask_A2:		INCBIN "gfx/rooms_overlap_masks/room0E_00_olmask_A2.2bpp" ;51BB
room0E_00_olmask_A3:		INCBIN "gfx/rooms_overlap_masks/room0E_00_olmask_A3.2bpp" ;51DB
room0E_00_olmask_A4:		INCBIN "gfx/rooms_overlap_masks/room0E_00_olmask_A4.2bpp" ;51FB
room0E_00_olmask_A5:		INCBIN "gfx/rooms_overlap_masks/room0E_00_olmask_A5.2bpp" ;521B
room0E_00_olmask_A6:		INCBIN "gfx/rooms_overlap_masks/room0E_00_olmask_A6.2bpp" ;523B
room0E_00_olmask_A7:		INCBIN "gfx/rooms_overlap_masks/room0E_00_olmask_A7.2bpp" ;525B
room0E_00_olmask_A8:		INCBIN "gfx/rooms_overlap_masks/room0E_00_olmask_A8.2bpp" ;527B
room0E_00_olmask_A9:		INCBIN "gfx/rooms_overlap_masks/room0E_00_olmask_A9.2bpp" ;529B
room0E_00_olmask_A10:		INCBIN "gfx/rooms_overlap_masks/room0E_00_olmask_A10.2bpp" ;52BB
room0E_00_olmask_A11:		INCBIN "gfx/rooms_overlap_masks/room0E_00_olmask_A11.2bpp" ;52DB
room0E_00_olmask_A12:		INCBIN "gfx/rooms_overlap_masks/room0E_00_olmask_A12.2bpp" ;52FB
room0E_00_olmask_A13:		INCBIN "gfx/rooms_overlap_masks/room0E_00_olmask_A13.2bpp" ;531B
room0E_00_olmask_A14:		INCBIN "gfx/rooms_overlap_masks/room0E_00_olmask_A14.2bpp" ;533B
room0E_00_olmask_A15:		INCBIN "gfx/rooms_overlap_masks/room0E_00_olmask_A15.2bpp" ;535B
room0E_01_olmask_A1:		INCBIN "gfx/rooms_overlap_masks/room0E_01_olmask_A1.2bpp" ;537B
room0E_01_olmask_A2:		INCBIN "gfx/rooms_overlap_masks/room0E_01_olmask_A2.2bpp" ;53A3
room0E_01_olmask_A3:		INCBIN "gfx/rooms_overlap_masks/room0E_01_olmask_A3.2bpp" ;53CB
room0E_01_olmask_A4:		INCBIN "gfx/rooms_overlap_masks/room0E_01_olmask_A4.2bpp" ;53F3
room0E_01_olmask_A5:		INCBIN "gfx/rooms_overlap_masks/room0E_01_olmask_A5.2bpp" ;541B
room0E_01_olmask_A6:		INCBIN "gfx/rooms_overlap_masks/room0E_01_olmask_A6.2bpp" ;5443
room0E_01_olmask_A7:		INCBIN "gfx/rooms_overlap_masks/room0E_01_olmask_A7.2bpp" ;546B
room0E_01_olmask_A8:		INCBIN "gfx/rooms_overlap_masks/room0E_01_olmask_A8.2bpp" ;5493
room0E_01_olmask_A9:		INCBIN "gfx/rooms_overlap_masks/room0E_01_olmask_A9.2bpp" ;54BB
room0E_01_olmask_A10:		INCBIN "gfx/rooms_overlap_masks/room0E_01_olmask_A10.2bpp" ;54E3
room0E_01_olmask_A11:		INCBIN "gfx/rooms_overlap_masks/room0E_01_olmask_A11.2bpp" ;550B
room0E_01_olmask_A12:		INCBIN "gfx/rooms_overlap_masks/room0E_01_olmask_A12.2bpp" ;5533
room0E_01_olmask_A13:		INCBIN "gfx/rooms_overlap_masks/room0E_01_olmask_A13.2bpp" ;555B
room0E_02_olmask_A1:		INCBIN "gfx/rooms_overlap_masks/room0E_02_olmask_A1.2bpp" ;5583
room0E_02_olmask_A2:		INCBIN "gfx/rooms_overlap_masks/room0E_02_olmask_A2.2bpp" ;55AB
room0E_02_olmask_A3:		INCBIN "gfx/rooms_overlap_masks/room0E_02_olmask_A3.2bpp" ;55D3
room0E_02_olmask_A4:		INCBIN "gfx/rooms_overlap_masks/room0E_02_olmask_A4.2bpp" ;55FB
room10_00_olmask_A1:		INCBIN "gfx/rooms_overlap_masks/room10_00_olmask_A1.2bpp" ;57DB
room10_00_olmask_A2:		INCBIN "gfx/rooms_overlap_masks/room10_00_olmask_A2.2bpp" ;5833
room10_00_olmask_A3:		INCBIN "gfx/rooms_overlap_masks/room10_00_olmask_A3.2bpp" ;588B
room10_00_olmask_A4:		INCBIN "gfx/rooms_overlap_masks/room10_00_olmask_A4.2bpp" ;58E3
room10_00_olmask_A5:		INCBIN "gfx/rooms_overlap_masks/room10_00_olmask_A5.2bpp" ;593B
room10_01_olmask_A1:		INCBIN "gfx/rooms_overlap_masks/room10_01_olmask_A1.2bpp" ;5993
room10_01_olmask_A2:		INCBIN "gfx/rooms_overlap_masks/room10_01_olmask_A2.2bpp" ;59D3
room10_01_olmask_A3:		INCBIN "gfx/rooms_overlap_masks/room10_01_olmask_A3.2bpp" ;5A13
room10_01_olmask_B1:		INCBIN "gfx/rooms_overlap_masks/room10_01_olmask_B1.2bpp" ;5A53
room10_01_olmask_B2:		INCBIN "gfx/rooms_overlap_masks/room10_01_olmask_B2.2bpp" ;5AA3
room10_01_olmask_B3:		INCBIN "gfx/rooms_overlap_masks/room10_01_olmask_B3.2bpp" ;5AF3
room10_01_olmask_B4:		INCBIN "gfx/rooms_overlap_masks/room10_01_olmask_B4.2bpp" ;5B43
room10_02_olmask_A1:		INCBIN "gfx/rooms_overlap_masks/room10_02_olmask_A1.2bpp" ;5B93
room10_02_olmask_A2:		INCBIN "gfx/rooms_overlap_masks/room10_02_olmask_A2.2bpp" ;5BD3
room10_02_olmask_A3:		INCBIN "gfx/rooms_overlap_masks/room10_02_olmask_A3.2bpp" ;5C13
room10_02_olmask_A4:		INCBIN "gfx/rooms_overlap_masks/room10_02_olmask_A4.2bpp" ;5C53
room10_02_olmask_A5:		INCBIN "gfx/rooms_overlap_masks/room10_02_olmask_A5.2bpp" ;5C93
room22_00_olmask_A1:		INCBIN "gfx/rooms_overlap_masks/room22_00_olmask_A1.2bpp" ;5CD3
room22_00_olmask_A2:		INCBIN "gfx/rooms_overlap_masks/room22_00_olmask_A2.2bpp" ;5CFB
room22_00_olmask_A3:		INCBIN "gfx/rooms_overlap_masks/room22_00_olmask_A3.2bpp" ;5D23
room22_00_olmask_A4:		INCBIN "gfx/rooms_overlap_masks/room22_00_olmask_A4.2bpp" ;5D4B
room22_00_olmask_A5:		INCBIN "gfx/rooms_overlap_masks/room22_00_olmask_A5.2bpp" ;5D73
room22_00_olmask_A6:		INCBIN "gfx/rooms_overlap_masks/room22_00_olmask_A6.2bpp" ;5D9B
room22_00_olmask_A7:		INCBIN "gfx/rooms_overlap_masks/room22_00_olmask_A7.2bpp" ;5DC3
room22_01_olmask_A1:		INCBIN "gfx/rooms_overlap_masks/room22_01_olmask_A1.2bpp" ;5DEB
room22_01_olmask_A2:		INCBIN "gfx/rooms_overlap_masks/room22_01_olmask_A2.2bpp" ;5E13
room22_01_olmask_A3:		INCBIN "gfx/rooms_overlap_masks/room22_01_olmask_A3.2bpp" ;5E3B
room22_01_olmask_A4:		INCBIN "gfx/rooms_overlap_masks/room22_01_olmask_A4.2bpp" ;5E63
room22_01_olmask_A5:		INCBIN "gfx/rooms_overlap_masks/room22_01_olmask_A5.2bpp" ;5E8B
room22_01_olmask_A6:		INCBIN "gfx/rooms_overlap_masks/room22_01_olmask_A6.2bpp" ;5EB3
room22_01_olmask_A7:		INCBIN "gfx/rooms_overlap_masks/room22_01_olmask_A7.2bpp" ;5EDB
room24_00_olmask_A1:		INCBIN "gfx/rooms_overlap_masks/room24_00_olmask_A1.2bpp" ;5F03
room24_00_olmask_A2:		INCBIN "gfx/rooms_overlap_masks/room24_00_olmask_A2.2bpp" ;5F33
room24_00_olmask_A3:		INCBIN "gfx/rooms_overlap_masks/room24_00_olmask_A3.2bpp" ;5F63
room24_00_olmask_A4:		INCBIN "gfx/rooms_overlap_masks/room24_00_olmask_A4.2bpp" ;5F93
room24_00_olmask_B1:		INCBIN "gfx/rooms_overlap_masks/room24_00_olmask_B1.2bpp" ;5FC3
room24_00_olmask_B2:		INCBIN "gfx/rooms_overlap_masks/room24_00_olmask_B2.2bpp" ;6013
room24_00_olmask_B3:		INCBIN "gfx/rooms_overlap_masks/room24_00_olmask_B3.2bpp" ;6063
room24_00_olmask_B4:		INCBIN "gfx/rooms_overlap_masks/room24_00_olmask_B4.2bpp" ;60B3
room24_00_olmask_C1:		INCBIN "gfx/rooms_overlap_masks/room24_00_olmask_C1.2bpp" ;6103
room24_00_olmask_C2:		INCBIN "gfx/rooms_overlap_masks/room24_00_olmask_C2.2bpp" ;613B
room24_00_olmask_C3:		INCBIN "gfx/rooms_overlap_masks/room24_00_olmask_C3.2bpp" ;6173
room24_00_olmask_C4:		INCBIN "gfx/rooms_overlap_masks/room24_00_olmask_C4.2bpp" ;61AB
room24_04_olmask_A1:		INCBIN "gfx/rooms_overlap_masks/room24_04_olmask_A1.2bpp" ;61E3
room24_04_olmask_A2:		INCBIN "gfx/rooms_overlap_masks/room24_04_olmask_A2.2bpp" ;620B
room24_04_olmask_A3:		INCBIN "gfx/rooms_overlap_masks/room24_04_olmask_A3.2bpp" ;6233
room24_04_olmask_A4:		INCBIN "gfx/rooms_overlap_masks/room24_04_olmask_A4.2bpp" ;625B
room24_04_olmask_A5:		INCBIN "gfx/rooms_overlap_masks/room24_04_olmask_A5.2bpp" ;6283
room24_04_olmask_A6:		INCBIN "gfx/rooms_overlap_masks/room24_04_olmask_A6.2bpp" ;62AB
room24_04_olmask_A7:		INCBIN "gfx/rooms_overlap_masks/room24_04_olmask_A7.2bpp" ;62D3
room24_04_olmask_A8:		INCBIN "gfx/rooms_overlap_masks/room24_04_olmask_A8.2bpp" ;62FB
room24_04_olmask_B1:		INCBIN "gfx/rooms_overlap_masks/room24_04_olmask_B1.2bpp" ;6323
room24_04_olmask_C1:		INCBIN "gfx/rooms_overlap_masks/room24_04_olmask_C1.2bpp" ;638B
room24_04_olmask_C2:		INCBIN "gfx/rooms_overlap_masks/room24_04_olmask_C2.2bpp" ;63B3
room24_04_olmask_C3:		INCBIN "gfx/rooms_overlap_masks/room24_04_olmask_C3.2bpp" ;63DB
room24_04_olmask_C4:		INCBIN "gfx/rooms_overlap_masks/room24_04_olmask_C4.2bpp" ;6403
room24_04_olmask_C5:		INCBIN "gfx/rooms_overlap_masks/room24_04_olmask_C5.2bpp" ;642B
room24_04_olmask_C6:		INCBIN "gfx/rooms_overlap_masks/room24_04_olmask_C6.2bpp" ;6453
room29_00_olmask_A1:		INCBIN "gfx/rooms_overlap_masks/room29_00_olmask_A1.2bpp" ;64A3
room29_00_olmask_A2:		INCBIN "gfx/rooms_overlap_masks/room29_00_olmask_A2.2bpp" ;64EB
room29_00_olmask_A3:		INCBIN "gfx/rooms_overlap_masks/room29_00_olmask_A3.2bpp" ;6533
room29_00_olmask_A4:		INCBIN "gfx/rooms_overlap_masks/room29_00_olmask_A4.2bpp" ;657B
room29_00_olmask_A5:		INCBIN "gfx/rooms_overlap_masks/room29_00_olmask_A5.2bpp" ;65C3
room29_00_olmask_A6:		INCBIN "gfx/rooms_overlap_masks/room29_00_olmask_A6.2bpp" ;660B
room29_00_olmask_A7:		INCBIN "gfx/rooms_overlap_masks/room29_00_olmask_A7.2bpp" ;6653
room29_00_olmask_A8:		INCBIN "gfx/rooms_overlap_masks/room29_00_olmask_A8.2bpp" ;669B
room2C_01_olmask_A1:		INCBIN "gfx/rooms_overlap_masks/room2C_01_olmask_A1.2bpp" ;66E3
room2C_01_olmask_A2:		INCBIN "gfx/rooms_overlap_masks/room2C_01_olmask_A2.2bpp" ;6723
room2C_01_olmask_A3:		INCBIN "gfx/rooms_overlap_masks/room2C_01_olmask_A3.2bpp" ;6763
room2C_01_olmask_B1:		INCBIN "gfx/rooms_overlap_masks/room2C_01_olmask_B1.2bpp" ;67A3
room2C_01_olmask_B2:		INCBIN "gfx/rooms_overlap_masks/room2C_01_olmask_B2.2bpp" ;67CB
room2C_01_olmask_B3:		INCBIN "gfx/rooms_overlap_masks/room2C_01_olmask_B3.2bpp" ;67F3
room2C_01_olmask_B4:		INCBIN "gfx/rooms_overlap_masks/room2C_01_olmask_B4.2bpp" ;681B
room2C_01_olmask_C1:		INCBIN "gfx/rooms_overlap_masks/room2C_01_olmask_C1.2bpp" ;6843
room2C_01_olmask_C2:		INCBIN "gfx/rooms_overlap_masks/room2C_01_olmask_C2.2bpp" ;687B
room2C_01_olmask_C3:		INCBIN "gfx/rooms_overlap_masks/room2C_01_olmask_C3.2bpp" ;68B3
room2C_02_olmask_A1:		INCBIN "gfx/rooms_overlap_masks/room2C_02_olmask_A1.2bpp" ;68EB
room2C_02_olmask_A2:		INCBIN "gfx/rooms_overlap_masks/room2C_02_olmask_A2.2bpp" ;692B
room2C_02_olmask_A3:		INCBIN "gfx/rooms_overlap_masks/room2C_02_olmask_A3.2bpp" ;696B
room2C_02_olmask_B1:		INCBIN "gfx/rooms_overlap_masks/room2C_02_olmask_B1.2bpp" ;69AB
room2C_02_olmask_B2:		INCBIN "gfx/rooms_overlap_masks/room2C_02_olmask_B2.2bpp" ;69CB
room2C_02_olmask_B3:		INCBIN "gfx/rooms_overlap_masks/room2C_02_olmask_B3.2bpp" ;69EB
room2C_02_olmask_B4:		INCBIN "gfx/rooms_overlap_masks/room2C_02_olmask_B4.2bpp" ;6A0B
room2C_02_olmask_C1:		INCBIN "gfx/rooms_overlap_masks/room2C_02_olmask_C1.2bpp" ;6A2B
room2C_02_olmask_C2:		INCBIN "gfx/rooms_overlap_masks/room2C_02_olmask_C2.2bpp" ;6A63
room4C_05_olmask_A1:		INCBIN "gfx/rooms_overlap_masks/room4C_05_olmask_A1.2bpp" ;6A9B
room4C_05_olmask_A2:		INCBIN "gfx/rooms_overlap_masks/room4C_05_olmask_A2.2bpp" ;6AB3
room54_05_olmask_A1:		INCBIN "gfx/rooms_overlap_masks/room54_05_olmask_A1.2bpp" ;6ACB
room54_05_olmask_A2:		INCBIN "gfx/rooms_overlap_masks/room54_05_olmask_A2.2bpp" ;6B0B
room54_05_olmask_A3:		INCBIN "gfx/rooms_overlap_masks/room54_05_olmask_A3.2bpp" ;6B4B
room54_05_olmask_A4:		INCBIN "gfx/rooms_overlap_masks/room54_05_olmask_A4.2bpp" ;6B8B
room54_05_olmask_A5:		INCBIN "gfx/rooms_overlap_masks/room54_05_olmask_A5.2bpp" ;6BCB
room54_02_olmask_A1:		INCBIN "gfx/rooms_overlap_masks/room54_02_olmask_A1.2bpp" ;6C0B
room54_02_olmask_A2:		INCBIN "gfx/rooms_overlap_masks/room54_02_olmask_A2.2bpp" ;6C4B
room54_02_olmask_A3:		INCBIN "gfx/rooms_overlap_masks/room54_02_olmask_A3.2bpp" ;6C8B
room54_02_olmask_A4:		INCBIN "gfx/rooms_overlap_masks/room54_02_olmask_A4.2bpp" ;6CCB
room54_02_olmask_A5:		INCBIN "gfx/rooms_overlap_masks/room54_02_olmask_A5.2bpp" ;6D0B
room54_01_olmask_A1:		INCBIN "gfx/rooms_overlap_masks/room54_01_olmask_A1.2bpp" ;6D4B
room54_01_olmask_A2:		INCBIN "gfx/rooms_overlap_masks/room54_01_olmask_A2.2bpp" ;6D8B
room54_02_olmask_B1:		INCBIN "gfx/rooms_overlap_masks/room54_02_olmask_B1.2bpp" ;6DCB
room54_02_olmask_B2:		INCBIN "gfx/rooms_overlap_masks/room54_02_olmask_B2.2bpp" ;6E03
room54_02_olmask_B3:		INCBIN "gfx/rooms_overlap_masks/room54_02_olmask_B3.2bpp" ;6E3B
room54_02_olmask_B4:		INCBIN "gfx/rooms_overlap_masks/room54_02_olmask_B4.2bpp" ;6E73
room54_02_olmask_B5:		INCBIN "gfx/rooms_overlap_masks/room54_02_olmask_B5.2bpp" ;6EAB
room54_02_olmask_B6:		INCBIN "gfx/rooms_overlap_masks/room54_02_olmask_B6.2bpp" ;6EE3
room54_01_olmask_B1:		INCBIN "gfx/rooms_overlap_masks/room54_01_olmask_B1.2bpp" ;6F1B
room54_01_olmask_B2:		INCBIN "gfx/rooms_overlap_masks/room54_01_olmask_B2.2bpp" ;6F3B
room54_01_olmask_B3:		INCBIN "gfx/rooms_overlap_masks/room54_01_olmask_B3.2bpp" ;6F5B
room54_02_olmask_C1:		INCBIN "gfx/rooms_overlap_masks/room54_02_olmask_C1.2bpp" ;6F7B
room54_02_olmask_C2:		INCBIN "gfx/rooms_overlap_masks/room54_02_olmask_C2.2bpp" ;6FD3
room54_02_olmask_C3:		INCBIN "gfx/rooms_overlap_masks/room54_02_olmask_C3.2bpp" ;702B
room54_02_olmask_C4:		INCBIN "gfx/rooms_overlap_masks/room54_02_olmask_C4.2bpp" ;7083
room54_02_olmask_C5:		INCBIN "gfx/rooms_overlap_masks/room54_02_olmask_C5.2bpp" ;70DB
room54_03_olmask_A1:		INCBIN "gfx/rooms_overlap_masks/room54_03_olmask_A1.2bpp" ;7133
room54_03_olmask_A2:		INCBIN "gfx/rooms_overlap_masks/room54_03_olmask_A2.2bpp" ;717B
room54_03_olmask_A3:		INCBIN "gfx/rooms_overlap_masks/room54_03_olmask_A3.2bpp" ;71C3
room54_03_olmask_A4:		INCBIN "gfx/rooms_overlap_masks/room54_03_olmask_A4.2bpp" ;720B
room54_03_olmask_A5:		INCBIN "gfx/rooms_overlap_masks/room54_03_olmask_A5.2bpp" ;7253
room54_03_olmask_A6:		INCBIN "gfx/rooms_overlap_masks/room54_03_olmask_A6.2bpp" ;729B
room54_03_olmask_A7:		INCBIN "gfx/rooms_overlap_masks/room54_03_olmask_A7.2bpp" ;72E3
room54_03_olmask_A8:		INCBIN "gfx/rooms_overlap_masks/room54_03_olmask_A8.2bpp" ;732B
room54_03_olmask_A9:		INCBIN "gfx/rooms_overlap_masks/room54_03_olmask_A9.2bpp" ;7373

;main hall pillar sprites
main_hall_pillar_01:		INCBIN "gfx/room_items_sprites/main_hall_pillar_01.2bpp" ;73BB
main_hall_pillar_02:		INCBIN "gfx/room_items_sprites/main_hall_pillar_02.2bpp" ;73FB
main_hall_pillar_03:		INCBIN "gfx/room_items_sprites/main_hall_pillar_03.2bpp" ;743B
main_hall_pillar_04:		INCBIN "gfx/room_items_sprites/main_hall_pillar_04.2bpp" ;747B
main_hall_pillar_05:		INCBIN "gfx/room_items_sprites/main_hall_pillar_05.2bpp" ;74BB
main_hall_pillar_06:		INCBIN "gfx/room_items_sprites/main_hall_pillar_06.2bpp" ;74FB
main_hall_pillar_07:		INCBIN "gfx/room_items_sprites/main_hall_pillar_07.2bpp" ;757B
main_hall_pillar_08:		INCBIN "gfx/room_items_sprites/main_hall_pillar_08.2bpp" ;763B
main_hall_pillar_09:		INCBIN "gfx/room_items_sprites/main_hall_pillar_09.2bpp" ;76FB
main_hall_pillar_10:		INCBIN "gfx/room_items_sprites/main_hall_pillar_10.2bpp" ;781B
main_hall_pillar_11:		INCBIN "gfx/room_items_sprites/main_hall_pillar_11.2bpp" ;789B
main_hall_pillar_12:		INCBIN "gfx/room_items_sprites/main_hall_pillar_12.2bpp" ;791B
rest_stop_corridor_lamp:	INCBIN "gfx/room_items_sprites/rest_stop_corridor_lamp.2bpp" ;799B


;7A9B
db "BANK8"
;7AA0


SECTION "bank9",ROMX,BANK[$9]

map_preview_pallete:			INCBIN "gfx/main_menu/map_preview_pallete.pal" ;4000

mapDetailPallete:				INCBIN "gfx/main_menu/map_detail_pallete.pal" ;4040

itemCheckOptionPallete:			INCBIN "gfx/main_menu/item_check_option.pal" ;4080
itemCombineOptionPallete:		INCBIN "gfx/main_menu/item_combine_option.pal" ;40C0
itemUseEquipOptionPallete:		INCBIN "gfx/main_menu/item_use_equip_option.pal" ;4100

mansionMapPreview01Data:		INCBIN "gfx/main_menu/mansion_map_preview_01.2bpp" ;4140 mansion only
mansionMapPreview02Data:		INCBIN "gfx/main_menu/mansion_map_preview_02.2bpp" ;4360 mansion & guardhouse (unused)
mansionMapPreview03Data:		INCBIN "gfx/main_menu/mansion_map_preview_03.2bpp" ;4650 mansion, courtyard & guardhouse (unused)
mansionMapPreview04Data:		INCBIN "gfx/main_menu/mansion_map_preview_04.2bpp" ;4A20 same as map 03 (unused)

fileBook01TilesData:			INCBIN "gfx/main_menu/filebook_01.2bpp" ;4DF0
fileBook02TilesData:			INCBIN "gfx/main_menu/filebook_02.2bpp" ;5040
fileBook03TilesData:			INCBIN "gfx/main_menu/filebook_03.2bpp" ;52B0
itemCheckOptionData:			INCBIN "gfx/main_menu/item_check_option.2bpp" ;5500
itemCombineOptionData:			INCBIN "gfx/main_menu/item_combine_option.2bpp" ;56B0
itemUseEquipOptionData:			INCBIN "gfx/main_menu/item_use_equip_option.2bpp" ;5860

;5A10 rest of bank empty


SECTION "bankA",ROMX,BANK[$A]

INCLUDE "engine/scaling/horizontalScalingTable.asm"

;0A:5A00 rest of bank empty

SECTION "bankB",ROMX,BANK[$B]

INCLUDE "engine/scaling/cameraPitchYawTable.asm" ;4000

;0B:5000
doorsSpritesheet: 	INCBIN "gfx/sprite_sheets/doors/doors_spritesheet.2bpp"
;0B:5900

doorsBGPallete:		INCBIN "gfx/doorSpritePallete.pal" ;5900


SECTION "bankC",ROMX,BANK[$C]

MainMenuBgData:		INCBIN "gfx/tilemaps/mainMenu.2bpp" ;4000
MainMenuPallete:	INCBIN "gfx/tilemaps/mainMenu.pal" ;4DC4

GreyPallete: 		INCBIN "gfx/greyPallete.pal" ;4E44

MainMenuFaces:		INCBIN "gfx/main_menu_faces.2bpp" ;4E84

FiregunTiles: 		INCBIN "gfx/firegun_tiles.2bpp" ;4F04

;0C:4FC0 rest of bank empty

SECTION "bankD",ROMX,BANK[$D]

chrisDeathScreenData: 			INCBIN "gfx/tilemaps/chrisDeathScreen.2bpp" ;4000
chrisDeathScreenPallete: 		INCBIN "gfx/tilemaps/chrisDeathScreen.pal" ;4B60

pauseScreenData: 				INCBIN "gfx/tilemaps/pauseScreen.2bpp" ;4BB0
pauseScreenPallete: 			INCBIN "gfx/tilemaps/pauseScreen.pal" ;56F0

LoadSaveMenuTiles: 				INCBIN "gfx/tilemaps/loadSaveMenu.2bpp" ;5740
loadSaveMenuFonts: 				INCBIN "gfx/tilemaps/loadSaveMenuFonts.2bpp" ;6700
loadSaveMenuIndexes: 			INCBIN "gfx/tilemaps/loadSaveMenuIndexes.2bpp" ;6930
loadSaveMenuPal: 				INCBIN "gfx/tilemaps/loadSaveMenu.pal" ;6C48


SECTION "bankE",ROMX,BANK[$E]

INCLUDE "events/eventsLookupTable.asm"

displayEvent:: ;0E:409A
    xor a
    ld [wLoadEventBgImagePal], a ;reset var
    ld hl, _ChrisEventsTable ;$4000
    ld a, [wSelectedPlayer]
    or a
    jr z, .Label380AA ;jump if chris
	;if jill
    ld hl, _JillEventsTable ;$403A
.Label380AA
    ld a, [wEventId]
    cp a, $80
    jr c, .Label380B6 ;jump if event Id is positive
	;else point to commons events table
    ld hl, _CommonEventsTable ;$4082
    sub a, $7F
.Label380B6
	;get event pointer ( ((id - 1) * 2) + HL)
    dec a
    add a
    ld e, a
    ld d, $00
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
Label380BF: ;0E:40BF
    ld a, [hli]
    cp a, END_EVENT ;$1D
    jp z, endEvent ;terminate
    cp a, RECEIVE_ITEM ;$3C
    jp z, getItemInEvent
    ld de, Label3820C ;$420C
    push de ;store return address
    cp a, LOAD_ROOM ;$00
    jp z, loadEventRoomBg
    cp a, CHRIS_EVENT_DATA ;$01
    jp z, loadChrisEventData
    cp a, JILL_EVENT_DATA ;$02
    jp z, loadJillEventData ;Label3A0D8
    cp a, WESKER_EVENT_DATA ;$03
    jp z, loadWeskerEventData ;Label3A0DF
    cp a, REBECCA_EVENT_DATA ;$04
    jp z, loadRebeccaEventData ;Label3A0E6
    cp a, BARRY_EVENT_DATA ;$32
    jp z, loadBarryEventData
    cp a, SPRITE_9E_EVENT_DATA ;$34
    jp z, load9ESpriteData
    cp a, ZOMBIE_EVENT_DATA ;$33
    jp z, loadZombieEventData
    cp a, FADEIN_SCREEN ;$05
    jp z, eventFadeInScreen ;615B
    cp a, EVENT_WAIT ;$06
    jp z, eventFrameDelay
    cp a, CHANGE_ROOM_SCREEN ;$07
    jp z, eventChangeScreen
    cp a, CHANGE_PLAYER_ANIM ;$08
    jp z, changePlayerSpriteAnimFrame
    cp a, CHANGE_NPC1_ANIM ;$09
    jp z, changeNPC1SpriteAnimFrame
    cp a, CHANGE_NPC2_ANIM ;$0A
    jp z, changeNPC2SpriteAnimFrame
    cp a, CHANGE_NPC3_ANIM ;$0B
    jp z, changeNPC3SpriteAnimFrame
    cp a, CHANGE_NPC4_ANIM ;$35
    jp z, changeNPC4SpriteAnimFrame
    cp a, CHANGE_NPC6_ANIM ;$38
    jp z, changeNPC6SpriteAnimFrame
    cp a, SHOW_CHRIS_MESSAGE ;$0C
    jp z, showChrisEventMessage
    cp a, SHOW_JILL_MESSAGE ;$0D
    jp z, showJillEventMessage
    cp a, SHOW_WESKER_MESSAGE ;$0E
    jp z, showWeskerEventMessage
    cp a, SHOW_REBECCA_MESSAGE ;$0F
    jp z, showRebeccaEventMessage
    cp a, SHOW_BARRY_MESSAGE ;$2E
    jp z, showBarryEventMessage
    cp a, SHOW_ENRICO_MESSAGE ;$2D
    jp z, showEnricoEventMessage
    cp a, SHOW_SELF_DESTRUCT_MSG ;$2F
    jp z, showLabSelfDestructEventMassage
    cp a, SHOW_RICHARD_MESSAGE ;$3D
    jp z, showRichardEventMessage
    cp a, SHOW_BRAD_MESSAGE ;$40
    jp z, showBradEventMessage
    cp a, SHOW_MISTERY_MESSAGE ;$41
    jp z, showMisteriousPersonEventMessage
    cp a, CHANGE_PLAYER_FACING ;$10
    jp z, changePlayerFacing
    cp a, CHANGE_NPC1_FACING ;$11
    jp z, changeNPC1Facing
    cp a, CHANGE_NPC2_FACING ;$12
    jp z, changeNPC2Facing
    cp a, CHANGE_NPC3_FACING ;$13
    jp z, changeNPC3Facing
    cp a, CHANGE_NPC4_FACING ;$30
    jp z, changeNPC4Facing
    cp a, CHANGE_NPC6_FACING ;$37
    jp z, changeNPC6Facing
    cp a, PLAY_SFX ;$1C
    jp z, playEventSFX
    cp a, MOVE_WALK_PLAYER ;$14
    jp z, moveWalkingEventPlayer
    cp a, MOVE_WALK_NPC1 ;$15
    jp z, moveWalkingEventNPC1
    cp a, MOVE_WALK_NPC2 ;$16
    jp z, moveWalkingEventNPC2
    cp a, MOVE_WALK_NPC3 ;$17
    jp z, moveWalkingEventNPC3
    cp a, MOVE_WALK_NPC4 ;$23
    jp z, moveWalkingEventNPC4
    cp a, MOVE_WALK_NPC5 ;$24
    jp z, moveWalkingEventNPC5
    cp a, MOVE_WALK_NPC6 ;$25
    jp z, moveWalkingEventNPC6
    cp a, MOVE_RUN_PLAYER ;$18
    jp z, moveRunningEventPlayer
    cp a, MOVE_RUN_NPC1 ;$19
    jp z, moveRunningEventNPC1
    cp a, MOVE_RUN_NPC2 ;$1A
    jp z, moveRunningEventNPC2
    cp a, MOVE_RUN_NPC3 ;$1B
    jp z, moveRunningEventNPC3
    cp a, MOVE_RUN_NPC4 ;$2C
    jp z, moveRunningEventNPC4
    cp a, MOVE_WALK_BACKWARD_PLAYER ;$26
    jp z, moveWalkBackwardPlayer
    cp a, MOVE_WALK_BACKWARD_NPC1 ;$27
    jp z, moveWalkBackwardNPC1
    cp a, MOVE_WALK_BACKWARD_NPC3 ;$28
    jp z, moveWalkBackwardNPC3
    cp a, MOVE_WALK_BACKWARD_NPC2 ;$29
    jp z, moveWalkBackwardNPC2
    cp a, MOVE_WALK_BACKWARD_NPC4 ;$2A
    jp z, moveWalkBackwardNPC4
    cp a, MOVE_WALK_BACKWARD_NPC5 ;$2B
    jp z, moveWalkBackwardNPC5
    cp a, SCREEN_PANNING_UP ;$1F
    jp z, eventScreenPanningUp
    cp a, SCREEN_PANNING_DOWN ;$1E
    jp z, eventScreenPanningDown
    cp a, FADEOUT_SCREEN ;$20
    jp z, eventFadeOutScreen
    cp a, SHOW_DOOR_ANIMATION ;$21
    jp z, eventDoorAnimation
    cp a, SHAKE_SCREEN ;$36
    jp z, shakeScreen
    cp a, LOAD_SPRITES ;$22
    jp z, callEventSpriteLoadFunctions ;63CC
    cp a, RESET_ALL_CHARS_DATA ;$39
    jp z, resetAllCharsData
    cp a, SHOW_BG_IMAGE ;$3A
    jp z, eventBgImage
    cp a, COPY_NPC1_DATA_TO_PLAYER ;$3B
    jp z, copyNPC1DataToPlayerData
    cp a, TIGER_AND_JEWEL_STATUE ;$3E
    jp z, tigerAndJewelStatuesTrigger
    cp a, LOAD_ROOM_MASK ;$3F
    jp z, goToLoadEventBgMask
	;if event action is unknown, restart game
    jp InitGame
Label3820C:
    jp Label380BF
endEvent:
    ld a, $FF
    ret

getItemInEvent: ;0E:4212
    ld a, [hli]
    ld [selectedItemId], a
    ld a, [hli]
    ld [wItemTriggerId], a
    ret

;0E:421B
INCLUDE "events/chrisEventsScripts.asm"
INCLUDE "events/jillEventsScripts.asm"
INCLUDE "events/commonEventsScripts.asm"
;5FD1

copyNPC1DataToPlayerData: ;0E:5FD1
    push hl
    ld hl, wNPCSpritesData
    ld de, wCharSpritesData
    ld b, $20
Loop39FDA
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, Loop39FDA
    pop hl
    ret
;5FE2

tigerAndJewelStatuesTrigger: ;0E:5FE2
    ld a, [hli]
    or a ;$00
    jp z, tigerStatueBlueJewelSide
    cp a, $01
    jp z, tigerStatueRedJewelSide
    cp a, $02
    jp z, disableDinningRoomJewelStatue
    ret
;5FF2

tigerStatueBlueJewelSide: ;0E:5FF2
    ld a, [wTigerStatueRotateDirection]
    dec a
    ld [wTigerStatueRotateDirection], a
    ret
;5FFA

tigerStatueRedJewelSide: ;0E:5FFA
    ld a, [wTigerStatueRotateDirection]
    inc a
    ld [wTigerStatueRotateDirection], a
    ret
;6002

disableDinningRoomJewelStatue: ;0E:6002
    xor a
    ld [wTriggerJewelStatue2F], a
    ld a, $FF
    ld [wTriggerJewelDinningRoom], a
    ld [wTriggerBrokenStatue], a
    push hl
    ld de, wNPCSpritesData
    ld b, $07
Loop3A014
    ld hl, wCharSpritesData - wCharSpritesData ;$0
    add hl, de
    ld a, [hl]
    and a, $80
    jr z, Label3A026 ;jump if NPC1 is disabled
    ld hl, wSpriteId - wCharSpritesData ;$B
    add hl, de
    ld a, [hl]
    cp a, JEWEL_STATUE ;$E1
    jr z, disableNPCSprite
Label3A026
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    dec b
    jr nz, Loop3A014 ;jump to next NPC
    pop hl
    ret
;6033

disableNPCSprite: ;0E:6033
    ld hl, wCharSpritesData - wCharSpritesData ;$0
    add hl, de
    ld [hl], $00 ;disable sprite
    pop hl
    ret
;603B

shakeScreen: ;0E:603B
    call haltCPU
    ld a, [wScreenYPos]
    sub a, $01
    ld [wScreenYPos], a
    call callEventSpriteLoadFunctions
    call haltCPU
    ld a, [wScreenYPos]
    add a, $02
    ld [wScreenYPos], a
    call callEventSpriteLoadFunctions
    call haltCPU
    ld a, [wScreenYPos]
    sub a, $02
    ld [wScreenYPos], a
    call callEventSpriteLoadFunctions
    call haltCPU
    ld a, [wScreenYPos]
    add a, $01
    ld [wScreenYPos], a
    call callEventSpriteLoadFunctions
    ret
;6074

eventScreenPanningUp: ;0E:6074
    ld b, $10 ;panning pixels
Loop3A076
    push bc
    ld a, [wScreenYPos]
    inc a ;panning up
    ld [wScreenYPos], a
    call callEventSpriteLoadFunctions
    call haltCPU
    call haltCPU
    pop bc
    dec b
    jr nz, Loop3A076
    ret
;608C

eventScreenPanningDown: ;0E:608C
    ld b, $10
Loop3A08E
    push bc
    ld a, [wScreenYPos]
    dec a ;panning down
    ld [wScreenYPos], a
    call callEventSpriteLoadFunctions
    call haltCPU
    call haltCPU
    pop bc
    dec b
    jr nz, Loop3A08E
    ret
;60A4

loadEventRoomBg: ;0E:60A4
    ld a, [hli]
    ld [wRoomId], a
    xor a
    ld [wRoomIdHigh], a
    ld	a, [hli]
    ld [wRoomScreen], a
    push hl
    call loadStoredRoomBg ;$0664
    pop hl
    ret

;0E:60B6

goToLoadEventBgMask: ;0E:60B6
    push hl
    call loadEventBgMask ;$6FB
    pop hl
    ret
;60BC

loadBarryEventData: ;0E:60BC
    ld de, wNPCSpritesData+$60 ;$C380
    ld a, BARRY ;$96
    jr Label3A0EB
load9ESpriteData:
    ld de, wNPCSpritesData+$80 ;$C3A0
    ld a, $9E
    jr Label3A0EB
loadZombieEventData:
    ld de, wNPCSpritesData+$A0 ;$C3C0
    ld a, ZOMBIE ;$98
    jr Label3A0EB
loadChrisEventData: ;0E:60D1
    ld de, wCharSpritesData
    ld a, CHRIS ;$92
    jr Label3A0EB
loadJillEventData:
    ld de, wNPCSpritesData
    ld a, JILL ;$93
    jr Label3A0EB
loadWeskerEventData:
    ld de, wNPCSpritesData+$20 ;$C340
    ld a, WESKER ;$94
    jr Label3A0EB
loadRebeccaEventData:
    ld de, wNPCSpritesData+$40 ;$C360
    ld a, REBECCA ;$95
Label3A0EB
    push hl
    ld c, l
    ld b, h ;set pointer to bc
    push af ;store sprite Id
    pop af
    ld hl, wSpriteId - wCharSpritesData ;$000B
    add hl, de
    ld [hl], a
    ld a, [wCharHealth]
    ld hl, wCharHealth - wCharSpritesData ;$000E
    add hl, de
    ld [hl], a ;set current player health to event sprites
    ld hl, wCharSpritesData - wCharSpritesData ;$0000
    add hl, de
    ld [hl], %11000000 ;$C0
    ld hl, wSpritePositionXLow - wCharSpritesData ;$0011
    add hl, de
    ld a, [bc]
    ld [hli], a
    inc bc
    ld a, [bc]
    ld [hl], a ;wSpritePositionXHigh
    inc bc
    ld hl, wSpritePositionZLow - wCharSpritesData ;$0013
    add hl, de
    ld a, [bc]
    ld [hli], a
    inc bc
    ld a, [bc]
    ld [hl], a ;wSpritePositionZHigh
    inc bc
    ld hl, wSpriteFacing - wCharSpritesData ;$0009
    add hl, de
    ld a, [bc]
    ld [hl], a
    inc bc
    inc bc
    ld hl, wSpriteAnimationId - wCharSpritesData ;$0006
    add hl, de
    ld a, [bc]
    ld [hl], a
    inc bc
    ld hl, wSpriteAnimationFrameId - wCharSpritesData ;$0007
    add hl, de
    ld a, [bc]
    ld [hl], a
    inc bc
    ld hl, wZombieAndObjectVarId - wCharSpritesData ;$000F
    add hl, de
    ld [hl], $FF
    ld hl, wSpriteDataC31D - wCharSpritesData ;$001D
    add hl, de
    ld a, [bc]
    ld [hli], a
    inc bc
    ld a, [bc]
    ld [hl], a ;wSpriteDataC31E
    pop hl
    ld de, $000A
    add hl, de
    ret

;0E:6142

eventDoorAnimation: ;0E:6142
    ld a, [hl]
    ld [wDoorAnimationType], a
    srl a
    srl a
    srl a
    ld [wDoorSpriteId], a
    ld a, [hli]
    and a, $07
    ld [wDoorPalleteId], a
    push hl
    call showEventDoorAnimation ;6B5
    pop hl
    ret
;615B

eventFadeInScreen: ;0E:615B
    push hl
    ld c, $1F
    call FadeScreen ;$067A
    pop hl
    ret
;6163

eventFadeOutScreen: ;0E:6163
    push hl
    ld c, $40
    call FadeScreen ;$67A
    pop hl
    ret
;616B

eventFrameDelay: ;0E:616B
    ld a, [hli]
    ld b, a
.loop3A16D
    push bc
    call haltCPU
    pop bc
    dec b
    jr nz, .loop3A16D
    ret
;6176

eventChangeScreen: ;0E:6176
    ld a, [hli]
    ld [wRoomScreen], a
    push hl
    call loadEventRoomScreen ;0641
    pop hl
    call callEventSpriteLoadFunctions
    call callEventSpriteLoadFunctions
    ret
;6186

changeNPC4SpriteAnimFrame: ;0E:6186
    ld de, wNPCSpritesData+$60 ;$C380
    jr Label3A1A7
changeNPC5SpriteAnimFrame: ;Label3A18B
    ld de, wNPCSpritesData+$80 ;$C3A0
    jr Label3A1A7
changeNPC6SpriteAnimFrame:
    ld de, wNPCSpritesData+$A0 ;$C3C0
    jr Label3A1A7
changePlayerSpriteAnimFrame:
    ld de, wCharSpritesData
    jr Label3A1A7
changeNPC1SpriteAnimFrame: ;0E:619A
    ld de, wNPCSpritesData
    jr Label3A1A7
changeNPC2SpriteAnimFrame: ;0E:619F
    ld de, wNPCSpritesData+$20 ;$C340
    jr Label3A1A7
changeNPC3SpriteAnimFrame: ;0E:61A4
    ld de, wNPCSpritesData+$40 ;$C360
Label3A1A7
    push hl
    ld c, l
    ld b, h
    ld hl, wSpriteAnimationId - wCharSpritesData ;$6
    add hl, de
    ld a, [bc]
    ld [hl], a
    inc bc
    ld hl, wSpriteAnimationFrameId - wCharSpritesData ;$7
    add hl, de
    ld a, [bc]
    ld [hl], a
    pop hl
    inc hl
    inc hl
    call callEventSpriteLoadFunctions ;Label3A3CC
    ret
;61BE

showLabSelfDestructEventMassage: ;0E:61BE
    ld de, $6485 ;wrong pointer %fix
    ld c, $F8
    jr Label3A202
showMisteriousPersonEventMessage:
    ld de, _misteriousMessageName ;$404D
    ld c, BANK(_misteriousMessageName) ;$F8
    jr Label3A202
showBradEventMessage:
    ld de, _bradMessageName ;$4046
    ld c, BANK(_bradMessageName) ;$F8
    jr Label3A202
showRichardEventMessage:
    ld de, _richardMessageName ;$403C
    ld c, BANK(_richardMessageName) ;$F8
    jr Label3A202
showEnricoEventMessage:
    ld de, _enricoMessageName ;$4033
    ld c, BANK(_enricoMessageName) ;$F8
    jr Label3A202
showBarryEventMessage:
    ld de, _barryMessageName ;$4022
    ld c, BANK(_barryMessageName) ;$F8
    jr Label3A202
showChrisEventMessage:
    ld de, _chrisMessageName ;$4000
    ld c, BANK(_chrisMessageName) ;$F8
    jr Label3A202
showJillEventMessage:
    ld de, _jillMessageName ;$4008
    ld c, BANK(_jillMessageName) ;$F8
    jr Label3A202
showWeskerEventMessage:
    ld de, _weskerMessageName ;$400F
    ld c, BANK(_weskerMessageName) ;$F8
    jr Label3A202
showRebeccaEventMessage:
    ld de, _rebeccaMessageName ;$4018
    ld c, BANK(_rebeccaMessageName) ;$F8
Label3A202
    call clearEventMessagebox
    push hl
    ld hl, $1000 ;tile coord (00,10)
    call showEventMsgCharName ;610
    pop hl
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    push hl
    ld a, [wMsgCharXpos]
    ld l, a
    ld a, [wMsgCharYpos]
    ld h, a
    call showEventMessage
    pop hl
    ret
;621F

clearEventMessagebox: ;0E:621F
    push bc
    push de
    push hl
    ld hl, $1000 ;tile coord (00,10)
    ld de, ClearThreeTextLines ;$6431
    ld c, BANK(ClearThreeTextLines) ;$FA
    call showEventMsgCharName
    pop hl
    pop de
    pop bc
    ret

changeNPC4Facing: ;0E:6231
    ld de, wNPCSpritesData+$60 ;$C380
    jr Label3A252
changeNPC5Facing: ;Label3A236:
    ld de, wNPCSpritesData+$80 ;$C3A0
    jr Label3A252
changeNPC6Facing:
    ld de, wNPCSpritesData+$A0 ;$C3C0
    jr Label3A252
changePlayerFacing:
    ld de, wCharSpritesData
    jr Label3A252
changeNPC1Facing:
    ld de, wNPCSpritesData ;$C320
    jr Label3A252
changeNPC2Facing:
    ld de, wNPCSpritesData+$20 ;$C340
    jr Label3A252
changeNPC3Facing:
    ld de, wNPCSpritesData+$40 ;$C360
Label3A252
    ld a, [hli]
    push hl
    cp a, $80
    jr c, Label3A27A ;rotate facing counterclockwise
	;rotate facing clockwise
    and a, $7F
    ld b, a
.loop3A25B
    push bc
    push de
    ld hl, wSpriteFacing - wCharSpritesData ;$9
    add hl, de
    ld a, [hl]
    sub a, $02
    and a, $1F
    ld [hl], a
    call haltCPU
    call haltCPU
    call haltCPU
    call callEventSpriteLoadFunctions
    pop de
    pop bc
    dec b
    jr nz, .loop3A25B
    pop hl
    ret

Label3A27A: ;0E:627A
    ld b, a
.loop3A27B
    push bc
    push de
    ld hl, wSpriteFacing - wCharSpritesData ;$9
    add hl, de
    ld a, [hl]
    add a, $02
    and a, $1F
    ld [hl], a
    call haltCPU
    call haltCPU
    call haltCPU
    call callEventSpriteLoadFunctions
    pop de
    pop bc
    dec b
    jr nz, .loop3A27B
    pop hl
    ret

playEventSFX: ;0E:629A
    ld a, [hli]
    ld c, a
    push hl
    call playSFX
    pop hl
    ret
;62A2

moveWalkBackwardNPC4: ;0E:62A2
    ld de, wNPCSpritesData+$60 ;$C380
    jr Label3A2C3
moveWalkBackwardNPC5:
    ld de, wNPCSpritesData+$80 ;$C3A0
    jr Label3A2C3
moveWalkBackwardNPC6:
    ld de, wNPCSpritesData+$A0 ;$C3C0
    jr Label3A2C3
moveWalkBackwardPlayer:
    ld de, wCharSpritesData
    jr Label3A2C3
moveWalkBackwardNPC1:
    ld de, wNPCSpritesData
    jr Label3A2C3
moveWalkBackwardNPC2:
    ld de, wNPCSpritesData+$20 ;$C340
    jr Label3A2C3
moveWalkBackwardNPC3:
    ld de, wNPCSpritesData+$40 ;$C360
Label3A2C3
    ld a, [hli]
    push hl
    ld b, a
Loop3A2C6
    push bc
    push de
    ld hl, wSpriteFacing - wCharSpritesData ;$9
    add hl, de
    ld a, [hl]
    add a, $10 ;reverse facing
    and a, $1C
    ld bc, spriteWalkTable ;$63D2
	;apply facing offset
    add a, c
    ld c, a
    ld a, $00
    adc a, b
    ld b, a
    ld hl, wSpritePositionXLow - wCharSpritesData ;$11
    add hl, de
    ld a, [bc]
    add a, [hl]
    ld [hli], a
    inc bc ;wSpritePositionXHigh
    ld a, [bc]
    adc a, [hl]
    ld [hli], a
	;add move offset to Ypos
    inc bc ;wSpritePositionZLow
    ld a, [bc]
    add a, [hl]
    ld [hli], a
    inc bc ;wSpritePositionZHigh
    ld a, [bc]
    adc a, [hl]
    ld [hli], a
	;change sprite animation
    ld hl, wSpriteAnimationId - wCharSpritesData ;$6
    add hl, de
    ld [hl], WALK_ANIM ;$01
	;change frame id
    ld hl, wSpriteAnimationFrameId - wCharSpritesData  ;$7
    add hl, de
    ld a, [hl]
    sub a, $02
    and a, $3F
    ld [hl], a
	;update sprite
    call haltCPU
    call callEventSpriteLoadFunctions
    pop de
    pop bc
    dec b
    jr nz, Loop3A2C6
    pop hl
    ret
;630A

moveWalkingEventNPC4: ;0E:630A
    ld de, wNPCSpritesData+$60 ;$C380
    jr Label3A32B
moveWalkingEventNPC5:
    ld de, wNPCSpritesData+$80 ;$C3A0
    jr Label3A32B
moveWalkingEventNPC6:
    ld de, wNPCSpritesData+$A0 ;$C3C0
    jr Label3A32B
moveWalkingEventPlayer:
    ld de, wCharSpritesData
    jr Label3A32B
moveWalkingEventNPC1:
    ld de, wNPCSpritesData
    jr Label3A32B
moveWalkingEventNPC2:
    ld de, wNPCSpritesData+$20 ;$C340
    jr Label3A32B
moveWalkingEventNPC3:
    ld de, wNPCSpritesData+$40 ;$C360
Label3A32B
    ld a, [hli]
    push hl
    ld b, a ;steps counter
.loop3A32E
    push bc
    push de
    ld hl, wSpriteFacing - wCharSpritesData ;$9
    add hl, de
    ld a, [hl]
    and a, $1C ;max posible facing mask
    ld bc, spriteWalkTable ;$63D2
	;apply facing offset
    add a, c
    ld c, a
    ld a, $00
    adc a, b
    ld b, a
	;add move offset to Xpos
    ld hl, wSpritePositionXLow - wCharSpritesData ;$11
    add hl, de
    ld a, [bc]
    add a, [hl]
    ld [hli], a
    inc bc ;wSpritePositionXHigh
    ld a, [bc]
    adc a, [hl]
    ld [hli], a
	;add move offset to Ypos
    inc bc ;wSpritePositionZLow
    ld a, [bc]
    add a, [hl]
    ld [hli], a
    inc bc ;wSpritePositionZHigh
    ld a, [bc]
    adc a, [hl]
    ld [hli], a
	;change sprite animation
    ld hl, wSpriteAnimationId - wCharSpritesData  ;$6
    add hl, de
    ld [hl], WALK_ANIM ;$01
    ld hl, wSpriteAnimationFrameId - wCharSpritesData ;$7
    add hl, de
    ld a, [hl]
    add a, $02
    and a, $3F
    ld [hl], a
	;update sprite
    call haltCPU
    call callEventSpriteLoadFunctions
    pop de
    pop bc
    dec b
    jr nz, .loop3A32E
    pop hl
    ret
;6370

moveRunningEventNPC4: ;0E:6370
    ld de, wNPCSpritesData+$60 ;$C380
    jr Label3A387
moveRunningEventPlayer:
    ld de, wCharSpritesData
    jr Label3A387
moveRunningEventNPC1:
    ld de, wNPCSpritesData
    jr Label3A387
moveRunningEventNPC2:
    ld de, wNPCSpritesData+$20 ;$C340
    jr Label3A387
moveRunningEventNPC3:
    ld de, wNPCSpritesData+$40 ;$C360
Label3A387
    ld a, [hli]
    push hl
    ld b, a ;steps counter
.loop3A38A
    push bc
    push de
    ld hl, wSpriteFacing - wCharSpritesData ;$9
    add hl, de
    ld a, [hl]
    and a, $1C ;max posible facing mask
    ld bc, spriteRunTable ;$63F2
	;apply facing offset
    add a, c
    ld c, a
    ld a, $00
    adc a, b
    ld b, a
	;add move offset to Xpos
    ld hl, wSpritePositionXLow - wCharSpritesData ;$11
    add hl, de
    ld a, [bc]
    add a, [hl]
    ld [hli], a
    inc bc ;wSpritePositionXHigh
    ld a, [bc]
    adc a, [hl]
    ld [hli], a
	;add move offset to Ypos
    inc bc ;wSpritePositionZLow
    ld a, [bc]
    add a, [hl]
    ld [hli], a
    inc bc ;wSpritePositionZHigh
    ld a, [bc]
    adc a, [hl]
    ld [hli], a
	;change sprite animation
    ld hl, wSpriteAnimationId - wCharSpritesData ;$6
    add hl, de
    ld [hl], RUN_ANIM ;$02
	;change frame id
    ld hl, wSpriteAnimationFrameId - wCharSpritesData ;$7
    add hl, de
    ld a, [hl]
    add a, $02
    and a, $3F
    ld [hl], a
	;update sprite
    call haltCPU
    call callEventSpriteLoadFunctions
    pop de
    pop bc
    dec b
    jr nz, .loop3A38A
    pop hl
    ret
;63CC

callEventSpriteLoadFunctions: ;0E:63CC
    push hl
    call loadAndCalcEventSpritesData ;$06D6
    pop hl
    ret


spriteWalkTable: ;63D2
INCLUDE "events/spriteWalkTable.asm"

spriteRunTable:
INCLUDE "events/spriteRunTable.asm" ;63F2

resetAllCharsData: ;0E:6412
;reset all chars data, but player health
    ld a, [wCharHealth]
    push af
    ld de, wCharSpritesData
    ld bc, $100
Loop3A41C
    xor a
    ld [de], a ;reset data
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, Loop3A41C
    pop af
    ld [wCharHealth], a ;restore health
    ret
;6429

eventBgImage: ;0E:6429
    ld a, [hli]
    ld [wLoadEventBgImagePal], a
    push hl
    call showEventBgImage ;$713
    pop hl
    ret
;6433

	db "BANKE"

;6438 rest of bank empty


SECTION "bankF",ROMX,BANK[$F]

hotGenLogoBGData: 			INCBIN "gfx/tilemaps/hotgenStudiosLogo.2bpp" ;4000
hotGenLogoPallete: 			INCBIN "gfx/tilemaps/hotgenStudiosLogo.pal" ;4C70

mainFonts: 					INCBIN "gfx/main_fonts.2bpp" ;4CB0
mainFontsBold: 				INCBIN "gfx/main_fonts_bold.2bpp"

INCLUDE "engine/roomsElevations.asm" ;5BB0
;5DCB

loadNumericPanelSprites: ;0F:5DCB
    ld hl, wSpriteTilesBuffer ;$CB00
    ld de, numericPanelKeysSprites ;$5E3F
    ld bc, $140 ;sprites total lenght
loadPanelSpritesLoop
    ld a, [de]
    ld [hli], a
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, loadPanelSpritesLoop
	;prepare OAM target
    ld hl, wOAMBufferC9 ;$C900
    call selectOAMDataDest
    ld de, $4
    ld b, $28
initPanelSpritesOAMLoop
    ld [hl], $C0
    add hl, de
    dec b
    jr nz, initPanelSpritesOAMLoop
    ld hl, wOAMBufferC9 ;$C900
    call selectOAMDataDest
    ld de, wNumericPanelKey01Value ;$C2C0
    ld b, $09 ;total keys
loadPanelKeyLightOAM
    ld a, [de]
    or a
    jr z, Label3DE01
    inc de
    inc de
    inc de
    jr Label3DE0E
Label3DE01
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    ld a, $00
    ld [hli], a
    ld a, $02
    ld [hli], a
Label3DE0E
    dec b
    jr nz, loadPanelKeyLightOAM
;load selected key sprite
    ld de, numericPanelKeysOAM ;$5E2D
    ld a, [wNumericPanelKeyId]
    add a
    add a, e
    ld e, a
    ld a, $00
    adc a, d
    ld d, a
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    ld a, [wNumericPanelKeyId]
    inc a
    add a
    ld [hli], a
    ld a, $03
    ld [hli], a
    ret
;5E2D

numericPanelKeysOAM: ;0F:5E2D
	db $5E, $48 ;pos y, pos x
	db $5E, $54
	db $5E, $60
	db $6A, $48
	db $6A, $54
	db $6A, $60
	db $76, $48
	db $76, $54
	db $76, $60

numericPanelKeysSprites: 	INCBIN "gfx/numeric_panel_keys.2bpp" ;0F:5E3F

checkNumericPanelInput: ;0F:5F7F
    ld a, [wButtonPressId]
    and a, LEFT_INPUT
    jp nz, numericPanelLeftKeyPress
    xor a
    ld [wTurnLeftTimer], a
    ld a, [wButtonPressId]
    and a, RIGHT_INPUT
    jp nz, numericPanelRightKeyPress
    xor a
    ld [wTurnRightTimer], a
    ld a, [wButtonPressId]
    and a, UP_INPUT
    jp nz, numericPanelUpKeyPress
    xor a
    ld [wUpKeyPressDown], a
    ld a, [wButtonPressId]
    and a, DOWN_INPUT
    jp nz, numericPanelDownKeyPress
    xor a
    ld [wDownKeyPressDown], a
    ld a, [wButtonPressId]
    and a, A_INPUT
    jp nz, numericPanelAKeyPress
    xor a
    ld [wBButtonPressDown], a
    ret
;5FBC

numericPanelAKeyPress: ;0F:5FBC
    ld a, [wBButtonPressDown]
    or a
    ret nz
    ld a, $FF
    ld [wBButtonPressDown], a
    ld a, CONFIRM_SFX ;$02
    call playSFX
    ld a, [wNumericPanelKeyId]
    or a ;$00  key 1
    jp z, numericPanelKey01Selected
    cp a, $01 ;key 2
    jp z, numericPanelKey02Selected
    cp a, $02 ;key 3
    jp z, numericPanelKey03Selected
    cp a, $03 ;key 4
    jp z, numericPanelKey04Selected
    cp a, $04 ;key 5
    jp z, numericPanelKey05Selected
    cp a, $05 ;key 6
    jp z, numericPanelKey06Selected
    cp a, $06 ;key 7
    jp z, numericPanelKey07Selected
    cp a, $07 ;key 8
    jp z, numericPanelKey08Selected

;numericPanelKey09Selected
    ld hl, wNumericPanelKey06Value
    call switchKeyValue
    ld hl, wNumericPanelKey08Value
    call switchKeyValue
    ld hl, wNumericPanelKey09Value
    jp switchKeyValue

numericPanelKey08Selected:
    ld hl, wNumericPanelKey05Value
    call switchKeyValue
    ld hl, wNumericPanelKey07Value
    call switchKeyValue
    ld hl, wNumericPanelKey08Value
    call switchKeyValue
    ld hl, wNumericPanelKey09Value
    jp switchKeyValue

numericPanelKey07Selected:
    ld hl, wNumericPanelKey04Value
    call switchKeyValue
    ld hl, wNumericPanelKey07Value
    call switchKeyValue
    ld hl, wNumericPanelKey08Value
    jp switchKeyValue

numericPanelKey06Selected:
    ld hl, wNumericPanelKey03Value
    call switchKeyValue
    ld hl, wNumericPanelKey05Value
    call switchKeyValue
    ld hl, wNumericPanelKey06Value
    call switchKeyValue
    ld hl, wNumericPanelKey09Value
    jp switchKeyValue

numericPanelKey05Selected:
    ld hl, wNumericPanelKey02Value
    call switchKeyValue
    ld hl, wNumericPanelKey04Value
    call switchKeyValue
    ld hl, wNumericPanelKey05Value
    call switchKeyValue
    ld hl, wNumericPanelKey06Value
    call switchKeyValue
    ld hl, wNumericPanelKey08Value
    jp switchKeyValue

numericPanelKey04Selected:
    ld hl, wNumericPanelKey01Value
    call switchKeyValue
    ld hl, wNumericPanelKey04Value
    call switchKeyValue
    ld hl, wNumericPanelKey05Value
    call switchKeyValue
    ld hl, wNumericPanelKey07Value
    jp switchKeyValue

numericPanelKey03Selected:
    ld hl, wNumericPanelKey02Value
    call switchKeyValue
    ld hl, wNumericPanelKey03Value
    call switchKeyValue
    ld hl, wNumericPanelKey06Value
    jp switchKeyValue

numericPanelKey02Selected:
    ld hl, wNumericPanelKey01Value
    call switchKeyValue
    ld hl, wNumericPanelKey02Value
    call switchKeyValue
    ld hl, wNumericPanelKey03Value
    call switchKeyValue
    ld hl, wNumericPanelKey05Value
    jp switchKeyValue

numericPanelKey01Selected:
    ld hl, wNumericPanelKey01Value
    call switchKeyValue
    ld hl, wNumericPanelKey02Value
    call switchKeyValue
    ld hl, wNumericPanelKey04Value
    jp switchKeyValue

switchKeyValue:
    ld a, [hl]
    xor a, $FF
    ld [hl], a
    ret
;60C0

numericPanelLeftKeyPress: ;0F:60C0
    ld a, [wTurnLeftTimer]
    or a
    ret nz
    ld a, $FF
    ld [wTurnLeftTimer], a
    ld a, [wNumericPanelKeyId]
    or a ;$00  key 1
    ret z
    cp a, $03 ;key 4
    ret z
    cp a, $06 ;key 7
    ret z
    dec a
    ld [wNumericPanelKeyId], a
    ld a, CURSOR_SFX ;$01
    jp playSFX

numericPanelRightKeyPress:
    ld a, [wTurnRightTimer]
    or a
    ret nz
    ld a, $FF
    ld [wTurnRightTimer], a
    ld a, [wNumericPanelKeyId]
    cp a, $02 ;key 3
    ret z
    cp a, $05 ;key 6
    ret z
    cp a, $08 ;key 9
    ret z
    inc a
    ld [wNumericPanelKeyId], a
    ld a, CURSOR_SFX ;$01
    jp playSFX

numericPanelUpKeyPress:
    ld a, [wUpKeyPressDown]
    or a
    ret nz
    ld a, $FF
    ld [wUpKeyPressDown], a
    ld a, [wNumericPanelKeyId]
    cp a, $03
    ret c ;ret if key < 4
    sub a, $03
    ld [wNumericPanelKeyId], a
    ld a, CURSOR_SFX ;$01
    jp playSFX

numericPanelDownKeyPress:
    ld a, [wDownKeyPressDown]
    or a
    ret nz
    ld a, $FF
    ld [wDownKeyPressDown], a
    ld a, [wNumericPanelKeyId]
    cp a, $06
    ret nc ;ret if key >= 7
    add a, $03
    ld [wNumericPanelKeyId], a
    ld a, CURSOR_SFX ;$01
    jp playSFX

;6131 rest of bank is empty

SECTION "roomBgBank1",ROMX,BANK[$10]

room00_00:				INCBIN "gfx/rooms_bg/room00_00.2bpp"
room00_01:				INCBIN "gfx/rooms_bg/room00_01.2bpp"
room00_02:				INCBIN "gfx/rooms_bg/room00_02.2bpp"
room00_03_b10:			INCBIN "gfx/rooms_bg/room00_03_b10.2bpp"

SECTION "roomBgBank2",ROMX,BANK[$11]

room00_03_b11:			INCBIN "gfx/rooms_bg/room00_03_b11.2bpp"
room00_04:				INCBIN "gfx/rooms_bg/room00_04.2bpp"
room00_05:				INCBIN "gfx/rooms_bg/room00_05.2bpp"
room00_06:				INCBIN "gfx/rooms_bg/room00_06.2bpp"
room01_00_b11:			INCBIN "gfx/rooms_bg/room01_00_b11.2bpp"

SECTION "roomBgBank3",ROMX,BANK[$12]

room01_00_b12:			INCBIN "gfx/rooms_bg/room01_00_b12.2bpp"
room01_01:				INCBIN "gfx/rooms_bg/room01_01.2bpp"
room01_02:				INCBIN "gfx/rooms_bg/room01_02.2bpp"
room01_03_b12:			INCBIN "gfx/rooms_bg/room01_03_b12.2bpp"

SECTION "roomBgBank4",ROMX,BANK[$13]

room01_03_b13:			INCBIN "gfx/rooms_bg/room01_03_b13.2bpp"
room01_04:				INCBIN "gfx/rooms_bg/room01_04.2bpp"
room01_05:				INCBIN "gfx/rooms_bg/room01_05.2bpp"
room01_06_b13:			INCBIN "gfx/rooms_bg/room01_06_b13.2bpp"

SECTION "roomBgBank5",ROMX,BANK[$14]

room01_06_b14:			INCBIN "gfx/rooms_bg/room01_06_b14.2bpp"
room02_00:				INCBIN "gfx/rooms_bg/room02_00.2bpp"
room02_01:				INCBIN "gfx/rooms_bg/room02_01.2bpp"
room02_02:				INCBIN "gfx/rooms_bg/room02_02.2bpp"
room02_03_b14:			INCBIN "gfx/rooms_bg/room02_03_b14.2bpp"

SECTION "roomBgBank6",ROMX,BANK[$15]

room02_03_b15:			INCBIN "gfx/rooms_bg/room02_03_b15.2bpp"
room02_04:				INCBIN "gfx/rooms_bg/room02_04.2bpp"
room02_05:				INCBIN "gfx/rooms_bg/room02_05.2bpp"
room03_00:				INCBIN "gfx/rooms_bg/room03_00.2bpp"
room03_01:				INCBIN "gfx/rooms_bg/room03_01.2bpp"
room03_02_b15:			INCBIN "gfx/rooms_bg/room03_02_b15.2bpp"

SECTION "roomBgBank7",ROMX,BANK[$16]

room03_02_b16:			INCBIN "gfx/rooms_bg/room03_02_b16.2bpp"
room03_03:				INCBIN "gfx/rooms_bg/room03_03.2bpp"
room03_04:				INCBIN "gfx/rooms_bg/room03_04.2bpp"
room03_05:				INCBIN "gfx/rooms_bg/room03_05.2bpp"
room03_06_b16:			INCBIN "gfx/rooms_bg/room03_06_b16.2bpp"

SECTION "roomBgBank8",ROMX,BANK[$17]

room03_06_b17:			INCBIN "gfx/rooms_bg/room03_06_b17.2bpp"
room04_00:				INCBIN "gfx/rooms_bg/room04_00.2bpp"
room04_01:				INCBIN "gfx/rooms_bg/room04_01.2bpp"
room04_02:				INCBIN "gfx/rooms_bg/room04_02.2bpp"
room04_03_b17:			INCBIN "gfx/rooms_bg/room04_03_b17.2bpp"

SECTION "roomBgBank9",ROMX,BANK[$18]

room04_03_b18:			INCBIN "gfx/rooms_bg/room04_03_b18.2bpp"
room04_04:				INCBIN "gfx/rooms_bg/room04_04.2bpp"
room04_05:				INCBIN "gfx/rooms_bg/room04_05.2bpp"
room04_06_b18:			INCBIN "gfx/rooms_bg/room04_06_b18.2bpp"

SECTION "roomBgBank10",ROMX,BANK[$19]

room04_06_b19:			INCBIN "gfx/rooms_bg/room04_06_b19.2bpp"
room04_07:				INCBIN "gfx/rooms_bg/room04_07.2bpp"
room05_00:				INCBIN "gfx/rooms_bg/room05_00.2bpp"
room05_01:				INCBIN "gfx/rooms_bg/room05_01.2bpp"
room05_02:				INCBIN "gfx/rooms_bg/room05_02.2bpp"
room05_03_b19:			INCBIN "gfx/rooms_bg/room05_03_b19.2bpp"

SECTION "roomBgBank11",ROMX,BANK[$1A]

room05_03_b1A:			INCBIN "gfx/rooms_bg/room05_03_b1A.2bpp"
room05_04:				INCBIN "gfx/rooms_bg/room05_04.2bpp"
room05_05:				INCBIN "gfx/rooms_bg/room05_05.2bpp"
room06_00:				INCBIN "gfx/rooms_bg/room06_00.2bpp"
room06_01_b1A:			INCBIN "gfx/rooms_bg/room06_01_b1A.2bpp"

SECTION "roomBgBank12",ROMX,BANK[$1B]

room06_01_b1B:			INCBIN "gfx/rooms_bg/room06_01_b1B.2bpp"
room06_02:				INCBIN "gfx/rooms_bg/room06_02.2bpp"
room06_03:				INCBIN "gfx/rooms_bg/room06_03.2bpp"
room06_04_b1B:			INCBIN "gfx/rooms_bg/room06_04_b1B.2bpp"

SECTION "roomBgBank13",ROMX,BANK[$1C]

room06_04_b1C:			INCBIN "gfx/rooms_bg/room06_04_b1C.2bpp"
room06_05:				INCBIN "gfx/rooms_bg/room06_05.2bpp"
room07_00:				INCBIN "gfx/rooms_bg/room07_00.2bpp"
room07_01:				INCBIN "gfx/rooms_bg/room07_01.2bpp"
room07_02:				INCBIN "gfx/rooms_bg/room07_02.2bpp"
room07_03_b1C:			INCBIN "gfx/rooms_bg/room07_03_b1C.2bpp"

SECTION "roomBgBank14",ROMX,BANK[$1D]

room07_03_b1D:			INCBIN "gfx/rooms_bg/room07_03_b1D.2bpp"
room07_04:				INCBIN "gfx/rooms_bg/room07_04.2bpp"
room07_05:				INCBIN "gfx/rooms_bg/room07_05.2bpp"
room07_06:				INCBIN "gfx/rooms_bg/room07_06.2bpp"
room07_07:				INCBIN "gfx/rooms_bg/room07_07.2bpp"
room08_00_b1D:			INCBIN "gfx/rooms_bg/room08_00_b1D.2bpp"

SECTION "roomBgBank15",ROMX,BANK[$1E]

room08_00_b1E:			INCBIN "gfx/rooms_bg/room08_00_b1E.2bpp"
room08_01:				INCBIN "gfx/rooms_bg/room08_01.2bpp"
room08_02:				INCBIN "gfx/rooms_bg/room08_02.2bpp"
room08_03:				INCBIN "gfx/rooms_bg/room08_03.2bpp"
room08_04_b1E:			INCBIN "gfx/rooms_bg/room08_04_b1E.2bpp"

SECTION "roomBgBank16",ROMX,BANK[$1F]

room08_04_b1F:			INCBIN "gfx/rooms_bg/room08_04_b1F.2bpp"
room08_05:				INCBIN "gfx/rooms_bg/room08_05.2bpp"
room09_00:				INCBIN "gfx/rooms_bg/room09_00.2bpp"
room09_01:				INCBIN "gfx/rooms_bg/room09_01.2bpp"
room09_02:				INCBIN "gfx/rooms_bg/room09_02.2bpp"
room09_03_b1F:			INCBIN "gfx/rooms_bg/room09_03_b1F.2bpp"

SECTION "roomBgBank17",ROMX,BANK[$20]

room09_03_b20:			INCBIN "gfx/rooms_bg/room09_03_b20.2bpp"
room0A_00:				INCBIN "gfx/rooms_bg/room0A_00.2bpp"
room0A_01:				INCBIN "gfx/rooms_bg/room0A_01.2bpp"
room0A_02:				INCBIN "gfx/rooms_bg/room0A_02.2bpp"
room0A_03_b20:			INCBIN "gfx/rooms_bg/room0A_03_b20.2bpp"

SECTION "roomBgBank18",ROMX,BANK[$21]

room0A_03_b21:			INCBIN "gfx/rooms_bg/room0A_03_b21.2bpp"
room0A_04:				INCBIN "gfx/rooms_bg/room0A_04.2bpp"
room0A_05:				INCBIN "gfx/rooms_bg/room0A_05.2bpp"
room0A_06:				INCBIN "gfx/rooms_bg/room0A_06.2bpp"
room0B_00_b21:			INCBIN "gfx/rooms_bg/room0B_00_b21.2bpp"

SECTION "roomBgBank19",ROMX,BANK[$22]

room0B_00_b22:			INCBIN "gfx/rooms_bg/room0B_00_b22.2bpp"
room0B_01:				INCBIN "gfx/rooms_bg/room0B_01.2bpp"
room0B_02:				INCBIN "gfx/rooms_bg/room0B_02.2bpp"
room0B_03_b22:			INCBIN "gfx/rooms_bg/room0B_03_b22.2bpp"

SECTION "roomBgBank20",ROMX,BANK[$23]

room0B_03_b23:			INCBIN "gfx/rooms_bg/room0B_03_b23.2bpp"
room0B_04:				INCBIN "gfx/rooms_bg/room0B_04.2bpp"
room0C_00:				INCBIN "gfx/rooms_bg/room0C_00.2bpp"
room0C_01:				INCBIN "gfx/rooms_bg/room0C_01.2bpp"
room0C_02_b23:			INCBIN "gfx/rooms_bg/room0C_02_b23.2bpp"

SECTION "roomBgBank21",ROMX,BANK[$24]

room0C_02_b24:			INCBIN "gfx/rooms_bg/room0C_02_b24.2bpp"
room0C_03:				INCBIN "gfx/rooms_bg/room0C_03.2bpp"
room0D_00:				INCBIN "gfx/rooms_bg/room0D_00.2bpp"
room0D_01:				INCBIN "gfx/rooms_bg/room0D_01.2bpp"
room0D_02:				INCBIN "gfx/rooms_bg/room0D_02.2bpp"
room0D_03_b24:			INCBIN "gfx/rooms_bg/room0D_03_b24.2bpp"

SECTION "roomBgBank22",ROMX,BANK[$25]

room0D_03_b25:			INCBIN "gfx/rooms_bg/room0D_03_b25.2bpp"
room0E_00:				INCBIN "gfx/rooms_bg/room0E_00.2bpp"
room0E_01:				INCBIN "gfx/rooms_bg/room0E_01.2bpp"
room0E_02:				INCBIN "gfx/rooms_bg/room0E_02.2bpp"
room0E_03_b25:			INCBIN "gfx/rooms_bg/room0E_03_b25.2bpp"

SECTION "roomBgBank23",ROMX,BANK[$26]

room0E_03_b26:			INCBIN "gfx/rooms_bg/room0E_03_b26.2bpp"
room0F_00:				INCBIN "gfx/rooms_bg/room0F_00.2bpp"
room0F_01:				INCBIN "gfx/rooms_bg/room0F_01.2bpp"
room0F_02:				INCBIN "gfx/rooms_bg/room0F_02.2bpp"
room0F_03_b26:			INCBIN "gfx/rooms_bg/room0F_03_b26.2bpp"

SECTION "roomBgBank24",ROMX,BANK[$27]

room0F_03_b27:			INCBIN "gfx/rooms_bg/room0F_03_b27.2bpp"
room0F_04:				INCBIN "gfx/rooms_bg/room0F_04.2bpp"
room10_00:				INCBIN "gfx/rooms_bg/room10_00.2bpp"
room10_01:				INCBIN "gfx/rooms_bg/room10_01.2bpp"
room10_02_b27:			INCBIN "gfx/rooms_bg/room10_02_b27.2bpp"

SECTION "roomBgBank25",ROMX,BANK[$28]

room10_02_b28:			INCBIN "gfx/rooms_bg/room10_02_b28.2bpp"
room10_03:				INCBIN "gfx/rooms_bg/room10_03.2bpp"
room10_04:				INCBIN "gfx/rooms_bg/room10_04.2bpp"
room11_00:				INCBIN "gfx/rooms_bg/room11_00.2bpp"
room11_01_b28:			INCBIN "gfx/rooms_bg/room11_01_b28.2bpp"

SECTION "roomBgBank26",ROMX,BANK[$29]

room11_01_b29:			INCBIN "gfx/rooms_bg/room11_01_b29.2bpp"
room11_02:				INCBIN "gfx/rooms_bg/room11_02.2bpp"
room11_03:				INCBIN "gfx/rooms_bg/room11_03.2bpp"
room12_00:				INCBIN "gfx/rooms_bg/room12_00.2bpp"
room12_01_b29:			INCBIN "gfx/rooms_bg/room12_01_b29.2bpp"

SECTION "roomBgBank27",ROMX,BANK[$2A]

room12_01_b2A:			INCBIN "gfx/rooms_bg/room12_01_b2A.2bpp"
room12_02:				INCBIN "gfx/rooms_bg/room12_02.2bpp"
room12_03:				INCBIN "gfx/rooms_bg/room12_03.2bpp"
room13_00_b2A:			INCBIN "gfx/rooms_bg/room13_00_b2A.2bpp"

SECTION "roomBgBank28",ROMX,BANK[$2B]

room13_00_b2B:			INCBIN "gfx/rooms_bg/room13_00_b2B.2bpp"
room13_01:				INCBIN "gfx/rooms_bg/room13_01.2bpp"
room13_02:				INCBIN "gfx/rooms_bg/room13_02.2bpp"
room13_03_b2B:			INCBIN "gfx/rooms_bg/room13_03_b2B.2bpp"

SECTION "roomBgBank29",ROMX,BANK[$2C]

room13_03_b2C:			INCBIN "gfx/rooms_bg/room13_03_b2C.2bpp"
room13_04:				INCBIN "gfx/rooms_bg/room13_04.2bpp"
room14_00:				INCBIN "gfx/rooms_bg/room14_00.2bpp"
room14_01:				INCBIN "gfx/rooms_bg/room14_01.2bpp"
room15_00_b2C:			INCBIN "gfx/rooms_bg/room15_00_b2C.2bpp"

SECTION "roomBgBank30",ROMX,BANK[$2D]

room15_00_b2D:			INCBIN "gfx/rooms_bg/room15_00_b2D.2bpp"
room15_01:				INCBIN "gfx/rooms_bg/room15_01.2bpp"
room15_02:				INCBIN "gfx/rooms_bg/room15_02.2bpp"
room16_00:				INCBIN "gfx/rooms_bg/room16_00.2bpp"
room16_01:				INCBIN "gfx/rooms_bg/room16_01.2bpp"
room16_02_b2D:			INCBIN "gfx/rooms_bg/room16_02_b2D.2bpp"

SECTION "roomBgBank31",ROMX,BANK[$2E]

room16_02_b2E:			INCBIN "gfx/rooms_bg/room16_02_b2E.2bpp"
room17_00:				INCBIN "gfx/rooms_bg/room17_00.2bpp"
room17_01:				INCBIN "gfx/rooms_bg/room17_01.2bpp"
room18_00_b2E:			INCBIN "gfx/rooms_bg/room18_00_b2E.2bpp"

SECTION "roomBgBank32",ROMX,BANK[$2F]

room18_00_b2F:			INCBIN "gfx/rooms_bg/room18_00_b2F.2bpp"
room18_01:				INCBIN "gfx/rooms_bg/room18_01.2bpp"
room19_00:				INCBIN "gfx/rooms_bg/room19_00.2bpp"
room19_01:				INCBIN "gfx/rooms_bg/room19_01.2bpp"
room19_02_b2F:			INCBIN "gfx/rooms_bg/room19_02_b2F.2bpp"

SECTION "roomBgBank33",ROMX,BANK[$30]

room19_02_b30:			INCBIN "gfx/rooms_bg/room19_02_b30.2bpp"
room19_03:				INCBIN "gfx/rooms_bg/room19_03.2bpp"
room1A_00:				INCBIN "gfx/rooms_bg/room1A_00.2bpp"
room1A_01:				INCBIN "gfx/rooms_bg/room1A_01.2bpp"
room1A_02:				INCBIN "gfx/rooms_bg/room1A_02.2bpp"
room1A_03_b30:			INCBIN "gfx/rooms_bg/room1A_03_b30.2bpp"

SECTION "roomBgBank34",ROMX,BANK[$31]

room1A_03_b31:			INCBIN "gfx/rooms_bg/room1A_03_b31.2bpp"
room1A_04:				INCBIN "gfx/rooms_bg/room1A_04.2bpp"
room1A_05:				INCBIN "gfx/rooms_bg/room1A_05.2bpp"
room1B_00:				INCBIN "gfx/rooms_bg/room1B_00.2bpp"
room1B_01_b31:			INCBIN "gfx/rooms_bg/room1B_01_b31.2bpp"

SECTION "roomBgBank35",ROMX,BANK[$32]

room1B_01_b32:			INCBIN "gfx/rooms_bg/room1B_01_b32.2bpp"
room1B_02:				INCBIN "gfx/rooms_bg/room1B_02.2bpp"
room1B_03:				INCBIN "gfx/rooms_bg/room1B_03.2bpp"
room1B_04:				INCBIN "gfx/rooms_bg/room1B_04.2bpp"
room1B_05_b32:			INCBIN "gfx/rooms_bg/room1B_05_b32.2bpp"

SECTION "roomBgBank36",ROMX,BANK[$33]

room1B_05_b33:			INCBIN "gfx/rooms_bg/room1B_05_b33.2bpp"
room1C_00:				INCBIN "gfx/rooms_bg/room1C_00.2bpp"
room1C_01:				INCBIN "gfx/rooms_bg/room1C_01.2bpp"
room1C_02_b33:			INCBIN "gfx/rooms_bg/room1C_02_b33.2bpp"

SECTION "roomBgBank37",ROMX,BANK[$34]

room1C_02_b34:			INCBIN "gfx/rooms_bg/room1C_02_b34.2bpp"
room1C_03:				INCBIN "gfx/rooms_bg/room1C_03.2bpp"
room1C_04:				INCBIN "gfx/rooms_bg/room1C_04.2bpp"
room1C_05:				INCBIN "gfx/rooms_bg/room1C_05.2bpp"
room1D_00_b34:			INCBIN "gfx/rooms_bg/room1D_00_b34.2bpp"

SECTION "roomBgBank38",ROMX,BANK[$35]

room1D_00_b35:			INCBIN "gfx/rooms_bg/room1D_00_b35.2bpp"
room1D_01:				INCBIN "gfx/rooms_bg/room1D_01.2bpp"
room1D_02:				INCBIN "gfx/rooms_bg/room1D_02.2bpp"
room1D_03:				INCBIN "gfx/rooms_bg/room1D_03.2bpp"
room1D_04:				INCBIN "gfx/rooms_bg/room1D_04.2bpp"
room1E_00_b35:			INCBIN "gfx/rooms_bg/room1E_00_b35.2bpp"

SECTION "roomBgBank39",ROMX,BANK[$36]

room1E_00_b36:			INCBIN "gfx/rooms_bg/room1E_00_b36.2bpp"
room1E_01:				INCBIN "gfx/rooms_bg/room1E_01.2bpp"
room1E_02:				INCBIN "gfx/rooms_bg/room1E_02.2bpp"
room1E_03:				INCBIN "gfx/rooms_bg/room1E_03.2bpp"
room1E_04_b36:			INCBIN "gfx/rooms_bg/room1E_04_b36.2bpp"

SECTION "roomBgBank40",ROMX,BANK[$37]

room1E_04_b37:			INCBIN "gfx/rooms_bg/room1E_04_b37.2bpp"
room1E_05:				INCBIN "gfx/rooms_bg/room1E_05.2bpp"
room1F_00:				INCBIN "gfx/rooms_bg/room1F_00.2bpp"
room1F_01_b37:			INCBIN "gfx/rooms_bg/room1F_01_b37.2bpp"

SECTION "roomBgBank41",ROMX,BANK[$38]

room1F_01_b38:			INCBIN "gfx/rooms_bg/room1F_01_b38.2bpp"
room1F_02:				INCBIN "gfx/rooms_bg/room1F_02.2bpp"
room20_00:				INCBIN "gfx/rooms_bg/room20_00.2bpp"
room20_01:				INCBIN "gfx/rooms_bg/room20_01.2bpp"
room20_02:				INCBIN "gfx/rooms_bg/room20_02.2bpp"
room20_03_b38:			INCBIN "gfx/rooms_bg/room20_03_b38.2bpp"

SECTION "roomBgBank42",ROMX,BANK[$39]

room20_03_b39:			INCBIN "gfx/rooms_bg/room20_03_b39.2bpp"
room20_04:				INCBIN "gfx/rooms_bg/room20_04.2bpp"
room20_05:				INCBIN "gfx/rooms_bg/room20_05.2bpp"
room20_06:				INCBIN "gfx/rooms_bg/room20_06.2bpp"
room21_00:				INCBIN "gfx/rooms_bg/room21_00.2bpp"
room21_01_b39:			INCBIN "gfx/rooms_bg/room21_01_b39.2bpp"

SECTION "roomBgBank43",ROMX,BANK[$3A]

room21_01_b3A:			INCBIN "gfx/rooms_bg/room21_01_b3A.2bpp"
room21_02:				INCBIN "gfx/rooms_bg/room21_02.2bpp"
room22_00:				INCBIN "gfx/rooms_bg/room22_00.2bpp"
room22_01:				INCBIN "gfx/rooms_bg/room22_01.2bpp"
room22_02_b3A:			INCBIN "gfx/rooms_bg/room22_02_b3A.2bpp"

SECTION "roomBgBank44",ROMX,BANK[$3B]

room22_02_b3B:			INCBIN "gfx/rooms_bg/room22_02_b3B.2bpp"
room23_00:				INCBIN "gfx/rooms_bg/room23_00.2bpp"
room23_01:				INCBIN "gfx/rooms_bg/room23_01.2bpp"
room23_02_b3B:			INCBIN "gfx/rooms_bg/room23_02_b3B.2bpp"

SECTION "roomBgBank45",ROMX,BANK[$3C]

room23_02_b3C:			INCBIN "gfx/rooms_bg/room23_02_b3C.2bpp"
room23_03:				INCBIN "gfx/rooms_bg/room23_03.2bpp"
room24_00:				INCBIN "gfx/rooms_bg/room24_00.2bpp"
room24_01:				INCBIN "gfx/rooms_bg/room24_01.2bpp"
room24_02_b3C:			INCBIN "gfx/rooms_bg/room24_02_b3C.2bpp"

SECTION "roomBgBank46",ROMX,BANK[$3D]

room24_02_b3D:			INCBIN "gfx/rooms_bg/room24_02_b3D.2bpp"
room24_03:				INCBIN "gfx/rooms_bg/room24_03.2bpp"
room24_04:				INCBIN "gfx/rooms_bg/room24_04.2bpp"
room24_05:				INCBIN "gfx/rooms_bg/room24_05.2bpp"
room24_06:				INCBIN "gfx/rooms_bg/room24_06.2bpp"
room25_00:				INCBIN "gfx/rooms_bg/room25_00.2bpp"
room25_01_b3D:			INCBIN "gfx/rooms_bg/room25_01_b3D.2bpp"

SECTION "roomBgBank47",ROMX,BANK[$3E]

room25_01_b3E:			INCBIN "gfx/rooms_bg/room25_01_b3E.2bpp"
room25_02:				INCBIN "gfx/rooms_bg/room25_02.2bpp"
room25_03:				INCBIN "gfx/rooms_bg/room25_03.2bpp"
room25_04:				INCBIN "gfx/rooms_bg/room25_04.2bpp"
room26_00:				INCBIN "gfx/rooms_bg/room26_00.2bpp"
room26_01_b3E:			INCBIN "gfx/rooms_bg/room26_01_b3E.2bpp"

SECTION "roomBgBank48",ROMX,BANK[$3F]

room26_01_b3F:			INCBIN "gfx/rooms_bg/room26_01_b3F.2bpp"
room26_02:				INCBIN "gfx/rooms_bg/room26_02.2bpp"
room27_00:				INCBIN "gfx/rooms_bg/room27_00.2bpp"
room27_01:				INCBIN "gfx/rooms_bg/room27_01.2bpp"
room27_02:				INCBIN "gfx/rooms_bg/room27_02.2bpp"
room27_03_b3F:			INCBIN "gfx/rooms_bg/room27_03_b3F.2bpp"

SECTION "roomBgBank49",ROMX,BANK[$40]

room27_03_b40:			INCBIN "gfx/rooms_bg/room27_03_b40.2bpp"
room27_04:				INCBIN "gfx/rooms_bg/room27_04.2bpp"
room28_00:				INCBIN "gfx/rooms_bg/room28_00.2bpp"
room28_01:				INCBIN "gfx/rooms_bg/room28_01.2bpp"
room28_02_b40:			INCBIN "gfx/rooms_bg/room28_02_b40.2bpp"

SECTION "roomBgBank50",ROMX,BANK[$41]

room28_02_b41:			INCBIN "gfx/rooms_bg/room28_02_b41.2bpp"
room28_03:				INCBIN "gfx/rooms_bg/room28_03.2bpp"
room28_04:				INCBIN "gfx/rooms_bg/room28_04.2bpp"
room29_00_b41:			INCBIN "gfx/rooms_bg/room29_00_b41.2bpp"

SECTION "roomBgBank51",ROMX,BANK[$42]

room29_00_b42:			INCBIN "gfx/rooms_bg/room29_00_b42.2bpp"
room29_01:				INCBIN "gfx/rooms_bg/room29_01.2bpp"
room29_02:				INCBIN "gfx/rooms_bg/room29_02.2bpp"
room2A_00:				INCBIN "gfx/rooms_bg/room2A_00.2bpp"
room2A_01_b42:			INCBIN "gfx/rooms_bg/room2A_01_b42.2bpp"

SECTION "roomBgBank52",ROMX,BANK[$43]

room2A_01_b43:			INCBIN "gfx/rooms_bg/room2A_01_b43.2bpp"
room2A_02:				INCBIN "gfx/rooms_bg/room2A_02.2bpp"
room2A_03:				INCBIN "gfx/rooms_bg/room2A_03.2bpp"
room2B_00_b43:			INCBIN "gfx/rooms_bg/room2B_00_b43.2bpp"

SECTION "roomBgBank53",ROMX,BANK[$44]

room2B_00_b44:			INCBIN "gfx/rooms_bg/room2B_00_b44.2bpp"
room2B_01:				INCBIN "gfx/rooms_bg/room2B_01.2bpp"
room2B_02:				INCBIN "gfx/rooms_bg/room2B_02.2bpp"
room2B_03_b44:			INCBIN "gfx/rooms_bg/room2B_03_b44.2bpp"

SECTION "roomBgBank54",ROMX,BANK[$45]

room2B_03_b45:			INCBIN "gfx/rooms_bg/room2B_03_b45.2bpp"
room2C_00:				INCBIN "gfx/rooms_bg/room2C_00.2bpp"
room2C_01:				INCBIN "gfx/rooms_bg/room2C_01.2bpp"
room2C_02_b45:			INCBIN "gfx/rooms_bg/room2C_02_b45.2bpp"

SECTION "roomBgBank55",ROMX,BANK[$46]

room2C_02_b46:			INCBIN "gfx/rooms_bg/room2C_02_b46.2bpp"
room2C_03:				INCBIN "gfx/rooms_bg/room2C_03.2bpp"
room2C_04:				INCBIN "gfx/rooms_bg/room2C_04.2bpp"
room2C_05_b46:			INCBIN "gfx/rooms_bg/room2C_05_b46.2bpp"

SECTION "roomBgBank56",ROMX,BANK[$47]

room2C_05_b47:			INCBIN "gfx/rooms_bg/room2C_05_b47.2bpp"
room2C_06:				INCBIN "gfx/rooms_bg/room2C_06.2bpp"
room2D_00:				INCBIN "gfx/rooms_bg/room2D_00.2bpp"
room2D_01_b47:			INCBIN "gfx/rooms_bg/room2D_01_b47.2bpp"

SECTION "roomBgBank57",ROMX,BANK[$48]

room2D_01_b48:			INCBIN "gfx/rooms_bg/room2D_01_b48.2bpp"
room2D_02:				INCBIN "gfx/rooms_bg/room2D_02.2bpp"
room2D_03:				INCBIN "gfx/rooms_bg/room2D_03.2bpp"
room2E_00:				INCBIN "gfx/rooms_bg/room2E_00.2bpp"
room2E_01_b48:			INCBIN "gfx/rooms_bg/room2E_01_b48.2bpp"

SECTION "roomBgBank58",ROMX,BANK[$49]

room2E_01_b49:			INCBIN "gfx/rooms_bg/room2E_01_b49.2bpp"
room2F_00:				INCBIN "gfx/rooms_bg/room2F_00.2bpp"
room2F_01:				INCBIN "gfx/rooms_bg/room2F_01.2bpp"
room2F_02:				INCBIN "gfx/rooms_bg/room2F_02.2bpp"
room2F_03_b49:			INCBIN "gfx/rooms_bg/room2F_03_b49.2bpp"

SECTION "roomBgBank59",ROMX,BANK[$4A]

room2F_03_b4A:			INCBIN "gfx/rooms_bg/room2F_03_b4A.2bpp"
room2F_04:				INCBIN "gfx/rooms_bg/room2F_04.2bpp"
room30_00:				INCBIN "gfx/rooms_bg/room30_00.2bpp"
room30_01:				INCBIN "gfx/rooms_bg/room30_01.2bpp"
room30_02_b4A:			INCBIN "gfx/rooms_bg/room30_02_b4A.2bpp"

SECTION "roomBgBank60",ROMX,BANK[$4B]

room30_02_b4B:			INCBIN "gfx/rooms_bg/room30_02_b4B.2bpp"
room30_03:				INCBIN "gfx/rooms_bg/room30_03.2bpp"
room31_00:				INCBIN "gfx/rooms_bg/room31_00.2bpp"
room31_01:				INCBIN "gfx/rooms_bg/room31_01.2bpp"
room31_02_b4B:			INCBIN "gfx/rooms_bg/room31_02_b4B.2bpp"

SECTION "roomBgBank61",ROMX,BANK[$4C]

room31_02_b4C:			INCBIN "gfx/rooms_bg/room31_02_b4C.2bpp"
room31_03:				INCBIN "gfx/rooms_bg/room31_03.2bpp"
room31_04:				INCBIN "gfx/rooms_bg/room31_04.2bpp"
room31_05_b4C:			INCBIN "gfx/rooms_bg/room31_05_b4C.2bpp"

SECTION "roomBgBank62",ROMX,BANK[$4D]

room31_05_b4D:			INCBIN "gfx/rooms_bg/room31_05_b4D.2bpp"
room32_00:				INCBIN "gfx/rooms_bg/room32_00.2bpp"
room32_01:				INCBIN "gfx/rooms_bg/room32_01.2bpp"
room32_02_b4D:			INCBIN "gfx/rooms_bg/room32_02_b4D.2bpp"

SECTION "roomBgBank63",ROMX,BANK[$4E]

room32_02_b4E:			INCBIN "gfx/rooms_bg/room32_02_b4E.2bpp"
room32_03:				INCBIN "gfx/rooms_bg/room32_03.2bpp"
room32_04:				INCBIN "gfx/rooms_bg/room32_04.2bpp"
room32_05:				INCBIN "gfx/rooms_bg/room32_05.2bpp"
room32_06_b4E:			INCBIN "gfx/rooms_bg/room32_06_b4E.2bpp"

SECTION "roomBgBank64",ROMX,BANK[$4F]

room32_06_b4F:			INCBIN "gfx/rooms_bg/room32_06_b4F.2bpp"
room32_07:				INCBIN "gfx/rooms_bg/room32_07.2bpp"
room33_00:				INCBIN "gfx/rooms_bg/room33_00.2bpp"
room33_01_b4F:			INCBIN "gfx/rooms_bg/room33_01_b4F.2bpp"

SECTION "roomBgBank65",ROMX,BANK[$50]

room33_01_b50:			INCBIN "gfx/rooms_bg/room33_01_b50.2bpp"
room34_00:				INCBIN "gfx/rooms_bg/room34_00.2bpp"
room34_01:				INCBIN "gfx/rooms_bg/room34_01.2bpp"
room34_02_b50:			INCBIN "gfx/rooms_bg/room34_02_b50.2bpp"

SECTION "roomBgBank66",ROMX,BANK[$51]

room34_02_b51:			INCBIN "gfx/rooms_bg/room34_02_b51.2bpp"
room35_00:				INCBIN "gfx/rooms_bg/room35_00.2bpp"
room35_01:				INCBIN "gfx/rooms_bg/room35_01.2bpp"
room35_02_b51:			INCBIN "gfx/rooms_bg/room35_02_b51.2bpp"

SECTION "roomBgBank67",ROMX,BANK[$52]

room35_02_b52:			INCBIN "gfx/rooms_bg/room35_02_b52.2bpp"
room35_03:				INCBIN "gfx/rooms_bg/room35_03.2bpp"
room35_04:				INCBIN "gfx/rooms_bg/room35_04.2bpp"
room35_05:				INCBIN "gfx/rooms_bg/room35_05.2bpp"
room35_06:				INCBIN "gfx/rooms_bg/room35_06.2bpp"
room35_07_b52:			INCBIN "gfx/rooms_bg/room35_07_b52.2bpp"

SECTION "roomBgBank68",ROMX,BANK[$53]

room35_07_b53:			INCBIN "gfx/rooms_bg/room35_07_b53.2bpp"
room36_00:				INCBIN "gfx/rooms_bg/room36_00.2bpp"
room36_01:				INCBIN "gfx/rooms_bg/room36_01.2bpp"
room36_02_b53:			INCBIN "gfx/rooms_bg/room36_02_b53.2bpp"

SECTION "roomBgBank69",ROMX,BANK[$54]

room36_02_b54:			INCBIN "gfx/rooms_bg/room36_02_b54.2bpp"
room36_03:				INCBIN "gfx/rooms_bg/room36_03.2bpp"
room36_04:				INCBIN "gfx/rooms_bg/room36_04.2bpp"
room36_05_b54:			INCBIN "gfx/rooms_bg/room36_05_b54.2bpp"

SECTION "roomBgBank70",ROMX,BANK[$55]

room36_05_b55:			INCBIN "gfx/rooms_bg/room36_05_b55.2bpp"
room36_06:				INCBIN "gfx/rooms_bg/room36_06.2bpp"
room37_00:				INCBIN "gfx/rooms_bg/room37_00.2bpp"
room37_01_b55:			INCBIN "gfx/rooms_bg/room37_01_b55.2bpp"

SECTION "roomBgBank71",ROMX,BANK[$56]

room37_01_b56:			INCBIN "gfx/rooms_bg/room37_01_b56.2bpp"
room37_02:				INCBIN "gfx/rooms_bg/room37_02.2bpp"
room37_03:				INCBIN "gfx/rooms_bg/room37_03.2bpp"
room37_04_b56:			INCBIN "gfx/rooms_bg/room37_04_b56.2bpp"

SECTION "roomBgBank72",ROMX,BANK[$57]

room37_04_b57:			INCBIN "gfx/rooms_bg/room37_04_b57.2bpp"
room37_05:				INCBIN "gfx/rooms_bg/room37_05.2bpp"
room37_06:				INCBIN "gfx/rooms_bg/room37_06.2bpp"
room37_07_b57:			INCBIN "gfx/rooms_bg/room37_07_b57.2bpp"

SECTION "roomBgBank73",ROMX,BANK[$58]

room37_07_b58:			INCBIN "gfx/rooms_bg/room37_07_b58.2bpp"
room38_00:				INCBIN "gfx/rooms_bg/room38_00.2bpp"
room38_01:				INCBIN "gfx/rooms_bg/room38_01.2bpp"
room38_02_b58:			INCBIN "gfx/rooms_bg/room38_02_b58.2bpp"

SECTION "roomBgBank74",ROMX,BANK[$59]

room38_02_b59:			INCBIN "gfx/rooms_bg/room38_02_b59.2bpp"
room38_03:				INCBIN "gfx/rooms_bg/room38_03.2bpp"
room38_04:				INCBIN "gfx/rooms_bg/room38_04.2bpp"
room38_05_b59:			INCBIN "gfx/rooms_bg/room38_05_b59.2bpp"

SECTION "roomBgBank75",ROMX,BANK[$5A]

room38_05_b5A:			INCBIN "gfx/rooms_bg/room38_05_b5A.2bpp"
room38_06:				INCBIN "gfx/rooms_bg/room38_06.2bpp"
room38_07:				INCBIN "gfx/rooms_bg/room38_07.2bpp"
room39_00_b5A:			INCBIN "gfx/rooms_bg/room39_00_b5A.2bpp"

SECTION "roomBgBank76",ROMX,BANK[$5B]

room39_00_b5B:			INCBIN "gfx/rooms_bg/room39_00_b5B.2bpp"
room39_01:				INCBIN "gfx/rooms_bg/room39_01.2bpp"
room39_02:				INCBIN "gfx/rooms_bg/room39_02.2bpp"
room39_03_b5B:			INCBIN "gfx/rooms_bg/room39_03_b5B.2bpp"

SECTION "roomBgBank77",ROMX,BANK[$5C]

room39_03_b5C:			INCBIN "gfx/rooms_bg/room39_03_b5C.2bpp"
room39_04:				INCBIN "gfx/rooms_bg/room39_04.2bpp"
room39_05:				INCBIN "gfx/rooms_bg/room39_05.2bpp"
room39_06:				INCBIN "gfx/rooms_bg/room39_06.2bpp"
room39_07_b5C:			INCBIN "gfx/rooms_bg/room39_07_b5C.2bpp"

SECTION "roomBgBank78",ROMX,BANK[$5D]

room39_07_b5D:			INCBIN "gfx/rooms_bg/room39_07_b5D.2bpp"
room3A_00:				INCBIN "gfx/rooms_bg/room3A_00.2bpp"
room3A_01:				INCBIN "gfx/rooms_bg/room3A_01.2bpp"
room3A_02_b5D:			INCBIN "gfx/rooms_bg/room3A_02_b5D.2bpp"

SECTION "roomBgBank79",ROMX,BANK[$5E]

room3A_02_b5E:			INCBIN "gfx/rooms_bg/room3A_02_b5E.2bpp"
room3A_03:				INCBIN "gfx/rooms_bg/room3A_03.2bpp"
room3A_04:				INCBIN "gfx/rooms_bg/room3A_04.2bpp"
room3A_05_b5E:			INCBIN "gfx/rooms_bg/room3A_05_b5E.2bpp"

SECTION "roomBgBank80",ROMX,BANK[$5F]

room3A_05_b5F:			INCBIN "gfx/rooms_bg/room3A_05_b5F.2bpp"
room3B_00:				INCBIN "gfx/rooms_bg/room3B_00.2bpp"
room3B_01_b5F:			INCBIN "gfx/rooms_bg/room3B_01_b5F.2bpp"

SECTION "roomBgBank81",ROMX,BANK[$60]

room3B_01_b60:			INCBIN "gfx/rooms_bg/room3B_01_b60.2bpp"
room3B_02:				INCBIN "gfx/rooms_bg/room3B_02.2bpp"
room3B_03:				INCBIN "gfx/rooms_bg/room3B_03.2bpp"
room3C_00_b60:			INCBIN "gfx/rooms_bg/room3C_00_b60.2bpp"

SECTION "roomBgBank82",ROMX,BANK[$61]

room3C_00_b61:			INCBIN "gfx/rooms_bg/room3C_00_b61.2bpp"
room3C_01:				INCBIN "gfx/rooms_bg/room3C_01.2bpp"
room3C_02:				INCBIN "gfx/rooms_bg/room3C_02.2bpp"
room3C_03_b61:			INCBIN "gfx/rooms_bg/room3C_03_b61.2bpp"

SECTION "roomBgBank83",ROMX,BANK[$62]

room3C_03_b62:			INCBIN "gfx/rooms_bg/room3C_03_b62.2bpp"
room3C_04:				INCBIN "gfx/rooms_bg/room3C_04.2bpp"
room3C_05:				INCBIN "gfx/rooms_bg/room3C_05.2bpp"
room3C_06_b62:			INCBIN "gfx/rooms_bg/room3C_06_b62.2bpp"

SECTION "roomBgBank84",ROMX,BANK[$63]

room3C_06_b63:			INCBIN "gfx/rooms_bg/room3C_06_b63.2bpp"
room3C_07:				INCBIN "gfx/rooms_bg/room3C_07.2bpp"
room3D_00:				INCBIN "gfx/rooms_bg/room3D_00.2bpp"
room3D_01_b63:			INCBIN "gfx/rooms_bg/room3D_01_b63.2bpp"

SECTION "roomBgBank85",ROMX,BANK[$64]

room3D_01_b64:			INCBIN "gfx/rooms_bg/room3D_01_b64.2bpp"
room3D_02:				INCBIN "gfx/rooms_bg/room3D_02.2bpp"
room3D_03:				INCBIN "gfx/rooms_bg/room3D_03.2bpp"
room3D_04_b64:			INCBIN "gfx/rooms_bg/room3D_04_b64.2bpp"

SECTION "roomBgBank86",ROMX,BANK[$65]

room3D_04_b65:			INCBIN "gfx/rooms_bg/room3D_04_b65.2bpp"
room3D_05:				INCBIN "gfx/rooms_bg/room3D_05.2bpp"
room3D_06:				INCBIN "gfx/rooms_bg/room3D_06.2bpp"
room3D_07_b65:			INCBIN "gfx/rooms_bg/room3D_07_b65.2bpp"

SECTION "roomBgBank87",ROMX,BANK[$66]

room3D_07_b66:			INCBIN "gfx/rooms_bg/room3D_07_b66.2bpp"
room3E_00:				INCBIN "gfx/rooms_bg/room3E_00.2bpp"
room3E_01_b66:			INCBIN "gfx/rooms_bg/room3E_01_b66.2bpp"

SECTION "roomBgBank88",ROMX,BANK[$67]

room3E_01_b67:			INCBIN "gfx/rooms_bg/room3E_01_b67.2bpp"
room3E_02:				INCBIN "gfx/rooms_bg/room3E_02.2bpp"
room3E_03:				INCBIN "gfx/rooms_bg/room3E_03.2bpp"
room3E_04_b67:			INCBIN "gfx/rooms_bg/room3E_04_b67.2bpp"

SECTION "roomBgBank89",ROMX,BANK[$68]

room3E_04_b68:			INCBIN "gfx/rooms_bg/room3E_04_b68.2bpp"
room3E_05:				INCBIN "gfx/rooms_bg/room3E_05.2bpp"
room3E_06:				INCBIN "gfx/rooms_bg/room3E_06.2bpp"
room3E_07_b68:			INCBIN "gfx/rooms_bg/room3E_07_b68.2bpp"

SECTION "roomBgBank90",ROMX,BANK[$69]

room3E_07_b69:			INCBIN "gfx/rooms_bg/room3E_07_b69.2bpp"
room3F_00:				INCBIN "gfx/rooms_bg/room3F_00.2bpp"
room3F_01:				INCBIN "gfx/rooms_bg/room3F_01.2bpp"
room3F_02_b69:			INCBIN "gfx/rooms_bg/room3F_02_b69.2bpp"

SECTION "roomBgBank91",ROMX,BANK[$6A]

room3F_02_b6A:			INCBIN "gfx/rooms_bg/room3F_02_b6A.2bpp"
room3F_03:				INCBIN "gfx/rooms_bg/room3F_03.2bpp"
room3F_04:				INCBIN "gfx/rooms_bg/room3F_04.2bpp"
room3F_05_b6A:			INCBIN "gfx/rooms_bg/room3F_05_b6A.2bpp"

SECTION "roomBgBank92",ROMX,BANK[$6B]

room3F_05_b6B:			INCBIN "gfx/rooms_bg/room3F_05_b6B.2bpp"
room3F_06:				INCBIN "gfx/rooms_bg/room3F_06.2bpp"
room40_00:				INCBIN "gfx/rooms_bg/room40_00.2bpp"
room40_01_b6B:			INCBIN "gfx/rooms_bg/room40_01_b6B.2bpp"

SECTION "roomBgBank93",ROMX,BANK[$6C]

room40_01_b6C:			INCBIN "gfx/rooms_bg/room40_01_b6C.2bpp"
room40_02:				INCBIN "gfx/rooms_bg/room40_02.2bpp"
room40_03:				INCBIN "gfx/rooms_bg/room40_03.2bpp"
room40_04:				INCBIN "gfx/rooms_bg/room40_04.2bpp"
room41_00_b6C:			INCBIN "gfx/rooms_bg/room41_00_b6C.2bpp"

SECTION "roomBgBank94",ROMX,BANK[$6D]

room41_00_b6D:			INCBIN "gfx/rooms_bg/room41_00_b6D.2bpp"
room41_01:				INCBIN "gfx/rooms_bg/room41_01.2bpp"
room41_02:				INCBIN "gfx/rooms_bg/room41_02.2bpp"
room41_03_b6D:			INCBIN "gfx/rooms_bg/room41_03_b6D.2bpp"

SECTION "roomBgBank95",ROMX,BANK[$6E]

room41_03_b6E:			INCBIN "gfx/rooms_bg/room41_03_b6E.2bpp"
room41_04:				INCBIN "gfx/rooms_bg/room41_04.2bpp"
room41_05:				INCBIN "gfx/rooms_bg/room41_05.2bpp"
room41_06_b6E:			INCBIN "gfx/rooms_bg/room41_06_b6E.2bpp"

SECTION "roomBgBank96",ROMX,BANK[$6F]

room41_06_b6F:			INCBIN "gfx/rooms_bg/room41_06_b6F.2bpp"
room41_07:				INCBIN "gfx/rooms_bg/room41_07.2bpp"
room42_00:				INCBIN "gfx/rooms_bg/room42_00.2bpp"
room43_00_b6F:			INCBIN "gfx/rooms_bg/room43_00_b6F.2bpp"

SECTION "roomBgBank97",ROMX,BANK[$70]

room43_00_b70:			INCBIN "gfx/rooms_bg/room43_00_b70.2bpp"
room43_01:				INCBIN "gfx/rooms_bg/room43_01.2bpp"
room43_02:				INCBIN "gfx/rooms_bg/room43_02.2bpp"
room43_03_b70:			INCBIN "gfx/rooms_bg/room43_03_b70.2bpp"

SECTION "roomBgBank98",ROMX,BANK[$71]

room43_03_b71:			INCBIN "gfx/rooms_bg/room43_03_b71.2bpp"
room43_04:				INCBIN "gfx/rooms_bg/room43_04.2bpp"
room43_05_b71:			INCBIN "gfx/rooms_bg/room43_05_b71.2bpp"

SECTION "roomBgBank99",ROMX,BANK[$72]

room43_05_b72:			INCBIN "gfx/rooms_bg/room43_05_b72.2bpp"
room44_00:				INCBIN "gfx/rooms_bg/room44_00.2bpp"
room44_01:				INCBIN "gfx/rooms_bg/room44_01.2bpp"
room44_02_b72:			INCBIN "gfx/rooms_bg/room44_02_b72.2bpp"

SECTION "roomBgBank100",ROMX,BANK[$73]

room44_02_b73:			INCBIN "gfx/rooms_bg/room44_02_b73.2bpp"
room44_03:				INCBIN "gfx/rooms_bg/room44_03.2bpp"
room44_04:				INCBIN "gfx/rooms_bg/room44_04.2bpp"
room44_05_b73:			INCBIN "gfx/rooms_bg/room44_05_b73.2bpp"

SECTION "roomBgBank101",ROMX,BANK[$74]

room44_05_b74:			INCBIN "gfx/rooms_bg/room44_05_b74.2bpp"
room44_06:				INCBIN "gfx/rooms_bg/room44_06.2bpp"
room44_07:				INCBIN "gfx/rooms_bg/room44_07.2bpp"
room45_00_b74:			INCBIN "gfx/rooms_bg/room45_00_b74.2bpp"

SECTION "roomBgBank102",ROMX,BANK[$75]

room45_00_b75:			INCBIN "gfx/rooms_bg/room45_00_b75.2bpp"
room45_01:				INCBIN "gfx/rooms_bg/room45_01.2bpp"
room45_02:				INCBIN "gfx/rooms_bg/room45_02.2bpp"
room45_03_b75:			INCBIN "gfx/rooms_bg/room45_03_b75.2bpp"

SECTION "roomBgBank103",ROMX,BANK[$76]

room45_03_b76:			INCBIN "gfx/rooms_bg/room45_03_b76.2bpp"
room46_00:				INCBIN "gfx/rooms_bg/room46_00.2bpp"
room46_01:				INCBIN "gfx/rooms_bg/room46_01.2bpp"
room46_02_b76:			INCBIN "gfx/rooms_bg/room46_02_b76.2bpp"

SECTION "roomBgBank104",ROMX,BANK[$77]

room46_02_b77:			INCBIN "gfx/rooms_bg/room46_02_b77.2bpp"
room46_03:				INCBIN "gfx/rooms_bg/room46_03.2bpp"
room46_04:				INCBIN "gfx/rooms_bg/room46_04.2bpp"
room47_00_b77:			INCBIN "gfx/rooms_bg/room47_00_b77.2bpp"

SECTION "roomBgBank105",ROMX,BANK[$78]

room47_00_b78:			INCBIN "gfx/rooms_bg/room47_00_b78.2bpp"
room47_01:				INCBIN "gfx/rooms_bg/room47_01.2bpp"
room47_02:				INCBIN "gfx/rooms_bg/room47_02.2bpp"
room47_03_b78:			INCBIN "gfx/rooms_bg/room47_03_b78.2bpp"

SECTION "roomBgBank106",ROMX,BANK[$79]

room47_03_b79:			INCBIN "gfx/rooms_bg/room47_03_b79.2bpp"
room47_04:				INCBIN "gfx/rooms_bg/room47_04.2bpp"
room47_05:				INCBIN "gfx/rooms_bg/room47_05.2bpp"
room48_00_b79:			INCBIN "gfx/rooms_bg/room48_00_b79.2bpp"

SECTION "roomBgBank107",ROMX,BANK[$7A]

room48_00_b7A:			INCBIN "gfx/rooms_bg/room48_00_b7A.2bpp"
room48_01:				INCBIN "gfx/rooms_bg/room48_01.2bpp"
room48_02:				INCBIN "gfx/rooms_bg/room48_02.2bpp"
room48_03_b7A:			INCBIN "gfx/rooms_bg/room48_03_b7A.2bpp"

SECTION "roomBgBank108",ROMX,BANK[$7B]

room48_03_b7B:			INCBIN "gfx/rooms_bg/room48_03_b7B.2bpp"
room48_04:				INCBIN "gfx/rooms_bg/room48_04.2bpp"
room49_00:				INCBIN "gfx/rooms_bg/room49_00.2bpp"
room49_01:				INCBIN "gfx/rooms_bg/room49_01.2bpp"
room4A_00_b7B:			INCBIN "gfx/rooms_bg/room4A_00_b7B.2bpp"

SECTION "roomBgBank109",ROMX,BANK[$7C]

room4A_00_b7C:			INCBIN "gfx/rooms_bg/room4A_00_b7C.2bpp"
room4A_01:				INCBIN "gfx/rooms_bg/room4A_01.2bpp"
room4A_02:				INCBIN "gfx/rooms_bg/room4A_02.2bpp"
room4B_00_b7C:			INCBIN "gfx/rooms_bg/room4B_00_b7C.2bpp"

SECTION "roomBgBank110",ROMX,BANK[$7D]

room4B_00_b7D:			INCBIN "gfx/rooms_bg/room4B_00_b7D.2bpp"
room4B_01:				INCBIN "gfx/rooms_bg/room4B_01.2bpp"
room4B_02:				INCBIN "gfx/rooms_bg/room4B_02.2bpp"
room4B_03:				INCBIN "gfx/rooms_bg/room4B_03.2bpp"
room4B_04_b7D:			INCBIN "gfx/rooms_bg/room4B_04_b7D.2bpp"

SECTION "roomBgBank111",ROMX,BANK[$7E]

room4B_04_b7E:			INCBIN "gfx/rooms_bg/room4B_04_b7E.2bpp"
room4B_05:				INCBIN "gfx/rooms_bg/room4B_05.2bpp"
room4C_00:				INCBIN "gfx/rooms_bg/room4C_00.2bpp"
room4C_01:				INCBIN "gfx/rooms_bg/room4C_01.2bpp"
room4C_02_b7E:			INCBIN "gfx/rooms_bg/room4C_02_b7E.2bpp"

SECTION "roomBgBank112",ROMX,BANK[$7F]

room4C_02_b7F:			INCBIN "gfx/rooms_bg/room4C_02_b7F.2bpp"
room4C_03:				INCBIN "gfx/rooms_bg/room4C_03.2bpp"
room4C_04:				INCBIN "gfx/rooms_bg/room4C_04.2bpp"
room4C_05_b7F:			INCBIN "gfx/rooms_bg/room4C_05_b7F.2bpp"

SECTION "roomBgBank113",ROMX,BANK[$80]

room4C_05_b80:			INCBIN "gfx/rooms_bg/room4C_05_b80.2bpp"
room4C_06:				INCBIN "gfx/rooms_bg/room4C_06.2bpp"
room4C_07:				INCBIN "gfx/rooms_bg/room4C_07.2bpp"
room4D_00_b80:			INCBIN "gfx/rooms_bg/room4D_00_b80.2bpp"

SECTION "roomBgBank114",ROMX,BANK[$81]

room4D_00_b81:			INCBIN "gfx/rooms_bg/room4D_00_b81.2bpp"
room4D_01:				INCBIN "gfx/rooms_bg/room4D_01.2bpp"
room4D_02:				INCBIN "gfx/rooms_bg/room4D_02.2bpp"
room4D_03:				INCBIN "gfx/rooms_bg/room4D_03.2bpp"
room4D_04:				INCBIN "gfx/rooms_bg/room4D_04.2bpp"
room4E_00_b81:			INCBIN "gfx/rooms_bg/room4E_00_b81.2bpp"

SECTION "roomBgBank115",ROMX,BANK[$82]

room4E_00_b82:			INCBIN "gfx/rooms_bg/room4E_00_b82.2bpp"
room4E_01:				INCBIN "gfx/rooms_bg/room4E_01.2bpp"
room4E_02:				INCBIN "gfx/rooms_bg/room4E_02.2bpp"
room4E_03_b82:			INCBIN "gfx/rooms_bg/room4E_03_b82.2bpp"

SECTION "roomBgBank116",ROMX,BANK[$83]

room4E_03_b83:			INCBIN "gfx/rooms_bg/room4E_03_b83.2bpp"
room4E_04:				INCBIN "gfx/rooms_bg/room4E_04.2bpp"
room4E_05:				INCBIN "gfx/rooms_bg/room4E_05.2bpp"
room4F_00_b83:			INCBIN "gfx/rooms_bg/room4F_00_b83.2bpp"

SECTION "roomBgBank117",ROMX,BANK[$84]

room4F_00_b84:			INCBIN "gfx/rooms_bg/room4F_00_b84.2bpp"
room4F_01:				INCBIN "gfx/rooms_bg/room4F_01.2bpp"
room4F_02:				INCBIN "gfx/rooms_bg/room4F_02.2bpp"
room4F_03_b84:			INCBIN "gfx/rooms_bg/room4F_03_b84.2bpp"

SECTION "roomBgBank118",ROMX,BANK[$85]

room4F_03_b85:			INCBIN "gfx/rooms_bg/room4F_03_b85.2bpp"
room4F_04:				INCBIN "gfx/rooms_bg/room4F_04.2bpp"
room4F_05_b85:			INCBIN "gfx/rooms_bg/room4F_05_b85.2bpp"

SECTION "roomBgBank119",ROMX,BANK[$86]

room4F_05_b86:			INCBIN "gfx/rooms_bg/room4F_05_b86.2bpp"
room4F_06:				INCBIN "gfx/rooms_bg/room4F_06.2bpp"
room4F_07:				INCBIN "gfx/rooms_bg/room4F_07.2bpp"
room50_00_b86:			INCBIN "gfx/rooms_bg/room50_00_b86.2bpp"

SECTION "roomBgBank120",ROMX,BANK[$87]

room50_00_b87:			INCBIN "gfx/rooms_bg/room50_00_b87.2bpp"
room50_01:				INCBIN "gfx/rooms_bg/room50_01.2bpp"
room50_02:				INCBIN "gfx/rooms_bg/room50_02.2bpp"
room50_03:				INCBIN "gfx/rooms_bg/room50_03.2bpp"
room50_04_b87:			INCBIN "gfx/rooms_bg/room50_04_b87.2bpp"

SECTION "roomBgBank121",ROMX,BANK[$88]

room50_04_b88:			INCBIN "gfx/rooms_bg/room50_04_b88.2bpp"
room50_05:				INCBIN "gfx/rooms_bg/room50_05.2bpp"
room50_06:				INCBIN "gfx/rooms_bg/room50_06.2bpp"
room51_00_b88:			INCBIN "gfx/rooms_bg/room51_00_b88.2bpp"

SECTION "roomBgBank122",ROMX,BANK[$89]

room51_00_b89:			INCBIN "gfx/rooms_bg/room51_00_b89.2bpp"
room51_01:				INCBIN "gfx/rooms_bg/room51_01.2bpp"
room52_00:				INCBIN "gfx/rooms_bg/room52_00.2bpp"
room52_01:				INCBIN "gfx/rooms_bg/room52_01.2bpp"
room52_02_b89:			INCBIN "gfx/rooms_bg/room52_02_b89.2bpp"

SECTION "roomBgBank123",ROMX,BANK[$8A]

room52_02_b8A:			INCBIN "gfx/rooms_bg/room52_02_b8A.2bpp"
room52_03:				INCBIN "gfx/rooms_bg/room52_03.2bpp"
room52_04:				INCBIN "gfx/rooms_bg/room52_04.2bpp"
room52_05_b8A:			INCBIN "gfx/rooms_bg/room52_05_b8A.2bpp"

SECTION "roomBgBank124",ROMX,BANK[$8B]

room52_05_b8B:			INCBIN "gfx/rooms_bg/room52_05_b8B.2bpp"
room52_06:				INCBIN "gfx/rooms_bg/room52_06.2bpp"
room52_07:				INCBIN "gfx/rooms_bg/room52_07.2bpp"
room53_00:				INCBIN "gfx/rooms_bg/room53_00.2bpp"
room53_01_b8B:			INCBIN "gfx/rooms_bg/room53_01_b8B.2bpp"

SECTION "roomBgBank125",ROMX,BANK[$8C]

room53_01_b8C:			INCBIN "gfx/rooms_bg/room53_01_b8C.2bpp"
room53_02:				INCBIN "gfx/rooms_bg/room53_02.2bpp"
room53_03:				INCBIN "gfx/rooms_bg/room53_03.2bpp"
room54_00_b8C:			INCBIN "gfx/rooms_bg/room54_00_b8C.2bpp"

SECTION "roomBgBank126",ROMX,BANK[$8D]

room54_00_b8D:			INCBIN "gfx/rooms_bg/room54_00_b8D.2bpp"
room54_01:				INCBIN "gfx/rooms_bg/room54_01.2bpp"
room54_02:				INCBIN "gfx/rooms_bg/room54_02.2bpp"
room54_03_b8D:			INCBIN "gfx/rooms_bg/room54_03_b8D.2bpp"

SECTION "roomBgBank127",ROMX,BANK[$8E]

room54_03_b8E:			INCBIN "gfx/rooms_bg/room54_03_b8E.2bpp"
room54_04:				INCBIN "gfx/rooms_bg/room54_04.2bpp"
room54_05:				INCBIN "gfx/rooms_bg/room54_05.2bpp"
room54_06:				INCBIN "gfx/rooms_bg/room54_06.2bpp"
room55_00_b8E:			INCBIN "gfx/rooms_bg/room55_00_b8E.2bpp"

SECTION "roomBgBank128",ROMX,BANK[$8F]

room55_00_b8F:			INCBIN "gfx/rooms_bg/room55_00_b8F.2bpp"
room55_01:				INCBIN "gfx/rooms_bg/room55_01.2bpp"
room56_00:				INCBIN "gfx/rooms_bg/room56_00.2bpp"
room56_01_b8F:			INCBIN "gfx/rooms_bg/room56_01_b8F.2bpp"

SECTION "roomBgBank129",ROMX,BANK[$90]

room56_01_b90:			INCBIN "gfx/rooms_bg/room56_01_b90.2bpp"
room56_02:				INCBIN "gfx/rooms_bg/room56_02.2bpp"
room56_03:				INCBIN "gfx/rooms_bg/room56_03.2bpp"
room56_04:				INCBIN "gfx/rooms_bg/room56_04.2bpp"
room56_05_b90:			INCBIN "gfx/rooms_bg/room56_05_b90.2bpp"

SECTION "roomBgBank130",ROMX,BANK[$91]

room56_05_b91:			INCBIN "gfx/rooms_bg/room56_05_b91.2bpp"
room56_06:				INCBIN "gfx/rooms_bg/room56_06.2bpp"
room57_00:				INCBIN "gfx/rooms_bg/room57_00.2bpp"
room57_01_b91:			INCBIN "gfx/rooms_bg/room57_01_b91.2bpp"

SECTION "roomBgBank131",ROMX,BANK[$92]

room57_01_b92:			INCBIN "gfx/rooms_bg/room57_01_b92.2bpp"
room58_00:				INCBIN "gfx/rooms_bg/room58_00.2bpp"
room58_01:				INCBIN "gfx/rooms_bg/room58_01.2bpp"
room58_02_b92:			INCBIN "gfx/rooms_bg/room58_02_b92.2bpp"

SECTION "roomBgBank132",ROMX,BANK[$93]

room58_02_b93:			INCBIN "gfx/rooms_bg/room58_02_b93.2bpp"
room58_03:				INCBIN "gfx/rooms_bg/room58_03.2bpp"
room58_04:				INCBIN "gfx/rooms_bg/room58_04.2bpp"
room59_00_b93:			INCBIN "gfx/rooms_bg/room59_00_b93.2bpp"

SECTION "roomBgBank133",ROMX,BANK[$94]

room59_00_b94:			INCBIN "gfx/rooms_bg/room59_00_b94.2bpp"
room59_01:				INCBIN "gfx/rooms_bg/room59_01.2bpp"
room59_02:				INCBIN "gfx/rooms_bg/room59_02.2bpp"
room59_03:				INCBIN "gfx/rooms_bg/room59_03.2bpp"
room59_04_b94:			INCBIN "gfx/rooms_bg/room59_04_b94.2bpp"

SECTION "roomBgBank134",ROMX,BANK[$95]

room59_04_b95:			INCBIN "gfx/rooms_bg/room59_04_b95.2bpp"
room59_05:				INCBIN "gfx/rooms_bg/room59_05.2bpp"
room59_06:				INCBIN "gfx/rooms_bg/room59_06.2bpp"
room59_07_b95:			INCBIN "gfx/rooms_bg/room59_07_b95.2bpp"

SECTION "roomBgBank135",ROMX,BANK[$96]

room59_07_b96:			INCBIN "gfx/rooms_bg/room59_07_b96.2bpp"
room5A_00:				INCBIN "gfx/rooms_bg/room5A_00.2bpp"
room5A_01:				INCBIN "gfx/rooms_bg/room5A_01.2bpp"
room5A_02:				INCBIN "gfx/rooms_bg/room5A_02.2bpp"
room5A_03_b96:			INCBIN "gfx/rooms_bg/room5A_03_b96.2bpp"

SECTION "roomBgBank136",ROMX,BANK[$97]

room5A_03_b97:			INCBIN "gfx/rooms_bg/room5A_03_b97.2bpp"
room5A_04:				INCBIN "gfx/rooms_bg/room5A_04.2bpp"
room5B_00:				INCBIN "gfx/rooms_bg/room5B_00.2bpp"
room5B_01:				INCBIN "gfx/rooms_bg/room5B_01.2bpp"
room5B_02_b97:			INCBIN "gfx/rooms_bg/room5B_02_b97.2bpp"

SECTION "roomBgBank137",ROMX,BANK[$98]

room5B_02_b98:			INCBIN "gfx/rooms_bg/room5B_02_b98.2bpp"
room5B_03:				INCBIN "gfx/rooms_bg/room5B_03.2bpp"
room5C_00:				INCBIN "gfx/rooms_bg/room5C_00.2bpp"
room5C_01_b98:			INCBIN "gfx/rooms_bg/room5C_01_b98.2bpp"

SECTION "roomBgBank138",ROMX,BANK[$99]

room5C_01_b99:			INCBIN "gfx/rooms_bg/room5C_01_b99.2bpp"
room5C_02:				INCBIN "gfx/rooms_bg/room5C_02.2bpp"
room5C_03:				INCBIN "gfx/rooms_bg/room5C_03.2bpp"
room5C_04_b99:			INCBIN "gfx/rooms_bg/room5C_04_b99.2bpp"

SECTION "roomBgBank139",ROMX,BANK[$9A]

room5C_04_b9A:			INCBIN "gfx/rooms_bg/room5C_04_b9A.2bpp"
room5C_05:				INCBIN "gfx/rooms_bg/room5C_05.2bpp"
room5D_00:				INCBIN "gfx/rooms_bg/room5D_00.2bpp"
room5D_01:				INCBIN "gfx/rooms_bg/room5D_01.2bpp"
room5D_02_b9A:			INCBIN "gfx/rooms_bg/room5D_02_b9A.2bpp"

SECTION "roomBgBank140",ROMX,BANK[$9B]

room5D_02_b9B:			INCBIN "gfx/rooms_bg/room5D_02_b9B.2bpp"
room5D_03:				INCBIN "gfx/rooms_bg/room5D_03.2bpp"
room5D_04:				INCBIN "gfx/rooms_bg/room5D_04.2bpp"
room5E_00:				INCBIN "gfx/rooms_bg/room5E_00.2bpp"
room5E_01:				INCBIN "gfx/rooms_bg/room5E_01.2bpp"
room5E_02_b9B:			INCBIN "gfx/rooms_bg/room5E_02_b9B.2bpp"

SECTION "roomBgBank141",ROMX,BANK[$9C]

room5E_02_b9C:			INCBIN "gfx/rooms_bg/room5E_02_b9C.2bpp"
room5E_03:				INCBIN "gfx/rooms_bg/room5E_03.2bpp"
room5E_04:				INCBIN "gfx/rooms_bg/room5E_04.2bpp"
room5E_05_b9C:			INCBIN "gfx/rooms_bg/room5E_05_b9C.2bpp"

SECTION "roomBgBank142",ROMX,BANK[$9D]

room5E_05_b9D:			INCBIN "gfx/rooms_bg/room5E_05_b9D.2bpp"
room5E_06:				INCBIN "gfx/rooms_bg/room5E_06.2bpp"
room5E_07:				INCBIN "gfx/rooms_bg/room5E_07.2bpp"
room5F_00_b9D:			INCBIN "gfx/rooms_bg/room5F_00_b9D.2bpp"

SECTION "roomBgBank143",ROMX,BANK[$9E]

room5F_00_b9E:			INCBIN "gfx/rooms_bg/room5F_00_b9E.2bpp"
room5F_01:				INCBIN "gfx/rooms_bg/room5F_01.2bpp"
room5F_02:				INCBIN "gfx/rooms_bg/room5F_02.2bpp"
room5F_03:				INCBIN "gfx/rooms_bg/room5F_03.2bpp"
room5F_04:				INCBIN "gfx/rooms_bg/room5F_04.2bpp"
room60_00_b9E:			INCBIN "gfx/rooms_bg/room60_00_b9E.2bpp"

SECTION "roomBgBank144",ROMX,BANK[$9F]

room60_00_b9F:			INCBIN "gfx/rooms_bg/room60_00_b9F.2bpp"
room60_01:				INCBIN "gfx/rooms_bg/room60_01.2bpp"
room60_02:				INCBIN "gfx/rooms_bg/room60_02.2bpp"
room60_03:				INCBIN "gfx/rooms_bg/room60_03.2bpp"
room60_04_b9F:			INCBIN "gfx/rooms_bg/room60_04_b9F.2bpp"

SECTION "roomBgBank145",ROMX,BANK[$A0]

room60_04_bA0:			INCBIN "gfx/rooms_bg/room60_04_bA0.2bpp"
room60_05:				INCBIN "gfx/rooms_bg/room60_05.2bpp"
room60_06:				INCBIN "gfx/rooms_bg/room60_06.2bpp"
room60_07:				INCBIN "gfx/rooms_bg/room60_07.2bpp"
room61_00:				INCBIN "gfx/rooms_bg/room61_00.2bpp"
room61_01_bA0:			INCBIN "gfx/rooms_bg/room61_01_bA0.2bpp"

SECTION "roomBgBank146",ROMX,BANK[$A1]

room61_01_bA1:			INCBIN "gfx/rooms_bg/room61_01_bA1.2bpp"
room61_02:				INCBIN "gfx/rooms_bg/room61_02.2bpp"
room61_03:				INCBIN "gfx/rooms_bg/room61_03.2bpp"
room61_04:				INCBIN "gfx/rooms_bg/room61_04.2bpp"
room62_00:				INCBIN "gfx/rooms_bg/room62_00.2bpp"
room62_01:				INCBIN "gfx/rooms_bg/room62_01.2bpp"
room62_02_bA1:			INCBIN "gfx/rooms_bg/room62_02_bA1.2bpp"

SECTION "roomBgBank147",ROMX,BANK[$A2]

room62_02_bA2:			INCBIN "gfx/rooms_bg/room62_02_bA2.2bpp"
room62_03:				INCBIN "gfx/rooms_bg/room62_03.2bpp"
room62_04:				INCBIN "gfx/rooms_bg/room62_04.2bpp"
room62_05:				INCBIN "gfx/rooms_bg/room62_05.2bpp"
room63_00:				INCBIN "gfx/rooms_bg/room63_00.2bpp"
room63_01:				INCBIN "gfx/rooms_bg/room63_01.2bpp"
room63_02_bA2:			INCBIN "gfx/rooms_bg/room63_02_bA2.2bpp"

SECTION "roomBgBank148",ROMX,BANK[$A3]

room63_02_bA3:			INCBIN "gfx/rooms_bg/room63_02_bA3.2bpp"
room63_03:				INCBIN "gfx/rooms_bg/room63_03.2bpp"
room63_04:				INCBIN "gfx/rooms_bg/room63_04.2bpp"
room64_00:				INCBIN "gfx/rooms_bg/room64_00.2bpp"
room64_01:				INCBIN "gfx/rooms_bg/room64_01.2bpp"
room64_02_bA3:			INCBIN "gfx/rooms_bg/room64_02_bA3.2bpp"

SECTION "roomBgBank149",ROMX,BANK[$A4]

room64_02_bA4:			INCBIN "gfx/rooms_bg/room64_02_bA4.2bpp"
room64_03:				INCBIN "gfx/rooms_bg/room64_03.2bpp"
room65_00:				INCBIN "gfx/rooms_bg/room65_00.2bpp"
room65_01:				INCBIN "gfx/rooms_bg/room65_01.2bpp"
room65_02_bA4:			INCBIN "gfx/rooms_bg/room65_02_bA4.2bpp"

SECTION "roomBgBank150",ROMX,BANK[$A5]

room65_02_bA5:			INCBIN "gfx/rooms_bg/room65_02_bA5.2bpp"
room65_03:				INCBIN "gfx/rooms_bg/room65_03.2bpp"
room65_04:				INCBIN "gfx/rooms_bg/room65_04.2bpp"
room65_05:				INCBIN "gfx/rooms_bg/room65_05.2bpp"
room66_00_bA5:			INCBIN "gfx/rooms_bg/room66_00_bA5.2bpp"

SECTION "roomBgBank151",ROMX,BANK[$A6]

room66_00_bA6:			INCBIN "gfx/rooms_bg/room66_00_bA6.2bpp"
room67_00:				INCBIN "gfx/rooms_bg/room67_00.2bpp"
room67_01:				INCBIN "gfx/rooms_bg/room67_01.2bpp"
room68_00_bA6:			INCBIN "gfx/rooms_bg/room68_00_bA6.2bpp"

SECTION "roomBgBank152",ROMX,BANK[$A7]

room68_00_bA7:			INCBIN "gfx/rooms_bg/room68_00_bA7.2bpp"
room68_01:				INCBIN "gfx/rooms_bg/room68_01.2bpp"
room68_02:				INCBIN "gfx/rooms_bg/room68_02.2bpp"
room68_03:				INCBIN "gfx/rooms_bg/room68_03.2bpp"
room68_04_bA7:			INCBIN "gfx/rooms_bg/room68_04_bA7.2bpp"

SECTION "roomBgBank153",ROMX,BANK[$A8]

room68_04_bA8:			INCBIN "gfx/rooms_bg/room68_04_bA8.2bpp"
room68_05:				INCBIN "gfx/rooms_bg/room68_05.2bpp"
room68_06:				INCBIN "gfx/rooms_bg/room68_06.2bpp"
room68_07_bA8:			INCBIN "gfx/rooms_bg/room68_07_bA8.2bpp"

SECTION "roomBgBank154",ROMX,BANK[$A9]

room68_07_bA9:			INCBIN "gfx/rooms_bg/room68_07_bA9.2bpp"
room69_00:				INCBIN "gfx/rooms_bg/room69_00.2bpp"
room69_01:				INCBIN "gfx/rooms_bg/room69_01.2bpp"
room69_02_bA9:			INCBIN "gfx/rooms_bg/room69_02_bA9.2bpp"

SECTION "roomBgBank155",ROMX,BANK[$AA]

room69_02_bAA:			INCBIN "gfx/rooms_bg/room69_02_bAA.2bpp"
room69_03:				INCBIN "gfx/rooms_bg/room69_03.2bpp"
room69_04:				INCBIN "gfx/rooms_bg/room69_04.2bpp"
room69_05:				INCBIN "gfx/rooms_bg/room69_05.2bpp"
room69_06_bAA:			INCBIN "gfx/rooms_bg/room69_06_bAA.2bpp"

SECTION "roomBgBank156",ROMX,BANK[$AB]

room69_06_bAB:			INCBIN "gfx/rooms_bg/room69_06_bAB.2bpp"
room69_07:				INCBIN "gfx/rooms_bg/room69_07.2bpp"
room6A_00:				INCBIN "gfx/rooms_bg/room6A_00.2bpp"
room6A_01_bAB:			INCBIN "gfx/rooms_bg/room6A_01_bAB.2bpp"

SECTION "roomBgBank157",ROMX,BANK[$AC]

room6A_01_bAC:			INCBIN "gfx/rooms_bg/room6A_01_bAC.2bpp"
room6A_02:				INCBIN "gfx/rooms_bg/room6A_02.2bpp"
room6A_03:				INCBIN "gfx/rooms_bg/room6A_03.2bpp"
room6A_04_bAC:			INCBIN "gfx/rooms_bg/room6A_04_bAC.2bpp"

SECTION "roomBgBank158",ROMX,BANK[$AD]

room6A_04_bAD:			INCBIN "gfx/rooms_bg/room6A_04_bAD.2bpp"
room6A_05:				INCBIN "gfx/rooms_bg/room6A_05.2bpp"
room6B_00:				INCBIN "gfx/rooms_bg/room6B_00.2bpp"
room6C_00:				INCBIN "gfx/rooms_bg/room6C_00.2bpp"
room6C_01_bAD:			INCBIN "gfx/rooms_bg/room6C_01_bAD.2bpp"

SECTION "roomBgBank159",ROMX,BANK[$AE]

room6C_01_bAE:			INCBIN "gfx/rooms_bg/room6C_01_bAE.2bpp"
room6C_02:				INCBIN "gfx/rooms_bg/room6C_02.2bpp"
room6C_03:				INCBIN "gfx/rooms_bg/room6C_03.2bpp"
room6C_04_bAE:			INCBIN "gfx/rooms_bg/room6C_04_bAE.2bpp"

SECTION "roomBgBank160",ROMX,BANK[$AF]

room6C_04_bAF:			INCBIN "gfx/rooms_bg/room6C_04_bAF.2bpp"
room6D_00:				INCBIN "gfx/rooms_bg/room6D_00.2bpp"
room6D_01:				INCBIN "gfx/rooms_bg/room6D_01.2bpp"
room6D_02:				INCBIN "gfx/rooms_bg/room6D_02.2bpp"
room6D_03:				INCBIN "gfx/rooms_bg/room6D_03.2bpp"
room6D_04_bAF:			INCBIN "gfx/rooms_bg/room6D_04_bAF.2bpp"

SECTION "roomBgBank161",ROMX,BANK[$B0]

room6D_04_bB0:			INCBIN "gfx/rooms_bg/room6D_04_bB0.2bpp"
room6D_05:				INCBIN "gfx/rooms_bg/room6D_05.2bpp"
room6D_06:				INCBIN "gfx/rooms_bg/room6D_06.2bpp"
room6E_00:				INCBIN "gfx/rooms_bg/room6E_00.2bpp"
room6E_01_bB0:			INCBIN "gfx/rooms_bg/room6E_01_bB0.2bpp"

SECTION "roomBgBank162",ROMX,BANK[$B1]

room6E_01_bB1:			INCBIN "gfx/rooms_bg/room6E_01_bB1.2bpp"
room6E_02:				INCBIN "gfx/rooms_bg/room6E_02.2bpp"
room6E_03:				INCBIN "gfx/rooms_bg/room6E_03.2bpp"
room6E_04_bB1:			INCBIN "gfx/rooms_bg/room6E_04_bB1.2bpp"

SECTION "roomBgBank163",ROMX,BANK[$B2]

room6E_04_bB2:			INCBIN "gfx/rooms_bg/room6E_04_bB2.2bpp"
room6E_05:				INCBIN "gfx/rooms_bg/room6E_05.2bpp"
room6E_06:				INCBIN "gfx/rooms_bg/room6E_06.2bpp"
room6E_07:				INCBIN "gfx/rooms_bg/room6E_07.2bpp"
room6F_00_bB2:			INCBIN "gfx/rooms_bg/room6F_00_bB2.2bpp"

SECTION "roomBgBank164",ROMX,BANK[$B3]

room6F_00_bB3:			INCBIN "gfx/rooms_bg/room6F_00_bB3.2bpp"
room6F_01:				INCBIN "gfx/rooms_bg/room6F_01.2bpp"
room6F_02:				INCBIN "gfx/rooms_bg/room6F_02.2bpp"
room6F_03:				INCBIN "gfx/rooms_bg/room6F_03.2bpp"
room6F_04_bB3:			INCBIN "gfx/rooms_bg/room6F_04_bB3.2bpp"

SECTION "roomBgBank165",ROMX,BANK[$B4]

room6F_04_bB4:			INCBIN "gfx/rooms_bg/room6F_04_bB4.2bpp"
room6F_05:				INCBIN "gfx/rooms_bg/room6F_05.2bpp"
room6F_06:				INCBIN "gfx/rooms_bg/room6F_06.2bpp"
room6F_07:				INCBIN "gfx/rooms_bg/room6F_07.2bpp"
room70_00:				INCBIN "gfx/rooms_bg/room70_00.2bpp"
room70_01_bB4:			INCBIN "gfx/rooms_bg/room70_01_bB4.2bpp"

SECTION "roomBgBank166",ROMX,BANK[$B5]

room70_01_bB5:			INCBIN "gfx/rooms_bg/room70_01_bB5.2bpp"
room71_00:				INCBIN "gfx/rooms_bg/room71_00.2bpp"
room71_01:				INCBIN "gfx/rooms_bg/room71_01.2bpp"
room72_00_bB5:			INCBIN "gfx/rooms_bg/room72_00_bB5.2bpp"

SECTION "roomBgBank167",ROMX,BANK[$B6]

room72_00_bB6:			INCBIN "gfx/rooms_bg/room72_00_bB6.2bpp"
room73_00:				INCBIN "gfx/rooms_bg/room73_00.2bpp"
room73_01:				INCBIN "gfx/rooms_bg/room73_01.2bpp"
room73_02_bB6:			INCBIN "gfx/rooms_bg/room73_02_bB6.2bpp"

SECTION "roomBgBank168",ROMX,BANK[$B7]

room73_02_bB7:						INCBIN "gfx/rooms_bg/room73_02_bB7.2bpp"
room73_03:							INCBIN "gfx/rooms_bg/room73_03.2bpp"
room73_04:							INCBIN "gfx/rooms_bg/room73_04.2bpp"
room06_01_mask_plant1:				INCBIN "gfx/rooms_bg/room06_01_mask_plant1.2bpp"
room06_01_mask_plant2_bB7:			INCBIN "gfx/rooms_bg/room06_01_mask_plant2_bB7.2bpp"

SECTION "roomBgBank169",ROMX,BANK[$B8]

room06_01_mask_plant2_bB8:			INCBIN "gfx/rooms_bg/room06_01_mask_plant2_bB8.2bpp"
room06_01_mask_plant3:				INCBIN "gfx/rooms_bg/room06_01_mask_plant3.2bpp"
room06_01_mask_plant4:				INCBIN "gfx/rooms_bg/room06_01_mask_plant4.2bpp"
room06_02_mask_plant1:				INCBIN "gfx/rooms_bg/room06_02_mask_plant1.2bpp"
room06_02_mask_plant2:				INCBIN "gfx/rooms_bg/room06_02_mask_plant2.2bpp"
room06_02_mask_plant3:				INCBIN "gfx/rooms_bg/room06_02_mask_plant3.2bpp"
room06_02_mask_plant4:				INCBIN "gfx/rooms_bg/room06_02_mask_plant4.2bpp"
room56_00_mask_plant42:				INCBIN "gfx/rooms_bg/room56_00_mask_plant42.2bpp"
room56_01_mask_plant42:				INCBIN "gfx/rooms_bg/room56_01_mask_plant42.2bpp"
room56_02_mask_plant42:				INCBIN "gfx/rooms_bg/room56_02_mask_plant42.2bpp"
room56_03_mask_plant42_bB8:			INCBIN "gfx/rooms_bg/room56_03_mask_plant42_bB8.2bpp"

SECTION "roomBgBank170",ROMX,BANK[$B9]

room56_03_mask_plant42_bB9:				INCBIN "gfx/rooms_bg/room56_03_mask_plant42_bB9.2bpp"
room56_04_mask_plant_42_:				INCBIN "gfx/rooms_bg/room56_04_mask_plant_42_.2bpp"
room56_05_mask_plant_42:				INCBIN "gfx/rooms_bg/room56_05_mask_plant_42.2bpp"
room6F_04_mask_painting:				INCBIN "gfx/rooms_bg/room6F_04_mask_painting.2bpp"
room6F_05_mask_painting:				INCBIN "gfx/rooms_bg/room6F_05_mask_painting.2bpp"
room6F_06_mask_painting:				INCBIN "gfx/rooms_bg/room6F_06_mask_painting.2bpp"
room5D_03_mask_button_panel:			INCBIN "gfx/rooms_bg/room5D_03_mask_button_panel.2bpp"
room5D_00_mask_lab_column1:				INCBIN "gfx/rooms_bg/room5D_00_mask_lab_column1.2bpp"
room5D_00_mask_lab_column2:				INCBIN "gfx/rooms_bg/room5D_00_mask_lab_column2.2bpp"
room5D_02_mask_lab_column1:				INCBIN "gfx/rooms_bg/room5D_02_mask_lab_column1.2bpp"
room5D_02_mask_lab_column2:				INCBIN "gfx/rooms_bg/room5D_02_mask_lab_column2.2bpp"
room5D_01_mask_lab_column1:				INCBIN "gfx/rooms_bg/room5D_01_mask_lab_column1.2bpp"
room5D_01_mask_lab_column2:				INCBIN "gfx/rooms_bg/room5D_01_mask_lab_column2.2bpp"
room01_01_mask_broken_statue_bB9:		INCBIN "gfx/rooms_bg/room01_01_mask_broken_statue_bB9.2bpp"

SECTION "roomBgBank171",ROMX,BANK[$BA]

room01_01_mask_broken_statue_bBA:			INCBIN "gfx/rooms_bg/room01_01_mask_broken_statue_bBA.2bpp"
room01_02_mask_broken_statue:				INCBIN "gfx/rooms_bg/room01_02_mask_broken_statue.2bpp"
room01_04_mask_broken_statue:				INCBIN "gfx/rooms_bg/room01_04_mask_broken_statue.2bpp"
room14_01_mask_lion_statue1:				INCBIN "gfx/rooms_bg/room14_01_mask_lion_statue1.2bpp"
room14_01_mask_lion_statue2:				INCBIN "gfx/rooms_bg/room14_01_mask_lion_statue2.2bpp"
room14_01_mask_lion_statue3:				INCBIN "gfx/rooms_bg/room14_01_mask_lion_statue3.2bpp"
room14_01_mask_lion_statue4_bBA:			INCBIN "gfx/rooms_bg/room14_01_mask_lion_statue4_bBA.2bpp"

SECTION "roomBgBank172",ROMX,BANK[$BB]

room14_01_mask_lion_statue4_bBB:			INCBIN "gfx/rooms_bg/room14_01_mask_lion_statue4_bBB.2bpp"
room14_01_mask_lion_statue5:				INCBIN "gfx/rooms_bg/room14_01_mask_lion_statue5.2bpp"
room14_01_mask_lion_statue6:				INCBIN "gfx/rooms_bg/room14_01_mask_lion_statue6.2bpp"
room14_01_mask_lion_statue7:				INCBIN "gfx/rooms_bg/room14_01_mask_lion_statue7.2bpp"
room14_00_mask_lion_statue1:				INCBIN "gfx/rooms_bg/room14_00_mask_lion_statue1.2bpp"
room14_00_mask_lion_statue2:				INCBIN "gfx/rooms_bg/room14_00_mask_lion_statue2.2bpp"
room07_01_mask_secret_door1:				INCBIN "gfx/rooms_bg/room07_01_mask_secret_door1.2bpp"
room07_03_mask_secret_door1:				INCBIN "gfx/rooms_bg/room07_03_mask_secret_door1.2bpp"
room07_07_mask_secret_door1_bBB:			INCBIN "gfx/rooms_bg/room07_07_mask_secret_door1_bBB.2bpp"

SECTION "roomBgBank173",ROMX,BANK[$BC]

room07_07_mask_secret_door1_bBC:		INCBIN "gfx/rooms_bg/room07_07_mask_secret_door1_bBC.2bpp"
room07_07_mask_secret_door2:			INCBIN "gfx/rooms_bg/room07_07_mask_secret_door2.2bpp"
room07_07_mask_secret_door3:			INCBIN "gfx/rooms_bg/room07_07_mask_secret_door3.2bpp"
room07_03_mask_secret_door2:			INCBIN "gfx/rooms_bg/room07_03_mask_secret_door2.2bpp"
room07_03_mask_secret_door3:			INCBIN "gfx/rooms_bg/room07_03_mask_secret_door3.2bpp"
room07_03_mask_secret_door4:			INCBIN "gfx/rooms_bg/room07_03_mask_secret_door4.2bpp"
room13_04_mask_crest_panel:				INCBIN "gfx/rooms_bg/room13_04_mask_crest_panel.2bpp"
room01_03_mask_blood:					INCBIN "gfx/rooms_bg/room01_03_mask_blood.2bpp"
room38_02_mask_cascade1:				INCBIN "gfx/rooms_bg/room38_02_mask_cascade1.2bpp"
room38_02_mask_cascade2:				INCBIN "gfx/rooms_bg/room38_02_mask_cascade2.2bpp"
room38_02_mask_cascade3:				INCBIN "gfx/rooms_bg/room38_02_mask_cascade3.2bpp"
room38_02_mask_cascade4:				INCBIN "gfx/rooms_bg/room38_02_mask_cascade4.2bpp"
room4B_00_mask_aquarium_flood_bBC:		INCBIN "gfx/rooms_bg/room4B_00_mask_aquarium_flood_bBC.2bpp"

SECTION "roomBgBank174",ROMX,BANK[$BD]

room4B_00_mask_aquarium_flood_bBD:			INCBIN "gfx/rooms_bg/room4B_00_mask_aquarium_flood_bBD.2bpp"
room4B_01_mask_aquarium_flood:				INCBIN "gfx/rooms_bg/room4B_01_mask_aquarium_flood.2bpp"
room4B_02_mask_aquarium_flood:				INCBIN "gfx/rooms_bg/room4B_02_mask_aquarium_flood.2bpp"
room4B_03_mask_aquarium_flood:				INCBIN "gfx/rooms_bg/room4B_03_mask_aquarium_flood.2bpp"
room4B_04_mask_aquarium_flood:				INCBIN "gfx/rooms_bg/room4B_04_mask_aquarium_flood.2bpp"
room4B_05_mask_aquarium_flood_bBD:			INCBIN "gfx/rooms_bg/room4B_05_mask_aquarium_flood_bBD.2bpp"

SECTION "roomBgBank175",ROMX,BANK[$BE]

room4B_05_mask_aquarium_flood_bBE:		INCBIN "gfx/rooms_bg/room4B_05_mask_aquarium_flood_bBE.2bpp"
room4C_05_mask_corridor_flood:			INCBIN "gfx/rooms_bg/room4C_05_mask_corridor_flood.2bpp"
room4D_00_mask_flood:					INCBIN "gfx/rooms_bg/room4D_00_mask_flood.2bpp"
room4D_01_mask_flood:					INCBIN "gfx/rooms_bg/room4D_01_mask_flood.2bpp"
room4D_02_mask_flood:					INCBIN "gfx/rooms_bg/room4D_02_mask_flood.2bpp"
room4D_03_mask_switch1_bBE:				INCBIN "gfx/rooms_bg/room4D_03_mask_switch1_bBE.2bpp"

SECTION "roomBgBank176",ROMX,BANK[$BF]

room4D_03_mask_switch1_bBF:				INCBIN "gfx/rooms_bg/room4D_03_mask_switch1_bBF.2bpp"
room4D_03_mask_switch2:					INCBIN "gfx/rooms_bg/room4D_03_mask_switch2.2bpp"
room37_00_mask_full_pool:				INCBIN "gfx/rooms_bg/room37_00_mask_full_pool.2bpp"
room37_01_mask_full_pool:				INCBIN "gfx/rooms_bg/room37_01_mask_full_pool.2bpp"
room37_02_mask_full_pool:				INCBIN "gfx/rooms_bg/room37_02_mask_full_pool.2bpp"
room58_00_mask_flood_roots_bBF:			INCBIN "gfx/rooms_bg/room58_00_mask_flood_roots_bBF.2bpp"

SECTION "roomBgBank177",ROMX,BANK[$C0]

room58_00_mask_flood_roots_bC0:			INCBIN "gfx/rooms_bg/room58_00_mask_flood_roots_bC0.2bpp"
room58_01_mask_flood_roots:				INCBIN "gfx/rooms_bg/room58_01_mask_flood_roots.2bpp"
room58_02_mask_flood_roots:				INCBIN "gfx/rooms_bg/room58_02_mask_flood_roots.2bpp"
room58_03_mask_flood_roots:				INCBIN "gfx/rooms_bg/room58_03_mask_flood_roots.2bpp"
room58_04_mask_flood_roots:				INCBIN "gfx/rooms_bg/room58_04_mask_flood_roots.2bpp"
room11_03_mask_full_bathtube_bC0:		INCBIN "gfx/rooms_bg/room11_03_mask_full_bathtube_bC0.2bpp"

SECTION "roomBgBank178",ROMX,BANK[$C1]

room11_03_mask_full_bathtube_bC1:		INCBIN "gfx/rooms_bg/room11_03_mask_full_bathtube_bC1.2bpp"
room11_01_mask_full_bathtube:			INCBIN "gfx/rooms_bg/room11_01_mask_full_bathtube.2bpp"
room49_00_mask_full_bathtube:			INCBIN "gfx/rooms_bg/room49_00_mask_full_bathtube.2bpp"
room49_01_mask_full_bathtube:			INCBIN "gfx/rooms_bg/room49_01_mask_full_bathtube.2bpp"
room58_01_mask_roots:					INCBIN "gfx/rooms_bg/room58_01_mask_roots.2bpp"
room58_02_mask_roots:					INCBIN "gfx/rooms_bg/room58_02_mask_roots.2bpp"
room2A_01_mask_rope:					INCBIN "gfx/rooms_bg/room2A_01_mask_rope.2bpp"
room2A_01_mask_open_tomb:				INCBIN "gfx/rooms_bg/room2A_01_mask_open_tomb.2bpp"
room2A_02_mask_open_tomb1:				INCBIN "gfx/rooms_bg/room2A_02_mask_open_tomb1.2bpp"
room2A_02_mask_open_tomb2_bC1:			INCBIN "gfx/rooms_bg/room2A_02_mask_open_tomb2_bC1.2bpp"

SECTION "roomBgBank179",ROMX,BANK[$C2]

room2A_02_mask_open_tomb2_bC2:			INCBIN "gfx/rooms_bg/room2A_02_mask_open_tomb2_bC2.2bpp"
room2A_03_mask_rope:					INCBIN "gfx/rooms_bg/room2A_03_mask_rope.2bpp"
room3E_05_mask_catacomb_crank1:			INCBIN "gfx/rooms_bg/room3E_05_mask_catacomb_crank1.2bpp"
room3E_05_mask_catacomb_crank2:			INCBIN "gfx/rooms_bg/room3E_05_mask_catacomb_crank2.2bpp"
room3E_05_mask_catacomb_crank3:			INCBIN "gfx/rooms_bg/room3E_05_mask_catacomb_crank3.2bpp"
room3F_05_mask_catacomb_crank1:			INCBIN "gfx/rooms_bg/room3F_05_mask_catacomb_crank1.2bpp"
room3F_05_mask_catacomb_crank2:			INCBIN "gfx/rooms_bg/room3F_05_mask_catacomb_crank2.2bpp"
room3F_05_mask_catacomb_crank3_bC2:		INCBIN "gfx/rooms_bg/room3F_05_mask_catacomb_crank3_bC2.2bpp"

SECTION "roomBgBank180",ROMX,BANK[$C3]

room3F_05_mask_catacomb_crank3_bC3:		INCBIN "gfx/rooms_bg/room3F_05_mask_catacomb_crank3_bC3.2bpp"
room3F_05_mask_catacomb_crank4:			INCBIN "gfx/rooms_bg/room3F_05_mask_catacomb_crank4.2bpp"
room3F_05_mask_catacomb_crank5:			INCBIN "gfx/rooms_bg/room3F_05_mask_catacomb_crank5.2bpp"
room45_03_mask_spiderweb1:				INCBIN "gfx/rooms_bg/room45_03_mask_spiderweb1.2bpp"
room45_03_mask_spiderweb2:				INCBIN "gfx/rooms_bg/room45_03_mask_spiderweb2.2bpp"
room45_03_mask_spiderweb3:				INCBIN "gfx/rooms_bg/room45_03_mask_spiderweb3.2bpp"
room45_00_mask_spiderweb1:				INCBIN "gfx/rooms_bg/room45_00_mask_spiderweb1.2bpp"
room45_00_mask_spiderweb2:				INCBIN "gfx/rooms_bg/room45_00_mask_spiderweb2.2bpp"
room45_00_mask_spiderweb3:				INCBIN "gfx/rooms_bg/room45_00_mask_spiderweb3.2bpp"
room45_01_mask_spiderweb:				INCBIN "gfx/rooms_bg/room45_01_mask_spiderweb.2bpp"
room45_02_mask_spiderweb:				INCBIN "gfx/rooms_bg/room45_02_mask_spiderweb.2bpp"
room45_incomplete_mask_spiderweb:		INCBIN "gfx/rooms_bg/room45_incomplete_mask_spiderweb.2bpp"



SECTION "bankC4",ROMX,BANK[$C4]

firstZombieScene:			INCBIN "gfx/tilemaps/firstZombieScene.2bpp" ;4000
firstZombieScenePal:		INCBIN "gfx/tilemaps/firstZombieScene.pal" ;4FA0

fallingStatueScreenData:	INCBIN "gfx/tilemaps/fallingStatueScreen.2bpp" ;4FE0
fallingStatueScreenPal:		INCBIN "gfx/tilemaps/fallingStatueScreen.pal" ;6240


checkAxSpritesScreenId:: ;C4:6280
;if screen correspond to criteria, return $00, otherwise $FF
;de: spriteData addr
    ld hl, wZombieAndObjectVarId - wCharSpritesData ;$F
    add hl, de
    ld a, [hl]
    or a
    jp z, Label3122FF
    cp a, $01
    jp z, Label31230F
    cp a, $02
    jp z, Label31231F
    cp a, $03
    jp z, Label31232A
    cp a, $04
    jp z, Label312335
    cp a, $05
    jp z, Label31233F
    cp a, $06
    jp z, Label31234A
    cp a, $07
    jp z, Label312355
    cp a, $08
    jp z, Label312360
    cp a, $09
    jp z, Label31236B
    cp a, $2E
    jp z, Label31237B
    cp a, $2F
    jp z, Label312386
    cp a, $30
    jp z, Label312396
    cp a, $31
    jp z, Label3123A0
    cp a, $32
    jp z, Label3123B0
    cp a, $33
    jp z, Label3123C0
    cp a, $34
    jp z, Label3123CB
    cp a, $35
    jp z, Label3123D6
    cp a, $36
    jp z, Label3123E0
    cp a, $37
    jp z, Label3123EB
    cp a, $3C
    jp z, Label3123FB
    cp a, $3D
    jp z, Label312406
    cp a, $3E
    jp z, Label312416
	;default
    ld a, $FF
    ret

Label3122FA: ;C4:62FA
    ld a, $FF
    ret
Label3122FD: ;C4:62FD
    xor a
    ret

Label3122FF: ;C4:62FF
    ld a, [wRoomScreen]
    cp a, $04
    jp z, Label3122FA
    cp a, $05
    jp z, Label3122FA
    jp Label3122FD
Label31230F:
    ld a, [wRoomScreen]
    cp a, $01
    jp z, Label3122FA
    cp a, $03
    jp z, Label3122FA
    jp Label3122FD
Label31231F:
    ld a, [wRoomScreen]
    cp a, $02
    jp z, Label3122FA
    jp Label3122FD
Label31232A:
    ld a, [wRoomScreen]
    cp a, $04
    jp nz, Label3122FD
    jp Label3122FA
Label312335:
    ld a, [wEventFirstZombieScn]
    or a
    jp z, Label3122FD
    jp Label3122FA
Label31233F:
    ld a, [wRoomScreen]
    cp a, $01
    jp nz, Label3122FD
    jp Label3122FA
Label31234A:
    ld a, [wRoomScreen]
    cp a, $02
    jp nz, Label3122FD
    jp Label3122FA
Label312355:
    ld a, [wRoomScreen]
    cp a, $04
    jp nz, Label3122FD
    jp Label3122FA
Label312360:
    ld a, [wRoomScreen]
    cp a, $00
    jp nz, Label3122FD
    jp Label3122FA
Label31236B:
    ld a, [wRoomScreen]
    cp a, $01
    jp z, Label3122FA
    cp a, $02
    jp z, Label3122FA
    jp Label3122FD
Label31237B:
    ld a, [wRoomScreen]
    cp a, $06
    jp nz, Label3122FD
    jp Label3122FA
Label312386:
    ld a, [wRoomScreen]
    cp a, $01
    jp z, Label3122FA
    cp a, $03
    jp z, Label3122FA
    jp Label3122FD
Label312396:
    ld a, [wRoomScreen]
    or a
    jp nz, Label3122FD
    jp Label3122FA
Label3123A0:
    ld a, [wRoomScreen]
    cp a, $04
    jp z, Label3122FA
    cp a, $05
    jp z, Label3122FA
    jp Label3122FD
Label3123B0:
    ld a, [wRoomScreen]
    cp a, $01
    jp z, Label3122FA
    cp a, $02
    jp z, Label3122FA
    jp Label3122FD
Label3123C0:
    ld a, [wRoomScreen]
    cp a, $03
    jp nz, Label3122FD
    jp Label3122FA
Label3123CB:
    ld a, [wRoomScreen]
    cp a, $02
    jp nz, Label3122FD
    jp Label3122FA
Label3123D6:
    ld a, [wRoomScreen]
    or a
    jp nz, Label3122FD
    jp Label3122FA
Label3123E0:
    ld a, [wRoomScreen]
    cp a, $01
    jp nz, Label3122FD
    jp Label3122FA
Label3123EB:
    ld a, [wRoomScreen]
    cp a, $03
    jp z, Label3122FA
    cp a, $04
    jp z, Label3122FA
    jp Label3122FD
Label3123FB:
    ld a, [wRoomScreen]
    cp a, $05
    jp nz, Label3122FD
    jp Label3122FA
Label312406:
    ld a, [wRoomScreen]
    cp a, $01
    jp z, Label3122FA
    cp a, $02
    jp z, Label3122FA
    jp Label3122FD
Label312416:
    ld a, [wRoomScreen]
    cp a, $03
    jp nz, Label3122FD
    jp Label3122FA


checkObjectsVisibility:: ;C4:6421 objectsSpritesFunc
;check if an object is visible when is visible from a certain room screen
;return FF when visible, 00 if not.
    ld a, [spriteIdBuffer]
    cp a, MAP_STEP_LADDER ;$E0
    jp z, Label312445
    cp a, WOODEN_RACK ;$EC
    jp z, Label312450
    cp a, DORM_002_CLOSET ;$EE
    jp z, Label31245B
    cp a, HIDDEN_LIBRARY_STATUE ;$F0
    jp z, Label312466
    cp a, WOODEN_BOX ;$F1
    jp z, Label312480
	;default
    ld a, $FF
    ret

Label312440: ;C4:6440
    ld a, $FF
    ret
Label312443: ;C4:6443
    xor a
    ret

Label312445: ;C4:6445
    ld a, [wRoomScreen]
    cp a, $02
    jp z, Label312440
    jp Label312443
Label312450:
    ld a, [wRoomScreen]
    cp a, $02
    jp z, Label312440
    jp Label312443
Label31245B:
    ld a, [wRoomScreen]
    cp a, $03
    jp z, Label312440
    jp Label312443
Label312466:
    ld a, [wRoomScreen]
    cp a, $02
    jp z, Label312440
    cp a, $04
    jp z, Label312440
    cp a, $06
    jp z, Label312440
    cp a, $07
    jp z, Label312440
    jp Label312443
Label312480:
    ld a, [wRoomScreen]
    cp a, $05
    jp z, Label312440
    jp Label312443

;C4:648B

INCLUDE "main/roomsEventsColliders.asm"

checkRoomsEventsColliders: ;C4:64FB
    ld a, [wRoomId]
    cp a, EXHIBITION_ROOM ;$04
    jp z, mapStepLadderElevationCollider
    cp a, GREENHOUSE ;$06
    jp z, checkShieldKeyPlantCollider
    cp a, PIANO_ROOM ;$07
    jp z, ShowPianoRoomBgChange
    cp a, HIDDEN_LIBRARY ;$32
    jp z, checkLibrarySecretDoorCollider
    cp a, COURTYARD_FLOODGATE ;$37
    jp z, checkCourtyardPoolCollider
    cp a, WATERFALL_GARDEN ;$38
    jp z, checkCascadeCollider
    cp a, UNDGRND_STATUE_ROOM ;$3B
    jp z, checkCatacombStatueWallCollider
    cp a, BOULDER_ROOM_2 ;$3E
    jp z, checkBoulderRotateFloorCollider
    cp a, UNDERGROUND_ENTRY ;$3F
    jp z, checkEntranceRotateFloorCollider
    cp a, AQUA_TANK_ENTRANCE ;$4C
    jp z, checkAquariumWoodenBoxCollider
    cp a, PLANT_42_ROOTS_ROOM ;$58
    jp z, checkPlant42RootsCollider
    cp a, VISUAL_DATA_ROOM ;$5D
    jp z, checkLabSlideRoomPillarCollider
    ret
;653B
mapStepLadderElevationCollider: ;C4:653B
    ld a, [wStepLadderElevationMode]
    or a
    ret z
    ld hl, mapStepLadderElevCollider1 ;$648B
    call evalRoomEventCollision
    ld hl, mapStepLadderElevCollider2 ;$6493
    jp evalRoomEventCollision

checkShieldKeyPlantCollider:
    ld a, [wTriggerShieldKeyPlant]
    or a
    ret nz
    ld hl, shieldKeyPlantCollider ;$649B
    jp evalRoomEventCollision

ShowPianoRoomBgChange:
    ld a, [wPianoRoomSecretDoorTrigger]
    or a
    jr z, Label312567
    ld a, [wPianoRoomGoldEmblemTrigger]
    ld c, a
    ld a, [wPianoRoomWoodEmblemTrigger]
    add a, c
    or a
    ret nz
Label312567
    ld hl, pianoRoomSecretDoorCollider ;$64A3
    jp evalRoomEventCollision

checkLibrarySecretDoorCollider:
    ld a, [wLibrarySecretDoorTrigger]
    or a
    ret nz
    ld hl, librarySecretDoorCollider ;$64AB
    jp evalRoomEventCollision

checkCourtyardPoolCollider:
    ld a, [wTriggerCourtyardCascade]
    or a
    ret nz
    ld hl, courtyardPoolCollider ;$64B3
    jp evalRoomEventCollision

checkCascadeCollider:
    ld a, [wTriggerCourtyardCascade]
    or a
    ret z
    ld hl, cascadeCollider ;$64BB
    jp evalRoomEventCollision

checkCatacombStatueWallCollider:
    ld a, [wCatacombStatueWallTrigger]
    or a
    ret z
    ld hl, catacombStatueWallCollider ;$64C3
    jp evalRoomEventCollision

checkBoulderRotateFloorCollider:
    ld a, [wRotateFloor2AnimId]
    cp a, $02
    ret z
    ld hl, boulderRotateFloorCollider ;$64CB
    jp evalRoomEventCollision

checkEntranceRotateFloorCollider:
    ld a, [wRotateFloor1AnimId]
    cp a, $04
    ret z
    ld hl, entranceRotateFloorCollider ;$64D3
    jp evalRoomEventCollision

checkAquariumWoodenBoxCollider:
    ld a, [wAquariumWoodenBoxSunken]
    or a
    ret nz
    ld hl, aquariumWoodenBoxCollider ;$64DB
    jp evalRoomEventCollision

checkPlant42RootsCollider:
    ld a, [wPlant42RootsTrigger]
    or a
    ret nz
    ld hl, plant42RootsCollider ;$64E3
    jp evalRoomEventCollision

checkLabSlideRoomPillarCollider:
    ld hl, labSlideRoomPillarCollider1 ;$64EB
    ld a, [wLabSlideRoomPillarMoved]
    or a
    jr z, Label3125D3
    ld hl, labSlideRoomPillarCollider2 ;$64F3
Label3125D3
    jp evalRoomEventCollision

evalRoomEventCollision:
    ld a, [hli]
    ld [wLowColliderRightX], a
    ld c, a
    ld a, [hli]
    ld [wHighColliderRightX], a
    ld b, a
    inc hl
    inc hl
    ld a, [hli]
    add a, c
    ld [wLowColliderLeftX], a
    ld a, [hld]
    adc a, b
    ld [wHighColliderLeftX], a
    dec hl
    dec hl
    ld a, [hli]
    ld [wLowColliderBottomY], a
    ld c, a
    ld a, [hli]
    ld [wHighColliderBottomY], a
    ld b, a
    inc hl
    inc hl
    ld a, [hli]
    add a, c
    ld [wLowColliderTopY], a
    ld a, [hli]
    adc a, b
    ld [wHighColliderTopY], a
    ld a, [wSpritePositionXLow]
    ld e, a
    ld a, [wSpritePositionXHigh]
    ld d, a
    call div8SignedWordC4
    push de
    ld a, [wSpritePositionZLow]
    ld e, a
    ld a, [wSpritePositionZHigh]
    ld d, a
    call div8SignedWordC4
    ld l, e
    ld h, d
    pop de
    jp Label312621
Label312621
    ld a, [wLowColliderRightX]
    sub a, e
    ld a, [wHighColliderRightX]
    sbc a, d
    cp a, $FF
    ret nz
    ld a, [wLowColliderLeftX]
    sub a, e
    ld a, [wHighColliderLeftX]
    sbc a, d
    or a
    ret nz
    ld a, [wLowColliderBottomY]
    sub a, l
    ld a, [wHighColliderBottomY]
    sbc a, h
    cp a, $FF
    ret nz
    ld a, [wLowColliderTopY]
    sub a, l
    ld a, [wHighColliderTopY]
    sbc a, h
    or a
    ret nz
    push de
    push hl
    ld a, [wSpriteRoomPositionXLow]
    ld e, a
    ld a, [wSpriteRoomPositionXHigh]
    ld d, a
    ld a, [wSpriteRoomPositionYLow]
    ld l, a
    ld a, [wSpriteRoomPositionYHigh]
    ld h, a
;checkRoomEventBottomCollider
    ld a, [wLowColliderBottomY]
    sub a, l
    ld a, [wHighColliderBottomY]
    sbc a, h
    or a
    jr nz, checkRoomEventTopCollider
    ld a, [wLowColliderBottomY]
    ld e, a
    ld a, [wHighColliderBottomY]
    ld d, a
    call multiply8SignedWordC4
    ld a, e
    sub a, $01
    ld [wSpritePositionZLow], a
    ld a, d
    sbc a, $00
    ld [wSpritePositionZHigh], a
    pop hl
    pop de
    ret
checkRoomEventTopCollider: ;C4:6682
    ld a, [wLowColliderTopY]
    sub a, l
    ld a, [wHighColliderTopY]
    sbc a, h
    cp a, $FF
    jr nz, checkRoomEventRightCollider
    ld a, [wLowColliderTopY]
    ld e, a
    ld a, [wHighColliderTopY]
    ld d, a
    call multiply8SignedWordC4
    ld a, e
    add a, $08
    ld [wSpritePositionZLow], a
    ld a, d
    adc a, $00
    ld [wSpritePositionZHigh], a
    pop hl
    pop de
    ret
checkRoomEventRightCollider: ;C4:66A8
    ld a, [wLowColliderRightX]
    sub a, e
    ld a, [wHighColliderRightX]
    sbc a, d
    or a
    jr nz, checkRoomEventLeftCollider
    ld a, [wLowColliderRightX]
    ld e, a
    ld a, [wHighColliderRightX]
    ld d, a
    call multiply8SignedWordC4
    ld a, e
    sub a, $01
    ld [wSpritePositionXLow], a
    ld a, d
    sbc a, $00
    ld [wSpritePositionXHigh], a
    pop hl
    pop de
    ret
checkRoomEventLeftCollider: ;C4:66CD
    ld a, [wLowColliderLeftX]
    ld e, a
    ld a, [wHighColliderLeftX]
    ld d, a
    call multiply8SignedWordC4
    ld a, e
    add a, $08
    ld [wSpritePositionXLow], a
    ld a, d
    adc a, $00
    ld [wSpritePositionXHigh], a
    pop hl
    pop de
    ret
;66E7

div8SignedWordC4: ;C4:66E7
    ld a, d
    cp a, $80
    jr c, Label3126FF
    call reverseWordSignC4
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    call reverseWordSignC4
    ret
Label3126FF: ;C4:66FF
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    ret
;670C

multiply8SignedWordC4: ;C4:670C
    ld a, d
    cp a, $80
    jr c, Label312721
    call reverseWordSignC4
    push hl
    push de
    pop hl
    add hl, hl
    add hl, hl
    add hl, hl
    push hl
    pop de
    pop hl
    call reverseWordSignC4
    ret
Label312721: ;C4:6721
    push hl
    push de
    pop hl
    add hl, hl
    add hl, hl
    add hl, hl
    push hl
    pop de
    pop hl
    ret
;672B

reverseWordSignC4: ;C4:672B
    ld a, $00
    sub a, e
    ld e, a
    ld a, $00
    sbc a, d
    ld d, a
    ret

;6734 rest of bank is empty


SECTION "bankC5",ROMX,BANK[$C5]

INCLUDE "main/RoomsActionsDataTable.asm" ;4000

INCLUDE "main/RoomsActionsData.asm" ;40E8

INCLUDE "main/roomsDoorsTriggerIdsTable.asm" ;5B5B

INCLUDE "main/initTriggersData.asm" ;5F25
;6273

InitGameTriggers: ;C5:6273
    ld de, _initTriggers1 ;$5F25
    ld hl, wDoorTriggers
    ld bc, $80
    call loadSprtTilesToBuffer
    ld de, _initTriggers2 ;$5FA5
    ld hl, wEventsTriggers ;C480
    ld bc, $80
    call loadSprtTilesToBuffer
    ld de, _initTriggers4 ;$6073
    ld hl, wRoomItemsTriggers
    ld bc, $100
    call loadSprtTilesToBuffer
    ld de, _initTriggers5 ;$6173
    ld hl, wEnemyAndObjectsVars ;C600
    ld bc, $100
    call loadSprtTilesToBuffer
    ld hl, wTriggerFile01
    ld b, $04
	;set 4 first files
.loop3162A8
    ld [hl], $FF
    inc hl
    dec b
    jr nz, .loop3162A8
    ld a, [wSelectedPlayer]
    or a
    jr z, .Label3162C4 ;jump if chris
	;if jill
    ld a, $FF
    ld [wBoulderPassage1DoorLock], a
    ld [wMansionBathroomTubUnplug], a
    xor a
    ld [wc574], a
    ld [wc57f], a
    ret
.Label3162C4
	ret
;c5:62c5


checkRoomsActions: ;C5:62C5
    xor a
    ld [wButtonAEventId], a ;reset button A event
    ld a, [wLCDUpdate]
    or a
    ret nz ;return if fade-in
    ld a, [wRoomId]
    ld l, a
    ld a, [wRoomIdHigh]
    ld h, a
    add hl, hl
    ld de, roomsActionsDatatable ;$4000
    add hl, de
    ld a, [hl]
    inc hl
    ld h, [hl]
    ld l, a
checkNextRoomAction:
    ld a, [hl]
    cp a, $FF
    jr z, finishRoomActionCheck
    cp a, $90
    jp c, checkRoomDoorsAction
    cp a, $91
    jp z, checkRoomItemBoxAction
    cp a, $90
    jp z, checkRoomTypewriterAction
    cp a, $98
    jp z, skipRoomCharactersSprites
    cp a, $A0
    jp z, skipRoomCharactersSprites
    cp a, $95
    jp z, skipRoomCharactersSprites
    cp a, $A8
    jp z, checkRoomDroppedItem
    cp a, $A9
    jp z, checkRoomCheckAction
    cp a, $E0
    jp nc, skipRoomObjectsSprites
    jr checkNextRoomAction
finishRoomActionCheck
    ret

skipRoomObjectsSprites: ;C5:6314
    ld de, $B
    add hl, de
    jp checkNextRoomAction

checkRoomDroppedItem:
    ld a, [wSpriteAnimationId]
    cp a, PICK_ITEM_ANIM ;$07
    jr z, alreadyPickingItem
    ld de, $5
    add hl, de ;offset to item position
    call checkDroppedItem
    or a
    jr z, Label316333 ;no picked item
    ld de, $6
    add hl, de
    jp checkNextRoomAction
Label316333
    ld de, $6
    add hl, de
    jp checkNextRoomAction
alreadyPickingItem
    ld de, $B
    add hl, de
    jp checkNextRoomAction

checkRoomCheckAction:
    ld de, $5
    add hl, de
    call roomCheckAction
    or a
    jr z, Label316352
    ld de, $6
    add hl, de
    jp checkNextRoomAction
Label316352
    ld de, $6
    add hl, de
    jp checkNextRoomAction

skipRoomCharactersSprites:
    ld de, $B
    add hl, de
    jp checkNextRoomAction

checkRoomDoorsAction:
    ld de, $5
    add hl, de
    call checkDoorAction
    or a
    jr z, Label316371
    ld de, $6
    add hl, de
    jp checkNextRoomAction
Label316371
    ld de, $6
    add hl, de
    jp checkNextRoomAction

checkRoomTypewriterAction:
    ld de, $5
    add hl, de
    call checkTypewriterAction
    or a
    jr z, Label316389
    ld de, $6
    add hl, de
    jp checkNextRoomAction
Label316389
    ld de, $6
    add hl, de
    jp checkNextRoomAction

checkRoomItemBoxAction:
    ld de, $5
    add hl, de
    call checkItemBoxAction
    or a
    jr z, Label3163A1
    ld de, $6
    add hl, de
    jp checkNextRoomAction
Label3163A1
    ld de, $6
    add hl, de
    jp checkNextRoomAction

roomCheckAction: ;C5:63A8
    ld a, [wButtonAEventId]
    cp a, BTN_CHECK_ACTION ;$05
    jr z, Label3163B3
    or a
    jp nz, Label316453
Label3163B3
    ld de, $4
    add hl, de ;facing
    ld a, [hl]
    ld [wc1f5], a
    ld de, $FFFC ;-4
    add hl, de
    ld a, [wSpritePositionXLow]
    sub a, [hl]
    ld c, a ;store x-distance
    inc hl
    ld a, [wSpritePositionXHigh]
    sbc a, [hl]
    inc hl
    or a
    jr z, Label3163D8 ;if positive x-axis
    cp a, $FF
    jr z, Label3163DF ;if negative x-axis
Label3163D1
    ld de, $FFFE ;-2
    add hl, de
    jp Label316453
Label3163D8
    ld a, c
    cp a, $40
    jr nc, Label3163D1 ;return if x-distance >= $40 (64)
    jr Label3163E4
Label3163DF
    ld a, c
    cp a, $C0
    jr c, Label3163D1 ;return if x-distance < $C0 (-64)
Label3163E4
    ld a, [wSpritePositionZLow]
    sub a, [hl]
    ld c, a ;store y-distance
    inc hl
    ld a, [wSpritePositionZHigh]
    sbc a, [hl]
    inc hl
    or a
    jr z, Label3163FD ;if positive y-axis
    cp a, $FF
    jr z, Label316404 ;if negative y-axis
Label3163F6
    ld de, $FFFC ;-4
    add hl, de
    jp Label316453
Label3163FD
    ld a, c
    cp a, $40
    jr nc, Label3163F6 ;return if y-distance >= $40 (64)
    jr checkPickItemFacing
Label316404
    ld a, c
    cp a, $C0
    jr c, Label3163F6 ;return if y-distance < $C0 (-64)
checkPickItemFacing
    ld a, [wSpriteFacing]
    ld c, a
    ld a, [hl] ;get check action facing
    ld de, $FFFC ;-4 back to start position offset
    add hl, de
    add a, $10
    sub a, c
    and a, $1F
    cp a, $08
    jr c, checkPickItemInput
    cp a, $18
    jr nc, checkPickItemInput
    jp Label316453
checkPickItemInput
    ld a, [wButtonPressId]
    and a, A_INPUT
    jr z, Label316450 ;no input
    ld a, [wSpriteAnimationId]
    cp a, IDLE_ANIM
    jr nz, Label316450 ;return if not idle anim
    ld de, $FFFE ;-2
    add hl, de
    ld a, [hl] ;get item id
    ld [selectedItemId], a
    ld de, $FFFE ;-2
    add hl, de
    ld a, [hl] ;get item id
    ld [wItemTriggerId], a
    call getItemTriggerVar
    ld de, $4
    add hl, de ;back to action x-position
    or a
    jp z, returnCheckAction ;if item id is $00, then this is a check action
;item got
    ld a, GET_ITEM_ACTION ;$03
    ld [wButtonAEventId], a
Label316450
    ld a, $FF
    ret
Label316453: ;C5:6453
    xor a
    ret
;6455

returnCheckAction: ;C5:6455
    ld a, [wItemTriggerId]
    ld [wCheckEventIdA], a ;store room check action id
    ld a, $FF
    ld [wCheckEventIdB], a ;set room check action mode
    ld a, BTN_CHECK_ACTION ;$05
    ld [wButtonAEventId], a
    xor a
    ret
;6467

checkDroppedItem: ;C5:6467
    ld a, [wButtonAEventId]
    cp a, BTN_CHECK_ACTION ;$05
    jr z, Label316472
    or a
    jp nz, Label316505
Label316472
    ld de, $4
    add hl, de ;facing
    ld a, [hl]
    ld [wc1f5], a
    ld de, $FFFC ;-4
    add hl, de
    ld a, [wSpritePositionXLow]
    sub a, [hl]
    ld c, a ;store x-distance
    inc hl
    ld a, [wSpritePositionXHigh]
    sbc a, [hl]
    inc hl
    or a
    jr z, Label316497 ;if positive x-axis
    cp a, $FF
    jr z, Label31649E ;if negative x-axis
Label316490
    ld de, $FFFE ;-2
    add hl, de
    jp Label316505
Label316497
    ld a, c
    cp a, $20
    jr nc, Label316490 ;return if x-distance >= $20 (32)
    jr Label3164A3
Label31649E
    ld a, c
    cp a, $E0
    jr c, Label316490 ;return if x-distance < $E0 (-32)
Label3164A3
    ld a, [wSpritePositionZLow]
    sub a, [hl]
    ld c, a ;store y-distance
    inc hl
    ld a, [wSpritePositionZHigh]
    sbc a, [hl]
    inc hl
    or a
    jr z, Label3164BC ;if positive y-axis
    cp a, $FF
    jr z, Label3164C3 ;if negative y-axis
Label3164B5
    ld de, $FFFC ;-2
    add hl, de
    jp Label316505
Label3164BC
    ld a, c
    cp a, $20
    jr nc, Label3164B5 ;return if y-distance >= $20 (32)
    jr checkDroppedItemInput
Label3164C3
    ld a, c
    cp a, $E0
    jr c, Label3164B5 ;return if y-distance < $E0 (-32)
checkDroppedItemInput
    ld de, $FFFC ;-4 back to start position offset
    add hl, de
    ld a, [wButtonPressId]
    and a, A_INPUT
    jr z, Label316502 ;no input
    ld a, [wSpriteAnimationId]
    cp a, IDLE_ANIM ;$00
    jr nz, Label316502 ;return if not idle anim
    ld de, $FFFE ;-2
    add hl, de ;get item Id
    ld a, [hl]
    ld [wFoundItemId], a ;for include item menu
    ld de, $FFFE ;-2
    add hl, de
    ld a, [hl] ;get item trigger id
    ld [wItemTriggerId], a
    call getItemTriggerVar
    ld de, $4
    add hl, de ;back to action x-position
    or a
    jp z, returnNoPickedDroppedItem
	;pick dropped item
    ld a, PICK_ITEM_ANIM
    ld [wSpriteAnimationId], a
    xor a
    ld [wSpriteAnimationFrameId], a
    ld [wButtonAEventId], a
    ret
Label316502: ;C5:6502
    ld a, $FF
    ret
;6505
Label316505: ;C5:6505
    xor a
    ret
;6507

returnNoPickedDroppedItem: ;C5:6507
    ld a, [wItemTriggerId]
    ld [wCheckEventIdA], a
    ld a, $FF
    ld [wCheckEventIdB], a
    ld a, $05
    ld [wButtonAEventId], a
    xor a
    ret
;6519

checkDoorAction:: ;C5:6519
    ld a, [wButtonAEventId]
    or a
    jp nz, returnNoRoomAction
    ld de, $4
    add hl, de
    ld a, [hl]
    ld [wButtonActionFacing], a
    ld de, $FFFC ;-4 return to action xpos
    add hl, de ;action xpos low
    ld a, [wSpritePositionXLow]
    sub a, [hl]
    ld c, a ;store x-distance
    inc hl ;action xpos high
    ld a, [wSpritePositionXHigh]
    sbc a, [hl]
    inc hl ;action ypos low
    or a
    jr z, setActionRangePositiveXAxis ;if positive x-axis
    cp a, $FF ;-1
    jr z, setActionRangeNegativeXAxis ;if negative x-axis
returnNoPosXMatch
    ld de, $FFFE ;-2
    add hl, de
    jp returnNoRoomAction
setActionRangePositiveXAxis
    ld b, $08 ;distance when facing at north-south
    ld a, [wButtonActionFacing]
    and a, $0F ;mask only east-west facing
    jr nz, Label316550
	;set distance when facing east-west
    ld b, $80
Label316550
    ld a, c
    cp a, b
    jr nc, returnNoPosXMatch ;return if out of action x-range
    jr evalActionYaxis
setActionRangeNegativeXAxis
    ld b, $F8 ;-8 distance when facing at north-south
    ld a, [wButtonActionFacing]
    and a, $0F ;mask only east-west facing
    jr nz, Label316561
	;set distance when facing east-west
    ld b, $80
Label316561
    ld a, c
    cp a, b
    jr c, returnNoPosXMatch ;return if out of action x-range
evalActionYaxis
    ld a, [wSpritePositionZLow]
    sub a, [hl]
    ld c, a ;store y-distance
    inc hl
    ld a, [wSpritePositionZHigh]
    sbc a, [hl]
    inc hl
    or a
    jr z, setActionRangePositiveYAxis
    cp a, $FF
    jr z, setActionRangeNegativeYAxis
returnNoPosYMatch
    ld de, $FFFC ;-4
    add hl, de
    jp returnNoRoomAction
setActionRangePositiveYAxis
    ld b, $80
    ld a, [wButtonActionFacing]
    and a, $0F ;mask only east-west facing
    jr nz, Label316589
    ld b, $08
Label316589
    ld a, c
    cp a, b
    jr nc, returnNoPosYMatch
    jr checkDoorActionFacing
setActionRangeNegativeYAxis
    ld b, $80
    ld a, [wButtonActionFacing]
    and a, $0F
    jr nz, Label31659A
    ld b, $F8
Label31659A
    ld a, c
    cp a, b
    jr c, returnNoPosYMatch
checkDoorActionFacing
    ld a, [wSpriteFacing]
    ld c, a
    ld a, [hl]
    ld de, $FFFC ;-4
    add hl, de
    add a, $10
    sub a, c
    and a, $1F
    cp a, $08
    jr c, checkDoorActionInput
    cp a, $18
    jr nc, checkDoorActionInput
    jp returnNoRoomAction
checkDoorActionInput
    ld a, [wButtonPressId]
    and a, A_INPUT ;$01
    jr z, Label31661D ;no A input
	;avoid trigger action when using weapon
    ld a, [wSpriteAnimationId]
    cp a, GUN_AIM_ANIM ;$03
    jr z, Label31661D
    cp a, KNIFE_AIM_ANIM ;$05
    jr z, Label31661D
    cp a, SHOTGUN_AIM_ANIM ;$04
    jr z, Label31661D
    ld de, $FFFB ;-5 get action Id
    add hl, de
    call checkDoorIdAction
    or a
    jp z, checkedDoorNotOpened
	;if door was opened
    ld a, [hl] ;door id
    ld [wDoorAnimationType], a ;get door anim type
    srl a
    srl a
    srl a
    ld [wDoorSpriteId], a
    ld a, [hl]
    and a, $07
    ld [wDoorPalleteId], a
    ld de, $3
    add hl, de ;add target door address offset
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    inc de ;roomId position
    ld a, [de]
    ld [wRoomId], a
    inc de
    ld a, [de]
    ld [wRoomIdHigh], a
	;offset to target door position
    inc de
    inc de
    inc de
	;set player position to target door pos
    ld a, [de]
    ld [wSpritePositionXLow], a
    inc de
    ld a, [de]
    ld [wSpritePositionXHigh], a
    inc de
    ld a, [de]
    ld [wSpritePositionZLow], a
    inc de
    ld a, [de]
    ld [wSpritePositionZHigh], a
    inc de
    ld a, [de]
    ld [wSpriteFacing], a
    ld a, OPEN_DOOR_ACTION ;$01
    ld [wButtonAEventId], a
Label31661D
    ld a, $FF
    ret
;6620
returnNoRoomAction: ;C5:6620
    xor a
    ret
;6622
checkedDoorNotOpened: ;C5:6622
    ld de, $5 ;offset to action x-pos
    add hl, de
    ld a, $FF
    ld [wCheckEventIdA], a
    ld a, [wc1ff]
    ld [wCheckEventIdB], a ;door id event
    ld a, BTN_CHECK_ACTION ;$05
    ld [wButtonAEventId], a ;normal check action
    xor a
    ret
;6638

checkTypewriterAction: ;C5:6638
    ld a, [wButtonAEventId]
    cp a, $05
    jr z, Label316643
    or a
    jp nz, returnNoTypewriterAction
Label316643
    ld a, [wSpritePositionXLow]
    sub a, [hl]
    ld c, a ;store x-distance
    inc hl ;action xpos high
    ld a, [wSpritePositionXHigh]
    sbc a, [hl]
    inc hl ;action ypos low
    or a
    jr z, Label31665C ;if positive x-axis
    cp a, $FF
    jr z, Label316663 ;if negative x-axis
xDistanceOutRange
    ld de, $FFFE ;-2
    add hl, de
    jp returnNoTypewriterAction
Label31665C
    ld a, c
    cp a, $40
    jr nc, xDistanceOutRange ;return if x-distance >= $40 (64)
    jr Label316668
Label316663
    ld a, c
    cp a, $C0
    jr c, xDistanceOutRange ;return if x-distance < $40 (-64)
Label316668
    ld a, [wSpritePositionZLow]
    sub a, [hl]
    ld c, a ;store y-distance
    inc hl ;y-pos high
    ld a, [wSpritePositionZHigh]
    sbc a, [hl]
    inc hl ;facing
    or a
    jr z, Label316681 ;if positive y-axis
    cp a, $FF
    jr z, Label316688 ;if negative y-axis
yDistanceOutRange
    ld de, $FFFC ;-4
    add hl, de
    jp returnNoTypewriterAction
Label316681
    ld a, c
    cp a, $40
    jr nc, yDistanceOutRange ;return if y-distance >= $40 (64)
    jr checkTypewriterActionFacing
Label316688
    ld a, c
    cp a, $C0
    jr c, yDistanceOutRange ;return if y-distance < $40 (-64)
checkTypewriterActionFacing
    ld a, [wSpriteFacing]
    ld c, a
    ld a, [hl]
    ld de, $FFFC ;-4
    add hl, de
    add a, $10
    sub a, c
    and a, $1F
    cp a, $04
    jr c, checkTypewriterActionInput
    cp a, $1C
    jr nc, checkTypewriterActionInput
    jp returnNoTypewriterAction
checkTypewriterActionInput ;C5:66A6
    ld a, [wButtonPressId]
    and a, A_INPUT
    jr z, Label3166C3 ;no A input
	;avoid action when using weapon
    ld a, [wSpriteAnimationId]
    cp a, GUN_AIM_ANIM ;$03
    jr z, Label3166C3
    ld a, $FF
    ld [wCheckEventIdA], a
    ld a, $80
    ld [wCheckEventIdB], a ;set typewriter action
    ld a, BTN_CHECK_ACTION ;$05
    ld [wButtonAEventId], a ;normal action
Label3166C3
    ld a, $FF
    ret
returnNoTypewriterAction: ;C5:66C6
    xor a
    ret
;66C8

checkItemBoxAction: ;C5:66C8
    ld a, [wButtonAEventId]
    or a
    jp nz, returnNoItemBoxAction
    ld a, [wSpritePositionXLow]
    sub a, [hl]
    ld c, a ;store x-distance
    inc hl ;action xpos high
    ld a, [wSpritePositionXHigh]
    sbc a, [hl]
    inc hl
    or a
    jr z, Label3166E8 ;if positive x-axis
    cp a, $FF
    jr z, Label3166EF ;if negative x-axis
itemBoxOutofXRange
    ld de, $FFFE ;-2
    add hl, de
    jp returnNoItemBoxAction
Label3166E8
    ld a, c
    cp a, $40
    jr nc, itemBoxOutofXRange ;return if x-distance >= $40 (64)
    jr Label3166F4
Label3166EF
    ld a, c
    cp a, $C0
    jr c, itemBoxOutofXRange ;return if x-distance < $40 (-64)
Label3166F4
    ld a, [wSpritePositionZLow]
    sub a, [hl]
    ld c, a ;store y-distance
    inc hl
    ld a, [wSpritePositionZHigh]
    sbc a, [hl]
    inc hl ;facing
    or a
    jr z, Label31670D ;if positive y-axis
    cp a, $FF
    jr z, Label316714 ;if negative y-axis
itemBoxOutofYRange
    ld de, $FFFC ;-4
    add hl, de
    jp returnNoItemBoxAction
Label31670D
    ld a, c
    cp a, $40
    jr nc, itemBoxOutofYRange
    jr checkItemBoxActionFacing
Label316714
    ld a, c
    cp a, $C0
    jr c, itemBoxOutofYRange
checkItemBoxActionFacing
    ld a, [wSpriteFacing]
    ld c, a
    ld a, [hl]
    ld de, $FFFC ;-4
    add hl, de
    add a, $10
    sub a, c
    and a, $1F
    cp a, $04
    jr c, checkItemBoxActionInput
    cp a, $1C
    jr nc, checkItemBoxActionInput
    jp returnNoItemBoxAction
checkItemBoxActionInput
    ld a, [wButtonPressId]
    and a, A_INPUT
    jr z, Label316745 ;no A input
	;avoid action when using weapon
    ld a, [wSpriteAnimationId]
    cp a, GUN_AIM_ANIM ;$03
    jr z, Label316745
    ld a, ITEMBOX_MENU_ACTION ;$04
    ld [wButtonAEventId], a
Label316745
    ld a, $FF
    ret
returnNoItemBoxAction: ;C5:6748
    xor a
    ret
;674A

checkDoorIdAction: ;C5:674A
;return $00 if door is already unlocked or locked door key not found,
;return $FF is locked door is unlocked
    push bc
    push de
    push hl
    ld e, l
    ld d, h ;store door id address into de
    ld hl, roomsDoorsTriggerIdsTable ;$5B5B
Label316752
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld a, c
    or a, b
    jp z, Label3167F5 ;infinite loop
    ld a, e
    cp a, c
    jr nz, Label316776 ;skip if address low is not equal
    ld a, d
    cp a, b
    jr nz, Label316776 ;skip if address high is not equal
    ld a, [hl] ;get door id
    ld [wc1ff], a
    ld e, a
    ld d, $00
    ld hl, wDoorTriggers ;$C400
    add hl, de ;add door offset
    ld a, [hl]
    or a
    jr z, checkLockedDoors ;if door state is false, check locked door
    pop hl
    pop de
    pop bc
    ret
Label316776 ;C5:6776
    inc hl
    inc hl
    jr Label316752

checkLockedDoors:
    ld a, [wRoomId]
    or a ;MAIN_HALL_1F
    jp z, checkMainHall1FLockedDoor
    cp a, F_SHAPED_CORRIDOR
    jp z, checkCorridor0CLockedDoors
    cp a, EXHIBITION_ROOM
    jp z, checkMapStatueRoomLockedDoor
    cp a, REST_STOP_CORRIDOR
    jp z, checkCorridor05LockedDoor
    cp a, WEST_STAIRCASE_1F
    jp z, checkCorridor08LockedDoor
    cp a, NORTH_EAST_CORRIDOR_1F
    jp z, checkCorridor0ALockedDoor
    cp a, BACK_ENTRANCE_CORRIDOR
    jp z, checkCorridor0BLockedDoor
    cp a, ELEVATOR_STAIRWAY
    jp z, checkCorridor0FLockedDoor
    cp a, OUTDOOR_AREA
    jp z, checkCorridor12LockedDoor
    cp a, PILLAR_CORRIDOR
    jp z, checkRichardRoomLockedDoor
    cp a, LOUNGE_ROOM
    jp z, checkChimney2FMapRoomLockedDoor
    cp a, EAST_STAIRCASE_2F
    jp z, checkCorridor24LockedDoor
    cp a, U_SHAPED_CORRIDOR
    jp z, checkCorridor27LockedDoor
    cp a, TREVORS_TOMB
    jp z, checkTombRoomLockedDoor
    cp a, ATTIC_ENTRY
    jp z, checkCorridor2DLockedDoor
    cp a, HELIPAD_LOOKOUT_ROOM
    jp z, checkLibraryRoom34LockedDoor
    cp a, WEST_STAIRCASE_2F
    jp z, checkCorridor35LockedDoor
    cp a, AQUA_TANK_ROOM
    jp z, checkAquariumLockedDoor
    cp a, DORMITORY_CORRIDOR
    jp z, checkCorridor4FLockedDoor
    cp a, BEEHIVE_PASSAGE
    jp z, checkGuardhouseBeesRoomLockedDoor
    cp a, LAB_CENTRAL_CLOISTER
    jp z, checkCorridor5ELockedDoor
    cp a, OPERATING_MORGE_ROOM
    jp z, checkOperationRoomLockedDoor
doorKeyNotFound:
    xor a
    pop hl
    pop de
    pop bc
    ret
lockedDoorOpened: ;C5:67EF
    ld a, $FF
    pop hl
    pop de
    pop bc
    ret
;67F5

Label3167F5: ;C5:67F5 infinite loop
    jr Label3167F5

checkMainHall1FLockedDoor:
    ld a, e
    cp a, $02
    jr z, Label3167FF
    jp doorKeyNotFound
Label3167FF
    ld c, ARMOR_KEY ;$02
    call searchKeyInInventory
    or a
    jp z, doorKeyNotFound
    ld [hl], $FF ;open closed door
    jp lockedDoorOpened

checkCorridor0CLockedDoors: ;C5:680D
    ld a, e
    cp a, $06 ;door to first zombie corridor
    jr z, Label316819
    cp a, $07 ;door to zombie closet bedroom
    jr z, Label316823
    jp doorKeyNotFound
Label316819
    ld [hl], $FF
    ld a, $FF
    ld [wCorridor0COneWayDoorOpen], a
    jp lockedDoorOpened
Label316823
    ld a, [wSpriteId]
    cp a, JILL ;$93
    jr z, Label316838 ;jump if jill, because she has lockpick
	;if chris, search sword key
    ld c, SWORD_KEY ;$42
    call searchKeyInInventory
    or a
    jp z, doorKeyNotFound
    ld [hl], $FF
    jp lockedDoorOpened
Label316838
    ld a, [wEventBackToMainHallJill]
    or a
    jp z, doorKeyNotFound ;avoid open sword key doors before get lockpick
    ld [hl], $FF
    jp lockedDoorOpened

checkMapStatueRoomLockedDoor:
    ld a, e
    cp a, $0B ;door to first cerberus corridor
    jr z, Label31684C
    jp doorKeyNotFound
Label31684C
    ld a, [wSpriteId]
    cp a, JILL ;$93
    jr z, Label316861 ;check lockpick
    ld c, SWORD_KEY ;$42
    call searchKeyInInventory
    or a
    jp z, doorKeyNotFound
    ld [hl], $FF
    jp lockedDoorOpened
Label316861
    ld a, [wEventBackToMainHallJill]
    or a
    jp z, doorKeyNotFound ;avoid open sword key doors before get lockpick
    ld [hl], $FF
    jp lockedDoorOpened

checkCorridor05LockedDoor:
    ld a, e
    cp a, $0C ;door to piano room
    jr z, Label316875
    jp doorKeyNotFound
Label316875
    ld a, [wSpriteId]
    cp a, JILL ;$93
    jr z, Label31688A ;check lockpick
    ld c, SWORD_KEY ;$42
    call searchKeyInInventory
    or a
    jp z, doorKeyNotFound
    ld [hl], $FF
    jp lockedDoorOpened
Label31688A
    ld a, [wEventBackToMainHallJill]
    or a
    jp z, doorKeyNotFound ;no lockpick
    ld [hl], $FF
    jp lockedDoorOpened

checkCorridor08LockedDoor:
    ld a, e
    cp a, $0E ;door to broken shotgun room
    jr z, Label31689E
    jp doorKeyNotFound
Label31689E
    ld c, ARMOR_KEY ;$02
    call searchKeyInInventory
    or a
    jp z, doorKeyNotFound
    ld [hl], $FF
    jp lockedDoorOpened

checkCorridor0ALockedDoor:
    ld a, e
    cp a, $11 ;bathroom corridor exterior door
    jr z, Label3168B4
    jp doorKeyNotFound
Label3168B4
    ld c, ARMOR_KEY ;$02
    call searchKeyInInventory
    or a
    jp z, doorKeyNotFound
    ld [hl], $FF
    jp lockedDoorOpened

checkCorridor0BLockedDoor:
    ld a, e
    cp a, $16 ;eagle medal room door
    jr z, Label3168CA
    jp doorKeyNotFound
Label3168CA
    ld c, HELMET_KEY ;$2F
    call searchKeyInInventory
    or a
    jp z, doorKeyNotFound
    ld [hl], $FF
    jp lockedDoorOpened

checkCorridor0FLockedDoor:
    ld a, e
    cp a, $0D ;one way locked door to first zombie corridor
    jr z, Label3168E0
    jp doorKeyNotFound
Label3168E0
    ld [hl], $FF
    jp lockedDoorOpened

checkCorridor12LockedDoor:
    ld a, e
    cp a, $11 ;door to corrdior 0A
    jr z, Label3168ED
    jp doorKeyNotFound
Label3168ED
    ld c, ARMOR_KEY ;$02
    call searchKeyInInventory
    or a
    jp z, doorKeyNotFound
    ld [hl], $FF
    jp lockedDoorOpened

checkRichardRoomLockedDoor:
    ld a, e
    cp a, $28 ;door to corridor 2D
    jr z, Label316903
    jp doorKeyNotFound
Label316903
    ld [hl], $FF
    ld a, $FF
    ld [wc47b], a
    jp lockedDoorOpened

checkChimney2FMapRoomLockedDoor:
    ld a, e
    cp a, $2A ;door to yawn 2 room
    jr z, Label316915
    jp doorKeyNotFound
Label316915
    ld c, HELMET_KEY ;$2F
    call searchKeyInInventory
    or a
    jp z, doorKeyNotFound
    ld [hl], $FF
    ld a, $FF
    ld [wc47b], a
    jp lockedDoorOpened

checkCorridor24LockedDoor:
    ld a, e
    cp a, $33 ;locked door to room 2E
    jr z, Label316934
    cp a, $32 ;one way locked door to corridor 27
    jr z, Label316942
    jp doorKeyNotFound
Label316934
    ld c, ARMOR_KEY ;$02
    call searchKeyInInventory
    or a
    jp z, doorKeyNotFound
    ld [hl], $FF
    jp lockedDoorOpened
Label316942
    ld [hl], $FF
    ld a, $FF
    ld [wCorridor24OneWayLockedDoorOpen], a
    jp lockedDoorOpened

checkCorridor27LockedDoor:
    ld a, e
    cp a, $79 ;door to richard room
    jr z, Label316958
    cp a, $31 ;door to armors room
    jr z, Label316966
    jp doorKeyNotFound
Label316958
    ld c, ARMOR_KEY ;$02
    call searchKeyInInventory
    or a
    jp z, doorKeyNotFound
    ld [hl], $FF
    jp lockedDoorOpened
Label316966
    ld c, ARMOR_KEY ;$02
    call searchKeyInInventory
    or a
    jp z, doorKeyNotFound
    ld [hl], $FF
    jp lockedDoorOpened

checkTombRoomLockedDoor:
    ld a, e
    cp a, $33 ;locked door to room 2E?
    jr z, Label31697C
    jp doorKeyNotFound
Label31697C
    ld c, ARMOR_KEY ;$02
    call searchKeyInInventory
    or a
    jp z, doorKeyNotFound
    ld [hl], $FF
    jp lockedDoorOpened

checkCorridor2DLockedDoor:
    ld a, e
    cp a, $3A ;door to yawn 1 room
    jr z, Label316992
    jp doorKeyNotFound
Label316992
    ld c, SHIELD_KEY ;$44
    call searchKeyInInventory
    or a
    jp z, doorKeyNotFound

Label31699B:
    ld a, $00
    ld [de], a ;set door id to $00
    ld [hl], $FF
    jp lockedDoorOpened

checkLibraryRoom34LockedDoor:
    jp doorKeyNotFound
    ld c, ARMOR_KEY ;$02
    call searchKeyInInventory
    or a
    jp z, doorKeyNotFound
    ld [hl], $FF
    jp lockedDoorOpened

checkCorridor35LockedDoor:
    ld a, e
    cp a, $3B ;door to red jewel room
    jr z, Label3169BC
    jp doorKeyNotFound
Label3169BC
    ld c, HELMET_KEY ;$2F
    call searchKeyInInventory
    or a
    jp z, doorKeyNotFound
    ld [hl], $FF
    jp lockedDoorOpened

checkAquariumLockedDoor:
    ld a, e
    cp a, $59 ;door to aquarium control room
    jr z, Label3169D2
    jp doorKeyNotFound
Label3169D2
    ld c, C_ROOM_KEY ;$01
    call searchKeyInInventory
    or a
    jp z, doorKeyNotFound
    ld c, C_ROOM_KEY ;$01
    call searchAndRemoveItem
    ld [hl], $FF
    jp lockedDoorOpened

checkCorridor4FLockedDoor:
    ld a, e
    cp a, $5C ;door to guardhouse dorm 002
    jr z, Label3169ED
    jp doorKeyNotFound
Label3169ED
    ld a, [wSelectedPlayer]
    or a ;chris
    jr z, Label3169FA
	;if jill
    ld a, [wDorm002EventTrigger]
    or a
    jp z, doorKeyNotFound
Label3169FA
    ld c, DORMITORY_2_KEY ;$3C
    call searchKeyInInventory
    or a
    jp z, doorKeyNotFound
    ld c, DORMITORY_2_KEY ;$3C
    call searchAndRemoveItem
    ld [hl], $FF
    jp lockedDoorOpened

checkGuardhouseBeesRoomLockedDoor:
    ld a, e
    cp a, $5E ;door to dorm 003
    jr z, Label316A15
    jp doorKeyNotFound
Label316A15
    ld c, DORMITORY_3_KEY ;$5B
    call searchKeyInInventory
    or a
    jp z, doorKeyNotFound
    ld c, DORMITORY_3_KEY ;$5B
    call searchAndRemoveItem
    ld [hl], $FF
    jp lockedDoorOpened

checkCorridor5ELockedDoor:
    ld a, e
    cp a, $6B ;door to corridor 65
    jr z, Label316A30
    jp doorKeyNotFound
Label316A30
    ld c, LAB_KEY ;$36
    call searchKeyInInventory
    or a
    jp z, doorKeyNotFound
    ld c, LAB_KEY ;$36
    call searchAndRemoveItem
    ld [hl], $FF
    jp lockedDoorOpened

checkOperationRoomLockedDoor:
    ld a, e
    cp a, $6A ;morgue room locked door
    jr z, Label316A4B
    jp doorKeyNotFound
Label316A4B
    ld [hl], $FF
    jp lockedDoorOpened

searchAndRemoveItem:
;search an item in inventory, if find it, it's removed
;c: item id
    push bc
    push hl
    ld hl, ItemIdSlot1
    ld b, $06 ;chris item slots
    ld a, [wSelectedPlayer]
    or a
    jr z, Loop316A5F
	;if jill set 8 item slots
    ld b, $08
Loop316A5F
    ld a, [hl]
    cp a, c
    jr z, removeFoundItem
    inc hl
    dec b
    jr nz, Loop316A5F
Label316A67
    pop hl
    pop bc
    ret
removeFoundItem: ;C5:6A6A
    ld [hl], EMPTY ;$00
    jr Label316A67

searchKeyInInventory: ;C5:6A6E
;search door key in inventory, return true if is found ($FF), false if not ($00)
;c: key id
    ld de, ItemIdSlot1
    ld b, $08 ;item slots count
Loop316A73
    ld a, [de]
    cp a, c
    jr z, doorKeyFound
    inc de
    dec b
    jr nz, Loop316A73
;door key not found
    xor a
    ret
doorKeyFound: ;C5:6A7D
    ld a, $FF
    ret
;6A80

getItemTriggerVar: ;C5:6A80
    push bc
    push de
    push hl
    ld a, [wItemTriggerId] ;item trigger id
	;check elevattion only pickable items
    cp a, $07
    jr z, Label316AB1
    cp a, $29
    jr z, Label316AA2
    cp a, $55
    jr z, Label316AC0
    cp a, $AD
    jr z, Label316ACE
Label316A96
    ld e, a
    ld d, $00 ;store item trigger id
    ld hl, wRoomItemsTriggers ;$C500
    add hl, de
    ld a, [hl] ;get item trigger var
returnItemTriggerVar:
    pop hl
    pop de
    pop bc
    ret
;6AA2

Label316AA2: ;C5:6AA2
    ld a, [wSpritePositionYLow]
    cp a, $10
    jr nc, Label316AAC
    xor a ;set item trigger var to false
    jr returnItemTriggerVar
Label316AAC
    ld a, [wItemTriggerId]
    jr Label316A96
Label316AB1:
    ld a, [wSpritePositionYLow]
    cp a, $10
    jr nc, Label316ABB
    xor a ;set item trigger var to false
    jr returnItemTriggerVar
Label316ABB
    ld a, [wItemTriggerId]
    jr Label316A96
Label316AC0:
    ld a, [wTaxidermyRoomLight]
    or a
    jr nz, Label316AC9
    xor a ;set item trigger var to false
    jr returnItemTriggerVar
Label316AC9
    ld a, [wItemTriggerId]
    jr Label316A96
Label316ACE:
    ld a, [wFloodedRoomsTrigger]
    or a
    jr nz, Label316AD7
    xor a ;set item trigger var to false
    jr returnItemTriggerVar
Label316AD7
    ld a, [wItemTriggerId]
    jr Label316A96
;6ADC

InitRoomSprites:: ;C5:6ADC
;search throw Room action data for sprites and initialize their data structures
	;reset all NPCs data
    ld hl, wNPCSpritesData
    ld b, $07
.loop316AE1
    ld c, $20 ;NPC data structure length
.loop316AE3
    ld [hl], $00
    inc hl
    dec c
    jr nz, .loop316AE3
    dec b
    jr nz, .loop316AE1
    xor a
    ld [wPoisonGasActivationByte], a ;reset poison gas byte
	;reset (again?) all NPCs data %fix
    ld hl, wNPCSpritesData
    ld b, $07
.loop316AF5
    ld c, $20
.loop316AF7
    ld [hl], $00
    inc hl
    dec c
    jr nz, .loop316AF7
    dec b
    jr nz, .loop316AF5
	;get room actions data
    ld a, [wRoomId]
    ld l, a
    ld a, [wRoomIdHigh]
    ld h, a
    add hl, hl
    ld de, roomsActionsDatatable ;$4000
    add hl, de
    ld a, [hl]
    inc hl
    ld h, [hl]
    ld l, a
Label316B11:
    ld a, [hl]
    cp a, $FF
    jr z, .Label316B30
    cp a, ZOMBIE ;$98
    jp z, Label316B31
    cp a, YAWN ;$A0
    jp z, Label316B31
    cp a, REBECCA ;$95
    jp z, Label316B31
    cp a, OBJECTS ;$E0
    jp nc, Label316BB4
    ld de, $000B ;next room action data
    add hl, de
    jr Label316B11
.Label316B30
    ret

Label316B31: ;C5:6B31
    push hl
    ld c, l ;pass data pointer to bc
    ld b, h
    call GetFirstEmptyNPCDataSlot ;$3EB8
    inc bc
    ld hl, wEnemyAndObjectsVars ;C600
    ld a, [bc]
    add a, l
    ld l, a
    ld a, $00
    adc a, h
    ld h, a
    ld a, [hl]
    or a
    jr nz, .Label316B4D
    pop hl
    ld de, $000B
    add hl, de
    jr Label316B11
.Label316B4D
    dec bc
    ld hl, wCharSpritesData - wCharSpritesData ;$0000
    add hl, de
    ld [hl], %10000000 ;$80 enable sprite
    ld hl, wSpriteId - wCharSpritesData ;$000B
    add hl, de
    ld a, [bc]
    ld [hl], a
    inc bc
    ld hl, wZombieAndObjectVarId - wCharSpritesData ;$000F
    add hl, de
    ld a, [bc]
    ld [hl], a
    inc hl ;wZombieAndObjectVarIdHigh
    inc bc
    ld a, [bc]
    ld [hl], a
    inc hl
    inc bc
    ld hl, wSpritePositionXLow - wCharSpritesData ;$0011
    add hl, de
    ld a, [bc]
    ld [hl], a
    inc hl ;wSpritePositionXHigh
    inc bc
    ld a, [bc]
    ld [hl], a
    inc hl ;wSpritePositionZLow
    inc bc
    ld a, [bc]
    ld [hl], a
    inc hl ;wSpritePositionZHigh
    inc bc
    ld a, [bc]
    ld [hl], a
    inc hl
    inc bc
    ld hl, wFiregunFramesId - wCharSpritesData ;$000C
    add hl, de
    ld [hl], $00
    ld hl, wBloodFramesId - wCharSpritesData ;$000D
    add hl, de
    ld [hl], $00
    ld hl, wSpriteAnimationId - wCharSpritesData ;$0006
    add hl, de
    ld [hl], $00
    ld hl, wSpriteAnimationFrameId - wCharSpritesData ;$0007
    add hl, de
    ld [hl], $00
    ld hl, wSpriteDataC308 - wCharSpritesData ;$0008
    add hl, de
    ld [hl], $00
    ld hl, wSpriteFacing - wCharSpritesData ;$0009
    add hl, de
    ld a, [bc]
    ld [hl], a
    inc bc
    ld hl, wWeaponBlockTimer - wCharSpritesData ;$000A
    add hl, de
    ld [hl], $00
    ld hl, wCharHealth - wCharSpritesData ;$000E
    add hl, de
    ld [hl], 64 ;$40
    pop hl
    ld de, $000B ;structure length
    add hl, de
    jp Label316B11

Label316BB4: ;C5:6BB4
    push hl ;object sprite id
    ld c, l
    ld b, h
    call GetFirstEmptyNPCDataSlot ;$3EB8
    inc bc
    ld hl, wEnemyAndObjectsVars ;C600
    ld a, [bc] ;object var id
    add a, l
    ld l, a
    ld a, $00
    adc a, h
    ld h, a
    ld a, [hl] ;get object var data
    or a
    jr nz, .Label316BD1 ;jump is object var is true
;else, jump to next room action data
    pop hl
    ld de, $000B
    add hl, de
    jp Label316B11
.Label316BD1
    dec bc
    ld hl, wCharSpritesData - wCharSpritesData ;$0000
    add hl, de
    ld [hl], %10000000 ;$80 enable sprite
    ld hl, wSpriteId - wCharSpritesData ;$000B
    add hl, de
    ld a, [bc]
    ld [hl], a
    inc bc
    ld hl, wZombieAndObjectVarId - wCharSpritesData ;$000F
    add hl, de
    ld a, [bc]
    ld [hl], a
    inc hl
    inc bc
    ld a, [bc]
    ld [hl], a
    inc hl
    inc bc
    ld hl, wSpritePositionXLow - wCharSpritesData ;$0011
    add hl, de
    ld a, [bc]
    ld [hl], a
    inc hl ;wSpritePositionXHigh
    inc bc
    ld a, [bc]
    ld [hl], a
    inc hl ;wSpritePositionZLow
    inc bc
    ld a, [bc]
    ld [hl], a
    inc hl ;wSpritePositionZHigh
    inc bc
    ld a, [bc]
    ld [hl], a
    inc hl
    inc bc
    ld hl, wFiregunFramesId - wCharSpritesData ;$000C
    add hl, de
    ld [hl], $00
    ld hl, wBloodFramesId - wCharSpritesData ;$000D
    add hl, de
    ld [hl], $00
    ld hl, wSpriteAnimationId - wCharSpritesData ;$0006
    add hl, de
    ld [hl], $00
    ld hl, wSpriteAnimationFrameId - wCharSpritesData ;$0007
    add hl, de
    ld [hl], $00
    ld hl, wSpriteDataC308 - wCharSpritesData ;$0008
    add hl, de
    ld [hl], $00
    ld hl, wSpriteFacing - wCharSpritesData ;$0009
    add hl, de
    ld a, [bc]
    ld [hl], a
    ld hl, wWeaponBlockTimer - wCharSpritesData ;$000A
    add hl, de
    ld [hl], $00
    ld hl, wCharHealth - wCharSpritesData ;$000E
    add hl, de
    ld [hl], 64 ;$40
    ld hl, wZombieAndObjectVarId - wCharSpritesData ;$000F
    add hl, de
    ld a, [hl]
    cp a, $FE
    jp z, Label316C41
Label316C39:
    pop hl
    ld de, $000B ; structure length
    add hl, de
    jp Label316B11

Label316C41:
    ld a, [wc4d5]
    or a
    jp z, Label316C39
    ld hl, wSpritePositionZLow - wCharSpritesData ;$0013
    add hl, de
    push bc
    ld bc, $FFC0 ;sprite position
    ld [hl], c
    inc hl
    ld [hl], b
    pop bc
    jp Label316C39

DivideBy8BankC5:: ;C5;6C57
    ld a, d
    cp a, $80
    jr c, .Label316C6F
    call ReverseWordSignC5
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    call ReverseWordSignC5
    ret
.Label316C6F
	srl d
    rr e
    srl d
    rr e
    srl d
    rr e
	ret

ReverseWordSignC5:: ;C5:6C7C
	ld a, $00
	sub e
	ld e, a
	ld a, $00
	sbc d
	ld d, a
	ret

;C5:6C85 rest of bank is empty

SECTION "bank_C6",ROMX,BANK[$C6]

checkRoomsCameraChange: ;C6:4000
;Eval player position and change room camera angle (screenId)
;and check if there is a camera change event trigger.
;Return true ($FF) if change screen, false ($00) if not
    ld a, [wSpritePositionXLow]
    ld e, a
    ld a, [wSpritePositionXHigh]
    ld d, a
    call div8SignedWordC6
    ld l, e
    ld h, d ; pos X into hl
    ld a, [wSpritePositionZLow]
    ld e, a
    ld a, [wSpritePositionZHigh]
    ld d, a ; pos Y into de
    call div8SignedWordC6
    ld c, $00
    ld a, [wRoomId]
    or a ;MAIN_HALL_1F
    jp z, checkMainMall1FCameraChange
    cp a, DINNING_ROOM_1F
    jp z, checkDinningRoom1FCameraChange
    cp a, WEST_STOREROOM
    jp z, checkSafeRoomCameraChange
    cp a, F_SHAPED_CORRIDOR
    jp z, checkCorridor03CameraChange
    cp a, EXHIBITION_ROOM
    jp z, checkMapStatueRoomCameraChange
    cp a, REST_STOP_CORRIDOR
    jp z, checkCorridor05CameraChange
    cp a, GREENHOUSE
    jp z, checkMansionPlantRoomCameraChange
    cp a, PIANO_ROOM
    jp z, checkPianoRoomCameraChange
    cp a, WEST_STAIRCASE_1F
    jp z, checkCorridor08CameraChange
    cp a, FIREARMS_ROOM
    jp z, checkBrokenShotgunRoomCameraChange
    cp a, NORTH_EAST_CORRIDOR_1F
    jp z, checkCorridor0ACameraChange
    cp a, BACK_ENTRANCE_CORRIDOR
    jp z, checkCorridor0BCameraChange
    cp a, L_SHAPED_CORRIDOR
    jp z, checkCorridor0CCameraChange
    cp a, EAST_STAIRS_CORRIDOR_1F
    jp z, checkCorridor0DCameraChange
    cp a, KEEPERS_ROOM
    jp z, checkZombieClosetBedroomCameraChange
    cp a, ELEVATOR_STAIRWAY
    jp z, checkCorridor0FCameraChange
    cp a, LARGE_ART_ROOM
    jp z, checkRoom10CameraChange
    cp a, MANSION_BATHROOM
    jp z, checkBathroomCameraChange
    cp a, OUTDOOR_AREA
    jp z, checkCorridor12CameraChange
    cp a, SHED_PASSAGE
    jp z, checkCrestPanelCorridorCameraChange
    cp a, CLOSET_ROOM
    jp z, checkClosetRoomCameraChange
    cp a, SHED_ROOM
    jp z, checkSquareCrankRoomCameraChange
    cp a, MIRROR_ROOM
    jp z, checkBigMirrorRoomCameraChange
    cp a, LIVING_ROOM
    jp z, checkShotgunRoomCameraChange
    cp a, FALLING_CIELING_ROOM
    jp z, checkFallingCielingRoomCameraChange
    cp a, UNDERGROUND_PASSAGE_1
    jp z, checkCorridor1ACameraChange
    cp a, UNDERGROUND_PASSAGE_2
    jp z, checkCorridor1BCameraChange
    cp a, DINNING_ROOM_2F
    jp z, checkDinningRoom2FCameraChange
    cp a, MAIN_HALL_2F
    jp z, checkMainHall2FCameraChange
    cp a, PILLAR_CORRIDOR
    jp z, checkRichardRoomCameraChange
    cp a, LOUNGE_ROOM
    jp z, checkChimney2FMapRoomCameraChange
    cp a, ELEVATOR_ROOM_2F
    jp z, checkCorridor20CameraChange
    cp a, HALLWAY_TO_EAST_TERRACE
    jp z, checkCorridor21CameraChange
    cp a, SMALL_DINNING_ROOM
    jp z, checkCandleRoomCameraChange
    cp a, ARMORS_ROOM
    jp z, checkArmorsRoomCameraChange
    cp a, EAST_STAIRCASE_2F
    jp z, checkCorridor24CameraChange
    cp a, WESTERN_CORRIDOR_2F
    jp z, checkCorridor25CameraChange
    cp a, MANSION_BEDROOM
    jp z, checkLighterBedroomCameraChange
    cp a, U_SHAPED_CORRIDOR
    jp z, checkCorridor27CameraChange
    cp a, SMALL_LIBRARY
    jp z, checkRoom28CameraChange
    cp a, RESEARCHERS_PRIVATE_ROOM
    jp z, checkInsectsRoomCameraChange
    cp a, TREVORS_TOMB
    jp z, checkTombRoomCameraChange
    cp a, LESSONS_ROOM
    jp z, checkYawn2RoomCameraChange
    cp a, ATTIC
    jp z, checkYawn1RoomCameraChange
    cp a, ATTIC_ENTRY
    jp z, checkCorridor2DCameraChange
    cp a, DEER_ROOM
    jp z, checkRoom2ECameraChange
    cp a, EAST_TERRACE
    jp z, checkForestCorpseRoomCameraChange
    cp a, TAXIDERMY_ROOM
    jp z, checkRedJewelRoomCameraChange
    cp a, LIBRARY
    jp z, checkLibraryCameraChange
    cp a, HIDDEN_LIBRARY
    jp z, checkLibraryMoDiskRoomCameraChange
    cp a, MATERIALS_ROOM
    jp z, checkRoom33CameraChange
    cp a, HELIPAD_LOOKOUT_ROOM
    jp z, checkLibraryRoom34CameraChange
    cp a, WEST_STAIRCASE_2F
    jp z, checkCorridor35CameraChange
    cp a, COURTYARD_GARDEN
    jp z, checkCourtyard1FCameraChange
    cp a, COURTYARD_FLOODGATE
    jp z, checkCourtyardPoolCameraChange
    cp a, WATERFALL_GARDEN
    jp z, checkCourtyard2FCameraChange
    cp a, HELIPORT
    jp z, checkHeliportCameraChange
    cp a, WAY_TO_GUARDHOUSE
    jp z, checkCorridor3ACameraChange
    cp a, UNDGRND_STATUE_ROOM
    jp z, checkEagleMedalRoomCameraChange
    cp a, UNDGRND_SOUTH_PASSAGE
    jp z, checkEnricosRoomCameraChange
    cp a, BOULDER_ROOM_1
    jp z, checkBoulderRoom1CameraChange
    cp a, BOULDER_ROOM_2
    jp z, checkBoulderRoom2CameraChange
    cp a, UNDERGROUND_ENTRY
    jp z, checkCorridor3FCameraChange
    cp a, UNDGRND_BREAK_ROOM
    jp z, checkCatacombSafeRoomCameraChange
    cp a, FOUNTAIN
    jp z, checkFountainCameraChange
    cp a, FOUNTAIN_ELEVATOR
    jp z, checkFountainElevatorCameraChange
    cp a, UNDGRND_BRANCHED_PASSAGE
    jp z, checkCorridor43CameraChange
    cp a, UNDGRND_GENERATOR_ROOM
    jp z, checkCatacombPowerRoomCameraChange
    cp a, UNDERGROUND_WAREHOUSE
    jp z, checkBlackTigerRoomCameraChange
    cp a, WAY_TO_BREAK_ROOM
    jp z, checkCorridor46CameraChange
    cp a, GUARDHOUSE_ENTRANCE
    jp z, checkGuardhouseEntranceCameraChange
    cp a, GUARDHOUSE_DORM_001
    jp z, checkGuardhouseDorm1CameraChange
    cp a, DORM_001_BATHROOM
    jp z, checkDorm1BathroomCameraChange
    cp a, GUARDHOUSE_BREAK_ROOM
    jp z, checkGuardhouseSafeRoomCameraChange
    cp a, AQUA_TANK_ROOM
    jp z, checkAquariumCameraChange
    cp a, AQUA_TANK_ENTRANCE
    jp z, checkCorridor4CCameraChange
    cp a, AQUA_TANK_CONTROL_ROOM
    jp z, checkAquariumControlRoomCameraChange
    cp a, GUARDHOUSE_BAR
    jp z, checkGuardhouseBarCameraChange
    cp a, DORMITORY_CORRIDOR
    jp z, checkCorridor4FCameraChange
    cp a, GUARDHOUSE_DORM_002
    jp z, checkGuardhouseDorm2CameraChange
    cp a, DORM_002_BATHROOM
    jp z, checkDorm2BathroomCameraChange
    cp a, BEEHIVE_PASSAGE
    jp z, checkGuardhouseBeesRoomCameraChange
    cp a, CHEMISTRY_ROOM
    jp z, checkChemicalsRoomCameraChange
    cp a, GUARDHOUSE_DORM_003
    jp z, checkGuardhouseDorm3CameraChange
    cp a, DORM_003_BATHROOM
    jp z, checkDorm3BathroomCameraChange
    cp a, PLANT_42_ROOM
    jp z, checkPlant42RoomCameraChange
    cp a, AQUA_TANK_STOREROOM
    jp z, checkAquariumRoom57CameraChange
    cp a, PLANT_42_ROOTS_ROOM
    jp z, checkPlant42RootsRoomCameraChange
    cp a, EMERGENCY_TUNNEL
    jp z, checkCorridor59CameraChange
    cp a, LAB_ENTRANCE
    jp z, checkLabEntranceCameraChange
    cp a, LAB_LADDER_ROOM
    jp z, checkLabItemboxRoomCameraChange
    cp a, LAB_B2F_STAIR_HALL
    jp z, checkCorridor5CCameraChange
    cp a, VISUAL_DATA_ROOM
    jp z, checkLabProjectorRoomCameraChange
    cp a, LAB_CENTRAL_CLOISTER
    jp z, checkCorridor5ECameraChange
    cp a, SMALL_LAB
    jp z, checkLabComputerRoomCameraChange
    cp a, OPERATING_MORGE_ROOM
    jp z, checkSurgeryMorgueRoomCameraChange
    cp a, LAB_B3F_WEST_CORRIDOR
    jp z, checkCorridor61CameraChange
    cp a, LAB_RESEARCHER_ROOM
    jp z, checkMoDiskReaderRoomCameraChange
    cp a, XRAY_ROOM
    jp z, checkLabPaintingRoomCameraChange
    cp a, DETENTION_ROOM_PASSAGE
    jp z, checkCorridor64CameraChange
    cp a, LAB_ELEVATOR_ENTRY
    jp z, checkCorridor65CameraChange
    cp a, LAB_B3F_LOUNGE
    jp z, checkLabSafeRoomCameraChange
    cp a, POWER_ROOM_PASSAGE_1
    jp z, checkQuimerasRoom1CameraChange
    cp a, POWER_ROOM_PASSAGE_2
    jp z, checkQuimerasRoom2CameraChange
    cp a, LAB_POWER_ROOM
    jp z, checkLabPowerRoomCameraChange
    cp a, MAIN_LAB_ENTRY
    jp z, checkCorridor6CCameraChange
    cp a, DETENTION_ROOM
    jp z, checkLabPrisonCameraChange
    cp a, MAIN_LABORATORY
    jp z, checkTyrantRoomCameraChange
    cp a, LARGE_GALLERY
    jp z, checkPaintingsRoomCameraChange
    cp a, EAST_STOREROOM
    jp z, checkHerbicideSafeRoomCameraChange
    cp a, COURTYARD_STUDY
    jp z, checkWolfMedalRoomCameraChange
    cp a, MANSION_KITCHEN
    jp z, checkMansionKitchenCameraChange
	;set default screen
    ld c, $00
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label31825B
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
Label31825B: ;C6:425B
    xor a
    ret
;425D

checkCorridor59CameraChange: ;C6:425D
    ld c, $00
    ld a, h
    or a
    jr nz, Label318268
    ld a, l
    cp a, $50
    jr nc, Label31826A
Label318268
    ld c, $01
Label31826A
    ld a, d
    or a
    jr nz, Label318273
    ld a, e
    cp a, $5F
    jr nc, Label318275
Label318273
    ld c, $02
Label318275
    ld a, d
    cp a, $FF
    jr nz, Label318281
    ld a, e
    cp a, $F2
    jr nc, Label318281
    ld c, $03
Label318281
    ld a, h
    cp a, $FF
    jr nz, Label31828D
    ld a, l
    cp a, $CA
    jr nc, Label31828D
    ld c, $04
Label31828D
    ld a, d
    cp a, $FF
    jr nz, Label318299
    ld a, e
    cp a, $A2
    jr nc, Label318299
    ld c, $05
Label318299
    ld a, h
    cp a, $FF
    jr nz, Label3182A5
    ld a, l
    cp a, $9A
    jr nc, Label3182A5
    ld c, $06
Label3182A5
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label31830D
    ld a, c
    ld [wRoomScreen], a
    ld a, [wSelectedPlayer]
    or a
    jr nz, Label3182ED
    ld a, [wc4c5]
    or a
    jr z, Label31830A
    ld a, [wc4c6]
    or a
    jr nz, Label3182D4
    ld a, [wRoomScreen]
    cp a, $02
    jr nz, Label31830A
    ld a, $1A
    ld [wEventId], a
    ld a, $FF
    ld [wc4c6], a
    jr Label31830A
Label3182D4
    ld a, [wc4c7]
    or a
    jr nz, Label31830A
    ld a, [wRoomScreen]
    cp a, $05
    jr nz, Label31830A
    ld a, $1B
    ld [wEventId], a
    ld a, $FF
    ld [wc4c7], a
    jr Label31830A
Label3182ED
    ld a, [wc4c5]
    or a
    jr z, Label31830A
    ld a, [wc4c6]
    or a
    jr nz, Label31830A
    ld a, [wRoomScreen]
    cp a, $02
    jr nz, Label31830A
    ld a, $22
    ld [wEventId], a
    ld a, $FF
    ld [wc4c6], a
Label31830A
    ld a, $FF
    ret
Label31830D: ;C6:430D
    xor a
    ret
;430F

checkLabEntranceCameraChange: ;C6:430F
    ld c, $02
    ld a, h
    cp a, $FF
    jr nz, Label31831B
    ld a, l
    cp a, $EF
    jr c, Label31831D
Label31831B
    ld c, $01
Label31831D
    ld a, d
    or a
    jr nz, Label318328
    ld a, e
    cp a, $36
    jr c, Label318328
    ld c, $00
Label318328
    ld a, h
    cp a, $FF
    jr nz, Label31833D
    ld a, l
    cp a, $E4
    jr nc, Label31833D
    ld a, d
    or a
    jr nz, Label31833D
    ld a, e
    cp a, $15
    jr c, Label31833D
    ld c, $03
Label31833D
    xor a
    ld [wLaboratoryEntranceOpened], a
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label31834E
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;434E

Label31834E: ;C6:434E
    xor a
    ret
;4350

checkLabItemboxRoomCameraChange: ;C6:4350
    ld c, $00
    ld a, d
    or a
    jr z, Label318358
    ld c, $01
Label318358
    ld a, d
    or a
    jr nz, Label31836D
    ld a, e
    cp a, $19
    jr c, Label31836D
    ld a, h
    cp a, $FF
    jr nz, Label31836B
    ld a, l
    cp a, $F5
    jr c, Label31836D
Label31836B
    ld c, $02
Label31836D
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label3183BC
    ld a, c
    ld [wRoomScreen], a
    ld a, [wSelectedPlayer]
    or a
    jr nz, Label31839C
    ld a, [wRoomScreen]
    cp a, $01
    jr nz, Label3183B9
    ld a, [wc4c4]
    or a
    jr z, Label3183B9
    ld a, [wc4c5]
    or a
    jr nz, Label3183B9
    ld a, $19
    ld [wEventId], a
    ld a, $FF
    ld [wc4c5], a
    jr Label3183B9
Label31839C
    ld a, [wRoomScreen]
    cp a, $01
    jr nz, Label3183B9
    ld a, [wc4c4]
    or a
    jr z, Label3183B9
    ld a, [wc4c5]
    or a
    jr nz, Label3183B9
    ld a, $20
    ld [wEventId], a
    ld a, $FF
    ld [wc4c5], a
Label3183B9
    ld a, $FF
    ret
;43BC

Label3183BC: ;C6:43BC
    xor a
    ret
;43BE

checkCorridor5CCameraChange: ;C6:43BE
    ld c, $00
    ld a, h
    or a
    jr nz, Label3183C9
    ld a, l
    cp a, $22
    jr nc, Label3183CB
Label3183C9
    ld c, $01
Label3183CB
    ld a, d
    or a
    jr nz, Label3183D4
    ld a, e
    cp a, $12
    jr nc, Label3183D6
Label3183D4
    ld c, $02
Label3183D6
    ld a, h
    cp a, $FF
    jr nz, Label3183E2
    ld a, l
    cp a, $D9
    jr nc, Label3183E2
    ld c, $03
Label3183E2
    ld a, h
    cp a, $FF
    jr nz, Label3183EE
    ld a, l
    cp a, $90
    jr nc, Label3183EE
    ld c, $05
Label3183EE
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label3183FB
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;43FB

Label3183FB: ;C6:43FB
    xor a
    ret
;43FD

checkLabProjectorRoomCameraChange: ;C6:43FD
    ld c, $00
    ld a, d
    or a
    jr z, Label318405
    ld c, $01
Label318405
    ld a, h
    or a
    jr nz, Label318421
    ld a, l
    cp a, $15
    jr c, Label318421
    ld a, d
    cp a, $FF
    jr nz, Label31841A
    ld a, e
    cp a, $D9
    jr c, Label318421
    jr Label31841F
Label31841A
    ld a, e
    cp a, $28
    jr nc, Label318421
Label31841F
    ld c, $02
Label318421
    ld a, h
    cp a, $FF
    jr nz, Label318437
    ld a, l
    cp a, $EC
    jr nc, Label318437
    ld a, d
    cp a, $FF
    jr nz, Label318437
    ld a, e
    cp a, $DC
    jr nc, Label318437
    ld c, $03
Label318437
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label318444
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;4444

Label318444: ;C6:4444
    xor a
    ret
;4446

checkCorridor5ECameraChange: ;C6:4446
    ld c, $00
    ld a, d
    or a
    jr nz, Label318452
    ld a, e
    or a
    jr z, Label318452
    ld c, $01
Label318452
    ld a, h
    cp a, $FF
    jr nz, Label31845C
    ld a, l
    cp a, $B2
    jr c, Label31845E
Label31845C
    ld c, $02
Label31845E
    ld a, h
    cp a, $FF
    jr nz, Label318468
    ld a, l
    cp a, $DE
    jr c, Label31846A
Label318468
    ld c, $03
Label31846A
    ld a, h
    or a
    jr nz, Label318475
    ld a, l
    cp a, $16
    jr c, Label318475
    ld c, $04
Label318475
    ld a, h
    or a
    jr nz, Label318489
    ld a, l
    cp a, $5F
    jr c, Label318489
    ld a, d
    or a
    jr nz, Label318487
    ld a, e
    cp a, $5A
    jr nc, Label318489
Label318487
    ld c, $05
Label318489
    ld a, h
    or a
    jr nz, Label31849E
    ld a, l
    cp a, $5F
    jr c, Label31849E
    ld a, d
    cp a, $FF
    jr nz, Label31849E
    ld a, e
    cp a, $D5
    jr nc, Label31849E
    ld c, $06
Label31849E
    ld a, d
    cp a, $FF
    jr nz, Label3184BB
    ld a, e
    cp a, $BA
    jr nc, Label3184BB
    ld a, h
    cp a, $FF
    jr nz, Label3184B4
    ld a, l
    cp a, $B2
    jr c, Label3184BB
    jr Label3184B9
Label3184B4
    ld a, l
    cp a, $5F
    jr nc, Label3184BB
Label3184B9
    ld c, $07
Label3184BB
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label3184EB
    ld a, c
    ld [wRoomScreen], a
    ld a, [wSelectedPlayer]
    or a
    jr nz, Label3184E8
    ld a, [wTyrant1Defeated]
    or a
    jr z, Label3184E8
    ld a, [wc4bd]
    or a
    jr nz, Label3184E8
    ld a, [wRoomScreen]
    cp a, $04
    jr nz, Label3184E8
    ld a, $16
    ld [wEventId], a
    ld a, $FF
    ld [wc4bd], a
Label3184E8
    ld a, $FF
    ret
;44EB

Label3184EB: ;C6:44EB
    xor a
    ret
;44ED

checkLabComputerRoomCameraChange: ;C6:44ED
    ld c, $00
    ld a, h
    cp a, $FF
    jr nz, Label3184F6
    ld c, $01
Label3184F6
    ld a, h
    cp a, $FF
    jr nz, Label318502
    ld a, l
    cp a, $DC
    jr nc, Label318502
    ld c, $02
Label318502
    ld a, h
    or a
    jr nz, Label318516
    ld a, l
    cp a, $31
    jr c, Label318516
    ld a, d
    or a
    jr nz, Label318514
    ld a, e
    cp a, $08
    jr nc, Label318516
Label318514
    ld c, $03
Label318516
    xor a
    ld [wc46d], a
    ld a, [wRoomScreen]
    cp a, $05
    jr nz, Label318533
    ld a, [wSpritePositionYLow]
    cp a, $20
    jr c, Label318533
    ld a, [wPoisonGasActivationByte]
    or a
    jr nz, Label318533
    ld a, $FF
    ld [wc46d], a
Label318533
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label318540
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;4540

Label318540: ;C6:4540
    xor a
    ret
;4542

checkSurgeryMorgueRoomCameraChange: ;C6:4542
    ld c, $03
    ld a, h
    cp a, $FF
    jr nz, Label31854E
    ld a, l
    cp a, $9D
    jr c, Label318550
Label31854E
    ld c, $01
Label318550
    ld a, h
    cp a, $FF
    jr nz, Label31855A
    ld a, l
    cp a, $BC
    jr c, Label31855C
Label31855A
    ld c, $00
Label31855C
    ld a, d
    cp a, $FF
    jr nz, Label318566
    ld a, e
    cp a, $FD
    jr c, Label318568
Label318566
    ld c, $02
Label318568
    ld a, h
    or a
    jr nz, Label31857F
    ld a, l
    cp a, $05
    jr c, Label31857F
    ld c, $04
    ld a, d
    cp a, $FF
    jr nz, Label31857F
    ld a, e
    cp a, $FE
    jr nc, Label31857F
    ld c, $05
Label31857F
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label31858C
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;458C

Label31858C: ;C6:458C
    xor a
    ret
;458E

checkCorridor61CameraChange: ;C6:458E
    ld c, $00
    ld a, h
    cp a, $FF
    jr nz, Label31859A
    ld a, l
    cp a, $C9
    jr c, Label31859C
Label31859A
    ld c, $01
Label31859C
    ld a, h
    cp a, $FF
    jr nz, Label3185A6
    ld a, l
    cp a, $FB
    jr c, Label3185A8
Label3185A6
    ld c, $02
Label3185A8
    ld a, h
    or a
    jr nz, Label3185B3
    ld a, l
    cp a, $3F
    jr c, Label3185B3
    ld c, $03
Label3185B3
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label318603
    ld a, c
    ld [wRoomScreen], a
    ld a, [wSelectedPlayer]
    or a
    jp nz, Label3185E3
    ld a, [wc4be]
    or a
    jr z, Label318600
    ld a, [wc4c4]
    or a
    jr nz, Label318600
    ld a, [wRoomScreen]
    cp a, $03
    jr nz, Label318600
    ld a, $18
    ld [wEventId], a
    ld a, $FF
    ld [wc4c4], a
    jr Label318600
Label3185E3
    ld a, [wc4be]
    or a
    jr z, Label318600
    ld a, [wc4c4]
    or a
    jr nz, Label318600
    ld a, [wRoomScreen]
    cp a, $03
    jr nz, Label318600
    ld a, $1F
    ld [wEventId], a
    ld a, $FF
    ld [wc4c4], a
Label318600
    ld a, $FF
    ret
;4603

Label318603: ;C6:4603
    xor a
    ret
;4605

checkMoDiskReaderRoomCameraChange: ;C6:4605
    ld c, $00
    ld a, d
    cp a, $FF
    jr nz, Label318613
    ld a, e
    cp a, $F6
    jr nc, Label318613
    ld c, $01
Label318613
    ld a, h
    cp a, $FF
    jr nz, Label31861D
    ld a, l
    cp a, $F7
    jr c, Label31862B
Label31861D
    ld c, $02
    ld a, d
    cp a, $FF
    jr nz, Label31862B
    ld a, e
    cp a, $F6
    jr nc, Label31862B
    ld c, $03
Label31862B
    ld a, d
    or a
    jr nz, Label31863F
    ld a, e
    cp a, $0D
    jr c, Label31863F
    ld a, h
    or a
    jr nz, Label31863F
    ld a, l
    cp a, $1B
    jr c, Label31863F
    ld c, $04
Label31863F
    ld a, d
    cp a, $FF
    jr nz, Label318659
    ld a, e
    cp a, $F4
    jr nc, Label318659
    cp a, $D9
    jr c, Label318659
    ld a, h
    cp a, $FF
    jr nz, Label318659
    ld a, l
    cp a, $D3
    jr nc, Label318659
    ld c, $05
Label318659
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label318666
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;4666

Label318666: ;C6:4666
    xor a
    ret
;4668

checkLabPaintingRoomCameraChange: ;C6:4668
    ld c, $02
    ld a, d
    or a
    jr nz, Label31867B
    ld a, e
    or a
    jr z, Label31867B
    ld c, $00
    ld a, h
    cp a, $FF
    jr nz, Label31867B
    ld c, $01
Label31867B
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label318688
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;4688

Label318688: ;C6:4688
    xor a
    ret
;468A

checkCorridor64CameraChange: ;C6:468A
    ld c, $00
    ld a, d
    or a
    jr nz, Label318695
    ld a, e
    cp a, $34
    jr nc, Label318697
Label318695
    ld c, $01
Label318697
    ld a, h
    cp a, $FF
    jr nz, Label3186A1
    ld a, l
    cp a, $E6
    jr c, Label3186A3
Label3186A1
    ld c, $02
Label3186A3
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label3186EE
    ld a, c
    ld [wRoomScreen], a
    ld a, [wc4a0]
    or a
    jr z, Label3186EB
    ld a, [wSelectedPlayer]
    or a
    jr nz, Label3186D2
    ld a, [wc4b8]
    or a
    jr nz, Label3186EB
    ld a, [wRoomScreen]
    cp a, $02
    jr nz, Label3186EB
    ld a, $11
    ld [wEventId], a
    ld a, $FF
    ld [wc4b8], a
    jr Label3186EB
Label3186D2
    ld a, [wc4b8]
    or a
    jr nz, Label3186EB
    ld a, [wRoomScreen]
    cp a, $02
    jr nz, Label3186EB
    ld a, $18
    ld [wEventId], a
    ld a, $FF
    ld [wc4b8], a
    jr Label3186EB
Label3186EB
    ld a, $FF
    ret
;46EE

Label3186EE: ;C6:46EE
    xor a
    ret
;46F0

checkCorridor65CameraChange: ;C6:46F0
    ld c, $00
    ld a, d
    cp a, $FF
    jr nz, Label3186FC
    ld a, e
    cp a, $A9
    jr c, Label3186FE
Label3186FC
    ld c, $01
Label3186FE
    ld a, d
    cp a, $FF
    jr nz, Label318708
    ld a, e
    cp a, $E5
    jr c, Label31872D
Label318708
    ld c, $05
    ld a, h
    cp a, $FF
    jr nz, Label318714
    ld a, l
    cp a, $91
    jr c, Label318716
Label318714
    ld c, $04
Label318716
    ld a, h
    cp a, $FF
    jr nz, Label318720
    ld a, l
    cp a, $DF
    jr c, Label318722
Label318720
    ld c, $02
Label318722
    ld a, d
    or a
    jr nz, Label31872D
    ld a, e
    cp a, $07
    jr c, Label31872D
    ld c, $03
Label31872D
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label318792
    ld a, c
    ld [wRoomScreen], a
    ld a, [wc4a0]
    or a
    jr z, Label31878F
    ld a, [wSelectedPlayer]
    or a
    jr nz, Label31876A
    ld a, [wTyrant1Defeated]
    or a
    jr nz, Label318768
    ld a, [wLabElevatorLock]
    or a
    jr z, Label31878F
    ld a, [wc4b9]
    or a
    jr nz, Label31878F
    ld a, [wRoomScreen]
    cp a, $03
    jr nz, Label31878F
    ld a, $12
    ld [wEventId], a
    ld a, $FF
    ld [wc4b9], a
    jr Label31878F
Label318768
    jr Label31878F
Label31876A
    ld a, [wTyrant1Defeated]
    or a
    jr nz, Label31878F
    ld a, [wLabElevatorLock]
    or a
    jr z, Label31878F
    ld a, [wc4b9]
    or a
    jr nz, Label31878F
    ld a, [wRoomScreen]
    cp a, $03
    jr nz, Label31878F
    ld a, $19
    ld [wEventId], a
    ld a, $FF
    ld [wc4b9], a
    jr Label31878F
Label31878F
    ld a, $FF
    ret
;4792

Label318792: ;C6:4792
    xor a
    ret
;4794

checkLabSafeRoomCameraChange: ;C6:4794
    ld c, $01
    ld a, d
    cp a, $FF
    jr nz, Label3187A2
    ld a, e
    cp a, $FA
    jr nc, Label3187A2
    ld c, $00
Label3187A2
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label3187AF
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;47AF

Label3187AF: ;C6:47AF
    xor a
    ret
;47B1

checkQuimerasRoom1CameraChange: ;C6:47B1
    ld c, $00
    ld a, h
    or a
    jr nz, Label3187BE
    ld a, l
    cp a, $17
    jr c, Label3187BE
    ld c, $03
Label3187BE
    ld a, h
    cp a, $FF
    jr nz, Label3187D4
    ld a, l
    cp a, $CE
    jr nc, Label3187D4
    ld a, d
    cp a, $FF
    jr nz, Label3187D2
    ld a, e
    cp a, $BE
    jr c, Label3187D4
Label3187D2
    ld c, $01
Label3187D4
    ld a, h
    cp a, $FF
    jr nz, Label3187EA
    ld a, l
    cp a, $B3
    jr nc, Label3187EA
    ld a, d
    cp a, $FF
    jr nz, Label3187E8
    ld a, e
    cp a, $AA
    jr c, Label3187EA
Label3187E8
    ld c, $02
Label3187EA
    ld a, h
    or a
    jr nz, Label3187FF
    ld a, l
    cp a, $17
    jr c, Label3187FF
    ld a, d
    cp a, $FF
    jr nz, Label3187FD
    ld a, e
    cp a, $BE
    jr c, Label3187FF
Label3187FD
    ld c, $04
Label3187FF
    ld a, h
    or a
    jr nz, Label318813
    ld a, l
    cp a, $17
    jr c, Label318813
    ld a, d
    or a
    jr nz, Label318813
    ld a, e
    cp a, $1D
    jr c, Label318813
    ld c, $05
Label318813
    ld a, h
    or a
    jr nz, Label318828
    ld a, l
    cp a, $56
    jr c, Label318828
    ld a, d
    cp a, $FF
    jr nz, Label318826
    ld a, e
    cp a, $BE
    jr c, Label318828
Label318826
    ld c, $06
Label318828
    ld a, h
    or a
    jr nz, Label31883C
    ld a, l
    cp a, $32
    jr c, Label31883C
    ld a, d
    or a
    jr nz, Label31883C
    ld a, e
    cp a, $27
    jr c, Label31883C
    ld c, $07
Label31883C
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label318849
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;4849

Label318849: ;C6:4849
    xor a
    ret
;484B

checkQuimerasRoom2CameraChange: ;C6:484B
    ld c, $00
    ld a, d
    or a
    jr nz, Label318858
    ld a, e
    cp a, $29
    jr c, Label318858
    ld c, $01
Label318858
    ld a, d
    or a
    jr nz, Label318863
    ld a, e
    cp a, $49
    jr c, Label318863
    ld c, $02
Label318863
    ld a, h
    or a
    jr nz, Label31886C
    ld a, l
    cp a, $67
    jr nc, Label318877
Label31886C
    ld a, d
    or a
    jr nz, Label318875
    ld a, e
    cp a, $1E
    jr nc, Label318877
Label318875
    ld c, $03
Label318877
    ld a, h
    cp a, $FF
    jr nz, Label318883
    ld a, l
    cp a, $DA
    jr nc, Label318883
    ld c, $04
Label318883
    ld a, d
    or a
    jr nz, Label318897
    ld a, e
    cp a, $2E
    jr c, Label318897
    ld a, h
    or a
    jr nz, Label318895
    ld a, l
    cp a, $3C
    jr nc, Label318897
Label318895
    ld c, $06
Label318897
    ld a, d
    or a
    jr nz, Label3188A7
    ld a, e
    cp a, $2E
    jr c, Label3188A7
    ld a, h
    cp a, $FF
    jr nz, Label3188A7
    ld c, $05
Label3188A7
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label3188B4
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;48B4

Label3188B4: ;C6:48B4
    xor a
    ret
;48B6

checkLabPowerRoomCameraChange: ;C6:48B6
    ld c, $05
    ld a, h
    or a
    jr nz, Label3188C1
    ld a, l
    cp a, $4C
    jr nc, Label3188C3
Label3188C1
    ld c, $00
Label3188C3
    ld a, h
    cp a, $FF
    jr nz, Label3188D9
    ld a, l
    cp a, $BD
    jr nc, Label3188D9
    ld a, d
    cp a, $FF
    jr nz, Label3188D7
    ld a, e
    cp a, $EA
    jr c, Label3188D9
Label3188D7
    ld c, $01
Label3188D9
    ld a, d
    or a
    jr nz, Label3188EE
    ld a, e
    cp a, $21
    jr c, Label3188EE
    ld a, h
    cp a, $FF
    jr nz, Label3188EC
    ld a, l
    cp a, $A8
    jr c, Label3188EE
Label3188EC
    ld c, $02
Label3188EE
    ld a, d
    or a
    jr nz, Label318903
    ld a, e
    cp a, $21
    jr c, Label318903
    ld a, h
    cp a, $FF
    jr nz, Label318901
    ld a, l
    cp a, $D9
    jr c, Label318903
Label318901
    ld c, $03
Label318903
    ld a, d
    cp a, $FF
    jr nz, Label31890D
    ld a, e
    cp a, $F8
    jr c, Label318918
Label31890D
    ld a, h
    or a
    jr nz, Label318918
    ld a, l
    cp a, $55
    jr c, Label318918
    ld c, $04
Label318918
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label318925
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;4925

Label318925: ;C6:4925
    xor a
    ret
;4927

checkCorridor6CCameraChange: ;C6:4927
    ld c, $00
    ld a, h
    or a
    jr nz, Label318932
    ld a, l
    cp a, $03
    jr nc, Label318934
Label318932
    ld c, $01
Label318934
    ld a, d
    cp a, $FF
    jr nz, Label31893E
    ld a, e
    cp a, $FB
    jr c, Label318940
Label31893E
    ld c, $02
Label318940
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label318993
    ld a, c
    ld [wRoomScreen], a
    ld a, [wSelectedPlayer]
    or a
    jr nz, Label318971
    ld a, [wTyrant1Defeated]
    or a
    jr nz, Label318958
    jr Label318990
Label318958
    ld a, [wc4bb]
    or a
    jr nz, Label318990
    ld a, [wRoomScreen]
    cp a, $02
    jr nz, Label318990
    ld a, $14
    ld [wEventId], a
    ld a, $FF
    ld [wc4bb], a
    jr Label318990
Label318971
    ld a, [wTyrant1Defeated]
    or a
    jr nz, Label318979
    jr Label318990
Label318979
    ld a, [wc4bb]
    or a
    jr nz, Label318990
    ld a, [wRoomScreen]
    cp a, $02
    jr nz, Label318990
    ld a, $1D
    ld [wEventId], a
    ld a, $FF
    ld [wc4bb], a
Label318990
    ld a, $FF
    ret
;4993

Label318993: ;C6:4993
    xor a
    ret
;4995

checkLabPrisonCameraChange: ;C6:4995
    ld c, $00
    ld a, d
    or a
    jr nz, Label3189A0
    ld a, e
    cp a, $08
    jr nc, Label3189A2
Label3189A0
    ld c, $01
Label3189A2
    ld a, d
    or a
    jr nz, Label3189B7
    ld a, e
    cp a, $17
    jr c, Label3189B7
    ld a, h
    cp a, $FF
    jr nz, Label3189B5
    ld a, l
    cp a, $F3
    jr c, Label3189B7
Label3189B5
    ld c, $02
Label3189B7
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label318A04
    ld a, c
    ld [wRoomScreen], a
    ld a, [wSelectedPlayer]
    or a
    jr nz, Label3189E5
    ld a, [wTyrant1Defeated]
    or a
    jr z, Label318A01
    ld a, [wc4be]
    or a
    jr nz, Label318A01
    ld a, [wRoomScreen]
    or a
    jr nz, Label318A01
    ld a, $17
    ld [wEventId], a
    ld a, $FF
    ld [wc4be], a
    jr Label318A01
Label3189E5
    ld a, [wTyrant1Defeated]
    or a
    jr z, Label318A01
    ld a, [wc4be]
    or a
    jr nz, Label318A01
    ld a, [wRoomScreen]
    or a
    jr nz, Label318A01
    ld a, $1E
    ld [wEventId], a
    ld a, $FF
    ld [wc4be], a
Label318A01
    ld a, $FF
    ret
;4A04

Label318A04: ;C6:4A04
    xor a
    ret
;4A06

checkTyrantRoomCameraChange: ;C6:4A06
    ld c, $00
    ld a, h
    cp a, $FF
    jr nz, Label318A14
    ld a, l
    cp a, $CA
    jr nc, Label318A14
    ld c, $01
Label318A14
    ld a, d
    or a
    jr nz, Label318A1F
    ld a, e
    cp a, $3F
    jr c, Label318A1F
    ld c, $02
Label318A1F
    ld a, h
    or a
    jr nz, Label318A35
    ld a, l
    cp a, $1A
    jr c, Label318A35
    ld c, $04
    ld a, d
    or a
    jr nz, Label318A35
    ld a, e
    cp a, $09
    jr c, Label318A35
    ld c, $03
Label318A35
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label318A42
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;4A42

Label318A42: ;C6:4A42
    xor a
    ret
;4A44


checkPaintingsRoomCameraChange: ;C6:4A44
    ld c, $00
    ld a, h
    cp a, $FF
    jr nz, Label318A50
    ld a, l
    cp a, $E1
    jr c, Label318A52
Label318A50
    ld c, $01
Label318A52
    ld a, h
    or a
    jr nz, Label318A5D
    ld a, l
    cp a, $09
    jr c, Label318A5D
    ld c, $02
Label318A5D
    ld a, d
    cp a, $FF
    jr nz, Label318A67
    ld a, e
    cp a, $FE
    jr c, Label318A80
Label318A67
    ld c, $03
    ld a, h
    or a
    jr nz, Label318A72
    ld a, l
    cp a, $10
    jr nc, Label318A74
Label318A72
    ld c, $04
Label318A74
    ld a, h
    cp a, $FF
    jr nz, Label318A80
    ld a, l
    cp a, $C7
    jr nc, Label318A80
    ld c, $05
Label318A80
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label318A8D
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;4A8D

Label318A8D: ;C6:4A8D
    xor a
    ret
;4A8F


checkHerbicideSafeRoomCameraChange: ;C6:4A8F
    ld c, $00
    ld a, d
    cp a, $FF
    jr nz, Label318A98
    ld c, $01
Label318A98
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label318AA5
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;4AA5

Label318AA5: ;C6:4AA5
    xor a
    ret
;4AA7

checkWolfMedalRoomCameraChange: ;C6:4AA7
    ld c, $00
    ld a, d
    or a
    jr nz, Label318AB2
    ld a, e
    cp a, $04
    jr nc, Label318AB4
Label318AB2
    ld c, $01
Label318AB4
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label318AC1
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;4AC1

Label318AC1: ;C6:4AC1
    xor a
    ret
;4AC3

checkMansionKitchenCameraChange: ;C6:4AC3
    ld c, $01
    ld a, d
    cp a, $FF
    jr nz, Label318AD1
    ld a, e
    cp a, $E9
    jr nc, Label318AD1
    ld c, $00
Label318AD1
    ld a, h
    cp a, $FF
    jr nz, Label318ADB
    ld a, l
    cp a, $FD
    jr c, Label318ADD
Label318ADB
    ld c, $02
Label318ADD
    ld a, h
    or a
    jr nz, Label318AE8
    ld a, l
    cp a, $53
    jr c, Label318AE8
    ld c, $03
Label318AE8
    ld a, d
    or a
    jr nz, Label318AF1
    ld a, e
    cp a, $0F
    jr nc, Label318AFC
Label318AF1
    ld a, h
    or a
    jr nz, Label318AFC
    ld a, l
    cp a, $53
    jr c, Label318AFC
    ld c, $04
Label318AFC
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label318B0E
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ld [wc41b], a
    ld a, $FF
    ret
;4B0E

Label318B0E: ;C6:4B0E
    xor a
    ret
;4B10

checkGuardhouseEntranceCameraChange: ;C6:4B10
    ld c, $01
    ld a, d
    cp a, $FF
    jr nz, Label318B1C
    ld a, e
    cp a, $AE
    jr c, Label318B1E
Label318B1C
    ld c, $00
Label318B1E
    ld a, h
    cp a, $FF
    jr nz, Label318B28
    ld a, l
    cp a, $A0
    jr c, Label318B2A
Label318B28
    ld c, $02
Label318B2A
    ld a, h
    cp a, $FF
    jr nz, Label318B34
    ld a, l
    cp a, $DC
    jr c, Label318B36
Label318B34
    ld c, $03
Label318B36
    ld a, h
    or a
    jr nz, Label318B52
    ld a, d
    cp a, $FF
    jr nz, Label318B44
    ld a, e
    cp a, $C8
    jr c, Label318B46
Label318B44
    ld c, $05
Label318B46
    ld a, d
    cp a, $FF
    jr nz, Label318B50
    ld a, e
    cp a, $ED
    jr c, Label318B52
Label318B50
    ld c, $04
Label318B52
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label318B5F
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;4B5F

Label318B5F: ;C6:4B5F
    xor a
    ret
;4B61

checkGuardhouseDorm1CameraChange: ;C6:4B61
    ld c, $01
    ld a, d
    or a
    jr nz, Label318B6E
    ld a, e
    cp a, $25
    jr c, Label318B6E
    ld c, $00
Label318B6E
    ld a, h
    or a
    jr nz, Label318B77
    ld a, l
    cp a, $14
    jr nc, Label318B79
Label318B77
    ld c, $02
Label318B79
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label318B86
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;4B86

Label318B86: ;C6:4B86
    xor a
    ret
;4B88

checkDorm1BathroomCameraChange: ;C6:4B88
    ld c, $00
    ld a, h
    or a
    jr nz, Label318B99
    ld a, l
    or a
    jr z, Label318B99
    ld a, d
    cp a, $FF
    jr nz, Label318B99
    ld c, $01
Label318B99
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label318BA6
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;4BA6

Label318BA6: ;C6:4BA6
    xor a
    ret
;4BA8

checkGuardhouseSafeRoomCameraChange: ;C6:4BA8
    ld c, $00
    ld a, d
    or a
    jr nz, Label318BB4
    ld a, e
    or a
    jr z, Label318BB4
    ld c, $01
Label318BB4
    ld a, d
    cp a, $FF
    jr nz, Label318BBE
    ld a, e
    cp a, $FD
    jr c, Label318BCE
Label318BBE
    ld a, e
    cp a, $23
    jr nc, Label318BCE
    ld a, h
    or a
    jr nz, Label318BCE
    ld a, l
    cp a, $15
    jr c, Label318BCE
    ld c, $02
Label318BCE
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label318BDB
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;4BDB

Label318BDB: ;C6:4BDB
    xor a
    ret
;4BDD

checkAquariumCameraChange: ;C6:4BDD
    ld c, $00
    ld a, d
    cp a, $FF
    jr nz, Label318BEB
    ld a, e
    cp a, $ED
    jr nc, Label318BEB
    ld c, $01
Label318BEB
    ld a, h
    or a
    jr nz, Label318BF4
    ld a, l
    cp a, $24
    jr nc, Label318C19
Label318BF4
    ld c, $03
    ld a, h
    cp a, $FF
    jr nz, Label318C02
    ld a, l
    cp a, $E2
    jr nc, Label318C02
    ld c, $02
Label318C02
    ld a, h
    cp a, $FF
    jr nz, Label318C0E
    ld a, l
    cp a, $A2
    jr nc, Label318C0E
    ld c, $04
Label318C0E
    ld a, d
    or a
    jr nz, Label318C19
    ld a, e
    cp a, $47
    jr c, Label318C19
    ld c, $05
Label318C19
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label318C26
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;4C26

Label318C26: ;C6:4C26
    xor a
    ret
;4C28

checkCorridor4CCameraChange: ;C6:4C28
    ld c, $00
    ld a, d
    cp a, $FF
    jr nz, Label318C34
    ld a, e
    cp a, $B2
    jr c, Label318C36
Label318C34
    ld c, $01
Label318C36
    ld a, h
    cp a, $FF
    jr nz, Label318C40
    ld a, l
    cp a, $A0
    jr c, Label318C42
Label318C40
    ld c, $02
Label318C42
    ld a, h
    cp a, $FF
    jr nz, Label318C4C
    ld a, l
    cp a, $EA
    jr c, Label318C4E
Label318C4C
    ld c, $03
Label318C4E
    ld a, h
    or a
    jr nz, Label318C59
    ld a, l
    cp a, $4D
    jr c, Label318C59
    ld c, $04
Label318C59
    ld a, d
    cp a, $FF
    jr nz, Label318C63
    ld a, e
    cp a, $E4
    jr c, Label318C65
Label318C63
    ld c, $05
Label318C65
    ld a, d
    or a
    jr nz, Label318C7B
    ld a, e
    cp a, $83
    jr c, Label318C7B
    ld c, $06
    ld a, h
    or a
    jr nz, Label318C79
    ld a, l
    cp a, $27
    jr nc, Label318C7B
Label318C79
    ld c, $07
Label318C7B
    ld a, $FF
    ld [wc4d5], a
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label318C8D
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;4C8D

Label318C8D: ;C6:4C8D
    xor a
    ret
;4C8F

checkAquariumControlRoomCameraChange: ;C6:4C8F
    ld c, $00
    ld a, d
    or a
    jr nz, Label318C9A
    ld a, e
    cp a, $04
    jr nc, Label318C9C
Label318C9A
    ld c, $01
Label318C9C
    ld a, h
    or a
    jr nz, Label318CB1
    ld a, l
    cp a, $06
    jr c, Label318CB1
    ld a, d
    cp a, $FF
    jr nz, Label318CB1
    ld a, e
    cp a, $ED
    jr nc, Label318CB1
    ld c, $02
Label318CB1
    ld a, h
    cp a, $FF
    jr nz, Label318CC7
    ld a, l
    cp a, $F3
    jr nc, Label318CC7
    ld a, d
    cp a, $FF
    jr nz, Label318CC7
    ld a, e
    cp a, $F6
    jr nc, Label318CC7
    ld c, $03
Label318CC7
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label318CD4
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;4CD4

Label318CD4: ;C6:4CD4
    xor a
    ret
;4CD6

checkGuardhouseBarCameraChange: ;C6:4CD6
    ld c, $05
    ld a, d
    cp a, $FF
    jr nz, Label318CE4
    ld a, e
    cp a, $CC
    jr nc, Label318CE4
    ld c, $04
Label318CE4
    ld a, h
    cp a, $FF
    jr nz, Label318CEE
    ld a, l
    cp a, $C2
    jr c, Label318CF0
Label318CEE
    ld c, $03
Label318CF0
    ld a, h
    cp a, $FF
    jr nz, Label318CFA
    ld a, l
    cp a, $C2
    jr c, Label318D06
Label318CFA
    ld a, d
    cp a, $FF
    jr nz, Label318D04
    ld a, e
    cp a, $CF
    jr c, Label318D06
Label318D04
    ld c, $02
Label318D06
    ld a, d
    or a
    jr nz, Label318D11
    ld a, e
    cp a, $13
    jr c, Label318D11
    ld c, $00
Label318D11
    ld a, h
    cp a, $FF
    jr nz, Label318D26
    ld a, l
    cp a, $CF
    jr nc, Label318D26
    ld a, d
    or a
    jr nz, Label318D26
    ld a, e
    cp a, $37
    jr c, Label318D26
    ld c, $01
Label318D26
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label318D33
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;4D33

Label318D33: ;C6:4D33
    xor a
    ret
;4D35

checkCorridor4FCameraChange: ;C6:4D35
    ld c, $00
    ld a, h
    cp a, $FF
    jr nz, Label318D41
    ld a, l
    cp a, $CF
    jr c, Label318D43
Label318D41
    ld c, $01
Label318D43
    ld a, h
    or a
    jr nz, Label318D4E
    ld a, l
    cp a, $04
    jr c, Label318D4E
    ld c, $02
Label318D4E
    ld a, h
    or a
    jr nz, Label318D59
    ld a, l
    cp a, $29
    jr c, Label318D59
    ld c, $07
Label318D59
    ld a, h
    or a
    jr nz, Label318D64
    ld a, l
    cp a, $46
    jr c, Label318D64
    ld c, $03
Label318D64
    ld a, d
    or a
    jr nz, Label318D6D
    ld a, e
    cp a, $25
    jr nc, Label318D6F
Label318D6D
    ld c, $04
Label318D6F
    ld a, d
    cp a, $FF
    jr nz, Label318D84
    ld a, e
    cp a, $BB
    jr nc, Label318D84
    ld a, h
    or a
    jr nz, Label318D84
    ld a, l
    cp a, $5A
    jr c, Label318D84
    ld c, $05
Label318D84
    ld a, d
    cp a, $FF
    jr nz, Label318D90
    ld a, e
    cp a, $A5
    jr nc, Label318D90
    ld c, $06
Label318D90
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label318DC9
    ld a, c
    ld [wRoomScreen], a
    cp a, $03
    jr nz, Label318DC6
    ld a, [wc4a0]
    or a
    jr z, Label318DC6
    ld a, [wc49f]
    or a
    jr nz, Label318DC6
    ld a, [wSelectedPlayer]
    or a
    jr z, Label318DBC
    ld a, $12
    ld [wEventId], a
    ld a, $FF
    ld [wc49f], a
    jr Label318DC6
Label318DBC
    ld a, $0C
    ld [wEventId], a
    ld a, $FF
    ld [wc49f], a
Label318DC6
    ld a, $FF
    ret
;4DC9

Label318DC9: ;C6:4DC9
    xor a
    ret
;4DCB

checkGuardhouseDorm2CameraChange: ;C6:4DCB
    ld c, $04
    ld a, d
    cp a, $FF
    jr nz, Label318DD7
    ld a, e
    cp a, $FA
    jr c, Label318DD9
Label318DD7
    ld c, $02
Label318DD9
    ld a, d
    or a
    jr nz, Label318DE4
    ld a, e
    cp a, $3E
    jr c, Label318DE4
    ld c, $01
Label318DE4
    ld a, h
    or a
    jr nz, Label318DED
    ld a, l
    cp a, $08
    jr nc, Label318DEF
Label318DED
    ld c, $03
Label318DEF
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label318E19
    ld a, c
    ld [wRoomScreen], a
    ld a, [wSelectedPlayer]
    or a
    jr z, Label318E16
    ld a, [wRoomScreen]
    cp a, $02
    jr nz, Label318E16
    ld a, [wc4c9]
    or a
    jr nz, Label318E16
    ld a, $11
    ld [wEventId], a
    ld a, $FF
    ld [wc4c9], a
Label318E16
    ld a, $FF
    ret
;4E19

Label318E19: ;C6:4E19
    xor a
    ret
;4E1B

checkDorm2BathroomCameraChange: ;C6:4E1B
    ld c, $01
    ld a, d
    cp a, $FF
    jr nz, Label318E29
    ld a, e
    cp a, $FB
    jr nc, Label318E29
    ld c, $00
Label318E29
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label318E36
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;4E36

Label318E36: ;C6:4E36
    xor a
    ret
;4E38

checkGuardhouseBeesRoomCameraChange: ;C6:4E38
    ld c, $00
    ld a, h
    cp a, $FF
    jr nz, Label318E44
    ld a, l
    cp a, $DA
    jr c, Label318E46
Label318E44
    ld c, $01
Label318E46
    ld a, h
    or a
    jr nz, Label318E51
    ld a, l
    cp a, $18
    jr c, Label318E51
    ld c, $07
Label318E51
    ld a, h
    or a
    jr nz, Label318E5C
    ld a, l
    cp a, $47
    jr c, Label318E5C
    ld c, $02
Label318E5C
    ld a, d
    or a
    jr nz, Label318E65
    ld a, e
    cp a, $1A
    jr nc, Label318E67
Label318E65
    ld c, $04
Label318E67
    ld a, d
    cp a, $FF
    jr nz, Label318E73
    ld a, e
    cp a, $E5
    jr nc, Label318E73
    ld c, $03
Label318E73
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label318E80
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;4E80

Label318E80: ;C6:4E80
    xor a
    ret
;4E82

checkChemicalsRoomCameraChange: ;C6:4E82
    ld c, $01
    ld a, h
    cp a, $FF
    jr nz, Label318E8E
    ld a, l
    cp a, $FB
    jr c, Label318E90
Label318E8E
    ld c, $02
Label318E90
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label318E9D
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;4E9D

Label318E9D: ;C6:4E9D
    xor a
    ret
;4E9F

checkGuardhouseDorm3CameraChange: ;C6:4E9F
    ld c, $00
    ld a, d
    or a
    jr nz, Label318EAA
    ld a, e
    cp a, $19
    jr nc, Label318EAC
Label318EAA
    ld c, $01
Label318EAC
    ld a, d
    cp a, $FF
    jr nz, Label318EB8
    ld a, e
    cp a, $F0
    jr nc, Label318EB8
    ld c, $02
Label318EB8
    ld a, d
    cp a, $FF
    jr nz, Label318ECD
    ld a, e
    cp a, $D1
    jr nc, Label318ECD
    ld a, h
    or a
    jr nz, Label318ECB
    ld a, l
    cp a, $28
    jr nc, Label318ECD
Label318ECB
    ld c, $05
Label318ECD
    ld a, h
    or a
    jr nz, Label318ED6
    ld a, l
    cp a, $07
    jr nc, Label318ED8
Label318ED6
    ld c, $03
Label318ED8
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label318EE5
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;4EE5

Label318EE5: ;C6:4EE5
    xor a
    ret
;4EE7

checkDorm3BathroomCameraChange: ;C6:4EE7
    ld c, $00
    ld a, h
    or a
    jr nz, Label318EF3
    ld a, l
    or a
    jr z, Label318EF3
    ld c, $01
Label318EF3
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label318F00
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;4F00

Label318F00: ;C6:4F00
    xor a
    ret
;4F02

checkPlant42RoomCameraChange: ;C6:4F02
    ld c, $02
    ld a, d
    or a
    jr nz, Label318F0F
    ld a, e
    cp a, $39
    jr c, Label318F0F
    ld c, $00
Label318F0F
    ld a, h
    cp a, $FF
    jr nz, Label318F19
    ld a, l
    cp a, $C9
    jr c, Label318F25
Label318F19
    ld a, d
    cp a, $FF
    jr nz, Label318F25
    ld a, e
    cp a, $DD
    jr nc, Label318F25
    ld c, $01
Label318F25
    ld a, d
    cp a, $FF
    jr nz, Label318F2F
    ld a, e
    cp a, $DD
    jr c, Label318F39
Label318F2F
    ld a, h
    or a
    jr nz, Label318F39
    ld a, l
    or a
    jr z, Label318F39
    ld c, $00
Label318F39
    ld a, d
    or a
    jr nz, Label318F4C
    ld a, e
    cp a, $24
    jr c, Label318F4C
    ld a, h
    or a
    jr nz, Label318F4C
    ld a, l
    or a
    jr z, Label318F4C
    ld c, $06
Label318F4C
    ld a, h
    cp a, $FF
    jr nz, Label318F62
    ld a, l
    cp a, $E2
    jr nc, Label318F62
    ld a, d
    cp a, $FF
    jr nz, Label318F62
    ld a, e
    cp a, $E2
    jr nc, Label318F62
    ld c, $05
Label318F62
    ld a, d
    or a
    jr nz, Label318F6B
    ld a, e
    cp a, $02
    jr nc, Label318F75
Label318F6B
    ld a, h
    or a
    jr nz, Label318F75
    ld a, l
    or a
    jr z, Label318F75
    ld c, $04
Label318F75
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label318F8E
    ld a, c
    ld [wRoomScreen], a
    xor a
    ld [wc462], a
    ld a, $FF
    ld [wc45f], a
    ld [wc4a0], a
    ld a, $FF
    ret
;4F8E

Label318F8E: ;C6:4F8E
    xor a
    ret
;4F90

checkAquariumRoom57CameraChange: ;C6:4F90
    ld c, $00
    ld a, h
    or a
    jr z, Label318F98
    ld c, $01
Label318F98
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label318FA5
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;4FA5

Label318FA5: ;C6:4FA5
    xor a
    ret
;4FA7

checkPlant42RootsRoomCameraChange: ;C6:4FA7
    ld c, $00
    ld a, h
    cp a, $FF
    jr nz, Label318FB3
    ld a, l
    cp a, $FA
    jr c, Label318FB5
Label318FB3
    ld c, $01
Label318FB5
    ld a, h
    or a
    jr nz, Label318FC0
    ld a, l
    cp a, $24
    jr c, Label318FC0
    ld c, $02
Label318FC0
    ld a, h
    cp a, $FF
    jr nz, Label318FD5
    ld a, l
    cp a, $E4
    jr nc, Label318FD5
    ld a, d
    or a
    jr nz, Label318FD5
    ld a, e
    cp a, $10
    jr c, Label318FD5
    ld c, $03
Label318FD5
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label318FE2
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;4FE2

Label318FE2: ;C6:4FE2
    xor a
    ret
;4FE4

checkCourtyard1FCameraChange: ;C6:4FE4
    ld c, $04
    ld a, h
    or a
    jr nz, Label318FEF
    ld a, l
    cp a, $46
    jr nc, Label318FF1
Label318FEF
    ld c, $05
Label318FF1
    ld a, d
    cp a, $FF
    jr nz, Label318FFB
    ld a, e
    cp a, $C1
    jr c, Label318FFD
Label318FFB
    ld c, $03
Label318FFD
    ld a, d
    or a
    jr nz, Label319008
    ld a, e
    cp a, $29
    jr c, Label319008
    ld c, $00
Label319008
    ld a, h
    or a
    jr nz, Label319011
    ld a, l
    cp a, $46
    jr nc, Label31901C
Label319011
    ld a, d
    or a
    jr nz, Label31901C
    ld a, e
    cp a, $29
    jr c, Label31901C
    ld c, $01
Label31901C
    ld a, h
    cp a, $FF
    jr nz, Label319028
    ld a, l
    cp a, $C4
    jr nc, Label319028
    ld c, $02
Label319028
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319050
    ld a, c
    ld [wRoomScreen], a
    cp a, $01
    jr nz, Label31904D
    ld a, [wSpriteId]
    cp a, CHRIS
    jr z, Label31904D
    ld a, [wc497]
    or a
    jr nz, Label31904D
    ld a, $0F
    ld [wEventId], a
    ld a, $FF
    ld [wc497], a
Label31904D
    ld a, $FF
    ret
;5050

Label319050: ;C6:5050
    xor a
    ret
;5052

checkCourtyardPoolCameraChange: ;C6:5052
    ld c, $00
    ld a, d
    or a
    jr nz, Label31905D
    ld a, e
    cp a, $55
    jr nc, Label319068
Label31905D
    ld a, h
    or a
    jr nz, Label319068
    ld a, l
    cp a, $65
    jr c, Label319068
    ld c, $01
Label319068
    ld a, d
    or a
    jr nz, Label31907A
    ld a, e
    cp a, $20
    jr c, Label31907A
    ld a, h
    or a
    jr nz, Label31907A
    ld a, l
    cp a, $65
    jr nc, Label31907C
Label31907A
    ld c, $02
Label31907C
    ld a, d
    or a
    jr nz, Label319085
    ld a, e
    cp a, $0A
    jr nc, Label319090
Label319085
    ld a, h
    or a
    jr nz, Label319090
    ld a, l
    cp a, $33
    jr c, Label319090
    ld c, $04
Label319090
    ld a, d
    cp a, $FF
    jr nz, Label31909C
    ld a, e
    cp a, $9E
    jr nc, Label31909C
    ld c, $05
Label31909C
    ld a, d
    cp a, $FF
    jr nz, Label3190B1
    ld a, e
    cp a, $CE
    jr nc, Label3190B1
    ld a, h
    or a
    jr nz, Label3190AF
    ld a, l
    cp a, $27
    jr nc, Label3190B1
Label3190AF
    ld c, $06
Label3190B1
    ld a, h
    cp a, $FF
    jr nz, Label3190BD
    ld a, l
    cp a, $BB
    jr nc, Label3190BD
    ld c, $07
Label3190BD
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label3190CA
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;50CA

Label3190CA: ;C6:50CA
    xor a
    ret
;50CC

checkCourtyard2FCameraChange: ;C6:50CC
    ld c, $01
    ld a, d
    cp a, $FF
    jr nz, Label3190E3
    ld a, e
    cp a, $B2
    jr nc, Label3190E3
    ld a, h
    or a
    jr nz, Label3190E3
    ld a, l
    cp a, $3B
    jr c, Label3190E3
    ld c, $00
Label3190E3
    ld a, h
    or a
    jr nz, Label3190EC
    ld a, l
    cp a, $20
    jr nc, Label3190EE
Label3190EC
    ld c, $02
Label3190EE
    ld a, h
    cp a, $FF
    jr nz, Label3190FA
    ld a, l
    cp a, $F8
    jr nc, Label3190FA
    ld c, $05
Label3190FA
    ld a, d
    or a
    jr nz, Label319104
    ld a, e
    or a
    jr z, Label319104
    ld c, $04
Label319104
    ld a, d
    or a
    jr nz, Label31910F
    ld a, e
    cp a, $45
    jr c, Label31910F
    ld c, $06
Label31910F
    ld a, d
    or a
    jr nz, Label319123
    ld a, e
    cp a, $3D
    jr c, Label319123
    ld a, h
    or a
    jr nz, Label319123
    ld a, l
    cp a, $17
    jr c, Label319123
    ld c, $07
Label319123
    ld a, d
    cp a, $FF
    jr nz, Label319142
    ld a, e
    cp a, $B7
    jr nc, Label319142
    ld a, h
    cp a, $FF
    jr nz, Label319137
    ld a, l
    cp a, $F1
    jr nc, Label319140
Label319137
    ld a, h
    or a
    jr nz, Label319142
    ld a, l
    cp a, $10
    jr nc, Label319142
Label319140
    ld c, $03
Label319142
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label31914F
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;514F

Label31914F: ;C6:514F
    xor a
    ret
;5151

checkHeliportCameraChange: ;C6:5151
    ld c, $01
    ld a, h
    or a
    jr nz, Label31915E
    ld a, l
    cp a, $38
    jr c, Label31915E
    ld c, $04
Label31915E
    ld a, d
    or a
    jr z, Label319164
    ld c, $03
Label319164
    ld a, h
    or a
    jr z, Label31917B
    ld a, d
    cp a, $FF
    jr nz, Label319174
    ld a, e
    cp a, $C1
    jr c, Label31917B
    jr Label319179
Label319174
    ld a, e
    cp a, $40
    jr nc, Label31917B
Label319179
    ld c, $02
Label31917B
    ld a, d
    or a
    jr nz, Label319186
    ld a, e
    cp a, $58
    jr c, Label319186
    ld c, $01
Label319186
    ld a, h
    cp a, $FF
    jr nz, Label31919C
    ld a, l
    cp a, $C1
    jr nc, Label31919C
    ld a, d
    cp a, $FF
    jr nz, Label31919C
    ld a, e
    cp a, $C4
    jr nc, Label31919C
    ld c, $06
Label31919C
    ld a, h
    cp a, $FF
    jr nz, Label3191B1
    ld a, l
    cp a, $DA
    jr nc, Label3191B1
    ld a, d
    or a
    jr nz, Label3191B1
    ld a, e
    cp a, $3F
    jr c, Label3191B1
    ld c, $00
Label3191B1
    ld a, h
    cp a, $FF
    jr nz, Label3191C6
    ld a, l
    cp a, $BD
    jr nc, Label3191C6
    ld a, d
    or a
    jr nz, Label3191C6
    ld a, e
    cp a, $5A
    jr c, Label3191C6
    ld c, $07
Label3191C6
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label3191D3
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;51D3

Label3191D3: ;C6:51D3
    xor a
    ret
;51D5

checkCorridor3ACameraChange: ;C6:51D5
    ld c, $01
    ld a, d
    or a
    jr nz, Label3191E2
    ld a, e
    cp a, $65
    jr c, Label3191E2
    ld c, $00
Label3191E2
    ld a, h
    or a
    jr nz, Label3191EB
    ld a, l
    cp a, $56
    jr nc, Label3191ED
Label3191EB
    ld c, $02
Label3191ED
    ld a, h
    cp a, $FF
    jr nz, Label3191F9
    ld a, l
    cp a, $BA
    jr nc, Label3191F9
    ld c, $03
Label3191F9
    ld a, d
    cp a, $FF
    jr nz, Label319205
    ld a, e
    cp a, $F6
    jr nc, Label319205
    ld c, $04
Label319205
    ld a, d
    cp a, $FF
    jr nz, Label319211
    ld a, e
    cp a, $9C
    jr nc, Label319211
    ld c, $05
Label319211
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319241
    ld a, c
    ld [wRoomScreen], a
    ld a, [wSelectedPlayer]
    or a
    jr z, Label31923E
    ld a, [wc4a0]
    or a
    jr z, Label31923E
    ld a, [wc4ca]
    or a
    jr nz, Label31923E
    ld a, [wRoomScreen]
    cp a, $04
    jr nz, Label31923E
    ld a, $13
    ld [wEventId], a
    ld a, $FF
    ld [wc4ca], a
Label31923E
    ld a, $FF
    ret
;5241

Label319241: ;C6:5241
    xor a
    ret
;5243

checkEagleMedalRoomCameraChange: ;C6:5243
    ld c, $03
    ld a, d
    or a
    jr nz, Label31924E
    ld a, e
    cp a, $08
    jr nc, Label319250
Label31924E
    ld c, $00
Label319250
    ld a, d
    or a
    jr nz, Label319259
    ld a, e
    cp a, $08
    jr nc, Label319265
Label319259
    ld a, h
    cp a, $FF
    jr nz, Label319265
    ld a, l
    cp a, $EF
    jr nc, Label319265
    ld c, $01
Label319265
    ld a, d
    cp a, $FF
    jr nz, Label31927A
    ld a, e
    cp a, $F0
    jr nc, Label31927A
    ld a, h
    or a
    jr nz, Label31927A
    ld a, l
    cp a, $0B
    jr c, Label31927A
    ld c, $02
Label31927A
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319287
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;5287

Label319287: ;C6:5287
    xor a
    ret
;5289

checkEnricosRoomCameraChange: ;C6:5289
    ld c, $00
    ld a, d
    cp a, $FF
    jr nz, Label319295
    ld a, e
    cp a, $FC
    jr c, Label319297
Label319295
    ld c, $01
Label319297
    ld a, h
    cp a, $FF
    jr nz, Label3192A1
    ld a, l
    cp a, $EA
    jr c, Label3192B9
Label3192A1
    ld c, $02
    ld a, d
    or a
    jr nz, Label3192AC
    ld a, e
    cp a, $35
    jr nc, Label3192AE
Label3192AC
    ld c, $03
Label3192AE
    ld a, d
    or a
    jr nz, Label3192B7
    ld a, e
    cp a, $10
    jr nc, Label3192B9
Label3192B7
    ld c, $04
Label3192B9
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label3192F8
    ld a, c
    ld [wRoomScreen], a
    cp a, $03
    jr nz, Label3192F5
    ld a, [wSelectedPlayer]
    or a
    jr z, Label3192E2
    ld a, [wc4a2]
    or a
    jr nz, Label3192F5
    ld a, $17
    ld [wEventId], a
    ld a, $FF
    ld [wc4a2], a
    ld [wSouthPassageHexCrank], a
    jr Label3192F5
Label3192E2
    ld a, [wc4a2]
    or a
    jr nz, Label3192F5
    ld a, $10
    ld [wEventId], a
    ld a, $FF
    ld [wc4a2], a
    ld [wSouthPassageHexCrank], a
Label3192F5
    ld a, $FF
    ret
;52F8

Label3192F8: ;C6:52F8
    xor a
    ret
;52FA

checkBoulderRoom1CameraChange: ;C6:52FA
    ld c, $06
    ld a, d
    cp a, $FF
    jr nz, Label319308
    ld a, e
    cp a, $FC
    jr nc, Label319308
    ld c, $07
Label319308
    ld a, d
    cp a, $FF
    jr nz, Label319314
    ld a, e
    cp a, $D7
    jr nc, Label319314
    ld c, $00
Label319314
    ld a, h
    or a
    jr nz, Label31931D
    ld a, l
    cp a, $14
    jr nc, Label31931F
Label31931D
    ld c, $02
Label31931F
    ld a, h
    cp a, $FF
    jr nz, Label31932B
    ld a, l
    cp a, $C4
    jr nc, Label31932B
    ld c, $03
Label31932B
    ld a, h
    cp a, $FF
    jr nz, Label319337
    ld a, l
    cp a, $9C
    jr nc, Label319337
    ld c, $04
Label319337
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319344
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;5344

Label319344: ;C6:5344
    xor a
    ret
;5346

checkBoulderRoom2CameraChange: ;C6:5346
    ld c, $01
    ld a, d
    or a
    jr nz, Label319351
    ld a, e
    cp a, $20
    jr nc, Label319353
Label319351
    ld c, $00
Label319353
    ld a, d
    cp a, $FF
    jr nz, Label31935F
    ld a, e
    cp a, $F6
    jr nc, Label31935F
    ld c, $02
Label31935F
    ld a, d
    cp a, $FF
    jr nz, Label31936B
    ld a, e
    cp a, $C6
    jr nc, Label31936B
    ld c, $04
Label31936B
    ld a, d
    cp a, $FF
    jr nz, Label319380
    ld a, e
    cp a, $C6
    jr nc, Label319380
    ld a, h
    or a
    jr nz, Label31937E
    ld a, l
    cp a, $42
    jr nc, Label319380
Label31937E
    ld c, $03
Label319380
    ld a, h
    or a
    jr nz, Label319389
    ld a, l
    cp a, $12
    jr nc, Label31938B
Label319389
    ld c, $05
Label31938B
    ld a, d
    cp a, $FF
    jr nz, Label319395
    ld a, e
    cp a, $C5
    jr c, Label3193A0
Label319395
    ld a, h
    or a
    jr nz, Label31939E
    ld a, l
    cp a, $0F
    jr nc, Label3193A0
Label31939E
    ld c, $06
Label3193A0
    ld a, h
    cp a, $FF
    jr nz, Label3193AC
    ld a, l
    cp a, $AB
    jr nc, Label3193AC
    ld c, $07
Label3193AC
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label3193B9
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;53B9

Label3193B9: ;C6:53B9
    xor a
    ret
;53BB

checkCorridor3FCameraChange: ;C6:53BB
    ld c, $00
    ld a, d
    or a
    jr nz, Label3193C6
    ld a, e
    cp a, $3E
    jr nc, Label3193C8
Label3193C6
    ld c, $01
Label3193C8
    ld a, d
    cp a, $FF
    jr nz, Label3193D4
    ld a, e
    cp a, $FB
    jr nc, Label3193D4
    ld c, $02
Label3193D4
    ld a, h
    or a
    jr nz, Label3193DD
    ld a, l
    cp a, $22
    jr nc, Label319402
Label3193DD
    ld c, $03
    ld a, d
    cp a, $FF
    jr nz, Label3193E9
    ld a, e
    cp a, $C5
    jr c, Label3193EB
Label3193E9
    ld c, $04
Label3193EB
    ld a, d
    cp a, $FF
    jr nz, Label3193F5
    ld a, e
    cp a, $EF
    jr c, Label3193F7
Label3193F5
    ld c, $05
Label3193F7
    ld a, d
    or a
    jr nz, Label319402
    ld a, e
    cp a, $3D
    jr c, Label319402
    ld c, $06
Label319402
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label31940F
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;540F

Label31940F: ;C6:540F
    xor a
    ret
;5411

checkCatacombSafeRoomCameraChange: ;C6:5411
    ld c, $00
    ld a, d
    or a
    jr z, Label319419
    ld c, $01
Label319419
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319426
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;5426

Label319426: ;C6:5426
    xor a
    ret
;5428

checkFountainCameraChange: ;C6:5428
    ld c, $00
    ld a, h
    cp a, $FF
    jr nz, Label319434
    ld a, l
    cp a, $DB
    jr c, Label319436
Label319434
    ld c, $01
Label319436
    ld a, h
    cp a, $FF
    jr nz, Label319440
    ld a, l
    cp a, $E9
    jr c, Label31944C
Label319440
    ld a, d
    cp a, $FF
    jr nz, Label31944A
    ld a, e
    cp a, $C1
    jr c, Label31944C
Label31944A
    ld c, $02
Label31944C
    ld a, h
    or a
    jr nz, Label319460
    ld a, l
    cp a, $2B
    jr c, Label319460
    ld a, d
    or a
    jr nz, Label319460
    ld a, e
    cp a, $21
    jr c, Label319460
    ld c, $03
Label319460
    ld a, h
    or a
    jr nz, Label319474
    ld a, l
    cp a, $33
    jr c, Label319474
    ld a, d
    or a
    jr nz, Label319472
    ld a, e
    cp a, $4E
    jr nc, Label319474
Label319472
    ld c, $04
Label319474
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319481
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;5481

Label319481: ;C6:5481
    xor a
    ret
;5483

checkFountainElevatorCameraChange: ;C6:5483
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319490
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;5490

Label319490: ;C6:5490
    xor a
    ret
;5492

checkCorridor43CameraChange: ;C6:5492
    ld c, $00
    ld a, h
    or a
    jr nz, Label3194D5
    ld a, l
    cp a, $06
    jr c, Label3194D5
    ld c, $01
    ld a, d
    cp a, $FF
    jr nz, Label3194AB
    ld a, e
    cp a, $BE
    jr nc, Label3194AB
    ld c, $02
Label3194AB
    ld a, d
    cp a, $FF
    jr nz, Label3194C0
    ld a, e
    cp a, $A2
    jr nc, Label3194C0
    ld a, h
    or a
    jr nz, Label3194C0
    ld a, l
    cp a, $1F
    jr c, Label3194C0
    ld c, $03
Label3194C0
    ld a, d
    or a
    jr nz, Label3194CA
    ld a, e
    or a
    jr z, Label3194CA
    ld c, $04
Label3194CA
    ld a, d
    or a
    jr nz, Label3194D5
    ld a, e
    cp a, $3B
    jr c, Label3194D5
    ld c, $05
Label3194D5
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label3194E2
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;54E2

Label3194E2: ;C6:54E2
    xor a
    ret
;54E4

checkCatacombPowerRoomCameraChange: ;C6:54E4
    ld c, $00
    ld a, h
    cp a, $FF
    jr nz, Label3194F0
    ld a, l
    cp a, $CA
    jr c, Label3194F2
Label3194F0
    ld c, $01
Label3194F2
    ld a, d
    or a
    jr nz, Label3194FB
    ld a, e
    cp a, $37
    jr nc, Label3194FD
Label3194FB
    ld c, $02
Label3194FD
    ld a, d
    cp a, $FF
    jr nz, Label319513
    ld a, e
    cp a, $ED
    jr nc, Label319513
    ld a, h
    cp a, $FF
    jr nz, Label319511
    ld a, l
    cp a, $D4
    jr c, Label319513
Label319511
    ld c, $03
Label319513
    ld a, d
    cp a, $FF
    jr nz, Label31951F
    ld a, e
    cp a, $A7
    jr nc, Label31951F
    ld c, $04
Label31951F
    ld a, h
    cp a, $FF
    jr nz, Label319535
    ld a, l
    cp a, $D4
    jr nc, Label319535
    ld a, d
    cp a, $FF
    jr nz, Label319535
    ld a, e
    cp a, $ED
    jr nc, Label319535
    ld c, $05
Label319535
    ld a, h
    or a
    jr nz, Label319540
    ld a, l
    cp a, $12
    jr c, Label319540
    ld c, $06
Label319540
    ld a, h
    or a
    jr nz, Label31954B
    ld a, l
    cp a, $4D
    jr c, Label31954B
    ld c, $07
Label31954B
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319558
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;5558

Label319558: ;C6:5558
    xor a
    ret
;555A

checkBlackTigerRoomCameraChange: ;C6:555A
    ld c, $00
    ld a, d
    cp a, $FF
    jr nz, Label319568
    ld a, e
    cp a, $D6
    jr nc, Label319568
    ld c, $01
Label319568
    ld a, d
    or a
    jr nz, Label319572
    ld a, e
    or a
    jr z, Label319572
    ld c, $02
Label319572
    ld a, d
    cp a, $FF
    jr nz, Label31957E
    ld a, e
    cp a, $F1
    jr c, Label31958E
    jr Label319583
Label31957E
    ld a, e
    cp a, $14
    jr nc, Label31958E
Label319583
    ld a, h
    or a
    jr nz, Label31958E
    ld a, l
    cp a, $1A
    jr c, Label31958E
    ld c, $03
Label31958E
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label31959B
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;559B

Label31959B: ;C6:559B
    xor a
    ret
;559D

checkCorridor46CameraChange: ;C6:559D
    ld c, $00
    ld a, h
    or a
    jr z, Label3195A5
    ld c, $02
Label3195A5
    ld a, h
    or a
    jr nz, Label3195B0
    ld a, l
    cp a, $4C
    jr c, Label3195B0
    ld c, $01
Label3195B0
    ld a, h
    cp a, $FF
    jr nz, Label3195BC
    ld a, l
    cp a, $C8
    jr nc, Label3195BC
    ld c, $03
Label3195BC
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label3195C9
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;55C9

Label3195C9: ;C6:55C9
    xor a
    ret
;55CB

checkCorridor35CameraChange: ;C6:55CB
    ld c, $01
    ld a, d
    cp a, $FF
    jr nz, Label3195E5
    ld a, e
    cp a, $B4
    jr nc, Label3195E5
    ld c, $03
    ld a, h
    cp a, $FF
    jr nz, Label3195E5
    ld a, l
    cp a, $EA
    jr nc, Label3195E5
    ld c, $04
Label3195E5
    ld a, h
    or a
    jr nz, Label3195F0
    ld a, l
    cp a, $40
    jr c, Label3195F0
    ld c, $02
Label3195F0
    ld a, d
    cp a, $FF
    jr nz, Label3195FA
    ld a, e
    cp a, $CC
    jr c, Label319601
Label3195FA
    ld a, h
    cp a, $FF
    jr nz, Label319601
    ld c, $00
Label319601
    ld a, d
    or a
    jr z, Label31960A
    ld a, e
    cp a, $F7
    jr c, Label31960C
Label31960A
    ld c, $05
Label31960C
    ld a, d
    or a
    jr nz, Label319617
    ld a, e
    cp a, $42
    jr c, Label319617
    ld c, $06
Label319617
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319624
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;5624

Label319624: ;C6:5624
    xor a
    ret
;5626

checkLibraryRoom34CameraChange: ;C6:5626
    ld c, $00
    ld a, d
    cp a, $FF
    jr nz, Label31962F
    ld c, $01
Label31962F
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label31963C
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;563C

Label31963C: ;C6:563C
    xor a
    ret
;563E

checkRoom33CameraChange: ;C6:563E
    ld c, $00
    ld a, d
    cp a, $FF
    jr nz, Label319647
    ld c, $01
Label319647
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319654
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;5654

Label319654: ;C6:5654
    xor a
    ret
;5656

checkLibraryMoDiskRoomCameraChange: ;C6:5656
    ld a, h
    or a
    jr nz, Label31966F
    ld a, l
    cp a, $18
    jr c, Label31966F
    ld c, $00
    ld a, d
    cp a, $FF
    jr nz, Label319685
    ld a, e
    cp a, $F5
    jr nc, Label319685
    ld c, $03
    jr Label319685
Label31966F
    ld c, $01
    ld a, d
    cp a, $FF
    jr nz, Label319685
    ld a, e
    cp a, $F5
    jr nc, Label319685
    ld c, $02
    ld a, [wLibraryStatueLightTrigger]
    or a
    jr z, Label319685
    ld c, $06
Label319685
    ld a, d
    cp a, $FF
    jr nz, Label3196B3
    ld a, e
    cp a, $DC
    jr nc, Label3196B3
    ld a, h
    cp a, $FF
    jr z, Label319699
    ld a, l
    cp a, $21
    jr nc, Label3196A3
Label319699
    ld c, $04
    ld a, [wLibraryStatueLightTrigger]
    or a
    jr z, Label3196A3
    ld c, $07
Label3196A3
    ld a, e
    cp a, $CE
    jr nc, Label3196B3
    ld a, h
    or a
    jr nz, Label3196B3
    ld a, l
    cp a, $1E
    jr c, Label3196B3
    ld c, $05
Label3196B3
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label3196C0
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;56C0

Label3196C0: ;C6:56C0
    xor a
    ret
;56C2

checkLibraryCameraChange: ;C6:56C2
    ld c, $00
    ld a, d
    or a
    jr nz, Label3196CA
    ld c, $01
Label3196CA
    ld a, h
    or a
    jr nz, Label3196D5
    ld a, l
    cp a, $1C
    jr c, Label3196D5
    ld c, $04
Label3196D5
    ld a, d
    or a
    jr nz, Label3196F1
    ld a, e
    cp a, $1F
    jr c, Label3196F1
    ld a, h
    or a
    jr nz, Label3196F1
    ld a, l
    cp a, $34
    jr nc, Label3196EF
    cp a, $1C
    jr c, Label3196F1
    ld c, $02
    jr Label3196F1
Label3196EF
    ld c, $03
Label3196F1
    ld a, d
    cp a, $FF
    jr nz, Label319706
    ld a, e
    cp a, $C3
    jr nc, Label319706
    ld a, h
    or a
    jr nz, Label319706
    ld a, l
    cp a, $1C
    jr c, Label319706
    ld c, $05
Label319706
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319713
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;5713

Label319713: ;C6:5713
    xor a
    ret
;5715

checkRedJewelRoomCameraChange: ;C6:5715
    ld c, $01
    ld a, d
    or a
    jr nz, Label319720
    ld a, e
    cp a, $06
    jr nc, Label319722
Label319720
    ld c, $02
Label319722
    ld a, h
    or a
    jr nz, Label319736
    ld a, l
    cp a, $0D
    jr c, Label319736
    ld a, d
    or a
    jr nz, Label319736
    ld a, e
    cp a, $0D
    jr c, Label319736
    ld c, $00
Label319736
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319743
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;5743

Label319743: ;C6:5743
    xor a
    ret
;5745

checkForestCorpseRoomCameraChange: ;C6:5745
    ld c, $00
    ld a, d
    cp a, $FF
    jr nz, Label319759
    ld c, $01
    ld a, h
    or a
    jr z, Label319757
    ld a, l
    cp a, $FF
    jr c, Label319759
Label319757
    ld c, $02
Label319759
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319781
    ld a, c
    ld [wRoomScreen], a
    cp a, $00
    jr nz, Label31977E
    ld a, [wSpriteId]
    cp a, CHRIS
    jr z, Label31977E
    ld a, [wc486]
    or a
    jr nz, Label31977E
    ld a, $08
    ld [wEventId], a
    ld a, $FF
    ld [wc486], a
Label31977E
    ld a, $FF
    ret
;5781

Label319781: ;C6:5781
    xor a
    ret
;5783

checkRoom2ECameraChange: ;C6:5783
    ld c, $00
    ld a, d
    cp a, $FF
    jr nz, Label319791
    ld a, e
    cp a, $EE
    jr nc, Label319791
    ld c, $01
Label319791
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label31979E
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;579E

Label31979E: ;C6:579E
    xor a
    ret
;57A0

checkCorridor2DCameraChange: ;C6:57A0
    ld c, $00
    ld a, d
    cp a, $FF
    jr nz, Label3197AE
    ld a, e
    cp a, $F2
    jr nc, Label3197AE
    ld c, $01
Label3197AE
    ld a, h
    or a
    jr nz, Label3197B7
    ld a, l
    cp a, $04
    jr nc, Label3197B9
Label3197B7
    ld c, $02
Label3197B9
    ld a, h
    cp a, $FF
    jr nz, Label3197C5
    ld a, l
    cp a, $CF
    jr nc, Label3197C5
    ld c, $03
Label3197C5
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label3197D2
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;57D2

Label3197D2: ;C6:57D2
    xor a
    ret
;57D4

checkYawn1RoomCameraChange: ;C6:57D4
    ld c, $01
    ld a, d
    or a
    jr z, Label3197EA
    ld c, $02
    ld a, e
    cp a, $D6
    jr nc, Label3197EA
    ld c, $06
    ld a, e
    cp a, $B8
    jr nc, Label3197EA
    ld c, $04
Label3197EA
    ld a, h
    cp a, $FF
    jr nz, Label3197FF
    ld a, l
    cp a, $FA
    jr nc, Label3197FF
    ld a, d
    or a
    jr nz, Label3197FF
    ld a, e
    cp a, $25
    jr c, Label3197FF
    ld c, $00
Label3197FF
    ld a, h
    cp a, $FF
    jr nz, Label319819
    ld a, l
    cp a, $EE
    jr nc, Label319819
    ld a, d
    cp a, $FF
    jr nz, Label319819
    ld a, e
    cp a, $C8
    jr c, Label319819
    cp a, $F6
    jr nc, Label319819
    ld c, $03
Label319819
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319826
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;5826

Label319826: ;C6:5826
    xor a
    ret
;5828

checkYawn2RoomCameraChange: ;C6:5828
    ld c, $00
    ld a, d
    or a
    jr nz, Label319833
    ld a, e
    cp a, $24
    jr nc, Label319835
Label319833
    ld c, $01
Label319835
    ld a, d
    cp a, $FF
    jr nz, Label319851
    ld a, e
    cp a, $E8
    jr nc, Label319841
    ld c, $02
Label319841
    ld a, e
    cp a, $D8
    jr nc, Label319851
    ld a, h
    or a
    jr nz, Label319851
    ld a, l
    cp a, $17
    jr c, Label319851
    ld c, $03
Label319851
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319878
    ld a, c
    ld [wRoomScreen], a
    cp a, $02
    jr nz, Label319875
    ld a, [wSelectedPlayer]
    or a
    jr z, Label319875
    ld a, [wc4a1]
    or a
    jr nz, Label319875
    ld a, $14
    ld [wEventId], a
    ld a, $FF
    ld [wc4a1], a
Label319875
    ld a, $FF
    ret
;5878

Label319878: ;C6:5878
    xor a
    ret
;587A

checkTombRoomCameraChange: ;C6:587A
    ld c, $01
    ld a, d
    or a
    jr z, Label319889
    ld a, e
    cp a, $F9
    jr c, Label319892
    ld c, $02
    jr Label319892
Label319889
    ld c, $02
    ld a, e
    cp a, $15
    jr c, Label319892
    ld c, $00
Label319892
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label3198CC
    ld a, c
    ld [wRoomScreen], a
    ld a, [wSelectedPlayer]
    or a
    jr z, Label3198C9
    ld a, [wRoomScreen]
    or a
    jr z, Label3198B3
    cp a, $02
    jr z, Label3198AC
Label3198AC
    ld a, $FF
    ld [wc4dc], a
    jr Label3198C9
Label3198B3
    ld a, [wc4dc]
    or a
    jr z, Label3198C9
    ld a, [wPasscodeTrigger]
    or a
    jr nz, Label3198C9
    ld a, $15
    ld [wEventId], a
    ld a, $FF
    ld [wPasscodeTrigger], a
Label3198C9
    ld a, $FF
    ret
;58CC

Label3198CC: ;C6:58CC
    xor a
    ret
;58CE

checkInsectsRoomCameraChange: ;C6:58CE
    ld c, $00
    ld a, d
    or a
    jr z, Label3198D6
    ld c, $01
Label3198D6
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label3198FE
    ld a, c
    ld [wRoomScreen], a
    cp a, $01
    jr nz, Label3198FB
    ld a, [wSpriteId]
    cp a, CHRIS
    jr z, Label3198FB
    ld a, [wc488]
    or a
    jr nz, Label3198FB
    ld a, $0B
    ld [wEventId], a
    ld a, $FF
    ld [wc488], a
Label3198FB
    ld a, $FF
    ret
;58FE

Label3198FE: ;C6:58FE
    xor a
    ret
;5900

checkRoom28CameraChange: ;C6:5900
    ld c, $00
    ld a, h
    or a
    jr nz, Label31990D
    ld a, l
    cp a, $09
    jr c, Label31990D
    ld c, $01
Label31990D
    ld a, d
    or a
    jr nz, Label319916
    ld a, e
    cp a, $08
    jr nc, Label31991E
Label319916
    ld c, $02
    ld a, h
    or a
    jr nz, Label31991E
    ld c, $03
Label31991E
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label31992B
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;592B

Label31992B: ;C6:592B
    xor a
    ret
;592D

checkCorridor27CameraChange: ;C6:592D
    ld c, $00
    ld a, h
    or a
    jr z, Label319938
    ld a, l
    cp a, $F9
    jr c, Label31993A
Label319938
    ld c, $01
Label31993A
    ld a, h
    or a
    jr nz, Label319945
    ld a, l
    cp a, $47
    jr c, Label319945
    ld c, $02
Label319945
    ld a, d
    cp a, $FF
    jr nz, Label31995D
    ld a, e
    cp a, $BC
    jr nc, Label31995D
    ld c, $03
    ld a, h
    cp a, $FF
    jr nz, Label31995D
    ld a, l
    cp a, $EC
    jr nc, Label31995D
    ld c, $04
Label31995D
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label31996A
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;596A

Label31996A: ;C6:596A
    xor a
    ret
;596C

checkLighterBedroomCameraChange: ;C6:596C
    ld c, $00
    ld a, d
    or a
    jr nz, Label319977
    ld a, e
    cp a, $14
    jr nc, Label319979
Label319977
    ld c, $01
Label319979
    ld a, h
    or a
    jr nz, Label319988
    ld a, d
    or a
    jr nz, Label319988
    ld a, e
    cp a, $13
    jr c, Label319988
    ld c, $02
Label319988
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319995
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;5995

Label319995: ;C6:5995
    xor a
    ret
;5997

checkCorridor25CameraChange: ;C6:5997
    ld c, $00
    ld a, h
    cp a, $FF
    jr nz, Label3199BC
    ld a, l
    cp a, $FC
    jr nc, Label3199BC
    ld c, $01
    ld a, d
    cp a, $FF
    jr z, Label3199B1
    ld a, e
    cp a, $31
    jr nc, Label3199BC
    jr Label3199B6
Label3199B1
    ld a, e
    cp a, $E7
    jr c, Label3199BA
Label3199B6
    ld c, $02
    jr Label3199BC
Label3199BA
    ld c, $03
Label3199BC
    ld a, h
    cp a, $FF
    jr nz, Label3199C8
    ld a, l
    cp a, $EE
    jr nc, Label3199C8
    ld c, $04
Label3199C8
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label3199D5
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;59D5

Label3199D5: ;C6:59D5
    xor a
    ret
;59D7

checkCorridor24CameraChange: ;C6:59D7
    ld c, $04
    ld a, h
    or a
    jr z, Label3199E2
    ld a, l
    cp a, $DF
    jr c, Label3199E4
Label3199E2
    ld c, $05
Label3199E4
    ld a, d
    or a
    jr nz, Label3199F8
    ld a, e
    cp a, $40
    jr nc, Label3199EF
    ld c, $01
Label3199EF
    ld a, d
    or a
    jr nz, Label3199F8
    ld a, e
    cp a, $13
    jr nc, Label3199FA
Label3199F8
    ld c, $02
Label3199FA
    ld a, d
    cp a, $FF
    jr nz, Label319A12
    ld a, e
    cp a, $B9
    jr nc, Label319A12
    ld c, $06
    ld a, h
    cp a, $FF
    jr nz, Label319A10
    ld a, l
    cp a, $D7
    jr c, Label319A12
Label319A10
    ld c, $03
Label319A12
    ld a, h
    cp a, $FF
    jr nz, Label319A1E
    ld a, l
    cp a, $C2
    jr nc, Label319A1E
    ld c, $00
Label319A1E
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319A2B
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;5A2B

Label319A2B: ;C6:5A2B
    xor a
    ret
;5A2D

checkArmorsRoomCameraChange: ;C6:5A2D
    ld c, $00
    ld a, h
    cp a, $FF
    jr nz, Label319A3D
    ld a, l
    cp a, $EC
    jr nc, Label319A42
    ld c, $02
    jr Label319A44
Label319A3D
    ld a, l
    cp a, $10
    jr nc, Label319A44
Label319A42
    ld c, $01
Label319A44
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319A51
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;5A51

Label319A51: ;C6:5A51
    xor a
    ret
;5A53

checkCandleRoomCameraChange: ;C6:5A53
    ld c, $00
    ld a, h
    cp a, $FF
    jr nz, Label319A5F
    ld a, l
    cp a, $F7
    jr c, Label319A61
Label319A5F
    ld c, $01
Label319A61
    ld a, d
    or a
    jr nz, Label319A6C
    ld a, e
    cp a, $2B
    jr c, Label319A6C
    ld c, $02
Label319A6C
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319A79
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;5A79

Label319A79: ;C6:5A79
    xor a
    ret
;5A7B

checkCorridor21CameraChange: ;C6:5A7B
    ld c, $00
    ld a, h
    cp a, $FF
    jr nz, Label319A8B
    ld a, l
    cp a, $F6
    jr c, Label319A92
Label319A87
    ld c, $01
    jr Label319A92
Label319A8B
    ld a, l
    cp a, $21
    jr c, Label319A87
    ld c, $02
Label319A92
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319A9F
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;5A9F

Label319A9F: ;C6:5A9F
    xor a
    ret
;5AA1

checkCorridor20CameraChange: ;C6:5AA1
    ld c, $00
    ld a, h
    or a
    jr nz, Label319AAC
    ld a, l
    cp a, $37
    jr nc, Label319AD3
Label319AAC
    ld c, $04
    ld a, d
    or a
    jr nz, Label319AB7
    ld a, e
    cp a, $11
    jr nc, Label319AB9
Label319AB7
    ld c, $05
Label319AB9
    ld a, d
    cp a, $FF
    jr nz, Label319AC5
    ld a, e
    cp a, $CE
    jr nc, Label319AC5
    ld c, $02
Label319AC5
    ld a, h
    cp a, $FF
    jr nz, Label319AE6
    ld a, l
    cp a, $EF
    jr nc, Label319AE6
    ld c, $06
    jr Label319AE6
Label319AD3
    ld a, d
    or a
    jr z, Label319AE4
    ld a, e
    cp a, $D9
    jr nc, Label319AE4
    cp a, $A7
    jr c, Label319AE6
    ld c, $01
    jr Label319AE6
Label319AE4
    ld c, $03
Label319AE6
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319AF3
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;5AF3

Label319AF3: ;C6:5AF3
    xor a
    ret
;5AF5

checkChimney2FMapRoomCameraChange: ;C6:5AF5
    ld c, $00
    ld a, d
    cp a, $FF
    jr nz, Label319B0E
    ld c, $01
    ld a, h
    or a
    jr z, Label319B07
    ld a, l
    cp a, $F7
    jr c, Label319B0E
Label319B07
    ld a, e
    cp a, $F0
    jr nc, Label319B0E
    ld c, $02
Label319B0E
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319B1B
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;5B1B

Label319B1B: ;C6:5B1B
    xor a
    ret
;5B1D

checkRichardRoomCameraChange: ;C6:5B1D
    ld c, $00
    ld a, h
    or a
    jr nz, Label319B50
    ld c, $01
    ld a, d
    or a
    jr nz, Label319B2E
    ld a, e
    cp a, $28
    jr nc, Label319B30
Label319B2E
    ld c, $02
Label319B30
    ld a, h
    or a
    jr nz, Label319B44
    ld a, l
    cp a, $2F
    jr c, Label319B44
    ld a, d
    or a
    jr nz, Label319B42
    ld a, e
    cp a, $14
    jr nc, Label319B44
Label319B42
    ld c, $03
Label319B44
    ld a, d
    cp a, $FF
    jr nz, Label319B50
    ld a, e
    cp a, $E4
    jr nc, Label319B50
    ld c, $04
Label319B50
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319B7B
    ld a, c
    ld [wRoomScreen], a
    cp a, $01
    jr nz, Label319B78
    ld a, [wSpriteId]
    cp a, CHRIS
    jr z, Label319B78
    ld a, [wc489]
    or a
    jr nz, Label319B7D
    ld a, $0C
    ld [wEventId], a
    ld a, $FF
    ld [wc489], a
    ld [wSafeRoomSerum], a
Label319B78
    ld a, $FF
    ret
Label319B7B: ;C6:5B7B
    xor a
    ret
Label319B7D: ;C6:5B7D
    ld a, [wc48a]
    or a
    jr nz, Label319B78
    ld hl, ItemIdSlot1
    ld b, $08
Label319B88
    ld a, [hl]
    cp a, $34
    jr z, Label319B93
    inc hl
    dec b
    jr nz, Label319B88
    jr Label319B78
Label319B93
    ld [hl], $00
    ld a, $0D
    ld [wEventId], a
    ld a, $FF
    ld [wc48a], a
    jr Label319B78
checkMainHall2FCameraChange:
    ld c, $03
    ld a, h
    or a
    jr nz, Label319BB0
    ld a, l
    cp a, $47
    jr c, Label319BB5
    ld c, $01
    jr Label319BB7
Label319BB0
    ld a, l
    cp a, $BB
    jr c, Label319BB7
Label319BB5
    ld c, $00
Label319BB7
    ld a, d
    cp a, $FF
    jr nz, Label319BC9
    ld a, e
    cp a, $F0
    jr nc, Label319BC9
    ld c, $02
    ld a, h
    or a
    jr z, Label319BC9
    ld c, $04
Label319BC9
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319BD6
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;5BD6

Label319BD6: ;C6:5BD6
    xor a
    ret
;5BD8

checkDinningRoom2FCameraChange: ;C6:5BD8
    ld c, $02
    ld a, h
    or a
    jr nz, Label319BE5
    ld a, l
    cp a, $58
    jr nc, Label319BF8
    jr Label319BEE
Label319BE5
    ld a, l
    cp a, $BA
    jr c, Label319BF2
    cp a, $E2
    jr c, Label319BF6
Label319BEE
    ld c, $01
    jr Label319BF8
Label319BF2
    ld c, $00
    jr Label319BF8
Label319BF6
    ld c, $05
Label319BF8
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319C05
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;5C05

Label319C05: ;C6:5C05
    xor a
    ret
;5C07

checkCorridor1ACameraChange: ;C6:5C07
    ld c, $05
    ld a, h
    or a
    jr z, Label319C1A
    ld a, l
    cp a, $E5
    jr nc, Label319C1F
    cp a, $B1
    jr c, Label319C25
    ld c, $04
    jr Label319C25
Label319C1A
    ld a, l
    cp a, $0F
    jr nc, Label319C23
Label319C1F
    ld c, $01
    jr Label319C25
Label319C23
    ld c, $00
Label319C25
    ld a, d
    or a
    jr nz, Label319C2E
    ld a, e
    cp a, $19
    jr nc, Label319C3B
Label319C2E
    ld c, $02
    ld a, h
    or a
    jr nz, Label319C3B
    ld a, l
    cp a, $09
    jr c, Label319C3B
    ld c, $03
Label319C3B
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319C48
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;5C48

Label319C48: ;C6:5C48
    xor a
    ret
;5C4A

checkCorridor1BCameraChange: ;C6:5C4A
    ld c, $05
    ld a, h
    or a
    jr nz, Label319C55
    ld a, l
    cp a, $4A
    jr nc, Label319C57
Label319C55
    ld c, $02
Label319C57
    ld a, h
    cp a, $FF
    jr nz, Label319C63
    ld a, l
    cp a, $FA
    jr nc, Label319C63
    ld c, $03
Label319C63
    ld a, h
    cp a, $FF
    jr nz, Label319C6F
    ld a, l
    cp a, $A0
    jr nc, Label319C6F
    ld c, $04
Label319C6F
    ld a, d
    or a
    jr nz, Label319C78
    ld a, e
    cp a, $16
    jr nc, Label319C85
Label319C78
    ld c, $01
    ld a, h
    or a
    jr nz, Label319C85
    ld a, l
    cp a, $37
    jr c, Label319C85
    ld c, $00
Label319C85
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319C92
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;5C92

Label319C92: ;C6:5C92
    xor a
    ret
;5C94

checkFallingCielingRoomCameraChange: ;C6:5C94
    ld c, $02
    ld a, d
    or a
    jr nz, Label319C9C
    ld c, $00
Label319C9C
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319CCF
    ld a, c
    ld [wRoomScreen], a
    ld a, [wSelectedPlayer]
    or a
    jr z, Label319CCC
    ld a, [wc413]
    or a
    jr nz, Label319CCC
    ld a, [wc4c8]
    or a
    jr nz, Label319CCC
    ld a, [wRoomScreen]
    cp a, $02
    jr nz, Label319CCC
    ld a, $07
    ld [wEventId], a
    ld a, $FF
    ld [wc4c8], a
    ld [wc413], a
Label319CCC
    ld a, $FF
    ret
;5CCF

Label319CCF: ;C6:5CCF
    xor a
    ret
;5CD1

checkShotgunRoomCameraChange: ;C6:5CD1
    ld c, $00
    ld a, d
    or a
    jr nz, Label319CD9
    ld c, $01
Label319CD9
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319D02
    ld a, c
    ld [wRoomScreen], a
    ld a, [wBrokenShotgunPlaced]
    or a
    jr nz, Label319CFF
    ld a, [wLivingRoomShotgunPlaced]
    or a
    jr nz, Label319CFF
    ld a, [wSelectedPlayer]
    or a
    jr z, Label319CFB
    xor a
    ld [wc413], a
    jr Label319CFF
Label319CFB
    xor a
    ld [wc41f], a
Label319CFF
    ld a, $FF
    ret
;5D02

Label319D02: ;C6:5D02
    xor a
    ret
;5D04

checkBigMirrorRoomCameraChange: ;C6:5D04
    ld c, $00
    ld a, d
    cp a, $FF
    jr nz, Label319D0D
    ld c, $01
Label319D0D
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319D1A
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;5D1A

Label319D1A: ;C6:5D1A
    xor a
    ret
;5D1C

checkSquareCrankRoomCameraChange: ;C6:5D1C
    ld c, $00
    ld a, d
    cp a, $FF
    jr nz, Label319D25
    ld c, $01
Label319D25
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319D32
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;5D32

Label319D32: ;C6:5D32
    xor a
    ret
;5D34

checkClosetRoomCameraChange: ;C6:5D34
    ld c, $00
    ld a, h
    cp a, $FF
    jr nz, Label319D46
    ld a, l
    cp a, $EC
    jr c, Label319D44
    ld c, $01
    jr Label319D46
Label319D44
    ld c, $02
Label319D46
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319D53
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;5D53

Label319D53: ;C6:5D53
    xor a
    ret
;5D55

checkCrestPanelCorridorCameraChange: ;C6:5D55
    ld c, $00
    ld a, d
    cp a, $FF
    jr z, Label319D61
    ld a, e
    cp a, $40
    jr nc, Label319D63
Label319D61
    ld c, $01
Label319D63
    ld a, d
    cp a, $FF
    jr nz, Label319D6F
    ld a, e
    cp a, $F8
    jr nc, Label319D6F
    ld c, $02
Label319D6F
    ld a, h
    cp a, $FF
    jr nz, Label319D79
    ld a, l
    cp a, $F3
    jr c, Label319D7B
Label319D79
    ld c, $03
Label319D7B
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319DAB
    ld a, c
    ld [wRoomScreen], a
    ld a, [wc4a0]
    or a
    jr z, Label319DA8
    ld a, [wc4b5]
    or a
    jr nz, Label319DA8
    ld a, [wSelectedPlayer]
    or a
    jr nz, Label319DA8
    ld a, [wRoomScreen]
    cp a, $01
    jr nz, Label319DA8
    ld a, $0D
    ld [wEventId], a
    ld a, $FF
    ld [wc4b5], a
Label319DA8
    ld a, $FF
    ret
;5DAB

Label319DAB: ;C6:5DAB
    xor a
    ret
;5DAD

checkCorridor12CameraChange: ;C6:5DAD
    ld c, $00
    ld a, d
    or a
    jr nz, Label319DBA
    ld a, e
    cp a, $29
    jr c, Label319DBA
    ld c, $01
Label319DBA
    ld a, h
    or a
    jr nz, Label319DC7
    ld a, l
    cp a, $38
    jr c, Label319DC7
    ld c, $02
    jr Label319DE0
Label319DC7
    ld a, h
    or a
    jr nz, Label319DD4
    ld a, l
    cp a, $1D
    jr c, Label319DDE
    ld c, $03
    jr Label319DE0
Label319DD4
    ld a, h
    cp a, $FF
    jr nz, Label319DE0
    ld a, l
    cp a, $F9
    jr c, Label319DE0
Label319DDE
    ld c, $02
Label319DE0
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319DED
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;5DED

Label319DED: ;C6:5DED
    xor a
    ret
;5DEF

checkBathroomCameraChange: ;C6:5DEF
    ld c, $00
    ld a, d
    or a
    jr nz, Label319DFA
    ld a, e
    cp a, $10
    jr nc, Label319DFC
Label319DFA
    ld c, $01
Label319DFC
    ld a, h
    or a
    jr nz, Label319E07
    ld a, l
    cp a, $13
    jr c, Label319E07
    ld c, $02
Label319E07
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319E14
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;5E14

Label319E14: ;C6:5E14
    xor a
    ret
;5E16

checkRoom10CameraChange: ;C6:5E16
    ld c, $02
    ld a, h
    cp a, $FF
    jr nz, Label319E2F
    ld a, l
    cp a, $D8
    jr nc, Label319E2F
    ld a, d
    or a
    jr nz, Label319E3E
    ld a, e
    cp a, $3A
    jr c, Label319E3E
    ld c, $04
    jr Label319E3E
Label319E2F
    ld a, d
    or a
    jr nz, Label319E3C
    ld a, e
    cp a, $40
    jr c, Label319E3C
    ld c, $00
    jr Label319E3E
Label319E3C
    ld c, $01
Label319E3E
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319E4B
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;5E4B

Label319E4B: ;C6:5E4B
    xor a
    ret
;5E4D

checkCorridor0FCameraChange: ;C6:5E4D
    ld c, $00
    ld a, h
    or a
    jr z, Label319E6E
    ld c, $02
    ld a, d
    cp a, $FF
    jr nz, Label319E5F
    ld a, e
    cp a, $F8
    jr c, Label319E7E
Label319E5F
    ld c, $01
    ld a, d
    or a
    jr nz, Label319E7E
    ld a, e
    cp a, $20
    jr c, Label319E7E
    ld c, $00
    jr Label319E7E
Label319E6E
    ld c, $03
    ld a, d
    cp a, $FF
    jr nz, Label319E7A
    ld a, e
    cp a, $F8
    jr c, Label319E7E
Label319E7A
    ld c, $04
    jr Label319E7E
Label319E7E
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319E8B
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;5E8B

Label319E8B: ;C6:5E8B
    xor a
    ret
;5E8D

checkZombieClosetBedroomCameraChange: ;C6:5E8D
    ld c, $00
    ld a, h
    or a
    jr nz, Label319E9C
    ld c, $01
    ld a, l
    cp a, $28
    jr c, Label319E9C
    ld c, $02
Label319E9C
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319EA9
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;5EA9

Label319EA9: ;C6:5EA9
    xor a
    ret
;5EAB

checkCorridor0DCameraChange: ;C6:5EAB
    ld c, $02
    ld a, d
    cp a, $FF
    jr nz, Label319EB9
    ld a, e
    cp a, $F6
    jr nc, Label319EB9
    ld c, $03
Label319EB9
    ld a, h
    or a
    jr nz, Label319ECC
    ld a, l
    cp a, $46
    jr nc, Label319ECA
    cp a, $1B
    jr c, Label319ECC
    ld c, $01
    jr Label319ECC
Label319ECA
    ld c, $00
Label319ECC
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319ED9
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;5ED9

Label319ED9: ;C6:5ED9
    xor a
    ret
;5EDB

checkCorridor0CCameraChange: ;C6:5EDB
    ld c, $01
    ld a, h
    cp a, $FF
    jr nz, Label319EE9
    ld a, l
    cp a, $F7
    jr nc, Label319EE9
    ld c, $00
Label319EE9
    ld a, d
    or a
    jr nz, Label319EF1
    cp a, $39
    jr nc, Label319EFC
Label319EF1
    ld a, h
    or a
    jr nz, Label319EFC
    ld a, l
    cp a, $2F
    jr c, Label319EFC
    ld c, $02
Label319EFC
    ld a, d
    cp a, $FF
    jr nz, Label319F08
    ld a, e
    cp a, $E4
    jr nc, Label319F08
    ld c, $03
Label319F08
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319F15
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;5F15

Label319F15: ;C6:5F15
    xor a
    ret
;5F17

checkCorridor0BCameraChange: ;C6:5F17
    ld c, $00
    ld a, h
    or a
    jr nz, Label319F28
    ld a, l
    cp a, $26
    jr c, Label319F26
    ld c, $02
    jr Label319F28
Label319F26
    ld c, $01
Label319F28
    ld a, d
    or a
    jr nz, Label319F3B
    ld a, e
    cp a, $20
    jr nc, Label319F39
    cp a, $0D
    jr c, Label319F3B
    ld c, $03
    jr Label319F3B
Label319F39
    ld c, $04
Label319F3B
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319F6B
    ld a, c
    ld [wRoomScreen], a
    ld a, [wc4a0]
    or a
    jr z, Label319F68
    ld a, [wc4b6]
    or a
    jr nz, Label319F68
    ld a, [wSelectedPlayer]
    or a
    jr nz, Label319F68
    ld a, [wRoomScreen]
    cp a, $02
    jr nz, Label319F68
    ld a, $0E
    ld [wEventId], a
    ld a, $FF
    ld [wc4b6], a
Label319F68
    ld a, $FF
    ret
;5F6B

Label319F6B: ;C6:5F6B
    xor a
    ret
;5F6D

checkCorridor0ACameraChange: ;C6:5F6D
    ld c, $01
    ld a, h
    cp a, $FF
    jr nz, Label319F84
    ld a, l
    cp a, $B4
    jr nc, Label319F84
    ld a, d
    or a
    jr nz, Label319F84
    ld a, e
    cp a, $8D
    jr c, Label319F84
    ld c, $00
Label319F84
    ld a, d
    cp a, $FF
    jr z, Label319F8E
    ld a, e
    cp a, $74
    jr nc, Label319F90
Label319F8E
    ld c, $02
Label319F90
    ld a, d
    cp a, $FF
    jr z, Label319F9A
    ld a, e
    cp a, $60
    jr nc, Label319F9C
Label319F9A
    ld c, $03
Label319F9C
    ld a, h
    or a
    jr nz, Label319FA7
    ld a, l
    cp a, $33
    jr c, Label319FA7
    ld c, $04
Label319FA7
    ld a, d
    cp a, $FF
    jr nz, Label319FB3
    ld a, e
    cp a, $F0
    jr nc, Label319FB3
    ld c, $05
Label319FB3
    ld a, h
    cp a, $FF
    jr z, Label319FBD
    ld a, l
    cp a, $14
    jr nc, Label319FC9
Label319FBD
    ld a, d
    cp a, $FF
    jr nz, Label319FC9
    ld a, e
    cp a, $E4
    jr nc, Label319FC9
    ld c, $06
Label319FC9
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319FD6
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;5FD6

Label319FD6: ;C6:5FD6
    xor a
    ret
;5FD8

checkBrokenShotgunRoomCameraChange: ;C6:5FD8
    ld c, $00
    ld a, d
    or a
    jr nz, Label319FE5
    ld a, e
    cp a, $11
    jr c, Label319FE5
    ld c, $02
Label319FE5
    ld a, d
    cp a, $FF
    jr nz, Label319FEC
    ld c, $01
Label319FEC
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label319FF9
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;5FF9

Label319FF9: ;C6:5FF9
    xor a
    ret
;5FFB

checkCorridor08CameraChange: ;C6:5FFB
    ld c, $00
    ld a, h
    or a
    jr nz, Label31A006
    ld a, l
    cp a, $4E
    jr nc, Label31A00D
Label31A006
    ld a, d
    cp a, $FF
    jr nz, Label31A00D
    ld c, $01
Label31A00D
    ld a, h
    cp a, $FF
    jr nz, Label31A025
    ld a, d
    cp a, $FF
    jr nz, Label31A01E
    ld a, e
    cp a, $C3
    jr nc, Label31A023
    jr Label31A025
Label31A01E
    ld a, e
    cp a, $40
    jr nc, Label31A025
Label31A023
    ld c, $02
Label31A025
    ld a, d
    or a
    jr nz, Label31A030
    ld a, e
    cp a, $3F
    jr c, Label31A030
    ld c, $03
Label31A030
    ld a, h
    or a
    jr nz, Label31A03A
    ld a, d
    or a
    jr nz, Label31A03A
    ld c, $04
Label31A03A
    ld a, h
    or a
    jr nz, Label31A04E
    ld a, l
    cp a, $39
    jr c, Label31A04E
    ld a, d
    or a
    jr nz, Label31A04E
    ld a, e
    cp a, $59
    jr c, Label31A04E
    ld c, $05
Label31A04E
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label31A07E
    ld a, c
    ld [wRoomScreen], a
    ld a, [wc4a0]
    or a
    jr z, Label31A07B
    ld a, [wc4b7]
    or a
    jr nz, Label31A07B
    ld a, [wSelectedPlayer]
    or a
    jr nz, Label31A07B
    ld a, [wRoomScreen]
    cp a, $05
    jr nz, Label31A07B
    ld a, $0F
    ld [wEventId], a
    ld a, $FF
    ld [wc4b7], a
Label31A07B
    ld a, $FF
    ret
;607E

Label31A07E: ;C6:607E
    xor a
    ret
;6080

checkMansionPlantRoomCameraChange: ;C6:6080
    ld c, $01
    ld a, h
    cp a, $FF
    jr nz, Label31A092
    ld a, l
    cp a, $D0
    jr nc, Label31A092
    ld a, d
    or a
    jr nz, Label31A092
    ld c, $00
Label31A092
    ld a, h
    cp a, $FF
    jr nz, Label31A09C
    ld a, l
    cp a, $F4
    jr c, Label31A09E
Label31A09C
    ld c, $02
Label31A09E
    ld a, h
    or a
    jr nz, Label31A0A9
    ld a, l
    cp a, $15
    jr c, Label31A0A9
    ld c, $03
Label31A0A9
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label31A0B6
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;60B6

Label31A0B6: ;C6:60B6
    xor a
    ret
;60B8

checkSafeRoomCameraChange: ;C6:60B8
    ld c, $00
    ld a, d
    cp a, $FF
    jr nz, Label31A0C6
    ld a, e
    cp a, $F8
    jr nc, Label31A0C6
    ld c, $01
Label31A0C6
    ld a, d
    cp a, $FF
    jr nz, Label31A0DC
    ld a, e
    cp a, $F8
    jr nc, Label31A0DC
    ld a, h
    cp a, $FF
    jr nz, Label31A0DC
    ld a, l
    cp a, $F0
    jr nc, Label31A0DC
    ld c, $05
Label31A0DC
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label31A106
    ld a, c
    ld [wRoomScreen], a
    or a
    jr nz, Label31A103
    ld a, [wSelectedPlayer]
    or a
    jr z, Label31A0F1
    jr Label31A103
Label31A0F1
    ld a, [wc482]
    or a
    jr nz, Label31A103
    ld a, $04
    ld [wEventId], a
    ld a, $FF
    ld [wc482], a
    jr Label31A103
Label31A103
    ld a, $FF
    ret
;6106

Label31A106: ;C6:6106
    xor a
    ret
;6108

checkPianoRoomCameraChange: ;C6:6108
    ld c, $01
    ld a, h
    or a
    jr nz, Label31A121
    ld a, l
    cp a, $19
    jr c, Label31A121
    ld a, d
    cp a, $FF
    jr nz, Label31A121
    ld a, e
    cp a, $E0
    jr nc, Label31A121
    ld c, $00
    jr Label31A14F
Label31A121
    ld a, h
    cp a, $FF
    jr nz, Label31A137
    ld a, l
    cp a, $E0
    jr nc, Label31A137
    ld a, d
    cp a, $FF
    jr nz, Label31A137
    ld a, e
    cp a, $C0
    jr nc, Label31A137
    ld c, $02
Label31A137
    ld a, h
    cp a, $FF
    jr nz, Label31A143
    ld a, l
    cp a, $C0
    jr nc, Label31A143
    ld c, $03
Label31A143
    ld a, h
    cp a, $FF
    jr nz, Label31A14F
    ld a, l
    cp a, $A0
    jr nc, Label31A14F
    ld c, $04
Label31A14F
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label31A17C
    ld a, c
    ld [wRoomScreen], a
    or a
    jr nz, Label31A179
    ld a, [wSpriteId]
    cp a, CHRIS
    jr nz, Label31A179
    ld a, [wc486]
    or a
    jr z, Label31A179
    ld a, [wPianoRoomSecretDoorTrigger]
    or a
    jr nz, Label31A179
    ld a, $09
    ld [wEventId], a
    ld a, $FF
    ld [wPianoRoomSecretDoorTrigger], a
Label31A179
    ld a, $FF
    ret
;617C

Label31A17C: ;C6:617C
    xor a
    ret
;617E

checkCorridor05CameraChange: ;C6:617E
    ld c, $04
    ld a, d
    cp a, $FF
    jr z, Label31A18A
    ld a, e
    cp a, $0C
    jr nc, Label31A1AD
Label31A18A
    ld c, $01
    ld a, h
    cp a, $FF
    jr nz, Label31A198
    ld a, l
    cp a, $9C
    jr c, Label31A1A9
    jr Label31A1A5
Label31A198
    ld a, l
    cp a, $10
    jr c, Label31A1A5
    cp a, $48
    jr nc, Label31A1AD
    ld c, $00
    jr Label31A1AD
Label31A1A5
    ld c, $02
    jr Label31A1AD
Label31A1A9
    ld c, $03
    jr Label31A1AD
Label31A1AD
    ld a, [wRoomScreen]
    cp a, c
    jr z, Label31A1F1
    ld a, c
    ld [wRoomScreen], a
    cp a, $04
    jr nz, Label31A1EE
    ld a, [wSpriteId]
    cp a, CHRIS
    jr z, Label31A1D4
    ld a, [wEventFirstZombieScn]
    or a
    jr nz, Label31A1EE
    ld a, $88
    ld [wEventId], a
    ld a, $FF
    ld [wEventFirstZombieScn], a
    jr Label31A1EE
Label31A1D4
    ld a, [wEventFirstZombieScn]
    or a
    jr nz, Label31A1EE
    ld a, $88
    ld [wEventId], a
    ld a, $FF
    ld [wEventFirstZombieScn], a
    ld a, $FF
    ld [wEventMsgAtMainHallDoor], a
    ld a, $FF
    ld [wTriggerHandgunMainHall], a
Label31A1EE
    ld a, $FF
    ret
;61F1

Label31A1F1: ;C6:61F1
    xor a
    ret
;61F3

checkMapStatueRoomCameraChange: ;C6:61F3
    ld c, $00
    ld a, d
    cp a, $FF
    jr nz, Label31A201
    ld a, e
    cp a, $F0
    jr c, Label31A244
    jr Label31A227
Label31A201
    ld a, d
    or a
    jr nz, Label31A244
    ld a, e
    cp a, $07
    jr c, Label31A227
    cp a, $48
    jr c, Label31A22B
    cp a, $65
    jr nc, Label31A22F
    ld a, h
    cp a, $FF
    jr z, Label31A223
    or a
    jr nz, Label31A21F
    ld a, l
    cp a, $31
    jr c, Label31A223
Label31A21F
    ld c, $05
    jr Label31A244
Label31A223
    ld c, $07
    jr Label31A244
Label31A227
    ld c, $01
    jr Label31A244
Label31A22B
    ld c, $02
    jr Label31A244
Label31A22F
    ld a, h
    cp a, $FF
    jr z, Label31A240
    or a
    jr nz, Label31A23C
    ld a, l
    cp a, $31
    jr c, Label31A240
Label31A23C
    ld c, $04
    jr Label31A244
Label31A240
    ld c, $03
    jr Label31A244
Label31A244
    ld a, [wRoomScreen]
    cp a, c
    jp z, Label31A252
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;6252

Label31A252: ;C6:6252
    xor a
    ret
;6254

checkCorridor03CameraChange: ;C6:6254
    ld c, $00
    ld a, h
    cp a, $FF
    jr nz, Label31A277
    ld a, l
    cp a, $A4
    jr nc, Label31A277
    ld a, d
    cp a, $FF
    jr nz, Label31A26C
    ld a, e
    cp a, $A0
    jr c, Label31A277
    jr Label31A275
Label31A26C
    ld a, d
    or a
    jr nz, Label31A277
    ld a, e
    cp a, $18
    jr nc, Label31A277
Label31A275
    ld c, $01
Label31A277
    ld a, h
    cp a, $FF
    jr nz, Label31A281
    ld a, l
    cp a, $A4
    jr c, Label31A28C
Label31A281
    ld a, d
    or a
    jr nz, Label31A28C
    ld a, e
    cp a, $18
    jr nc, Label31A28C
    ld c, $02
Label31A28C
    ld a, h
    cp a, $FF
    jr nz, Label31A2A2
    ld a, l
    cp a, $F5
    jr nc, Label31A2A2
    ld a, d
    cp a, $FF
    jr nz, Label31A2A2
    ld a, e
    cp a, $AF
    jr nc, Label31A2A2
    ld c, $04
Label31A2A2
    ld a, h
    cp a, $FF
    jr nz, Label31A2B8
    ld a, l
    cp a, $BD
    jr nc, Label31A2B8
    ld a, d
    cp a, $FF
    jr nz, Label31A2B8
    ld a, e
    cp a, $AF
    jr nc, Label31A2B8
    ld c, $03
Label31A2B8
    ld a, h
    cp a, $FF
    jr nz, Label31A2C2
    ld a, l
    cp a, $F4
    jr c, Label31A2C4
Label31A2C2
    ld c, $05
Label31A2C4
    ld a, h
    or a
    jr nz, Label31A2D9
    ld a, l
    cp a, $60
    jr c, Label31A2D9
    ld a, d
    cp a, $FF
    jr nz, Label31A2D7
    ld a, e
    cp a, $B0
    jr c, Label31A2D9
Label31A2D7
    ld c, $06
Label31A2D9
    ld a, [wRoomScreen]
    cp a, c
    jp z, Label31A2E7
    ld a, c
    ld [wRoomScreen], a
    ld a, $FF
    ret
;62E7

Label31A2E7: ;C6:62E7
    xor a
    ret
;62E9

checkDinningRoom1FCameraChange: ;C6:62E9
    ld c, $00
    ld a, h
    cp a, $FF
    jr nz, Label31A2F5
    ld a, l
    cp a, $C9
    jr c, Label31A2F7
Label31A2F5
    ld c, $01
Label31A2F7
    ld a, h
    or a
    jr nz, Label31A302
    ld a, l
    cp a, $20
    jr c, Label31A302
    ld c, $02
Label31A302
    ld a, d
    or a
    jr nz, Label31A322
    ld a, e
    cp a, $19
    jr c, Label31A322
    ld a, h
    cp a, $FF
    jr nz, Label31A317
    ld a, l
    cp a, $EC
    jr c, Label31A322
    jr Label31A320
Label31A317
    ld a, h
    or a
    jr nz, Label31A322
    ld a, l
    cp a, $1C
    jr nc, Label31A322
Label31A320
    ld c, $05
Label31A322
    ld a, d
    cp a, $FF
    jr nz, Label31A343
    ld a, e
    cp a, $E8
    jr nc, Label31A343
    ld a, h
    cp a, $FF
    jr nz, Label31A338
    ld a, l
    cp a, $EC
    jr c, Label31A343
    jr Label31A341
Label31A338
    ld a, h
    or a
    jr nz, Label31A343
    ld a, l
    cp a, $40
    jr nc, Label31A343
Label31A341
    ld c, $04
Label31A343
    ld a, h
    or a
    jr nz, Label31A363
    ld a, l
    cp a, $69
    jr c, Label31A363
    ld a, d
    cp a, $FF
    jr nz, Label31A358
    ld a, e
    cp a, $F0
    jr c, Label31A363
    jr Label31A361
Label31A358
    ld a, d
    or a
    jr nz, Label31A363
    ld a, e
    cp a, $10
    jr nc, Label31A363
Label31A361
    ld c, $03
Label31A363
    ld a, [wRoomScreen]
    cp a, c
    jp z, Label31A3D3
    ld a, c
    ld [wRoomScreen], a
    ld a, [wSpriteId]
    cp a, JILL
    jr z, Label31A378
    jp Label31A3D0
Label31A378
    ld a, [wRoomScreen]
    or a
    jr z, Label31A384
    cp a, $02
    jr z, Label31A39A
    jr Label31A3D0
Label31A384
    ld a, [wEventFirstDinningRoomScn]
    or a
    jr nz, Label31A3D0
    ld a, $02
    ld [wEventId], a
    ld a, $FF
    ld [wEventFirstDinningRoomScn], a
    xor a
    ld [wEventMsgAtMainHallDoor], a
    jr Label31A3D0
Label31A39A
    ld a, [wc482]
    or a
    jr nz, Label31A3AC
    ld a, $03
    ld [wEventId], a
    ld a, $FF
    ld [wc482], a
    jr Label31A3D0
Label31A3AC
    ld a, [wEventFirstZombieScn]
    or a
    jr z, Label31A3D0
    ld a, [wc483]
    or a
    jr nz, Label31A3D0
    ld a, $04
    ld [wEventId], a
    ld a, $FF
    ld [wc483], a
    xor a
    ld [wBlockDoorToFirstZombie], a
    ld [wc604], a
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
;hl: pos x
;de: pos y
;c: screen id
    ld a, h
    cp a, $80
    jr c, Label31A3DE ;jump if xpos if positive
    ld c, $01
    jr Label31A3E0
Label31A3DE
    ld c, $06
Label31A3E0
    ld a, d
    cp a, $FF
    jr c, Label31A402
    ld a, e
    cp a, $A0
    jr nc, Label31A402
    ld a, h
    cp a, $FF
    jr z, Label31A3F9
    or a ;$00
    jr nz, Label31A402
    ld a, l
    cp a, $20
    jr nc, Label31A402
    jr Label31A3FE
Label31A3F9
    ld a, l
    cp a, $E0
    jr c, Label31A402
Label31A3FE
    ld c, $00
    jr Label31A474
Label31A402
    ld a, d
    or a ;$00
    jr nz, Label31A418
    ld a, e
    cp a, $58
    jr c, Label31A418
    ld a, h
    cp a, $80
    jr nc, Label31A414
    ld c, $04
    jr Label31A474
Label31A414
    ld c, $03
    jr Label31A474
Label31A418
    ld a, d
    cp a, $FF
    jr nz, Label31A422
    ld a, e
    cp a, $D0
    jr c, Label31A430
Label31A422
    ld a, h
    cp a, $FF
    jr nz, Label31A430
    ld a, l
    cp a, $E0
    jr nc, Label31A430
    ld c, $02
    jr Label31A474
Label31A430
    ld a, d
    cp a, $FF
    jr nz, Label31A43A
    ld a, e
    cp a, $D4
    jr c, Label31A447
Label31A43A
    ld a, h
    or a
    jr nz, Label31A447
    ld a, l
    cp a, $20
    jr c, Label31A447
    ld c, $05
    jr Label31A474
Label31A447
    ld a, c
    cp a, $01
    jr nz, Label31A45E
    ld a, h
    cp a, $FF
    jr nz, Label31A45E
    ld a, l
    cp a, $E0
    jr c, Label31A45E
    ld a, [wRoomScreen]
    cp a, $04
    jp z, Label31A4DF
Label31A45E
    ld a, c
    cp a, $06
    jr nz, Label31A474
    ld a, h
    or a
    jr nz, Label31A474
    ld a, l
    cp a, $20
    jr nc, Label31A474
    ld a, [wRoomScreen]
    cp a, $01
    jp z, Label31A4DF
Label31A474
    ld a, [wSpriteId]
    cp a, CHRIS
    jr nz, Label31A487
    xor a
    ld a, [wEventBackToMainHallJill]
    or a
    jr z, Label31A487
    ld a, $FF
    ld [wc486], a
Label31A487
    ld a, [wRoomScreen]
    cp a, c
    jp z, Label31A4DF
    ld a, c
    ld [wRoomScreen], a
    cp a, $05
    jr nz, Label31A4DC
;check event when back to main hall before first zombie scene
    ld a, [wSpriteId]
    cp a, CHRIS ;$92
    jr z, Label31A4BB
	;if jill
    ld a, [wEventFirstZombieScn]
    or a
    jr z, Label31A4DC
    ld a, [wEventBackToMainHallJill]
    or a
    jr nz, Label31A4DC
    ld a, $05
    ld [wEventId], a
    ld a, $FF
    ld [wEventBackToMainHallJill], a
    ld [wEventMsgAtMainHallDoor], a
    ld [wBlockDoorToFirstZombie], a
    jr Label31A4DC
Label31A4BB
    ld a, [wEventFirstZombieScn]
    or a
    jr nz, Label31A4CC
    ld a, $02
    ld [wEventId], a
    xor a
    ld [wEventMsgAtMainHallDoor], a
    jr Label31A4DC
Label31A4CC
    ld a, [wEventFirstDinningRoomScn]
    or a
    jr nz, Label31A4DC
    ld a, $03
    ld [wEventId], a
    ld a, $FF
    ld [wEventFirstDinningRoomScn], a
Label31A4DC
    ld a, $FF
    ret
Label31A4DF: ;C6:64DF
    xor a
    ret
;64E1

div8SignedWordC6: ;C6:64E1
    ld a, d
    cp a, $80
    jr c, Label31A4F9
    call reverseWordSignC6
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    call reverseWordSignC6
    ret
Label31A4F9: ;C6:64F9
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    ret
;6506

multiply8SignedWordC6: ;C6:6506
    ld a, d
    cp a, $80
    jr c, Label31A51B
    call reverseWordSignC6
    push hl
    push de
    pop hl
    add hl, hl
    add hl, hl
    add hl, hl
    push hl
    pop de
    pop hl
    call reverseWordSignC6
    ret
Label31A51B: ;C6:651B
    push hl
    push de
    pop hl
    add hl, hl
    add hl, hl
    add hl, hl
    push hl
    pop de
    pop hl
    ret
;6525

reverseWordSignC6: ;C6:6525
    ld a, $00
    sub a, e
    ld e, a
    ld a, $00
    sbc a, d
    ld d, a
    ret
;652E rest of bank is empty

SECTION "bank_C7",ROMX,BANK[$C7]

stairAtilemapData:			INCBIN "gfx/tilemaps/stairAtilemap.2bpp" ;4000
stairAtilemapPallete:		INCBIN "gfx/tilemaps/stairAtilemap.pal" ;44E0

stairBtilemapData:			INCBIN "gfx/tilemaps/stairBtilemap.2bpp" ;4520
stairBtilemapPallete:		INCBIN "gfx/tilemaps/stairBtilemap.pal" ;4A40

ladderTilemapData:			INCBIN "gfx/tilemaps/ladderTilemap.2bpp" ;4A80
ladderTilemapPallete:		INCBIN "gfx/tilemaps/ladderTilemap.pal" ;4DB0

ropeTilemapData:			INCBIN "gfx/tilemaps/ropeTilemap.2bpp" ;4DF0
ropeTilemapPallete:			INCBIN "gfx/tilemaps/ropeTilemap.pal" ;5110

;5150 rest of bank empty


SECTION "bank_C8",ROMX,BANK[$C8]

objects_spritesheet:					INCBIN "gfx/sprite_sheets/objects/objects_spritesheet.2bpp"

SECTION "bank_C9",ROMX,BANK[$C9]

INCLUDE "text/roomActionsMessages.asm"
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
zombie_front_spritesheet:			INCBIN "gfx/sprite_sheets/zombie/zombie_front_spritesheet.2bpp"
zombie_front_right_spritesheet:		INCBIN "gfx/sprite_sheets/zombie/zombie_front_right_spritesheet.2bpp"
zombie_right_spritesheet:			INCBIN "gfx/sprite_sheets/zombie/zombie_right_spritesheet.2bpp"
zombie_back_right_spritesheet:		INCBIN "gfx/sprite_sheets/zombie/zombie_back_right_spritesheet.2bpp"
zombie_back_spritesheet:			INCBIN "gfx/sprite_sheets/zombie/zombie_back_spritesheet.2bpp"

SECTION "bank_D1",ROMX,BANK[$D1]
zombie_back_left_spritesheet:		INCBIN "gfx/sprite_sheets/zombie/zombie_back_left_spritesheet.2bpp"
zombie_left_spritesheet:			INCBIN "gfx/sprite_sheets/zombie/zombie_left_spritesheet.2bpp"
zombie_front_left_spritesheet:		INCBIN "gfx/sprite_sheets/zombie/zombie_front_left_spritesheet.2bpp"

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


;overhead jill sprites
SECTION "bank_D8",ROMX,BANK[$D8]
jill_overhead_front_spritesheet:		INCBIN "gfx/sprite_sheets/jill/jill_overhead_front_spritesheet.2bpp"

REPT $300
	db $FF
ENDR

SECTION "bank_D9",ROMX,BANK[$D9]
jill_overhead_front_right_spritesheet:	INCBIN "gfx/sprite_sheets/jill/jill_overhead_front_right_spritesheet.2bpp"

REPT $300
	db $FF
ENDR

SECTION "bank_DA",ROMX,BANK[$DA]
jill_overhead_right_spritesheet:		INCBIN "gfx/sprite_sheets/jill/jill_overhead_right_spritesheet.2bpp"

REPT $300
	db $FF
ENDR

SECTION "bank_DB",ROMX,BANK[$DB]
jill_overhead_back_right_spritesheet:	INCBIN "gfx/sprite_sheets/jill/jill_overhead_back_right_spritesheet.2bpp"

REPT $300
	db $FF
ENDR

SECTION "bank_DC",ROMX,BANK[$DC]
jill_overhead_back_spritesheet:			INCBIN "gfx/sprite_sheets/jill/jill_overhead_back_spritesheet.2bpp"

REPT $300
	db $FF
ENDR

SECTION "bank_DD",ROMX,BANK[$DD]
jill_overhead_back_left_spritesheet:	INCBIN "gfx/sprite_sheets/jill/jill_overhead_back_left_spritesheet.2bpp"

REPT $300
	db $FF
ENDR

SECTION "bank_DE",ROMX,BANK[$DE]
jill_overhead_left_spritesheet:			INCBIN "gfx/sprite_sheets/jill/jill_overhead_left_spritesheet.2bpp"

REPT $300
	db $FF
ENDR

SECTION "bank_DF",ROMX,BANK[$DF]
jill_overhead_front_left_spritesheet:	INCBIN "gfx/sprite_sheets/jill/jill_overhead_front_left_spritesheet.2bpp"

REPT $300
	db $FF
ENDR

;chris sprites
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

;jill spritesheets
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

INCLUDE "text/eventMessageNames.asm"

INCLUDE "text/eventScripts.asm"

SECTION "bank_F9",ROMX,BANK[$F9]

fileTextsData:				INCLUDE "text/filesTexts.asm" ;4000
doorsAndActionsTextsData:	INCLUDE "text/doorsAndActionsTexts.asm" ;6D04
;71BD rest of bank empty

SECTION "TextPointers",ROMX,BANK[$FA]

INCLUDE "text/textPointers.asm" ;4000

INCLUDE "text/itemsNames.asm" ;48EC
INCLUDE "text/getItemsText.asm" ;4F3C

INCLUDE "text/newGameWelcomeMessages.asm" ;59FA

INCLUDE "text/itemDescriptions.asm"

INCLUDE "text/clearTexts.asm"

;FA:64A0 rest of bank is empty

SECTION "BankFB",ROMX,BANK[$FB]

INCLUDE "main/loadRoomObjectsSprites.asm"

objectsSpritesCollidersTable: ;4BF4
INCLUDE "main/objectsSpritesColliders.asm"

checkSpritesCollision:: ;FB:4C94
;evaluate player collision with objects or zombies
;if objects, evaluate objects push and step ladders elevation
;if zombies, evaluate zombie facing toward player and attack collision
    ld de, wNPCSpritesData
    ld b, $07
Loop3ECC99:
    push bc
    push de
    ld hl, wCharSpritesData - wCharSpritesData ;$0
    add hl, de
    ld a, [hl]
    and a, $40
    jp z, checkNextSpriteCollision ;if sprite is not visible
    ld hl, wSpriteId - wCharSpritesData ;$B
    add hl, de
    ld a, [hl]
    cp a, ZOMBIE
    jp z, checkZombieCollision
    cp a, OBJECTS
    jp nc, checkObjectCollision
    jp checkNextSpriteCollision
checkObjectCollision
    ld hl, wSpriteId - wCharSpritesData ;$B
    add hl, de
    ld a, [hl]
    cp a, WOODEN_BOX ;$F1
    jr nz, Label3ECCCF
    ld hl, wSpritePositionYHigh - wCharSpritesData ;$1A
    add hl, de
    ld a, [hld]
    cp a, $FF
    jr nz, Label3ECCCF ;check collision if woodenBox is not sunken
    ld a, [hl]
    cp a, $ED
    jp c, checkNextSpriteCollision ;if wooden box is sunken, check next
Label3ECCCF
    ld hl, wSpriteId - wCharSpritesData ;$B
    add hl, de
    ld a, [hl]
    ld [spriteIdBuffer], a ;store sprite Id
    sub a, OBJECTS ;$E0 get object id
    ld l, a
    ld h, $00
    add hl, hl
    add hl, hl
    add hl, hl
    ld bc, objectsSpritesCollidersTable ;$4BF4
    add hl, bc
    ld c, l
    ld b, h ;set collider pos to bc
    ld hl, wSpritePositionXLow - wCharSpritesData ;$11
    add hl, de
    ld e, [hl]
    inc hl ;wSpritePositionXHigh
    ld d, [hl]
    call div8SignedWordFB
    ld a, [bc]
    ld l, a
    inc bc
    ld a, [bc]
    ld h, a
    inc bc
    add hl, de ;add obj current pos x to collider right border
    ld a, l
    ld [wLowColliderRightX], a
    ld a, h
    ld [wHighColliderRightX], a
    ld a, [bc]
    ld l, a
    inc bc
    ld a, [bc]
    ld h, a
    inc bc
    add hl, de ;add obj current pos x to collider left border
    ld a, l
    ld [wLowColliderLeftX], a
    ld a, h
    ld [wHighColliderLeftX], a
    pop de
    push de
    ld hl, wSpritePositionZLow - wCharSpritesData ;$13
    add hl, de
    ld e, [hl]
    inc hl ;wSpritePositionZHigh
    ld d, [hl]
    call div8SignedWordFB
    ld a, [bc]
    ld l, a
    inc bc
    ld a, [bc]
    ld h, a
    inc bc
    add hl, de ;add obj current pos y to collider bottom border
    ld a, l
    ld [wLowColliderBottomY], a
    ld a, h
    ld [wHighColliderBottomY], a
    ld a, [bc]
    ld l, a
    inc bc
    ld a, [bc]
    ld h, a
    inc bc
    add hl, de ;add obj current pos y to collider top border
    ld a, l
    ld [wLowColliderTopY], a
    ld a, h
    ld [wHighColliderTopY], a
    ld a, [wSpritePositionXLow]
    ld e, a
    ld a, [wSpritePositionXHigh]
    ld d, a
    call div8SignedWordFB
    push de ; store player sprite position
    ld a, [wSpritePositionZLow]
    ld e, a
    ld a, [wSpritePositionZHigh]
    ld d, a
    call div8SignedWordFB
    ld l, e
    ld h, d
    pop de
    call evaluateObjectCollision
    or a
    jp z, checkNextSpriteCollision ;jump if not collision
;check object push
    pop de
    push de
    ld hl, wSpriteId - wCharSpritesData ;$B
    add hl, de
    ld a, [hl]
    cp a, MAP_STEP_LADDER ;$E0
    jr z, Label3ECD96
    cp a, JEWEL_STATUE ;$E1
    jr z, Label3ECD96
    cp a, GUARDHOUSE_STATUE ;$E4
    jr z, Label3ECD96
    cp a, ARMORS_ROOM_STATUE_1 ;$E7
    jr z, Label3ECD96
    cp a, ARMORS_ROOM_STATUE_2 ;$E8
    jr z, Label3ECD96
    cp a, WOODEN_RACK ;$EC
    jr z, Label3ECD96
    cp a, UNDERGROUND_STATUE ;$ED
    jr z, Label3ECD96
    cp a, DORM_002_CLOSET ;$EE
    jr z, Label3ECD96
    cp a, XRAY_ROOM_SHELF ;$EF
    jr z, Label3ECD96
    cp a, HIDDEN_LIBRARY_STATUE ;$F0
    jr z, Label3ECD96
    cp a, WOODEN_BOX ;$F1
    jr z, Label3ECD96
    cp a, OPERATING_ROOM_LADDER ;$F2
    jr z, Label3ECD96
    cp a, OPERATING_ROOM_BOX ;$F3
    jr z, Label3ECD96
    jp checkNextSpriteCollision
Label3ECD96
    ld hl, wSpriteFacing - wCharSpritesData ;$9
    add hl, de
    ld a, [wSpriteFacing]
    add a, $10 ;reverse facing
    and a, $1F ;set limit
    cp a, [hl]
    jp nz, checkNextSpriteCollision ;jump if player is not facing object
    ld bc, objectMoveTable
    ld a, [hl]
    and a, $1C
    add a, c
    ld c, a
    ld a, $00
    adc a, b
    ld b, a
    push bc ;store movement offset
    ld hl, wSpritePositionXLow - wCharSpritesData ;$11
    add hl, de
    ld a, [bc]
    add a, [hl]
    ld [hl], a
    inc hl ;wSpritePositionXHigh
    inc bc
    ld a, [bc]
    adc a, [hl]
    ld [hl], a
    inc hl ;wSpritePositionZLow
    inc bc
    ld a, [bc]
    add a, [hl]
    ld [hl], a
    inc hl ;wSpritePositionZHigh
    inc bc
    ld a, [bc]
    adc a, [hl]
    ld [hl], a
    inc hl
    inc bc
    pop bc
    ld hl, wZombieAndObjectVarId - wCharSpritesData ;$F
    add hl, de
    ld a, [hl]
    cp a, $F0
    jr z, Label3ECE0B
    cp a, $F1
    jr z, Label3ECE24
    cp a, $F4 ;GUARDHOUSE_STATUE
    jp z, Label3ECF2E
    cp a, $F7
    jr z, Label3ECE3C
    cp a, $F8
    jr z, Label3ECE51
    cp a, $FC
    jp z, Label3ECE5F
    cp a, $FD
    jp z, Label3ECE6D
    cp a, $FE
    jp z, Label3ECE90
    cp a, $EF
    jp z, Label3ECEAA
    cp a, $EE
    jp z, Label3ECEC4
    cp a, $ED
    jp z, Label3ECED9
    cp a, $EC
    jp z, Label3ECF19
    jp checkNextSpriteCollision
Label3ECE0B
    ld hl, wSpritePositionZHigh - wCharSpritesData ;$14
    add hl, de
    ld a, [hld]
    or a
    jp nz, checkNextSpriteCollision
    ld a, [hl]
    cp a, $02
    jp nc, checkNextSpriteCollision
    ld [hl], $02
    ld a, $FF
    ld [wMansion1FMapStepLadderPushed], a
    jp checkNextSpriteCollision
Label3ECE24
    ld hl, wSpritePositionZHigh - wCharSpritesData ;$14
    add hl, de
    ld a, [hld]
    cp a, $FF
    jp nz, checkNextSpriteCollision
    ld a, [hl]
    cp a, $0A
    jp c, checkNextSpriteCollision
    ld a, $8B
    ld [wEventId], a
    jp checkNextSpriteCollision
Label3ECE3C
    ld hl, wSpritePositionXHigh - wCharSpritesData ;$12
    add hl, de
    ld a, [hld]
    cp a, $FE
    jp nz, checkNextSpriteCollision
    ld a, [hl]
    cp a, $F0
    jp nc, checkNextSpriteCollision
    ld [hl], $F0
    jp checkNextSpriteCollision
Label3ECE51
    ld hl, wSpritePositionZHigh - wCharSpritesData ;$14
    add hl, de
    ld a, [hld]
    or a ;$00
    jp nz, checkNextSpriteCollision
    ld [hl], $00
    jp checkNextSpriteCollision
Label3ECE5F:
    ld hl, wSpritePositionZHigh - wCharSpritesData ;$14
    add hl, de
    ld a, [hld]
    or a
    jp nz, checkNextSpriteCollision
    ld [hl], $00
    jp checkNextSpriteCollision
Label3ECE6D:
    ld hl, wSpritePositionXHigh - wCharSpritesData ;$12
    add hl, de
    ld a, [hld]
    or a
    jp nz, checkNextSpriteCollision
    ld a, [hl]
    cp a, $C0
    jp c, checkNextSpriteCollision
    ld [hl], $C0
    ld a, [wc4c3]
    or a
    jp nz, checkNextSpriteCollision
    ld a, $FF
    ld [wc4c3], a
    ld [wc571], a
    jp checkNextSpriteCollision
Label3ECE90:
    ld hl, wSpritePositionZHigh - wCharSpritesData ;$14
    add hl, de
    ld a, [hld]
    cp a, $FF
    jp nz, checkNextSpriteCollision
    ld a, [hl]
    cp a, $C0
    jp c, checkNextSpriteCollision
    ld [hl], $C0
    ld a, $FF
    ld [wc4d5], a
    jp checkNextSpriteCollision
Label3ECEAA:
    ld hl, wSpritePositionZHigh - wCharSpritesData ;$14
    add hl, de
    ld a, [hld]
    cp a, $FD
    jp nz, checkNextSpriteCollision
    ld a, [hl]
    cp a, $D0
    jp nc, checkNextSpriteCollision
    ld [hl], $D0
    ld a, $FF
    ld [wLibrarySecretDoorTrigger], a
    jp checkNextSpriteCollision
Label3ECEC4:
    ld hl, wSpritePositionZHigh - wCharSpritesData ;$14
    add hl, de
    ld a, [hld]
    cp a, $FF
    jp nz, checkNextSpriteCollision
    ld a, [hl]
    cp a, $88
    jp c, checkNextSpriteCollision
    ld [hl], $88
    jp checkNextSpriteCollision
Label3ECED9:
    ld hl, wSpritePositionXHigh - wCharSpritesData ;$12
    add hl, de
    ld a, [hld]
    or a
    jp nz, checkNextSpriteCollision
    ld a, [hl]
    cp a, $80
    jp nc, checkNextSpriteCollision
    ld [hl], $80
    ld a, $FF
    ld [wLabStepLadderPushed], a
	;save current NPC data
    push bc
    push de
    push hl
    ld c, OPERATING_ROOM_BOX ;$F3
    call searchNPC
    or a
    jr z, restoreCurrentNPCData
	;check if surgery room box is above poison gas
    ld hl, $12
    add hl, de
    ld a, [hld]
    cp a, $01
    jr nz, activateSurgeryRoomGas
    ld a, [hl]
    cp a, $90
    jr nc, activateSurgeryRoomGas
restoreCurrentNPCData
    pop hl
    pop de
    pop bc
    jp checkNextSpriteCollision
activateSurgeryRoomGas
    pop hl ;restore current NPC data
    pop de
    pop bc
    ld a, $FF
    ld [wPoisonGasActivationByte], a
    jp checkNextSpriteCollision
Label3ECF19:
    ld hl, wSpritePositionXHigh - wCharSpritesData ;$12
    add hl, de
    ld a, [hld]
    cp a, $01
    jp nz, checkNextSpriteCollision
    ld a, [hl]
    cp a, $60
    jp nc, checkNextSpriteCollision
    ld [hl], $60
    jp checkNextSpriteCollision
Label3ECF2E:
    ld hl, wSpritePositionZHigh - wCharSpritesData ;$14
    add hl, de
    ld a, [hld]
    cp a, $FF
    jp nz, checkNextSpriteCollision
    ld a, [hl]
    cp a, $18
    jp c, checkNextSpriteCollision
    ld [hl], $17
    ld a, $FF
    ld [wGuardhouseStatueMoved], a
    jp checkNextSpriteCollision

checkZombieCollision:
;set a collider of 12,12
    ld hl, wSpritePositionXLow - wCharSpritesData ;$11
    add hl, de
    ld e, [hl]
    inc hl ;wSpritePositionXHigh
    ld d, [hl]
    call div8SignedWordFB
    ld hl, $FFFA ;-6
    add hl, de
    ld a, l
    ld [wLowColliderRightX], a
    ld a, h
    ld [wHighColliderRightX], a
    ld de, $000C ;12
    add hl, de
    ld a, l
    ld [wLowColliderLeftX], a
    ld a, h
    ld [wHighColliderLeftX], a
    pop de
    push de
    ld hl, wSpritePositionZLow - wCharSpritesData ;$13
    add hl, de
    ld e, [hl]
    inc hl ;wSpritePositionZHigh
    ld d, [hl]
    call div8SignedWordFB
    ld hl, $FFFA ;-6
    add hl, de
    ld a, l
    ld [wLowColliderBottomY], a
    ld a, h
    ld [wHighColliderBottomY], a
    ld de, $C ;12
    add hl, de
    ld a, l
    ld [wLowColliderTopY], a
    ld a, h
    ld [wHighColliderTopY], a
    ld a, [wSpritePositionXLow]
    ld e, a
    ld a, [wSpritePositionXHigh]
    ld d, a
    call div8SignedWordFB
    push de ;store player posX into de
    ld a, [wSpritePositionZLow]
    ld e, a
    ld a, [wSpritePositionZHigh]
    ld d, a
    call div8SignedWordFB
    ld l, e
    ld h, d ;store player posY into hl
    pop de
    call evaluateZombieCollision
checkNextSpriteCollision
    pop de
    ld hl, $20
    add hl, de
    ld e, l
    ld d, h
    pop bc
    dec b
    jp nz, Loop3ECC99
    call checkZombiePlayerFacing
    jp checkZombieAttack
;4FBD

searchNPC:
;search an NPC, return true ($FF) if find it or false ($00) if not
;params
;c: sprite id
    ld de, wNPCSpritesData
    ld b, $07
Loop3ECFC2
    ld hl, wSpriteId - wCharSpritesData ;$B
    add hl, de
    ld a, [hl]
    cp a, c
    jr z, Label3ECFD7
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    dec b
    jr nz, Loop3ECFC2
    xor a
    ret
Label3ECFD7 ;FB:4FD7
    ld a, $FF
    ret

objectMoveTable: ;4FDA
;move_north
	dw $0000
	dw $FFFE
;move_north_west
	dw $0000
	dw $0000
;move_west
	dw $FFFE
	dw $0000
;move_south_west
	dw $0000
	dw $0000
;move_south
	dw $0000
	dw $0002
;move_south_east
	dw $0000
	dw $0000
;move_east
	dw $0002
	dw $0000
;move_north_east
	dw $0000
	dw $0000

;4FFA

evaluateZombieCollision: ;FB:4FFA
;de: player pos X
;hl: player pos Y
    ld a, [wLowColliderRightX]
    sub a, e
    ld a, [wHighColliderRightX]
    sbc a, d
    cp a, $FF
    jp nz, returnNotZombieCollision
    ld a, [wLowColliderLeftX]
    sub a, e
    ld a, [wHighColliderLeftX]
    sbc a, d
    or a
    jp nz, returnNotZombieCollision
    ld a, [wLowColliderBottomY]
    sub a, l
    ld a, [wHighColliderBottomY]
    sbc a, h
    cp a, $FF
    jp nz, returnNotZombieCollision
    ld a, [wLowColliderTopY]
    sub a, l
    ld a, [wHighColliderTopY]
    sbc a, h
    or a
    jp nz, returnNotZombieCollision
    push de ;store player pos X
    push hl ;store player pos Y
    ld a, [wSpriteRoomPositionXLow]
    ld e, a
    ld a, [wSpriteRoomPositionXHigh]
    ld d, a
    push de
    ld a, [wSpriteRoomPositionYLow]
    ld e, a
    ld a, [wSpriteRoomPositionYHigh]
    ld d, a
    ld l, e
    ld h, d
    pop de
;checkZombieBottomCollider
    ld a, [wLowColliderBottomY]
    sub a, l
    ld a, [wHighColliderBottomY]
    sbc a, h
    or a
    jr nz, checkZombieTopCollider
    ld a, [wLowColliderBottomY]
    ld e, a
    ld a, [wHighColliderBottomY]
    ld d, a
    call multiply8SignedWordFB
    ld a, e
    sub a, $01
    ld [wSpritePositionZLow], a
    ld a, d
    sbc a, $00
    ld [wSpritePositionZHigh], a
    pop hl
    pop de
    ld a, $FF
    ret
checkZombieTopCollider: ;FB:5069
    ld a, [wLowColliderTopY]
    sub a, l
    ld a, [wHighColliderTopY]
    sbc a, h
    cp a, $FF
    jr nz, checkZombieRightCollider
    ld a, [wLowColliderTopY]
    ld e, a
    ld a, [wHighColliderTopY]
    ld d, a
    call multiply8SignedWordFB
    ld a, e
    add a, $08
    ld [wSpritePositionZLow], a
    ld a, d
    adc a, $00
    ld [wSpritePositionZHigh], a
    pop hl
    pop de
    ld a, $FF
    ret
checkZombieRightCollider: ;FB:5091
    ld a, [wLowColliderRightX]
    sub a, e
    ld a, [wHighColliderRightX]
    sbc a, d
    or a
    jr nz, checkZombieLeftCollider
    ld a, [wLowColliderRightX]
    ld e, a
    ld a, [wHighColliderRightX]
    ld d, a
    call multiply8SignedWordFB
    ld a, e
    sub a, $01
    ld [wSpritePositionXLow], a
    ld a, d
    sbc a, $00
    ld [wSpritePositionXHigh], a
    pop hl
    pop de
    ld a, $FF
    ret
checkZombieLeftCollider: ;FB:50B8
    ld a, [wLowColliderLeftX]
    ld e, a
    ld a, [wHighColliderLeftX]
    ld d, a
    call multiply8SignedWordFB
    ld a, e
    add a, $08
    ld [wSpritePositionXLow], a
    ld a, d
    adc a, $00
    ld [wSpritePositionXHigh], a
    pop hl
    pop de
    ld a, $FF
    ret
;50D4

returnNotZombieCollision: ;FB:50D4
    xor a
    ret
;50D6


evaluateObjectCollision: ;FB:50D6
;de: player sprite position
;return true if there is a collision, false if not or step ladder elevation
    ld a, [wLowColliderRightX]
    sub a, e
    ld a, [wHighColliderRightX]
    sbc a, d
    cp a, $FF
    jp nz, checkStepLaddersElevation
    ld a, [wLowColliderLeftX]
    sub a, e
    ld a, [wHighColliderLeftX]
    sbc a, d
    or a
    jp nz, checkStepLaddersElevation
    ld a, [wLowColliderBottomY]
    sub a, l
    ld a, [wHighColliderBottomY]
    sbc a, h
    cp a, $FF
    jp nz, checkStepLaddersElevation
    ld a, [wLowColliderTopY]
    sub a, l
    ld a, [wHighColliderTopY]
    sbc a, h
    or a
    jp nz, checkStepLaddersElevation
    ld a, [wStepLadderElevationMode]
    or a
    jp nz, Label3ED205 ;return if step ladder elevation is true
	;else check for step ladder elevation
    push de
    push hl
    ld a, [wSpriteRoomPositionXLow]
    ld e, a
    ld a, [wSpriteRoomPositionXHigh]
    ld d, a
    push de ;store player pos-X
    ld a, [wSpriteRoomPositionYLow]
    ld e, a
    ld a, [wSpriteRoomPositionYHigh]
    ld d, a
    ld l, e
    ld h, d ;store player pos-y into hl
    pop de ;restore player pos-X
	;check bottom collider
    ld a, [wLowColliderBottomY]
    sub a, l
    ld a, [wHighColliderBottomY]
    sbc a, h
    or a
    jr nz, checkObjTopCollider ;jump if y-axis not match
	;else, set player y-pos to limit
    ld a, [wLowColliderBottomY]
    ld e, a
    ld a, [wHighColliderBottomY]
    ld d, a
    call multiply8SignedWordFB
    ld a, e
    sub a, $01
    ld [wSpritePositionZLow], a
    ld a, d
    sbc a, $00
    ld [wSpritePositionZHigh], a
    pop hl
    pop de
    ld a, $FF
    ret
;514C

checkObjTopCollider: ;FB:514C
    ld a, [wLowColliderTopY]
    sub a, l
    ld a, [wHighColliderTopY]
    sbc a, h
    cp a, $FF
    jr nz, checkObjRightCollider
    ld a, [spriteIdBuffer]
    cp a, MAP_STEP_LADDER ;$E0
    jr z, Label3ED161
    jr Label3ED16F
Label3ED161
    ld a, [wMansion1FMapStepLadderPushed]
    or a
    jr z, Label3ED16F ;jump if disabled
    ld a, $FF
    ld [wStepLadderElevationMode], a
    jp Label3ED207
Label3ED16F
    ld a, [wLowColliderTopY]
    ld e, a
    ld a, [wHighColliderTopY]
    ld d, a
    call multiply8SignedWordFB
    ld a, e
    add a, $08
    ld [wSpritePositionZLow], a
    ld a, d
    adc a, $00
    ld [wSpritePositionZHigh], a
    pop hl
    pop de
    ld a, $FF
    ret
;518B

checkObjRightCollider: ;FB:518B
    ld a, [wLowColliderRightX]
    sub a, e
    ld a, [wHighColliderRightX]
    sbc a, d
    or a
    jr nz, checkObjLeftCollider
    ld a, [spriteIdBuffer]
    cp a, SHED_STEP_LADDER ;$E9
    jr z, Label3ED19F
    jr Label3ED1A7
Label3ED19F
    ld a, $FF
    ld [wStepLadderElevationMode], a
    jp Label3ED207
Label3ED1A7
    ld a, [wLowColliderRightX]
    ld e, a
    ld a, [wHighColliderRightX]
    ld d, a
    call multiply8SignedWordFB
    ld a, e
    sub a, $01
    ld [wSpritePositionXLow], a
    ld a, d
    sbc a, $00
    ld [wSpritePositionXHigh], a
    pop hl
    pop de
    ld a, $FF
    ret
;51C3

checkObjLeftCollider: ;FB:51C3
    ld a, [spriteIdBuffer]
    cp a, OPERATING_ROOM_LADDER ;$F2
    jr z, Label3ED1CC
    jr Label3ED1DA
Label3ED1CC
    ld a, [wLabStepLadderPushed]
    or a
    jr z, Label3ED1DA
    ld a, $FF
    ld [wStepLadderElevationMode], a
    jp Label3ED207
Label3ED1DA
    ld a, [wLowColliderLeftX]
    ld e, a
    ld a, [wHighColliderLeftX]
    ld d, a
    call multiply8SignedWordFB
    ld a, e
    add a, $08
    ld [wSpritePositionXLow], a
    ld a, d
    adc a, $00
    ld [wSpritePositionXHigh], a
    pop hl
    pop de
    ld a, $FF
    ret
;51F6

checkStepLaddersElevation:: ;FB:51F6
    ld a, [spriteIdBuffer]
    cp a, MAP_STEP_LADDER ;$E0
    jr z, Label3ED20B
    cp a, SHED_STEP_LADDER ;$E9
    jr z, Label3ED20B
    cp a, OPERATING_ROOM_LADDER ;$F2
    jr z, Label3ED20B
Label3ED205 ;FB:5205
    xor a
    ret
Label3ED207 ;FB:5207
    pop hl
    pop de
    jr Label3ED205
Label3ED20B
	xor a
    ld [wStepLadderElevationMode], a ;reset step ladder elevation
    jr Label3ED205

;5211

checkZombieAttack: ;FB:5211
    ld de, wNPCSpritesData
    ld b, $07
Loop3ED216:
    push bc
    push de
    ld hl, wSpriteId - wCharSpritesData ;$B
    add hl, de
    ld a, [hl]
    cp a, ZOMBIE ;$98
    jp z, Label3ED225
    jp evalNextZombieAttack
Label3ED225
    ld hl, wSpriteAnimationId - wCharSpritesData ;$6
    add hl, de
    ld a, [hl]
    cp a, ATTACK_ANIM ;$03
    jp z, evalNextZombieAttack ;skip if is already attacking
    cp a, DEAD_ANIM ;$02
    jp z, evalNextZombieAttack ;skip if dead
    ld hl, wCharHealth - wCharSpritesData ;$E
    add hl, de
    ld a, [hl]
    or a ;$00
    jp z, evalNextZombieAttack ;skip if dead
    ld hl, wCharSpritesData - wCharSpritesData ;$0
    add hl, de
    ld a, [hl]
    and a, $40
    jp z, resetZombieAnimation ;reset animation and skip if hidden
	;set a collider of 18,18
    ld hl, wSpritePositionXLow - wCharSpritesData ;$11
    add hl, de
    ld e, [hl]
    inc hl ;wSpritePositionXHigh
    ld d, [hl]
    call div8SignedWordFB
    ld hl, $FFF7 ;-9
    add hl, de
    ld a, l
    ld [wLowColliderRightX], a
    ld a, h
    ld [wHighColliderRightX], a
    ld de, $12 ;18
    add hl, de
    ld a, l
    ld [wLowColliderLeftX], a
    ld a, h
    ld [wHighColliderLeftX], a
    pop de
    push de
    ld hl, wSpritePositionZLow - wCharSpritesData ;$13
    add hl, de
    ld e, [hl]
    inc hl ;wSpritePositionZHigh
    ld d, [hl]
    call div8SignedWordFB
    ld hl, $FFF7
    add hl, de
    ld a, l
    ld [wLowColliderBottomY], a
    ld a, h
    ld [wHighColliderBottomY], a
    ld de, $12
    add hl, de
    ld a, l
    ld [wLowColliderTopY], a
    ld a, h
    ld [wHighColliderTopY], a
    ld a, [wSpritePositionXLow]
    ld e, a
    ld a, [wSpritePositionXHigh]
    ld d, a
    call div8SignedWordFB
    push de
    ld a, [wSpritePositionZLow]
    ld e, a
    ld a, [wSpritePositionZHigh]
    ld d, a
    call div8SignedWordFB
    ld l, e
    ld h, d
    pop de
    call checkZombieAttackCollision
    or a
    jr z, Label3ED2C7 ;jump if not collision
    pop de
    push de
    ld a, [wMoveInputBlockTimer]
    or a
    jr z, beginZombieAttack ;if not player move blocked
    and a, $07
    jr nz, evalNextZombieAttack
    ld a, [wSpriteAnimationId]
    cp a, GET_DAMAGED_ANIM ;$06
    jr nz, evalNextZombieAttack
    ld a, ZOMBIE_BYTE_SFX ;$15
    call playSFX
    jr evalNextZombieAttack
Label3ED2C7
    pop de
    push de
    ld hl, wSpriteAnimationId - wCharSpritesData ;$6
    add hl, de
    ld a, [hl]
    cp a, ATTACK_ANIM ;$03
    jr nz, evalNextZombieAttack ;skip if not attacking
	;reset zombie animation
    ld [hl], IDLE_ANIM ;$00
    ld hl, wSpriteAnimationFrameId - wCharSpritesData ;$7
    add hl, de
    ld [hl], $00
    jr evalNextZombieAttack
beginZombieAttack
    ld hl, wSpriteAnimationId - wCharSpritesData ;$6
    add hl, de
    ld [hl], ATTACK_ANIM ;$03
    ld hl, wSpriteAnimationFrameId - wCharSpritesData ;$7
    add hl, de
    ld [hl], $00
    ld a, $28 ;set attack duration
    ld [wMoveInputBlockTimer], a
    ld a, GET_DAMAGED_ANIM ;$06 set player getting damage anim
    ld [wSpriteAnimationId], a
    ld a, [wCharHealth]
    or a ;$00
    jr z, evalNextZombieAttack ;skip if player is dead
    cp a, $09
    jr c, setPlayerHealthZero ;jump if player health is below 9
	;substract player health
    sub a, $08
    ld [wCharHealth], a
    ld a, ZOMBIE_BYTE_SFX ;$15
    call playSFX
    jr evalNextZombieAttack
setPlayerHealthZero
    xor a
    ld [wCharHealth], a
    ld a, $40 ;begin game over fade-out
    ld [wLCDUpdate], a
    jr evalNextZombieAttack
resetZombieAnimation:
    ld hl, wSpriteAnimationId - wCharSpritesData ;$6
    add hl, de
    ld [hl], IDLE_ANIM ;$00
    ld hl, wSpriteAnimationFrameId - wCharSpritesData ;$7
    add hl, de
    ld [hl], $00
evalNextZombieAttack:
    pop de
    ld hl, $20
    add hl, de
    ld e, l
    ld d, h
    pop bc
    dec b
    jp nz, Loop3ED216
    ret
;532C

checkZombieAttackCollision: ;FB:532C
    ld a, [wLowColliderRightX]
    sub a, e
    ld a, [wHighColliderRightX]
    sbc a, d
    cp a, $FF
    jr nz, notZombieAttackCollision
    ld a, [wLowColliderLeftX]
    sub a, e
    ld a, [wHighColliderLeftX]
    sbc a, d
    or a
    jr nz, notZombieAttackCollision
    ld a, [wLowColliderBottomY]
    sub a, l
    ld a, [wHighColliderBottomY]
    sbc a, h
    cp a, $FF
    jr nz, notZombieAttackCollision
    ld a, [wLowColliderTopY]
    sub a, l
    ld a, [wHighColliderTopY]
    sbc a, h
    or a
    jr nz, notZombieAttackCollision
    ld a, $FF
    ret
;535D

notZombieAttackCollision: ;FB:535D
    xor a
    ret
;535F

checkZombiePlayerFacing: ;FB:535F
    ld de, wNPCSpritesData
    ld b, $07
Loop3ED364:
    push bc
    push de
    ld hl, wCharSpritesData - wCharSpritesData ;$0
    add hl, de
    ld a, [hl]
    and a, $40
    jp z, checkNextZombie
    ld hl, wSpriteId - wCharSpritesData ;$B
    add hl, de
    ld a, [hl]
    cp a, ZOMBIE ;$98
    jp nz, checkNextZombie
    ld hl, wSpriteAnimationId - wCharSpritesData ;$6
    add hl, de
    ld a, [hl]
    cp a, DEAD_ANIM ;$02
    jp z, checkNextZombie
	;create a collider of 48,48
    ld hl, wSpritePositionXLow - wCharSpritesData ;$11
    add hl, de
    ld e, [hl]
    inc hl ;wSpritePositionXHigh
    ld d, [hl]
    call div8SignedWordFB
    ld hl, $FFD0 ;-48
    add hl, de
    ld a, l
    ld [wLowColliderRightX], a
    ld a, h
    ld [wHighColliderRightX], a
    ld de, $60 ;96
    add hl, de
    ld a, l
    ld [wLowColliderLeftX], a
    ld a, h
    ld [wHighColliderLeftX], a
    pop de
    push de
    ld hl, wSpritePositionZLow - wCharSpritesData ;$13
    add hl, de
    ld e, [hl]
    inc hl ;wSpritePositionZHigh
    ld d, [hl]
    call div8SignedWordFB
    ld hl, $FFD0 ;-48
    add hl, de
    ld a, l
    ld [wLowColliderBottomY], a
    ld a, h
    ld [wHighColliderBottomY], a
    ld de, $60 ;96
    add hl, de
    ld a, l
    ld [wLowColliderTopY], a
    ld a, h
    ld [wHighColliderTopY], a
    ld a, [wSpritePositionXLow]
    ld e, a
    ld a, [wSpritePositionXHigh]
    ld d, a
    call div8SignedWordFB
    push de
    ld a, [wSpritePositionZLow]
    ld e, a
    ld a, [wSpritePositionZHigh]
    ld d, a
    call div8SignedWordFB
    ld l, e
    ld h, d
    pop de
    call checkZombieAttackCollision
    or a
    jp z, checkNextZombie
;eval zombie-player distance and get zombie facing to player
    pop de
    push de
    ld b, $80
    ld hl, wSpritePositionXLow - wCharSpritesData ;$11
    add hl, de
    ld a, [wSpritePositionXLow]
    sub a, [hl]
    ld c, a
    inc hl ;wSpritePositionXHigh
    ld a, [wSpritePositionXHigh]
    sbc a, [hl]
    or a
    jr z, Label3ED413 ;if positions are iqual
    cp a, $FF
    jr z, Label3ED40A ;if player position is less than zombie's
    cp a, $80
    jr c, Label3ED418 ;if player position is greater than zombie's
    jr Label3ED40F
Label3ED40A
    ld a, c
    cp a, $C0
    jr nc, Label3ED41A
Label3ED40F
    ld b, $18
    jr Label3ED41A
Label3ED413
    ld a, c
    cp a, $40
    jr c, Label3ED41A
Label3ED418
    ld b, $08
Label3ED41A
    ld hl, wSpritePositionZLow - wCharSpritesData ;$13
    add hl, de
    ld a, [wSpritePositionZLow]
    sub a, [hl]
    ld c, a
    inc hl ;wSpritePositionZHigh
    ld a, [wSpritePositionZHigh]
    sbc a, [hl]
    or a
    jr z, Label3ED44F
    cp a, $FF
    jr z, Label3ED435
    cp a, $80
    jr c, Label3ED454
    jr Label3ED43A
Label3ED435
    ld a, c
    cp a, $C0
    jr nc, setZombieFacing
Label3ED43A
    ld a, b
    and a, $7F
    jr z, Label3ED447
    cp a, $08
    jr z, Label3ED44B
    ld b, $14
    jr setZombieFacing
Label3ED447
    ld b, $10
    jr setZombieFacing
Label3ED44B
    ld b, $0C
    jr setZombieFacing
Label3ED44F
    ld a, c
    cp a, $40
    jr c, setZombieFacing
Label3ED454
    ld a, b
    and a, $7F
    jr z, Label3ED461
    cp a, $08
    jr z, Label3ED465
    ld b, $1C
    jr setZombieFacing
Label3ED461
    ld b, $00
    jr setZombieFacing
Label3ED465
    ld b, $04
setZombieFacing
    ld hl, wSpriteFacing - wCharSpritesData ;$9
    add hl, de
    ld a, b
    and a, $80
    jr nz, checkNextZombie
    ld a, b
    and a, $1F
    ld [hl], a
checkNextZombie:
    pop de
    ld hl, $20
    add hl, de
    ld e, l
    ld d, h
    pop bc
    dec b
    jp nz, Loop3ED364
    ret
;5481

div8SignedWordFB: ;FB:5481
    ld a, d
    cp a, $80
    jr c, Label3ED499
    call reverseWordSignFB
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    call reverseWordSignFB
    ret
Label3ED499: ;FB:5499
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    ret
;54A6

multiply8SignedWordFB: ;FB:54A6
    ld a, d
    cp a, $80
    jr c, Label3ED4BB
    call reverseWordSignFB
    push hl
    push de
    pop hl
    add hl, hl
    add hl, hl
    add hl, hl
    push hl
    pop de
    pop hl
    call reverseWordSignFB
    ret
Label3ED4BB ;FB:54BB
    push hl
    push de
    pop hl
    add hl, hl
    add hl, hl
    add hl, hl
    push hl
    pop de
    pop hl
    ret
;54C5

reverseWordSignFB: ;FB:54C5
    ld a, $00
    sub a, e
    ld e, a
    ld a, $00
    sbc a, d
    ld d, a
    ret

;54CE rest of bank empty


SECTION "BankFC",ROMX,BANK[$FC]

INCLUDE "engine/enemyBoundariesTable.asm"

checkEnemyBoundaries: ;FC:41E4
    ld de, wNPCSpritesData
    ld b, $07
Loop3F01E9
    push bc
    push de
    ld hl, wSpriteId - wCharSpritesData ;$B
    add hl, de
    ld a, [hl]
    cp a, ZOMBIE
    jp c, nextEnemyChaseNPC ;jump if not enemy
    cp a, $A8
    jp nc, nextEnemyChaseNPC ;jump if not enemy
    ld hl, wCharSpritesData - wCharSpritesData ;$0
    add hl, de
    ld a, [hl]
    and a, $40
    jp z, nextEnemyChaseNPC ;jump if not visible
    ld hl, wSpriteAnimationId - wCharSpritesData ;$6
    add hl, de
    ld a, [hl]
    cp a, DEAD_ANIM ;$02
    jp z, nextEnemyChaseNPC ;jump if enemy is dead
    ld hl, wZombieAndObjectVarId - wCharSpritesData ;$F
    add hl, de
    ld a, [hli]
    ld h, [hl] ;$10
    ld l, a
    add hl, hl
    ld bc, enemyBoundariesTable ;$4000
    add hl, bc
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld c, e ;de to bc
    ld b, d
    ld a, c
    add a, wSpritePositionXLow - wCharSpritesData ;$11
    ld c, a
    ld a, b
    adc a, $00
    ld b, a
    ld a, [bc]
    sub a, [hl] ;enemyPosX - limitPosX
    inc hl ;limitPosXHigh
    inc bc ;wSpritePositionXHigh
    ld a, [bc]
    sbc a, [hl]
    cp a, $C0
    jr c, Label3F0238 ;jump if distance < $C0 (192)
    dec hl ;limitPosXLow
    dec bc ;wSpritePositionXLow
    ld a, [hli] ;limitPosXHigh
    ld [bc], a ;set enemyPosX = limitPosX
    inc bc ;wSpritePositionXHigh
    ld a, [hl]
    ld [bc], a
Label3F0238
    dec bc ;wSpritePositionXLow
    inc hl ;next limitPosX (low)
    ld a, [bc]
    sub a, [hl] ;enemyPosX - limitPosX
    inc hl ;limitPosX (high)
    inc bc ;wSpritePositionXHigh
    ld a, [bc]
    sbc a, [hl]
    cp a, $40
    jr nc, Label3F0259 ;jump if distance > $40(64)
    dec hl ;limit X low
    dec bc ;wSpritePositionXLow
    ld a, [hli]
    ld [bc], a ;set limit X low to enemy pos X low
    inc bc ;wSpritePositionXHigh
    ld a, [hl]
    ld [bc], a ;set limit X high to enemy pos X high
    push hl
    ld hl, wSpriteAnimationId - wCharSpritesData ;$6
    add hl, de
    ld [hl], IDLE_ANIM ;$00
    ld hl, wSpriteAnimationFrameId - wCharSpritesData ;$7
    add hl, de
    ld [hl], $00
    pop hl
Label3F0259
    inc hl ;wSpritePositionZLow
    inc bc ;limit Y low
    ld a, [bc]
    sub a, [hl] ;enemyPosY - limitPosY
    inc hl ;limit Y high
    inc bc ;wSpritePositionZHigh
    ld a, [bc]
    sbc a, [hl]
    cp a, $C0
    jr c, Label3F027A ;jump if Y-distance < $C0 (192)
    dec hl ;limit Y low
    dec bc ;wSpritePositionZLow
    ld a, [hli]
    ld [bc], a ;set limit Y low to enemy pos Y low
    inc bc
    ld a, [hl]
    ld [bc], a ;set limit Y high to enemy pos Y high
    push hl
    ld hl, wSpriteAnimationId - wCharSpritesData ;$6
    add hl, de
    ld [hl], IDLE_ANIM ;$00
    ld hl, wSpriteAnimationFrameId - wCharSpritesData ;$7
    add hl, de
    ld [hl], $00
    pop hl
Label3F027A
    dec bc ;wSpritePositionZLow
    inc hl ;next limitPosY (low)
    ld a, [bc]
    sub a, [hl] ;enemyPosY - limitPosY
    inc hl ;limitPosY high
    inc bc ;wSpritePositionZHigh
    ld a, [bc]
    sbc a, [hl]
    cp a, $40
    jr nc, nextEnemyChaseNPC ;jump if Y-distance > $40(64)
    dec hl
    dec bc
    ld a, [hli]
    ld [bc], a ;set limit Y low to enemy pos Y low
    inc bc
    ld a, [hl]
    ld [bc], a ;set limit Y high to enemy pos Y high
    push hl
    ld hl, wSpriteAnimationId - wCharSpritesData ;$6
    add hl, de
    ld [hl], IDLE_ANIM ;$00
    ld hl, wSpriteAnimationFrameId - wCharSpritesData ;$7
    add hl, de
    ld [hl], $00
    pop hl
nextEnemyChaseNPC:
    pop de
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop bc
    dec b
    jp nz, Loop3F01E9
    ret
;42AA

loadZombieAndObjectAnimFrames: ;FC:42AA
    ld de, wNPCSpritesData
    ld b, $07
Loop3F02AF
    push bc
    push de
    ld hl, $0
    add hl, de
    ld a, [hl]
    and a, $40
    jr z, nextObjectNPC ;next NPC is sprite is hidden
    ld hl, wSpriteId - wCharSpritesData ;$B
    add hl, de
    ld a, [hl]
    cp a, ZOMBIE ;$98
    jp z, setZombieAnimation
    cp a, OBJECTS ;$E0
    jr nc, setObjectFrames
nextObjectNPC:
    pop de
    pop bc
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    dec b
    jr nz, Loop3F02AF
    ret
;42D6

objectsSpritesFramesId: ;42D6
	db $00, $20, $10, $10, $30, $00, $40, $50, $50, $60
	db $70, $70, $80, $90, $A0, $B0, $C0, $D0, $E0, $F0

setObjectFrames: ;FC:42EA
    ld hl, wSpriteId - wCharSpritesData ;$B
    add hl, de
    ld a, [hl]
    sub a, OBJECTS ;$E0 get object Id
    ld c, a
    ld b, $00
    ld hl, objectsSpritesFramesId ;$42D6
    add hl, bc
    ld a, [hli]
    ld hl, wSpriteAnimationFrameId - wCharSpritesData ;$7
    add hl, de
    ld [hl], a ;set frameId
    ld hl, wSpriteAnimationId - wCharSpritesData ;$6
    add hl, de
    ld [hl], IDLE_ANIM ;$00
    ld hl, wSpriteId - wCharSpritesData ;$B
    add hl, de
    ld a, [hl]
    cp a, DINNING_ROOM_CLOCK ;$E2
    jr z, setDinningRoomClockFrame
    cp a, GUARDHOUSE_STATUE ;$E4
    jr z, setGuardHouseStatueFrame
    cp a, RESEARCHER_ROOM_SHELF ;$E6
    jr z, setBookcase1Frame
    cp a, SHED_STEP_LADDER ;$E9
    jr z, setCrankStepLadderFrame
    cp a, WOODEN_BOX ;$F1
    jr z, setWoodenBoxFrame
    cp a, OPERATING_ROOM_LADDER ;$F2
    jp z, setStepLadder3Frame
    jp nextObjectNPC

setDinningRoomClockFrame ;FC:4325
    ld a, [wRoomScreen]
    cp a, $05
    jp z, nextObjectNPC
    ld hl, wSpriteAnimationFrameId - wCharSpritesData ;$7
    add hl, de
    ld a, [hl]
    add a, $08
    ld [hl], a
    jp nextObjectNPC

setGuardHouseStatueFrame ;FC:4338
    ld a, [wGuardhouseStatueMoved]
    or a
    jp z, nextObjectNPC
    ld hl, wSpritePositionZLow - wCharSpritesData ;$13
    add hl, de
    ld [hl], $17
    inc hl ;wSpritePositionZHigh
    ld [hl], $FF
    jp nextObjectNPC

setBookcase1Frame ;FC:434B
    ld a, [wRoomScreen]
    or a ;$00
    jp z, nextObjectNPC
    ld hl, wSpriteAnimationFrameId - wCharSpritesData ;$7
    add hl, de
    ld a, [hl]
    add a, $08
    ld [hl], a
    jp nextObjectNPC

setCrankStepLadderFrame ;FC:435D
    ld a, [wRoomScreen]
    cp a, $01
    jp z, nextObjectNPC
    ld hl, wSpriteAnimationFrameId - wCharSpritesData ;$7
    add hl, de
    ld a, [hl]
    add a, $08
    ld [hl], a
    jp nextObjectNPC

setWoodenBoxFrame ;FC:4370
    ld a, [wAquariumWoodenBoxSunken]
    or a
    jr nz, Label3F039D
    ld hl, wSpritePositionZHigh - wCharSpritesData ;$14
    add hl, de
    ld a, [hld] ;wSpritePositionZLow
    or a
    jp nz, nextObjectNPC
    ld a, [hl]
    cp a, $88
    jp c, nextObjectNPC
    ld hl, wSpritePositionYHigh - wCharSpritesData ;$1A
    add hl, de
    ld [hl], $FF
    dec hl
    dec [hl]
    ld a, [hl]
    cp a, $EC
    jp nc, nextObjectNPC
    ld [hl], $EC
    ld a, $FF
    ld [wAquariumWoodenBoxSunken], a
    jp nextObjectNPC
Label3F039D
    ld hl, wSpritePositionZLow - wCharSpritesData ;$13
    add hl, de
    ld [hl], $88
    inc hl
    ld [hl], $00
    ld hl, wSpritePositionYLow - wCharSpritesData ;$19
    add hl, de
    ld [hl], $EC
    inc hl ;wSpritePositionYHigh
    ld [hl], $FF
    jp nextObjectNPC

setStepLadder3Frame: ;FC:43B2
    ld a, [wGuardhouseStatueMoved] ;recicled var
    or a
    jp z, nextObjectNPC
    ld hl, wSpritePositionZLow - wCharSpritesData ;$13
    add hl, de
    ld [hl], $17
    inc hl ;
    ld [hl], $FF
    jp nextObjectNPC
;43C5

setZombieAnimation: ;FC:43C5
    ld a, [wLCDUpdate]
    or a
    jp nz, nextObjectNPC
    ld hl, wZombieAndObjectVarId - wCharSpritesData ;$F
    add hl, de
    ld a, [hl]
    call checkZombieActive
    or a
    jp z, nextObjectNPC ;next sprt if zombie is inactive
    ld hl, wSpriteAnimationId - wCharSpritesData ;$6
    add hl, de
    ld a, [hl]
    cp a, DEAD_ANIM ;$02
    jp z, nextObjectNPC ;next sprt if zombie is dead
    ld hl, wZombieRecoilTimer - wCharSpritesData ;$1C
    add hl, de
    ld a, [hl]
    or a
    jp nz, zombieAttackRecoil
    ld hl, wSpriteAnimationId - wCharSpritesData ;$6
    add hl, de
    ld a, [hl]
    cp a, ATTACK_ANIM ;$03
    jp z, setZombieAttackAnimation
	;set walk animation
    ld hl, wSpriteAnimationId - wCharSpritesData ;$6
    add hl, de
    ld [hl], WALK_ANIM ;$01
    ld hl, wSpriteAnimationFrameId - wCharSpritesData ;$7
    add hl, de
    ld a, [hl]
    add a, $02
    and a, $3F ;limit max frame
    ld [hl], a
    ld hl, wSpriteFacing - wCharSpritesData ;$9
    add hl, de
    ld a, [hl]
    and a, $1C
    ld c, a
    ld b, $00
;move zombie
    ld hl, zombieMoveTable ;$4489
    add hl, bc
    ld c, l
    ld b, h
    ld hl, wSpritePositionXLow - wCharSpritesData ;$11
    add hl, de
    ld a, [bc]
    add a, [hl]
    ld [hli], a
    inc bc ;wSpritePositionXHigh
    ld a, [bc]
    adc a, [hl]
    ld [hli], a
    inc bc ;wSpritePositionZLow
    ld a, [bc]
    add a, [hl]
    ld [hli], a
    inc bc ;wSpritePositionZHigh
    ld a, [bc]
    adc a, [hl]
    ld [hli], a
    inc bc
    jp nextObjectNPC

setZombieAttackAnimation:
    ld a, [wMoveInputBlockTimer]
    cp a, $08
    jp nc, nextObjectNPC
    ld a, [wButtonPressId]
    and a, AB_INPUT ;$03
    jp z, nextObjectNPC
    ld hl, wZombieRecoilTimer - wCharSpritesData ;$1C
    add hl, de
    ld a, [hl]
    or a
    jp nz, nextObjectNPC
    ld [hl], $0C
    ld a, PUSH_ZOMBIE_SFX ;$12
    call playSFX
    jp nextObjectNPC

zombieAttackRecoil:
    ld hl, wZombieRecoilTimer - wCharSpritesData ;$1C
    add hl, de
    dec [hl]
    ld hl, wSpriteAnimationId - wCharSpritesData ;$6
    add hl, de
    ld [hl], WALK_ANIM ;$01
    ld hl, wSpriteAnimationFrameId - wCharSpritesData ;$7
    add hl, de
    ld [hl], $00
    ld hl, wSpriteFacing - wCharSpritesData ;$9
    add hl, de
    ld a, [hl]
    add a, $10 ;reverse facing
    and a, $1C
    ld c, a
    ld b, $00
    ld hl, zombieMoveBackwardTable ;$44A9
    add hl, bc
    ld c, l
    ld b, h
    ld hl, wSpritePositionXLow - wCharSpritesData ;$11
    add hl, de
    ld a, [bc]
    add a, [hl]
    ld [hli], a
    inc bc ;wSpritePositionXHigh
    ld a, [bc]
    adc a, [hl]
    ld [hli], a
    inc bc ;wSpritePositionZLow
    ld a, [bc]
    add a, [hl]
    ld [hli], a
    inc bc ;wSpritePositionZHigh
    ld a, [bc]
    adc a, [hl]
    ld [hli], a
    inc bc
    jp nextObjectNPC

;4489
INCLUDE "engine/zombieMoveTable.asm"

checkZombieActive: ;FC:44C9
    cp a, $04
    jr z, Label3F04D0
    ld a, $FF
    ret
Label3F04D0 ;FC:44D0
    ld a, [wEventFirstZombieScn]
    or a
    jr z, .zombieInactive
    ld a, $FF
    ret
.zombieInactive ;FC:44D9
    xor a
    ret
;44DB


checkPlayerInput: ;FC:44DB
    xor a
    ld [wButtonAEventId], a
	;convert sprite xpos
    ld a, [wSpritePositionXLow]
    ld e, a
    ld a, [wSpritePositionXHigh]
    ld d, a
    call div8SignedWordFC
    ld a, e
    ld [wSpriteRoomPositionXLow], a
    ld a, d
    ld [wSpriteRoomPositionXHigh], a
	;convert sprite ypos
    ld a, [wSpritePositionZLow]
    ld e, a
    ld a, [wSpritePositionZHigh]
    ld d, a
    call div8SignedWordFC
    ld a, e
    ld [wSpriteRoomPositionYLow], a
    ld a, d
    ld [wSpriteRoomPositionYHigh], a
    ld a, [wMoveInputBlockTimer]
    or a
    jr z, Label3F0512
    dec a
    ld [wMoveInputBlockTimer], a
    cp a, $08
    ret nc
Label3F0512
    ld a, [wWeaponBlockTimer]
    or a
    jr z, Label3F051C
    dec a
    ld [wWeaponBlockTimer], a
Label3F051C
    ld a, [wFiregunFramesId]
    or a
    jr z, Label3F052F
    and a, $7F
    add a, $02
    cp a, $0C
    jr c, Label3F052D
    xor a
    jr Label3F052F
Label3F052D
    or a, $80
Label3F052F
    ld [wFiregunFramesId], a
    ld a, [wBloodFramesId]
    or a
    jr z, Label3F0544
    and a, $7F
    inc a
    cp a, $0C
    jr c, Label3F0542
    xor a
    jr Label3F0544
Label3F0542
    or a, $80
Label3F0544 ;4544
    ld [wBloodFramesId], a
    ld a, [wSpriteAnimationId]
    cp a, IDLE_ANIM ;$00
    jp z, idleAnimationInput
    cp a, WALK_ANIM ;$01
    jp z, walkAnimationInput
    cp a, RUN_ANIM ;$02
    jp z, runAnimationInput
    cp a, GUN_AIM_ANIM ;$03
    jp z, gunAimAnimationInput
    cp a, SHOTGUN_AIM_ANIM ;$04
    jp z, shotgunAimAnimationInput
    cp a, KNIFE_AIM_ANIM ;$05
    jp z, knifeAimAnimationInput
    cp a, PICK_ITEM_ANIM ;$07
    jp z, pickItemAnimationInput
    ld a, IDLE_ANIM ;$00
    ld [wSpriteAnimationId], a
    xor a
    ld [wSpriteAnimationFrameId], a ;reset frameId
    ret
;4577

pickItemAnimationInput: ;FC:4577
    ld a, [wSpriteAnimationFrameId]
    inc a
    cp a, $10
    jr nc, Label3F0583
    ld [wSpriteAnimationFrameId], a
    ret
Label3F0583 ;FC:4583
    ld [wSpriteAnimationFrameId], a
    cp a, $10
    jr nz, Label3F0590
    ld a, DROPPED_ITEM_ACTION ;$01
    ld [wButtonAEventId], a
    ret
Label3F0590 ;FC:4590
    cp a, $20
    ret c
    ld a, IDLE_ANIM ;$00
    ld [wSpriteAnimationId], a
    xor a
    ld [wSpriteAnimationFrameId], a
    ret
;459D

idleAnimationInput: ;FC:459D
    ld a, [wButtonPressId]
    and a, B_INPUT ;$02
    jr nz, indleAnimBInput
    xor a
    ld [wBButtonPressDown], a
Label3F05A8
    ld a, [wButtonPressId]
    and a, LEFT_INPUT ;$20
    call nz, indleAnimLeftInput
    ld a, [wButtonPressId]
    and a, RIGHT_INPUT ;$10
    call nz, indleAnimRightInput
    ld a, [wButtonPressId]
    and a, UP_INPUT ;$40
    call nz, indleAnimUpInput
    ld a, [wButtonPressId]
    and a, DOWN_INPUT ;$80
    call nz, indleAnimDownInput
    call checkTurnLeftPress
    call checkTurnRightPress
    ld a, [wButtonPressId]
    and a, ALL_DIRECTION_B_INPUT ;$F2
    ret nz
    ld a, [wSpriteAnimationFrameId]
    cp a, $1F
    ret z
    inc a
    ld [wSpriteAnimationFrameId], a
    ret

indleAnimLeftInput: ;FC:45DF
    ret

indleAnimRightInput: ;FC:45E0
    ret

indleAnimUpInput: ;FC:45E1
    ld a, WALK_ANIM ;$01
    ld [wSpriteAnimationId], a
    xor a
    ld [wSpriteAnimationFrameId], a
    jp playerWalkMove

indleAnimDownInput: ;FC:45ED
    ld a, WALK_ANIM ;$01
    ld [wSpriteAnimationId], a
    ld a, $3F
    ld [wSpriteAnimationFrameId], a
    jp playerWalkBackwardMove

indleAnimBInput: ;45FA
    ld a, [wBButtonPressDown]
    or a
    jp nz, Label3F05A8 ;if B button is already pressed
    ld a, [equipedItemId]
    cp a, BERRETTA
    jr z, setGunAimAnimation
    cp a, SHOTGUN
    jr z, setShotgunAimAnimation
    cp a, COMBAT_KNIFE
    jr z, setKnifeAimAnimation
    ret
;4611
setShotgunAimAnimation: ;FC:4611
    ld a, SHOTGUN_AIM_ANIM ;$04
    ld [wSpriteAnimationId], a
    ld c, $00
    ld a, [wButtonPressId]
    and a, UP_INPUT ;$40
    jr nz, Label3F062A
    ld c, $10
    ld a, [wButtonPressId]
    and a, DOWN_INPUT ;$80
    jr nz, Label3F062A
    ld c, $08
Label3F062A
    ld a, c
    ld [wSpriteAnimationFrameId], a
    ret
;462F
setGunAimAnimation: ;FC:462F
    ld a, GUN_AIM_ANIM ;$03
    ld [wSpriteAnimationId], a
    ld c, $00
    ld a, [wButtonPressId]
    and a, UP_INPUT ;$40
    jr nz, Label3F0648
    ld c, $10
    ld a, [wButtonPressId]
    and a, DOWN_INPUT ;$80
    jr nz, Label3F0648
    ld c, $08
Label3F0648
    ld a, c
    ld [wSpriteAnimationFrameId], a
    ret
;464D
setKnifeAimAnimation: ;FC:464D
    ld a, KNIFE_AIM_ANIM ;$05
    ld [wSpriteAnimationId], a
    xor a
    ld [wSpriteAnimationFrameId], a
    ret
;4657

shotgunAimAnimationInput: ;FC:4657
    ld a, [wButtonPressId]
    and a, B_INPUT
    jr z, stopShotgunAim
    ld c, $00
	;aim up
    ld a, [wButtonPressId]
    and a, UP_INPUT
    jr nz, Label3F0672
    ld c, $10
	;aim down
    ld a, [wButtonPressId]
    and a, DOWN_INPUT
    jr nz, Label3F0672
    ld c, $08
Label3F0672
    ld a, c
    ld [wSpriteAnimationFrameId], a
    call checkTurnLeftPress
    call checkTurnRightPress
    ld a, [wButtonPressId]
    and a, A_INPUT
    ret z
    ld a, [wWeaponBlockTimer]
    or a
    ret nz
    ld a, $08
    ld [wWeaponBlockTimer], a
    ld a, $82
    ld [wFiregunFramesId], a
    ld a, SHOTGUN_SFX ;$10
    call playSFX
    ld a, [wSpriteAnimationFrameId]
    or a
    ret z
    call gunShotAtEnemy
    ret
stopShotgunAim: ;FC:469F
    ld a, $00
    ld [wSpriteAnimationId], a
    xor a
    ld [wSpriteAnimationFrameId], a
    ret
;46A9

gunAimAnimationInput: ;FC:46A9
    ld a, [wButtonPressId]
    and a, B_INPUT ;$02
    jr z, stopGunAim
    ld c, $00
	;aim up
    ld a, [wButtonPressId]
    and a, UP_INPUT ;$40
    jr nz, Label3F06C4
    ld c, $10
	;aim down
    ld a, [wButtonPressId]
    and a, DOWN_INPUT ;$80
    jr nz, Label3F06C4
    ld c, $08
Label3F06C4
    ld a, c
    ld [wSpriteAnimationFrameId], a
    call checkTurnLeftPress
    call checkTurnRightPress
    ld a, [wButtonPressId]
    and a, A_INPUT ;$01
    ret z
    ld a, [wWeaponBlockTimer]
    or a
    ret nz
    ld a, $08
    ld [wWeaponBlockTimer], a
    ld a, $82
    ld [wFiregunFramesId], a
    ld a, FIREGUN_SFX ;$0F
    call playSFX
    ld a, [wSpriteAnimationFrameId]
    or a
    ret z
    call gunShotAtEnemy
    ret
stopGunAim: ;FC:46F1
    ld a, IDLE_ANIM ;$00
    ld [wSpriteAnimationId], a
    xor a
    ld [wSpriteAnimationFrameId], a
    ret
;46FB

knifeAimAnimationInput: ;FC:46FB
    ld a, [wButtonPressId]
    and a, B_INPUT ;$02
    jp z, stopKnifeAiming
    ld a, [wSpriteAnimationFrameId]
    cp a, $10
    jr c, Label3F0716
    cp a, $18
    jr c, Label3F071E
    cp a, $20
    jr c, Label3F072C
    cp a, $28
    jr c, Label3F073A
Label3F0716
    inc a
    and a, $0F
    ld [wSpriteAnimationFrameId], a
    jr checkKnifeInput
Label3F071E
    inc a
    ld [wSpriteAnimationFrameId], a
    cp a, $18
    jr c, checkKnifeInput
    xor a
    ld [wSpriteAnimationFrameId], a
    jr checkKnifeInput
Label3F072C
    inc a
    ld [wSpriteAnimationFrameId], a
    cp a, $20
    jr c, checkKnifeInput
    xor a
    ld [wSpriteAnimationFrameId], a
    jr checkKnifeInput
Label3F073A
    inc a
    ld [wSpriteAnimationFrameId], a
    cp a, $28
    jr c, checkKnifeInput
    xor a
    ld [wSpriteAnimationFrameId], a
    jr checkKnifeInput
checkKnifeInput
    call checkTurnLeftPress
    call checkTurnRightPress
    ld a, [wSpriteAnimationFrameId]
    cp a, $10
    ret nc
    ld a, [wButtonPressId]
    and a, A_INPUT
    jr z, stopKnifeAttack
    ld a, [wAButtonPressDown]
    or a
    ret nz
    ld a, $FF
    ld [wAButtonPressDown], a
	;aim up
    ld a, [wButtonPressId]
    and a, UP_INPUT
    jr nz, setKnifeAimUpFrame
	;aim down
    ld a, [wButtonPressId]
    and a, DOWN_INPUT
    jr nz, setKnifeAimDownFrame
    ld a, $20
    ld [wSpriteAnimationFrameId], a
    ret
setKnifeAimUpFrame ;FC:4779
    ld a, $10
    ld [wSpriteAnimationFrameId], a
    ret
setKnifeAimDownFrame ;FC:477F
    ld a, $18
    ld [wSpriteAnimationFrameId], a
    ret
;4785

stopKnifeAiming: ;FC:4785
    ld a, IDLE_ANIM
    ld [wSpriteAnimationId], a
    xor a
    ld [wSpriteAnimationFrameId], a
    ret
;478F
stopKnifeAttack: ;FC:478F
    xor a
    ld [wAButtonPressDown], a
    ret
;4794

walkAnimationInput: ;FC:4794
    ld a, [wButtonPressId]
    and a, B_INPUT ;$02
    jr nz, .checkRunning
    ld a, [wButtonPressId]
    and a, ALL_DIRECTION_INPUT ;$F0
    jr nz, .keepWalking
	;stop walking
    ld a, IDLE_ANIM ;$00
    ld [wSpriteAnimationId], a
    xor a
    ld [wSpriteAnimationFrameId], a
    ret
.checkRunning ;FC:47AC
    ld a, [wButtonPressId]
    and a, DOWN_INPUT ;$80
    jr nz, .keepWalking
	;begin running
    ld a, RUN_ANIM ;$02
    ld [wSpriteAnimationId], a
.keepWalking
    ld a, [wButtonPressId]
    and a, UP_INPUT ;$40
    call nz, playerWalkMove
    ld a, [wButtonPressId]
    and a, DOWN_INPUT ;$80
    call nz, playerWalkBackwardMove
    call checkTurnLeftPress
    call checkTurnRightPress
    ret
;47CF

runAnimationInput: ;FC:47CF
    ld a, [wButtonPressId]
    and a, B_INPUT ;$02
    jr z, .stopRunning
    ld a, [wButtonPressId]
    and a, ALL_DIRECTION_INPUT ;$F0
    jr nz, .checkRunningDirection
    ld a, IDLE_ANIM ;$00
    ld [wSpriteAnimationId], a
    xor a
    ld [wSpriteAnimationFrameId], a
    ld a, $FF
    ld [wBButtonPressDown], a
    ret
.stopRunning ;FC:47EC
    ld a, WALK_ANIM ;$01
    ld [wSpriteAnimationId], a
.checkRunningDirection
    ld a, [wButtonPressId]
    and a, UP_INPUT ;$40
    call nz, playerWalkMove
    ld a, [wButtonPressId]
    and a, DOWN_INPUT ;$80
    call nz, playerWalkBackwardMove
    call checkTurnLeftPress
    call checkTurnRightPress
    ret
;4808

checkTurnLeftPress: ;FC:4808
    ld hl, wTurnLeftTimer
    ld a, [wButtonPressId]
    and a, LEFT_INPUT ;$20
    jp z, leftInputNotPressed
    ld a, [hl]
    or a
    jr z, Label3F081F
    dec [hl]
    ld a, [hl]
    or a
    ret nz
    ld [hl], $06
    jr Label3F0821
Label3F081F
    ld [hl], $0A
Label3F0821
    ld a, [wSpriteFacing]
    add a, $04 ;add facing rotate
    and a, $1F ;set limit
    ld [wSpriteFacing], a
    ld a, [wSpriteAnimationId]
    cp a, WALK_ANIM ;$01
    jr z, Label3F083D ; if moving, not rotate
    cp a, $00
    ret nz
    xor a
    ld [wSpriteAnimationFrameId], a
    ret
leftInputNotPressed: ;FC:483A
    ld [hl], $00
    ret
Label3F083D
	ret

checkTurnRightPress: ;FC:483E
    ld hl, wTurnRightTimer
    ld a, [wButtonPressId]
    and a, RIGHT_INPUT ;$10
    jp z, rightInputNotPressed
    ld a, [hl]
    or a
    jr z, Label3F0855
    dec [hl]
    ld a, [hl]
    or a
    ret nz
    ld [hl], $06
    jr Label3F0857
Label3F0855
    ld [hl], $0A
Label3F0857
    ld a, [wSpriteFacing]
    sub a, $04
    and a, $1F
    ld [wSpriteFacing], a
    ld a, [wSpriteAnimationId]
    cp a, WALK_ANIM ;$01
    jr z, Label3F0873
    cp a, $00
    ret nz
    xor a
    ld [wSpriteAnimationFrameId], a
    ret
rightInputNotPressed: ;FC:4870
    ld [hl], $00
    ret
Label3F0873
	ret

playerWalkMove: ;FC:4874
    ld a, [wSpriteAnimationFrameId]
    add a, $04 ;add sprite frames
    and a, $3F ;set limit frame
    ld [wSpriteAnimationFrameId], a ;set new frame
	;walk north
    ld bc, $0000
    ld de, $000E
    ld a, [wSpriteFacing]
    cp a, FACING_NORTH_WEST ;$04
    jr c, Label3F08CD
	;walk north west
    ld bc, $000C
    ld de, $000C
    cp a, FACING_WEST ;$08
    jr c, Label3F08CD
	;walk west
    ld bc, $000E
    ld de, $0000
    cp a, FACING_SOUTH_WEST ;$0C
    jr c, Label3F08CD
	;walk south west
    ld bc, $000C
    ld de, $FFF4
    cp a, FACING_SOUTH ;$10
    jr c, Label3F08CD
	;walk south
    ld bc, $0000
    ld de, $FFF2
    cp a, FACING_SOUTH_EAST ;$14
    jr c, Label3F08CD
	;walk south east
    ld bc, $FFF4
    ld de, $FFF4
    cp a, FACING_EAST ;$18
    jr c, Label3F08CD
	;walk east
    ld bc, $FFF2
    ld de, $0000
    cp a, FACING_NORTH_EAST ;$1C
    jr c, Label3F08CD
	;walk north east
    ld bc, $FFF4
    ld de, $000C
Label3F08CD ;48CD
    call Label3F0971
	;set move X offset
    ld a, [wSpritePositionXLow]
    add a, c
    ld [wSpritePositionXLow], a
    ld a, [wSpritePositionXHigh]
    adc a, b
    ld [wSpritePositionXHigh], a
	;set move Y offset
    ld a, [wSpritePositionZLow]
    add a, e
    ld [wSpritePositionZLow], a
    ld a, [wSpritePositionZHigh]
    adc a, d
    ld [wSpritePositionZHigh], a
    ld a, [wSpriteAnimationFrameId]
    and a, $1F
    cp a, $03
    jr c, .playWalkSfx
    ret
.playWalkSfx ;FC:48F6
    ld a, STEPS_SFX ;$0C
    jp playSFX

playerWalkBackwardMove: ;FC:48FB
    ld a, [wSpriteAnimationFrameId]
    sub a, $03
    and a, $3F
    ld [wSpriteAnimationFrameId], a
	;walk backward north
    ld bc, $0000
    ld de, $FFF9
    ld a, [wSpriteFacing]
    cp a, FACING_NORTH_WEST ;$04
    jr c, Label3F0954
	;walk backward north west
    ld bc, $FFFA
    ld de, $FFFA
    cp a, FACING_WEST ;$08
    jr c, Label3F0954
	;walk backward west
    ld bc, $FFF9
    ld de, $0000
    cp a, FACING_SOUTH_WEST ;$0C
    jr c, Label3F0954
	;walk backward south west
    ld bc, $FFFA
    ld de, $0006
    cp a, FACING_SOUTH ;$10
    jr c, Label3F0954
	;walk backward south
    ld bc, $0000
    ld de, $0007
    cp a, FACING_SOUTH_EAST ;$14
    jr c, Label3F0954
	;walk backward south east
    ld bc, $0006
    ld de, $0006
    cp a, FACING_EAST ;$18
    jr c, Label3F0954
	;walk backward east
    ld bc, $0007
    ld de, $0000
    cp a, FACING_NORTH_EAST ;$1C
    jr c, Label3F0954
	;walk backward north east
    ld bc, $0006
    ld de, $FFFA
Label3F0954
    ld a, [wSpritePositionXLow]
    add a, c
    ld [wSpritePositionXLow], a
    ld a, [wSpritePositionXHigh]
    adc a, b
    ld [wSpritePositionXHigh], a
    ld a, [wSpritePositionZLow]
    add a, e
    ld [wSpritePositionZLow], a
    ld a, [wSpritePositionZHigh]
    adc a, d
    ld [wSpritePositionZHigh], a
    ret
;4971

Label3F0971: ;FC:4971
    ld a, [wSpriteAnimationId]
    cp a, $02
    ret nz
    push bc
    pop hl
    add hl, bc
    ld c, l
    ld b, h
    push de
    pop hl
    add hl, de
    ld e, l
    ld d, h
    ret
;4982

div8SignedWordFC: ;FC:4982
    ld a, d
    cp a, $80
    jr c, Label3F099A
    call reverseWordSignFC
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    call reverseWordSignFC
    ret
Label3F099A: ;FC:499A
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    ret

reverseWordSignFC: ;FC:49A7
    ld a, $00
    sub a, e
    ld e, a
    ld a, $00
    sbc a, d
    ld d, a
    ret
;49B0

gunShotAtEnemy: ;FC:49B0
    ld de, wNPCSpritesData
    ld b, $07
Loop3F09B5
    push bc
    push de
    ld hl, wCharSpritesData - wCharSpritesData ;$0000
    add hl, de
    ld a, [hl]
    and a, $40
    jr z, evalShotNextNPC ;jump if hidden
    ld hl, wSpriteId - wCharSpritesData ;$B
    add hl, de
    ld a, [hl]
    cp a, ZOMBIE
    jr z, Label3F09CB
    jr evalShotNextNPC ; jump if npc is not zombie
Label3F09CB
    ld hl, wCharHealth - wCharSpritesData ;$E
    add hl, de
    ld a, [hl]
    or a
    jr z, evalShotNextNPC ;jump is health is zero
    call gunShootingAction
evalShotNextNPC ;next sprite
    pop de
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    pop bc
    dec b
    jr nz, Loop3F09B5
    ret
;49E4

gunShootingAction: ;FC:49E4
    ld a, [wSpriteFacing]
    cp a, FACING_SOUTH_WEST
    jp z, gunShotFacingSouthWest
    cp a, FACING_SOUTH
    jp z, gunShotFacingSouth
    cp a, FACING_SOUTH_EAST
    jp z, gunShotFacingSouthEast
    cp a, FACING_EAST
    jp z, gunShotFacingEast
    cp a, FACING_NORTH_EAST
    jp z, gunShotFacingNorthEast
    or a ;FACING_NORTH
    jp z, gunShotFacingNorth
    cp a, FACING_NORTH_WEST
    jp z, gunShotFacingNorthWest
    cp a, FACING_WEST
    jp z, gunShotFacingWest
    xor a
    ret
;4A10
gunShotFacingSouthEast: ;FC:4A10
    ld hl, wSpritePositionXLow - wCharSpritesData; $11
    add hl, de
    ld c, [hl]
    inc hl ;wSpritePositionXHigh
    ld b, [hl]
	;NPC Xpos - sprite Xpos
    ld a, [wSpritePositionXLow]
    sub a, c
    ld c, a
    ld a, [wSpritePositionXHigh]
    sbc a, b
    ld b, a
    cp a, $02
    jp nc, noDamageShot
    ld hl, wSpritePositionZLow - wCharSpritesData ;$13
    add hl, de
    ld a, [hl]
    inc hl ;wSpritePositionZHigh
    ld h, [hl]
	;NPC Ypos - sprite Ypos
    ld l, a
    ld a, [wSpritePositionZLow]
    sub a, l
    ld l, a
    ld a, [wSpritePositionZHigh]
    sbc a, h
    ld h, a
    cp a, $02
    jp nc, noDamageShot
    ld a, l
    sub a, c
    ld c, a
    ld a, h
    sbc a, b
    ld b, a
    or a
    jr z, Label3F0A54
    cp a, $FF
    jp nz, noDamageShot
    ld a, c
    cp a, $C0
    jp c, noDamageShot
    jp applyShotDamage
Label3F0A54
    ld a, c
    cp a, $40
    jp nc, noDamageShot
    jp applyShotDamage

gunShotFacingNorthEast: ;FC:4A5D
    ld hl, wSpritePositionXLow - wCharSpritesData; $11
    add hl, de
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, [wSpritePositionXLow]
    sub a, c
    ld c, a
    ld a, [wSpritePositionXHigh]
    sbc a, b
    ld b, a
    cp a, $02
    jp nc, noDamageShot
    ld hl, wSpritePositionZLow - wCharSpritesData ;$13
    add hl, de
    ld a, [hl]
    inc hl
    ld h, [hl]
    ld l, a
    ld a, [wSpritePositionZLow]
    sub a, l
    ld l, a
    ld a, [wSpritePositionZHigh]
    sbc a, h
    ld h, a
    cp a, $FE
    jp c, noDamageShot
    ld a, $00
    sub a, l
    ld l, a
    ld a, $00
    sbc a, h
    ld h, a
    ld a, l
    sub a, c
    ld c, a
    ld a, h
    sbc a, b
    ld b, a
    or a
    jr z, Label3F0AA9
    cp a, $FF
    jp nz, noDamageShot
    ld a, c
    cp a, $C0
    jp c, noDamageShot
    jp applyShotDamage
Label3F0AA9
    ld a, c
    cp a, $40
    jp nc, noDamageShot
    jp applyShotDamage

gunShotFacingSouthWest: ;FC:4AB2
    ld hl, wSpritePositionXLow - wCharSpritesData; $11
    add hl, de
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, [wSpritePositionXLow]
    sub a, c
    ld c, a
    ld a, [wSpritePositionXHigh]
    sbc a, b
    ld b, a
    cp a, $FE
    jp c, noDamageShot
    ld a, $00
    sub a, c
    ld c, a
    ld a, $00
    sbc a, b
    ld b, a
    ld hl, wSpritePositionZLow - wCharSpritesData ;$13
    add hl, de
    ld a, [hl]
    inc hl
    ld h, [hl]
    ld l, a
    ld a, [wSpritePositionZLow]
    sub a, l
    ld l, a
    ld a, [wSpritePositionZHigh]
    sbc a, h
    ld h, a
    cp a, $02
    jp nc, noDamageShot
    ld a, l
    sub a, c
    ld c, a
    ld a, h
    sbc a, b
    ld b, a
    or a
    jr z, Label3F0AFE
    cp a, $FF
    jp nz, noDamageShot
    ld a, c
    cp a, $C0
    jp c, noDamageShot
    jp applyShotDamage
Label3F0AFE
    ld a, c
    cp a, $40
    jp nc, noDamageShot
    jp applyShotDamage

gunShotFacingNorthWest: ;FC:4B07
    ld hl, wSpritePositionXLow - wCharSpritesData; $11
    add hl, de
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, [wSpritePositionXLow]
    sub a, c
    ld c, a
    ld a, [wSpritePositionXHigh]
    sbc a, b
    ld b, a
    cp a, $FE
    jp c, noDamageShot
    ld a, $00
    sub a, c
    ld c, a
    ld a, $00
    sbc a, b
    ld b, a
    ld hl, wSpritePositionZLow - wCharSpritesData ;$13
    add hl, de
    ld a, [hl]
    inc hl
    ld h, [hl]
    ld l, a
    ld a, [wSpritePositionZLow]
    sub a, l
    ld l, a
    ld a, [wSpritePositionZHigh]
    sbc a, h
    ld h, a
    cp a, $FE
    jp c, noDamageShot
    ld a, $00
    sub a, l
    ld l, a
    ld a, $00
    sbc a, h
    ld h, a
    ld a, l
    sub a, c
    ld c, a
    ld a, h
    sbc a, b
    ld b, a
    or a
    jr z, Label3F0B5B
    cp a, $FF
    jp nz, noDamageShot
    ld a, c
    cp a, $C0
    jp c, noDamageShot
    jp applyShotDamage
Label3F0B5B
    ld a, c
    cp a, $40
    jp nc, noDamageShot
    jp applyShotDamage

gunShotFacingSouth: ;FC:4B64
    ld hl, wSpritePositionXLow - wCharSpritesData; $11
    add hl, de
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, [wSpritePositionXLow]
    sub a, c
    ld c, a
    ld a, [wSpritePositionXHigh]
    sbc a, b
    ld b, a
    or a
    jr z, Label3F0B85
    cp a, $FF
    jp nz, noDamageShot
    ld a, c
    cp a, $A0
    jp c, noDamageShot
    jr Label3F0B8B
Label3F0B85
    ld a, c
    cp a, $60
    jp nc, noDamageShot
Label3F0B8B
    ld hl, wSpritePositionZLow - wCharSpritesData ;$13
    add hl, de
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, [wSpritePositionZLow]
    sub a, c
    ld c, a
    ld a, [wSpritePositionZHigh]
    sbc a, b
    ld b, a
    cp a, $02
    jp nc, noDamageShot
    jp applyShotDamage

gunShotFacingEast: ;FC:4BA4
    ld hl, wSpritePositionZLow - wCharSpritesData ;$13
    add hl, de
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, [wSpritePositionZLow]
    sub a, c
    ld c, a
    ld a, [wSpritePositionZHigh]
    sbc a, b
    ld b, a
    or a
    jr z, Label3F0BC5
    cp a, $FF
    jp nz, noDamageShot
    ld a, c
    cp a, $A0
    jp c, noDamageShot
    jr Label3F0BCB
Label3F0BC5
    ld a, c
    cp a, $60
    jp nc, noDamageShot
Label3F0BCB
    ld hl, wSpritePositionXLow - wCharSpritesData; $11
    add hl, de
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, [wSpritePositionXLow]
    sub a, c
    ld c, a
    ld a, [wSpritePositionXHigh]
    sbc a, b
    ld b, a
    cp a, $02
    jp nc, noDamageShot
    jr applyShotDamage

gunShotFacingNorth: ;FC:4BE3
    ld hl, wSpritePositionXLow - wCharSpritesData; $11
    add hl, de
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, [wSpritePositionXLow]
    sub a, c
    ld c, a
    ld a, [wSpritePositionXHigh]
    sbc a, b
    ld b, a
    or a
    jr z, Label3F0C04
    cp a, $FF
    jp nz, noDamageShot
    ld a, c
    cp a, $A0
    jp c, noDamageShot
    jr Label3F0C0A
Label3F0C04
    ld a, c
    cp a, $60
    jp nc, noDamageShot
Label3F0C0A
    ld hl, wSpritePositionZLow - wCharSpritesData ;$13
    add hl, de
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, [wSpritePositionZLow]
    sub a, c
    ld c, a
    ld a, [wSpritePositionZHigh]
    sbc a, b
    ld b, a
    cp a, $FE
    jp c, noDamageShot
    jr applyShotDamage

gunShotFacingWest: ;FC:4C22
    ld hl, wSpritePositionZLow - wCharSpritesData ;$13
    add hl, de
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, [wSpritePositionZLow]
    sub a, c
    ld c, a
    ld a, [wSpritePositionZHigh]
    sbc a, b
    ld b, a
    or a
    jr z, Label3F0C43
    cp a, $FF
    jp nz, noDamageShot
    ld a, c
    cp a, $A0
    jp c, noDamageShot
    jr Label3F0C49
Label3F0C43
    ld a, c
    cp a, $60
    jp nc, noDamageShot
Label3F0C49
    ld hl, wSpritePositionXLow - wCharSpritesData; $11
    add hl, de
    ld c, [hl]
    inc hl
    ld b, [hl]
    ld a, [wSpritePositionXLow]
    sub a, c
    ld c, a
    ld a, [wSpritePositionXHigh]
    sbc a, b
    ld b, a
    cp a, $FE
    jp c, noDamageShot
    jr applyShotDamage

applyShotDamage:
    ld c, BERRETTA_DAMAGE ;$0C
    ld a, [equipedItemId]
    cp a, BERRETTA
    jr z, Label3F0C6C
    ld c, SHOTGUN_DAMAGE ;$18
Label3F0C6C
    ld hl, wCharHealth - wCharSpritesData ;$E
    add hl, de
    ld a, [hl]
    or a
    jp z, noDamageShot ; if target health is zero
    ld hl, wBloodFramesId - wCharSpritesData ;$D
    add hl, de
    ld [hl], $80
    ld hl, wCharHealth - wCharSpritesData ;$E
    add hl, de
    ld a, [hl]
    sub a, c ;substract target health
    ld [hl], a
    jp nc, noDamageShot ; target not dead
	;target dead
    ld [hl], $00
    ld hl, wSpriteAnimationId - wCharSpritesData ;$6
    add hl, de
    ld [hl], DEAD_ANIM ;$02
    ld hl, wSpriteAnimationFrameId - wCharSpritesData ;$7
    add hl, de
    ld [hl], $00
    ld hl, wZombieAndObjectVarId - wCharSpritesData ;$F
    add hl, de
    ld c, [hl]
    ld b, $00
    ld hl, wEnemyAndObjectsVars ;C600
    add hl, bc
    ld [hl], $00
    ld a, ZOMBIE_DEATH_SFX ;$13
    call playSFX
    ld a, $FF
    ret
;4CA8

noDamageShot: ;FC:4CA8
    xor a
    ret
;4CAA


spritePrioritySort:: ;FC:4CAA
    ld hl, spritePriorityTable
    ld de, $000A ;sprite Priority structure length
    ld b, $00
.spritesCountLoop
    ld a, [hl]
    or a
    jr z, Label3F0CBA
    add hl, de ; next sprite data
    inc b
    jr .spritesCountLoop
Label3F0CBA
    ld a, b
    cp a, $02
    ret c ;return if below 2 sprites, no priority needed
    dec a
    ld b, a
    ld c, a
evalSpritesPriorityLoop2
    push bc
    ld hl, spritePriorityTable
    ld de, spritePriorityTable+$0A ;$C80A
evalSpritesPriorityLoop1
    ld a, [hl]
    ld a, [de]
    cp a, [hl]
    jr nc, Label3F0CDC ;jump if sprt2.Y >= sprt1.Y
	;else, swap priority data
    push bc
    ld b, $0A
.swapLoop
    ld c, [hl]
    ld a, [de]
    ld [hli], a
    ld a, c
    ld [de], a
    inc de
    dec b
    jr nz, .swapLoop
    pop bc
    jr Label3F0CEC
Label3F0CDC
    ld a, l
    add a, $0A
    ld l, a
    ld a, h
    adc a, $00
    ld h, a
    ld a, e
    add a, $0A
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
Label3F0CEC
    dec c
    jr nz, evalSpritesPriorityLoop1
    pop bc
    dec b
    jr nz, evalSpritesPriorityLoop2
    ret
;4CF4

INCLUDE "main/mainMenuCursorsData.asm" ;4CF4
;4DBA

loadMenuItemCursors: ;FC:4DBA
    ld e, $00
    ld a, c
    or a
    jr z, Label3F0DDC
    ld e, $04
    ld hl, chrisFirstItemSlotCursor+8 ;$4D8C
    ld a, [wSelectedPlayer]
    or a
    jr z, Label3F0DCE
    ld hl, jillFirstItemSlotCursor+8 ;$4D20
Label3F0DCE
    ld bc, $0C0C
    ld a, [wSelectedPlayer]
    or a
    jr nz, Label3F0DDA
    ld bc, $0A0A
Label3F0DDA
    jr Loop3F0DF4
Label3F0DDC
    ld hl, chrisMapCursor+8 ;$4D68
    ld a, [wSelectedPlayer]
    or a
    jr z, Label3F0DE8
    ld hl, jillMapCursor+8 ;$4CFC
Label3F0DE8
    ld bc, $0C08
    ld a, [wSelectedPlayer]
    or a
    jr nz, Loop3F0DF4
    ld bc, $0A06
Loop3F0DF4:
    push de
    push bc
    push hl
    ld a, [wMenuSelGridId]
    cp a, COMBINE_GRID_MODE ;$E0
    jr c, Label3F0E00
    sub a, COMBINE_GRID_MODE ;$E0
Label3F0E00
    cp a, [hl]
    jr nz, Label3F0E40 ;jump if cursor id are not equal
    dec hl
    ld a, [hld]
    ld [wCursorTilesHeight], a ;cursor tiles height
    ld a, [hld]
    ld [wCursorTilesWidth], a ;cursor tiles width
    ld a, [hld]
    ld e, [hl] ;set selected cursor tiles addr into de
    ld d, a
    ld a, b
    sub a, c
    cp a, $05
    jr nc, Label3F0E38
    or a
    jr z, Label3F0E38
    ld c, a
    ld a, $05
    sub a, c
    ld c, a
    push hl ;store selected cursor addr
    ld hl, wMenuSelGridId
    add a, l
    ld l, a
    ld a, $00
    adc a, h
    ld h, a
    ld a, [hl]
    pop hl ;restore selected cursor addr
    or a
    jr z, Label3F0E38
    ld a, c
    add a
    add a
    add a
    add a
    add a
    add a, e
    ld e, a
    ld a, $00
    adc a, d
    ld d, a
Label3F0E38
    dec hl
    dec hl
    dec hl
    ld a, [hld] ;set cursor map position addr
    ld l, [hl]
    ld h, a
    jr Label3F0E7B
Label3F0E40
    dec hl
    ld a, [hld]
    ld [wCursorTilesHeight], a ;cursor tile height
    ld a, [hld]
    ld [wCursorTilesWidth], a ;cursor tile width
    dec hl
    dec hl
    ld a, [hld] ;set unselected cursor tile addr
    ld e, [hl]
    ld d, a
    ld a, b
    sub a, c
    cp a, $05
    jr nc, Label3F0E77
    or a
    jr z, Label3F0E77
    ld c, a
    ld a, $05
    sub a, c
    ld c, a
    push hl
    ld hl, wMenuSelGridId
    add a, l
    ld l, a
    ld a, $00
    adc a, h
    ld h, a
    ld a, [hl]
    pop hl
    or a
    jr z, Label3F0E77
    ld a, c
    add a
    add a
    add a
    add a
    add a
    add a, e
    ld e, a
    ld a, $00
    adc a, d
    ld d, a
Label3F0E77
    dec hl
    ld a, [hld] ;set cursor map position in hl
    ld l, [hl]
    ld h, a
Label3F0E7B
    ld a, [wMenuSelGridId]
    cp a, $E0
    jr c, Label3F0E86
    ld a, e
    sub a, $03
    ld e, a
Label3F0E86
    call loadMenuTiles
    pop hl
    ld de, $9
    add hl, de
    pop bc
    dec b
    pop de
    ld a, b
    cp a, e
    jp nz, Loop3F0DF4
    ret
;4E97

loadMenuTiles: ;FC:4E97
;de: source tiles
;hl: tiles target
    ld a, [wCursorTilesHeight]
    ld b, a
tilesHeightLoop
    push de
    push hl
    ld a, [wCursorTilesWidth]
    ld c, a
tilesWidthLoop
    call VBlankWait
    ld a, [de]
    ld [hli], a
    inc de
    dec c
    jr nz, tilesWidthLoop
    pop hl
    ld de, $20 ;add next tile line offset (32 tiles long)
    add hl, de
    pop de
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    dec b
    jr nz, tilesHeightLoop
    ret
;4EBC

itemBoxMenuData:		INCBIN "gfx/tilemaps/itemBoxMenu.2bpp" ;4EBC
itemBoxMenuPallete:		INCBIN "gfx/tilemaps/itemBoxMenu.pal" ;5B60

;5BE0 rest of bank empty

SECTION "bankFD",ROMX,BANK[$FD]

roomsBoundaries: INCLUDE "main/roomsBoundaries.asm" ;4000

checkRoomBoundaries:: ;FD:43A0
;checkLeftBorder
    ld a, [wRoomId]
    ld l, a
    ld a, [wRoomIdHigh]
    ld h, a
    add hl, hl
    add hl, hl
    add hl, hl
    ld de, roomsBoundaries ;$4000
    add hl, de
    ld a, [wSpritePositionXLow]
    ld e, a
    ld a, [wSpritePositionXHigh]
    ld d, a
    call div8SignedWordFD
    push hl
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld a, d
    cp a, b
    jr nz, checkRightBorder ;jump to next check if coordinates not match
	;if match
    ld a, e
    cp a, c
    jr nc, checkTopBorder ;if inside left border
	;else, set posX to limit
    ld e, c
    call multiply8SignedWordFD
    ld a, e
    ld [wSpritePositionXLow], a
    ld a, d
    ld [wSpritePositionXHigh], a
    jr checkTopBorder ;jump to check y-axis
checkRightBorder
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld a, d
    cp a, b
    jr nz, checkTopBorder ;jump to next check if coordinates not match
    ld a, e
    cp a, c
    jr c, checkTopBorder ;if inside right border
	;else, set pos X to right limit
    ld e, c
    call multiply8SignedWordFD
    ld a, e
    ld [wSpritePositionXLow], a
    ld a, d
    ld [wSpritePositionXHigh], a
checkTopBorder
    pop hl
    ld bc, $0004 ;offset to top border
    add hl, bc
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld a, [wSpritePositionZLow]
    ld e, a
    ld a, [wSpritePositionZHigh]
    ld d, a
    call div8SignedWordFD
    ld a, d
    cp a, b
    jr nz, checkBottomBorder ;jump to next check if coordinates not match
    ld a, e
    cp a, c
    jr nc, finishBoundaryCheck ;finish if inside boundary
	;limit top pos if beyond limit
    ld e, c
    call multiply8SignedWordFD
    ld a, e
    ld [wSpritePositionZLow], a
    ld a, d
    ld [wSpritePositionZHigh], a
    jr finishBoundaryCheck
checkBottomBorder
    ld c, [hl]
    inc hl
    ld b, [hl]
    inc hl
    ld a, d
    cp a, b
    jr nz, finishBoundaryCheck ;finish if  coordinates not match
    ld a, e
    cp a, c
    jr c, finishBoundaryCheck ;finish if inside boundary
	;limit bottom pos if beyond limit
    ld e, c
    call multiply8SignedWordFD
    ld a, e
    ld [wSpritePositionZLow], a
    ld a, d
    ld [wSpritePositionZHigh], a
finishBoundaryCheck
    ret
;4430

INCLUDE "main/roomsCollidersTable.asm"
INCLUDE "main/roomsCollidersData.asm"

checkRoomsColliders:: ;FD:511C
    ld a, [wRoomId]
    ld l, a
    ld a, [wRoomIdHigh]
    ld h, a
    add hl, hl ;pointer offset
    ld de, roomsCollidersTable ;$4430
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld a, [hli] ;get colliders struct address
    or a
    ret z
    ld b, a ;set colliders count
collidersLoop:
    push bc
    ld a, [hli]
    ld [wLowColliderRightX], a
    ld c, a
    ld a, [hli]
    ld [wHighColliderRightX], a
    ld b, a
    inc hl
    inc hl
    ld a, [hli]
    add a, c
    ld [wLowColliderLeftX], a
    ld a, [hld]
    adc a, b
    ld [wHighColliderLeftX], a
    dec hl
    dec hl
    ld a, [hli]
    ld [wLowColliderBottomY], a
    ld c, a
    ld a, [hli]
    ld [wHighColliderBottomY], a
    ld b, a
    inc hl
    inc hl
    ld a, [hli]
    add a, c
    ld [wLowColliderTopY], a
    ld a, [hli]
    adc a, b
    ld [wHighColliderTopY], a
    push hl
	;check collider collision
    ld a, [wSpritePositionXLow]
    ld e, a
    ld a, [wSpritePositionXHigh]
    ld d, a
    call div8SignedWordFD
    push de
    ld a, [wSpritePositionZLow]
    ld e, a
    ld a, [wSpritePositionZHigh]
    ld d, a
    call div8SignedWordFD
    ld l, e
    ld h, d
    pop de
    call checkRoomCollisions
    pop hl
    pop bc
    dec b
    jp nz, collidersLoop
    ret
;5184

checkRoomCollisions: ;FD:5184
;de: player x pos
;hl: player y pos
    ld a, [wLowColliderRightX]
    sub a, e
    ld a, [wHighColliderRightX]
    sbc a, d
    cp a, $FF
    ret nz
    ld a, [wLowColliderLeftX]
    sub a, e
    ld a, [wHighColliderLeftX]
    sbc a, d
    or a
    ret nz
    ld a, [wLowColliderBottomY]
    sub a, l
    ld a, [wHighColliderBottomY]
    sbc a, h
    cp a, $FF
    ret nz
    ld a, [wLowColliderTopY]
    sub a, l
    ld a, [wHighColliderTopY]
    sbc a, h
    or a
    ret nz
    push de
    push hl
    ld a, [wSpriteRoomPositionXLow]
    ld e, a
    ld a, [wSpriteRoomPositionXHigh]
    ld d, a
    ld a, [wSpriteRoomPositionYLow]
    ld l, a
    ld a, [wSpriteRoomPositionYHigh]
    ld h, a
;evalBottomCollider
    ld a, [wLowColliderBottomY]
    sub a, l
    ld a, [wHighColliderBottomY]
    sbc a, h
    or a
    jr nz, evalTopCollider
    ld a, [wLowColliderBottomY]
    ld e, a
    ld a, [wHighColliderBottomY]
    ld d, a
    call multiply8SignedWordFD
    ld a, e
    sub a, $01
    ld [wSpritePositionZLow], a
    ld a, d
    sbc a, $00
    ld [wSpritePositionZHigh], a
    pop hl
    pop de
    ret
;51E5

evalTopCollider: ;FD:51E5
    ld a, [wLowColliderTopY]
    sub a, l
    ld a, [wHighColliderTopY]
    sbc a, h
    cp a, $FF
    jr nz, evalRightCollider
    ld a, [wLowColliderTopY]
    ld e, a
    ld a, [wHighColliderTopY]
    ld d, a
    call multiply8SignedWordFD
    ld a, e
    add a, $08
    ld [wSpritePositionZLow], a
    ld a, d
    adc a, $00
    ld [wSpritePositionZHigh], a
    pop hl
    pop de
    ret
;520B

evalRightCollider: ;FD:520B
    ld a, [wLowColliderRightX]
    sub a, e
    ld a, [wHighColliderRightX]
    sbc a, d
    or a
    jr nz, evalLeftCollider
    ld a, [wLowColliderRightX]
    ld e, a
    ld a, [wHighColliderRightX]
    ld d, a
    call multiply8SignedWordFD
    ld a, e
    sub a, $01
    ld [wSpritePositionXLow], a
    ld a, d
    sbc a, $00
    ld [wSpritePositionXHigh], a
    pop hl
    pop de
    ret
;5230

evalLeftCollider: ;FD:5230
    ld a, [wLowColliderLeftX]
    ld e, a
    ld a, [wHighColliderLeftX]
    ld d, a
    call multiply8SignedWordFD
    ld a, e
    add a, $08
    ld [wSpritePositionXLow], a
    ld a, d
    adc a, $00
    ld [wSpritePositionXHigh], a
    pop hl
    pop de
    ret
;524A


div8SignedWordFD: ;FD:524A
    ld a, d
    cp a, $80
    jr c, Label3F5262
    call reverseWordSignFD
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    call reverseWordSignFD
    ret
Label3F5262: ;FD:5262
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    ret
;526F

multiply8SignedWordFD: ;FD:526F
    ld a, d
    cp a, $80
    jr c, Label3F5284
    call reverseWordSignFD
    push hl
    push de
    pop hl
    add hl, hl
    add hl, hl
    add hl, hl
    push hl
    pop de
    pop hl
    call reverseWordSignFD
    ret
Label3F5284: ;FD:5284
    push hl
    push de
    pop hl
    add hl, hl
    add hl, hl
    add hl, hl
    push hl
    pop de
    pop hl
    ret
;528E

reverseWordSignFD: ;FD:528E
    ld a, $00
    sub a, e
    ld e, a
    ld a, $00
    sbc a, d
    ld d, a
    ret
;5297



Function3F5297: ;FD:5297
    ld a, [wRoomId]
    cp a, MAIN_LAB_ENTRY ; corridor to tyrant's room
    jp z, Function3F52A0
    ret

Function3F52A0:: ;FD:52A0
    ld a, [wRoomScreen]
    cp a, $05
    jr z, .Label3F52A8
    ret
.Label3F52A8: ;FD:52A8
    ld hl, _SCRN0+$131
    ld b, $02
    call Label3F52D9
    ld hl, _SCRN0+$151
    ld b, $02
    call Label3F52D9
    ld hl, _SCRN0+$171
    ld b, $02
    call Label3F52D9
    ld hl, _SCRN0+$191
    ld b, $02
    call Label3F52D9
    ld hl, _SCRN0+$1B1
    ld b, $02
    call Label3F52D9
    ld hl, _SCRN0+$1D1
    ld b, $02
    call Label3F52D9
    ret

Label3F52D9:: ;FD:52D9
    ld a, $01
    ld [vramBank], a ;vram bank select
.loop3F52DD
    call VBlankWait
    ld a, [hl]
    or a, $80
    ld [hli], a
    dec b
    jr nz, .loop3F52DD
    xor a
    ld [vramBank], a ;vram bank select
    ret


;FD:52EB

INCLUDE "engine/spritesTables/chrisSpritesTable.asm"
INCLUDE "engine/spritesTables/jillSpritesTable.asm"
INCLUDE "engine/spritesTables/weskerBarrySpritesTable.asm"
INCLUDE "engine/spritesTables/rebeccaSpritesTable.asm"
INCLUDE "engine/spritesTables/zombieSpritesTable.asm"
INCLUDE "engine/spritesTables/objectsSpritesTable.asm"
INCLUDE "engine/spritesTables/yawnSpritesTable.asm"

;FD:69EB

;yawn spritesheet
yawn_back_right_spritesheet:	INCBIN "gfx/sprite_sheets/yawn/yawn_back_right_spritesheet.2bpp"

SECTION "bank_FE",ROMX,BANK[$FE]
yawn_right_spritesheet:			INCBIN "gfx/sprite_sheets/yawn/yawn_right_spritesheet.2bpp"
yawn_front_right_spritesheet:   INCBIN "gfx/sprite_sheets/yawn/yawn_front_right_spritesheet.2bpp"
yawn_front_spritesheet:      	INCBIN "gfx/sprite_sheets/yawn/yawn_front_spritesheet.2bpp"
yawn_front_left_spritesheet:    INCBIN "gfx/sprite_sheets/yawn/yawn_front_left_spritesheet.2bpp"
yawn_left_spritesheet:      	INCBIN "gfx/sprite_sheets/yawn/yawn_left_spritesheet.2bpp"
yawn_back_left_spritesheet:     INCBIN "gfx/sprite_sheets/yawn/yawn_back_left_spritesheet.2bpp"
yawn_back_spritesheet:      	INCBIN "gfx/sprite_sheets/yawn/yawn_back_spritesheet.2bpp"



SECTION "play sample",ROMX,BANK[$FF]

INCLUDE "audio/samples/play_sample.asm"

ResidentSample::  INCBIN "audio/samples/resident_sample.bin" ;FF:409C
;4CCC

REPT $4A
 db $00
ENDR

;4D16
 db $C6, $0C, $00, $00

EvilSample::      INCBIN "audio/samples/evil_sample.bin" ;FF:4D1A




