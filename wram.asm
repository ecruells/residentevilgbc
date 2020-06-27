
SECTION "WRAM Bank 0", WRAM0

wWorkRamStart:: ;c000
	ds $c100 - $c000

wWRamStart::
wButtonPressId:: ; c100
	ds 1

wButtonsCombinationValue:: ;c101
	ds 1

wCurrentRomBank:: ;c102
	ds 1

wHaltCPUFlag:: ;c103
	ds 1

; 11: gbc mode
wInitialRegisterValue:: ;c104
	ds 1

wPaletteFadeCounter:: ;c105
	ds 1

tilemapImgStructPointerLo:: ;C106
	ds 1

tilemapImgStructPointerHi:: ;C107
	ds 1


wVramTilesCounter:: ;C108
	ds 1

wVramTileAttributes:: ;C109
	ds 1


wBgCurrentPointerBankId:: ;c10A
	ds 1

wBgStartBankId:: ;C10B
	ds 1

wPoliceCardXpos:: ;c10c
	ds 1

wPoliceCardYpos:: ;c10d
	ds 1

wCursorPosId:: ;C10E
	ds 1

; 00: load game mode
; 01: save game mode
wLoadOrSave:: ;C10F
	ds 1


wPressingUpKey:: ;C110
	ds 1

wPressingDownKey:: ;C111
	ds 1


wFrameRateCounter:: ;c112
	ds 1


wSpriteTilesBufferPointer:: ;C113
	ds 2

wLastSpriteInSortedSpritesList:: ;C115
	ds 2


; 00 disabled
; 01 enabled
wHDMAFlag:: ;C117
	ds 1

wCurrentSpriteHeight:: ;c118
	ds 1

wc119:: ;c119
	ds 1

wSpriteHalfBufferSize:: ;c11a
	ds 1

; 00 chris
; 01 jill
wSelectedCharacter:: ;c11b
	ds 1

wc11c:: ;c11c
	ds 1

wc11d:: ;c11d
	ds 1

wc11e:: ;c11e
	ds 1


wRoomCameraId:: ;c11F
	ds 1

;  0: $C9 default
;  1: $CA
wCurrentOAMBufferFlag:: ;C120
	ds 1


wCursorTilesWidth:: ;C121
	ds 1
wCursorTilesHeight:: ;C122
	ds 1


; 00 Map option
; 01 Radio option
; 02 File option
; 03 Exit option
; 04 item slot 1
; 05 item slot 2
; 06 item slot 3
; 07 item slot 4
; 08 item slot 5
; 09 item slot 6
; 0A item slot 7
; 0B item slot 8
; 0C File books
; 0E global map
; 0D radio
; 12 map detail
; 80 use/equip | itembox cursor
; 81 check
; 82 combine
; 84 item description
; E0 combine grid
; E4 combine item 1
; E5 combine item 2
; E6 combine item 3
; E7 combine item 4
; E8 combine item 5
; E9 combine item 6
; EA combine item 7
; EB combine item 8
; FF get item choice
wMainMenuSelectedCursorId:: ; C123
	ds 1

; 00: disable FF:enabled
wMenuMapEnable:: ;C124
	ds 1

; 00: disable FF:enabled
wMenuRadioEnable:: ;C125
	ds 1

; 00: disable FF:enabled
wMenuFileEnable:: ;C126
	ds 1

; 00: disable FF:enabled
wMenuExitEnable:: ;C127
	ds 1


wCurrentSpriteWidthId::
wCurrentSpriteWidth:: ;C128
	ds 1

wc129:: ;c129
	ds 1

;
;camera position & angles values
;
wCameraYawSin:: ;C12A
	ds 1
wCameraYawCos:: ;c12b
	ds 1
wCameraPitchSine:: ;C12C
	ds 1
wCameraPitchCos:: ;C12D
	ds 1
wCameraYawAngle:: ;c12E
	ds 2
wCameraPitchAngle:: ;c130
	ds 2
wCameraPositionX:: ;c132
	ds 2
wCameraPositionY:: ;c134
	ds 2
wCameraPositionZ:: ;c136
	ds 2
wCameraPositionTX:: ;c138
	ds 2
wCameraPositionTY:: ;c13A
	ds 2
wCameraPositionTZ:: ;c13C
	ds 2

wSpriteProjectedX:: ;c13E
	ds 2
wSpriteProjectedY:: ;c140
	ds 2
wSpriteProjectedZ:: ;c142
	ds 2

wSpriteRotatedX:: ;C144
wSpriteXSizeOffset::
	ds 2

wSpritePositionTY2:: ;c146
	ds 2

wRotatedSXCZ:: ;c148
wSpriteZSizeOffset::
	ds 2

wc14a:: ;c14a
	ds 1

wc14b:: ;c14b
	ds 1

wc14c:: ;c14c
	ds 1

wc14d:: ;c14d
	ds 1

wc14e:: ;c14e
	ds 1

wc14f:: ;c14f
	ds 1


; division vars
wDivisor:: ;c150-c151
	ds 2

wDivLoopCounter:: ;c152
	ds 1


wc153:: ;c153
	ds 1

; previous multiplication product
wPrevMultProduct:: ;c154
	ds 2

wc156:: ;c156
	ds 1

wc157:: ;c157
	ds 1

wc158:: ;c158
	ds 1

wc159:: ;c159
	ds 1

wc15a:: ;c15a
	ds 1

wc15b:: ;c15b
	ds 1


; doors sprites vars
wDoorSpriteFrameAddress:: ;C15C
	ds 2

wDoorSpriteYPos:: ;C15E
	ds 1

wDoorSpriteXPos:: ;C15F
	ds 1

wDoorSpritesUsedCounter:: ;C160
	ds 1

wDoorSpritesAttributes:: ;c161
	ds 1

wDoorAnimationFrameCounter:: ;c162
	ds 1


wRoomSpriteScreenXPos:: ;c163
	ds 1

wRoomSpriteScreenYPos:: ;c164
	ds 1

wSpritesOamUsedCounter:: ;C165
	ds 1


wc166:: ;c166
	ds 1

wc167:: ;c167
	ds 1

wc168:: ;c168
	ds 1

wc169:: ;c169
	ds 1

wc16a:: ;c16a
	ds 1


wPressingLeftKey:: ;C16B
	ds 1

wPressingRightKey:: ;C16C
	ds 1


; player + camera facing
wPlayerCamFacing:: ;C16D
	ds 1

; 00 south
; 04 south-west
; 08 west
; 0C north-west
; 10 north
; 14 north-east
; 18 east
; 1C south-east
wCameraFacing:: ;c16E
	ds 1

wCameraC16F:: ;c16F
	ds 1

; colliders borders vars
wColliderRectRightX:: ;c170
wRoomBgTileLeftX::
	ds 2
wColliderRectLeftX:: ;c172
wRoomBgTileRightX::
	ds 2
wColliderRectBottomY:: ;c174
wRoomBgTileTopY::
	ds 2
wColliderRectTopY:: ;c176
wRoomBgTileBottomY::
	ds 2


wc178:: ;c178
	ds 1

wc179:: ;c179
	ds 1

wc17a:: ;c17a
	ds 1

wc17b:: ;c17b
	ds 1


wRoomId:: ;c17C
	ds 1
wRoomIdHigh:: ;c17d
	ds 1


; 00: nothing
; 01: open door
; 02: typewriter
; 03: getting item
; 04: item box
; 05: normal action
wActionButtonEventId:: ;c17E
	ds 1


wCurrentSoundId:: ;C17F
	ds 1

wCurrentMusicId:: ;C180
	ds 1


wSavesCounter:: ;C181
	ds 1

wRoomInteractionID:: ;C182
	ds 1

wDoorInteractionID:: ;C183
	ds 1

wTigerStatueRotateDirection:: ;C184
	ds 1

; 32 item slots (00-1F)
wSelectedItemBoxSlotId:: ;C185
	ds 1

; 39 files flags
wFilesFlags:: ;C186
	ds 39

wc1ad:: ;c1ad
	ds 1


; 13 bookmarks (0-12)
wFileBookmarkCursorPos:: ;C1AE
	ds 1

wPressingAButton:: ;C1AF
	ds 1

wAnimatedRoomSpritesFrameCounter:: ;c1b0
	ds 1

wRoomGasActivatedFlag:: ;C1B1
	ds 1

wSpiderwebKnifeCutsCounter:: ;c1b2
	ds 1

wc1b3:: ;c1b3
	ds 1

wc1b4:: ;c1b4
	ds 1

wc1b5:: ;c1b5
	ds 1


; 00: single mansion door 1 (4 panels)
; 01: single mansion door 2 (6 panels)
; 02: single mansion door 3 (6 diamond panels)
; 08: double mansion door 1
; 09: double mansion door 2
; 0A: double mansion door 3
wDoorSpriteId:: ;C1B6
	ds 1


; 00: brown
; 01: blue
; 02: light brown
wDoorPaletteId:: ;C1B7
	ds 1


wFoundItemId:: ;C1B8
	ds 1


wSaveGameFlag1:: ;C1B9
	ds 1
wSaveGameFlag2:: ;C1BA
	ds 1

wc1bb:: ;c1bb
	ds 1

wSaveGameFlag3:: ;C1BC
	ds 1


wc1bd:: ;c1bd
	ds 1

wc1be:: ;c1be
	ds 1


wEventSceneId:: ;c1bf
	ds 1

wScreenYPos:: ;c1c0
	ds 1

wRoomItemAttributes:: ;c1c1
	ds 1

wCurrentSpriteCharId:: ;c1c2
	ds 1

; door type < 7C : normal sprite doors animations
; door type < 88 : Background type animations
;				  < 7E: stairs 1
;				  < 80: stairs 2
;				  < 82: stairs 3
;				  < 84: Ladder 1
;				  < 86: Rope
;				  = 14: Ladder 2
; door type >= 88 : Elevator animations
;				  < 8C: Mansion elevator
;				  < 90: Heliport elevator
wDoorAnimationType:: ;c1c3
	ds 1


wTicksCounter:: ;c1c4
	ds 1

wTicksCounterHigh:: ;c1c5
	ds 1


wLoadEventBgImagePal:: ;C1C6
	ds 1

wRoomItemId:: ;C1C7
	ds 1


wPcmTempoLo:: ;c1c8
	ds 1

wPcmTempoHi:: ;c1c9
	ds 1

wc1ca:: ;c1ca
	ds 1

; map vars
wRoomMapRectX:: ;C1CB
	ds 1
wRoomMapRectY:: ;C1CC
	ds 1
wRoomMapRectWidth:: ;C1CD
	ds 1
wRoomMapRectHeight:: ;C1CE
	ds 1
wRoomMapRectId:: ;C1CF
	ds 1
wRoomMapRectIdHigh:: ;C1D0
	ds 1
wRoomMapHeightCounter:: ;C1D1
	ds 1


wRoomBgTilesDataPointerLo:: ;C1D2
	ds 1
wRoomBgTilesDataPointerHi:: ;C1D3
	ds 1


; 00: filebook 1
; 01: filebook 2
; 02: filebook 3
wFileBookId:: ;C1D4
	ds 1

; unused entity sprite position vars
wUnusedSpritePositionX:: ;c1D5
	ds 2
wUnusedSpritePositionY:: ;c1D7
	ds 2
wUnusedSpritePositionZ:: ;c1D9
	ds 2

wXScaleFactor:: ;c1DB
	ds 2
wYScaleFactor:: ;c1DD
	ds 2
wZScaleFactor:: ;c1DF
	ds 2

wCameraReverseYawSin:: ;C1E1
	ds 1
wCameraReverseYawCos:: ;C1E2
	ds 1

; 0: normal
; 1: overhead
wCameraType:: ;c1E3
	ds 1


wButtonActionFacing:: ;C1E4
	ds 1


wCurrentSpriteScreenX:: ;C1E5
	ds 1
wCurrentSpriteScreenY:: ;C1E6
	ds 1


wItemIdSlot1:: ;C1E7
	ds 1
wItemIdSlot2:: ;C1E8
	ds 1
wItemIdSlot3:: ;C1E9
	ds 1
wItemIdSlot4:: ;C1EA
	ds 1
wItemIdSlot5:: ;C1EB
	ds 1
wItemIdSlot6:: ;C1EC
	ds 1
wItemIdSlot7:: ;C1ED
	ds 1
wItemIdSlot8:: ;C1EE
	ds 1

wEquippedItemId:: ;C1EF
	ds 1


wc1f0:: ;c1f0
	ds 1

; hardware sprites used counter
wSpritesUsedCounter:: ;C1F1
	ds 1

wBgTransitionDirCounter:: ;C1F2
	ds 1


wSelectedSlotId:: ;C1F3
	ds 1
wSelectedItemId:: ;C1F4
	ds 1

; used to store facing value, but is never read.
wc1f5:: ;c1f5
	ds 1


charTileXPosition:: ;c1f6
	ds 1
charTileYPosition:: ;c1f7
	ds 1

wTextCharTileXPos:: ;C1F8
	ds 1
wTextCharTileYPos:: ;C1F9
	ds 1

; 00: yes
; 01: no
wChoiceId:: ;C1FA
	ds 1


wPressingBButton:: ;C1FB
	ds 1

wCursorIdBuffer:: ;C1FC
	ds 1

wTypingCharactersFlag:: ;C1FD
	ds 1

wRoomMusicId:: ;C1FE
	ds 1

wDoorLockFlagId:: ;c1ff
	ds 1


; 19 visited rooms variables
wVisitedRoomsFlags:: ;C200
	ds 19


wc213:: ;c213
	ds 1

wc214:: ;c214
	ds 1

wc215:: ;c215
	ds 1

wc216:: ;c216
	ds 1

wc217:: ;c217
	ds 1

wc218:: ;c218
	ds 1

wc219:: ;c219
	ds 1

wc21a:: ;c21a
	ds 1

wc21b:: ;c21b
	ds 1

wc21c:: ;c21c
	ds 1

wc21d:: ;c21d
	ds 1

wc21e:: ;c21e
	ds 1

wc21f:: ;c21f
	ds 1

wc220:: ;c220
	ds 1

wc221:: ;c221
	ds 1

wc222:: ;c222
	ds 1

wc223:: ;c223
	ds 1

wc224:: ;c224
	ds 1

wc225:: ;c225
	ds 1

wc226:: ;c226
	ds 1

wc227:: ;c227
	ds 1

wc228:: ;c228
	ds 1

wc229:: ;c229
	ds 1

wc22a:: ;c22a
	ds 1

wc22b:: ;c22b
	ds 1

wc22c:: ;c22c
	ds 1

wc22d:: ;c22d
	ds 1

wc22e:: ;c22e
	ds 1

wc22f:: ;c22f
	ds 1

wc230:: ;c230
	ds 1

wc231:: ;c231
	ds 1

wc232:: ;c232
	ds 1

wc233:: ;c233
	ds 1

wc234:: ;c234
	ds 1

wc235:: ;c235
	ds 1

wc236:: ;c236
	ds 1

wc237:: ;c237
	ds 1

wc238:: ;c238
	ds 1

wc239:: ;c239
	ds 1

wc23a:: ;c23a
	ds 1

wc23b:: ;c23b
	ds 1

wc23c:: ;c23c
	ds 1

wc23d:: ;c23d
	ds 1

wc23e:: ;c23e
	ds 1

wc23f:: ;c23f
	ds 1

wc240:: ;c240
	ds 1

wc241:: ;c241
	ds 1

wc242:: ;c242
	ds 1

wc243:: ;c243
	ds 1

wc244:: ;c244
	ds 1

wc245:: ;c245
	ds 1

wc246:: ;c246
	ds 1

wc247:: ;c247
	ds 1

wc248:: ;c248
	ds 1

wc249:: ;c249
	ds 1

wc24a:: ;c24a
	ds 1

wc24b:: ;c24b
	ds 1

wc24c:: ;c24c
	ds 1

wc24d:: ;c24d
	ds 1

wc24e:: ;c24e
	ds 1

wc24f:: ;c24f
	ds 1

wc250:: ;c250
	ds 1

wc251:: ;c251
	ds 1

wc252:: ;c252
	ds 1

wc253:: ;c253
	ds 1

wc254:: ;c254
	ds 1

wc255:: ;c255
	ds 1

wc256:: ;c256
	ds 1

wc257:: ;c257
	ds 1

wc258:: ;c258
	ds 1

wc259:: ;c259
	ds 1

wc25a:: ;c25a
	ds 1

wc25b:: ;c25b
	ds 1

wc25c:: ;c25c
	ds 1

wc25d:: ;c25d
	ds 1

wc25e:: ;c25e
	ds 1

wc25f:: ;c25f
	ds 1

wc260:: ;c260
	ds 1

wc261:: ;c261
	ds 1

wc262:: ;c262
	ds 1

wc263:: ;c263
	ds 1

wc264:: ;c264
	ds 1

wc265:: ;c265
	ds 1

wc266:: ;c266
	ds 1

wc267:: ;c267
	ds 1

wc268:: ;c268
	ds 1

wc269:: ;c269
	ds 1

wc26a:: ;c26a
	ds 1

wc26b:: ;c26b
	ds 1

wc26c:: ;c26c
	ds 1

wc26d:: ;c26d
	ds 1

wc26e:: ;c26e
	ds 1

wc26f:: ;c26f
	ds 1

wc270:: ;c270
	ds 1

wc271:: ;c271
	ds 1

wc272:: ;c272
	ds 1

wc273:: ;c273
	ds 1

wc274:: ;c274
	ds 1

wc275:: ;c275
	ds 1

wc276:: ;c276
	ds 1

wc277:: ;c277
	ds 1

wc278:: ;c278
	ds 1

wc279:: ;c279
	ds 1

wc27a:: ;c27a
	ds 1

wc27b:: ;c27b
	ds 1

wc27c:: ;c27c
	ds 1

wc27d:: ;c27d
	ds 1

wc27e:: ;c27e
	ds 1

wc27f:: ;c27f
	ds 1


;
; item box slots, 32 slots in total
;
wItemBoxSlot01:: ;C280
	ds 32


wC2A0:: ;C2A0
	ds 1

wc2a1:: ;c2a1
	ds 1

wc2a2:: ;c2a2
	ds 1

wc2a3:: ;c2a3
	ds 1

wc2a4:: ;c2a4
	ds 1

wc2a5:: ;c2a5
	ds 1

wc2a6:: ;c2a6
	ds 1

wc2a7:: ;c2a7
	ds 1

wc2a8:: ;c2a8
	ds 1

wc2a9:: ;c2a9
	ds 1

wc2aa:: ;c2aa
	ds 1

wc2ab:: ;c2ab
	ds 1

wc2ac:: ;c2ac
	ds 1

wc2ad:: ;c2ad
	ds 1

wc2ae:: ;c2ae
	ds 1

wc2af:: ;c2af
	ds 1

wC2b0:: ;C2b0
	ds 1

wc2b1:: ;c2b1
	ds 1

wc2b2:: ;c2b2
	ds 1

wc2b3:: ;c2b3
	ds 1

wc2b4:: ;c2b4
	ds 1

wc2b5:: ;c2b5
	ds 1

wc2b6:: ;c2b6
	ds 1

wc2b7:: ;c2b7
	ds 1

wc2b8:: ;c2b8
	ds 1

wc2b9:: ;c2b9
	ds 1

wc2ba:: ;c2ba
	ds 1

wc2bb:: ;c2bb
	ds 1

wc2bc:: ;c2bc
	ds 1

wc2bd:: ;c2bd
	ds 1

wc2be:: ;c2be
	ds 1

wc2bf:: ;c2bf
	ds 1

;
; numeric panel puzzle vars
;
wNumPanelKey01PressedFlag:: ;C2C0
	ds 1
wNumericPanelKey01PosY:: ;C2C1
	ds 1
wNumericPanelKey01PosX:: ;C2C2
	ds 1
wNumPanelKey02PressedFlag:: ;C2C3
	ds 1
wNumericPanelKey02PosY:: ;C2C4
	ds 1
wNumericPanelKey02PosX:: ;C2C5
	ds 1
wNumPanelKey03PressedFlag:: ;C2C6
	ds 1
wNumericPanelKey03PosY:: ;C2C7
	ds 1
wNumericPanelKey03PosX:: ;C2C8
	ds 1
wNumPanelKey04PressedFlag:: ;C2C9
	ds 1
wNumericPanelKey04PosY:: ;C2CA
	ds 1
wNumericPanelKey04PosX:: ;C2CB
	ds 1
wNumPanelKey05PressedFlag:: ;C2CC
	ds 1
wNumericPanelKey05PosY:: ;C2CD
	ds 1
wNumericPanelKey05PosX:: ;C2CE
	ds 1
wNumPanelKey06PressedFlag:: ;C2CF
	ds 1
wNumericPanelKey06PosY:: ;C2D0
	ds 1
wNumericPanelKey06PosX:: ;C2D1
	ds 1
wNumPanelKey07PressedFlag:: ;C2D2
	ds 1
wNumericPanelKey07PosY:: ;C2D3
	ds 1
wNumericPanelKey07PosX:: ;C2D4
	ds 1
wNumPanelKey08PressedFlag:: ;C2D5
	ds 1
wNumericPanelKey08PosY:: ;C2D6
	ds 1
wNumericPanelKey08PosX:: ;C2D7
	ds 1
wNumPanelKey09PressedFlag:: ;C2D8
	ds 1
wNumericPanelKey09PosY:: ;C2D9
	ds 1
wNumericPanelKey09PosX:: ;C2DA
	ds 1


wc2db:: ;c2db
	ds 1

wc2dc:: ;c2dc
	ds 1

wc2dd:: ;c2dd
	ds 1

wc2de:: ;c2de
	ds 1

wc2df:: ;c2df
	ds 1


wNumericPanelKeyId:: ;C2E0
	ds 1

; boulder rotate floor
; 00: bottom
; 01: medium
; 02: left
wRotateFloor2AnimId:: ;C2E1
	ds 1

; 00: top
; 01: medium
; 02: left
; 03: medium
; 04: below
wRotateFloor1AnimId:: ;C2E2
	ds 1


wComputerKeyboardKeyId:: ;C2E3
	ds 1
wCompKeyboardKeyIdUpdated:: ;C2E4
	ds 1

wc2e5:: ;c2e5
	ds 1

wc2e6:: ;c2e6
	ds 1

wc2e7:: ;c2e7
	ds 1

wComputerLoginEntered:: ;C2E8
	ds 1
wLoginPasswordLastCharId:: ;C2E9
	ds 1

; 00: B2
; 01: B3
; 02: Cancel
wElectronicUnlockFloorSelectId:: ;C2EA
	ds 1

; 00: Login Password
; 01: E. Locks Password
wComputerPasswordMode:: ;C2EB
	ds 1

wComputerLoginChar01:: ;C2EC
	ds 1
wComputerLoginChar02:: ;C2ED
	ds 1
wComputerLoginChar03:: ;C2EE
	ds 1
wComputerLoginChar04:: ;C2EF
	ds 1
wComputerLoginStringEnd:: ;C2F0
	ds 1

wComputerPasswordChar01:: ;C2F1
	ds 1
wComputerPasswordChar02:: ;C2F2
	ds 1
wComputerPasswordChar03:: ;C2F3
	ds 1
wComputerPasswordChar04:: ;C2F4
	ds 1
wComputerPasswordStringEnd:: ;C2F5
	ds 1


wc2f6:: ;c2f6
	ds 1

wc2f7:: ;c2f7
	ds 1

wc2f8:: ;c2f8
	ds 1


wMaskAddressLow:: ;C2F9
	ds 1
wMaskAddressHigh:: ;C2FA
	ds 1

wMaskOffsetLow:: ; C2FB
	ds 1
wMaskOffsetHigh:: ; C2FC
	ds 1

wMaskOnSpriteOffset:: ; C2FD
	ds 1
wMaskIntersectHeight:: ; C2FE
	ds 1

wCurrentSpriteZOrder:: ;C2FF
	ds 1


; Data struct list for all entities (player and NPCs)
;
; 32 bytes for each entity struct (8 entities max)
;
; player entity struct is always the first (c300), NPC entities start at c320 to c3e0
;
; C3X0+00: entity state
;		bit 7: enabled
;		bit 6: visible
; c3X0+01: Z order
; c3X0+02: Screen X position
; c3X0+03: Screen Y position
; c3X0+04: Width
; c3X0+05: Height
; C3X0+06: animation Id
; C3X0+07: animation frame Id
; C3X0+09: facing
; C3X0+0A: weapon firegun pause timer
; C3X0+0B: Entity Id
; C3X0+0C: firegun entity frames
; C3X0+0D: Blood entity frames
; C3X0+0E: health  32: full
; C3X0+0F: zombie/object var id
; C3X0+10: zombie/object var id High
; C3X0+11-C3X0+12: entity X pos (low-hi signed 16bit number)
; C3X0+13-C3X0+14: entity Z pos (low-hi signed 16bit number)
; C3X0+15-C3X0+16: entity map X position (low-hi signed 16bit number)
; C3X0+17-C3X0+18: entity map Z position (low-hi signed 16bit number)
; C3X0+19-C3X0+1A: entity Y position (entity elevation) (low-hi signed 16bit number)
; C3X0+1B: player input block timer
; C3X0+1C: enemy recoil timer
;
wEntityStructData:: ;c300
wEntityState:: ; c300
	ds 1
wEntityZOrder:: ;c301
	ds 1
wEntityScreenX:: ;c302
	ds 1
wEntityScreenY:: ;c303
	ds 1
wEntityWidth:: ;c304
	ds 1
wEntityHeight:: ;c305
	ds 1
wEntityAnimationId:: ;c306
	ds 1
wEntityAnimationFrameId:: ;c307
	ds 1
wEntityDataC308:: ;c308
	ds 1
wEntityFacing:: ;c309
	ds 1
wWeaponBlockTimer:: ;c30A
	ds 1
wEntityId:: ;c30B
	ds 1
wFiregunFramesId:: ;c30C
	ds 1
wBloodFramesId:: ;c30D
	ds 1
wEntityHealth:: ;c30E
	ds 1
wZombieAndObjectVarId:: ;c30F object movement
	ds 1
wZombieAndObjectVarIdHigh:: ;c310
	ds 1
wEntityPositionX:: ;c311-c312
	ds 2
wEntityPositionZ:: ;c313-c314
	ds 2
wEntityRoomPositionX:: ;c315-c316
	ds 2
wEntityRoomPositionZ:: ;c317-c318
	ds 2
wEntityPositionY:: ;c319-c31a
	ds 2
wMoveInputBlockTimer:: ;c31B
	ds 1
wZombieRecoilTimer::  ;c31C zombieRecoilTimer
	ds 1
wEntityDataC31D::  ;c31D
	ds 1
wEntityDataC31E::  ;c31E
	ds 1
wStepLadderElevationMode::  ;c31F step ladder elevation mode
	ds 1

; rest of NPC entities data structs
wNPCEntitiesDataStructs:: ;c320
	ds 32 * 7

;wEndCharSpritesData:: ;C3FF



; flags RAM

wDoorsLocksFlags:: ;c400
	ds 128

wEventsFlags::
wFirstZombieEventFlag:: ;c480
	ds 1

wADinningRoomEventFlag:: ;c481
	ds 1

wChrisMeetRebeccaFlag:: ;c482
	ds 1

wDiningRoomZombieSceneFlag:: ;c483
	ds 1

wBackToMainHallAsJillEventFlag:: ;c484
	ds 1

wPianoRoomSecretDoorOpenFlag:: ;c485
	ds 1

wFindForestCorpseFlag:: ;c486
	ds 1

wHerbicideUsedFlag:: ;c487
	ds 1

wJillBarryTalkInResearcherRoomFlag:: ;c488
	ds 1

wRichardFoundFlag:: ;c489
	ds 1

wRichardDiesFlag:: ;c48a
	ds 1

wBrokenJewelStatueFlag:: ;C48B
	ds 1

; large gallery paintings puzzle vars
wMidleAgeManPaintingSwitch:: ;C48C
	ds 1
wNewBornBabyPaintingSwitch:: ;C48D
	ds 1
wYoungManPaintingSwitch:: ;C48E
	ds 1
wInfantPaintingSwitch:: ;C48F
	ds 1
wLivelyBoyPaintingSwitch:: ;C490
	ds 1
wOldManPaintingSwitch:: ;C491
	ds 1
wPaintingsPuzzleSolvedFlag:: ;C492
	ds 1

; crests placed flags
wMoonCrestPlacedFlag:: ;c493
	ds 1
wSunCrestPlacedFlag:: ;c494
	ds 1
wStarCrestPlacedFlag:: ;c495
	ds 1
wWindCrestPlacedFlag:: ;c496
	ds 1

wBradRadioMsgInCourtyardFlag:: ;c497
	ds 1

wCourtyardFloodgateClosedFlag:: ;c498
	ds 1

wc499:: ;c499
	ds 1

; jill and werker conversation in werehouse
wDorm002EventSceneFlag:: ;C49A
	ds 1

wFloodedRoomsDrainedWaterFlag:: ;C49B
    ds 1
wVJoltUsedOnPlant42Flag:: ;C49C
	ds 1
wDorm003WhiteBookRemovedFlag:: ;C49D
	ds 1
wRedBookPlacedFlag:: ;C49E
	ds 1

wTalkWithWeskerInWarehouseFlag:: ;c49f
	ds 1

wPlant42DefeatedFlag:: ;c4a0
	ds 1

wJawnDeathSceneFLag:: ;c4a1
	ds 1

wMeetEnricoFlag:: ;c4a2
	ds 1

wc4a3:: ;c4a3
	ds 1

wc4a4:: ;c4a4
	ds 1

wVisualDataRoomPanelButtonOpened:: ;C4A5
	ds 1
wVisualDataRoomPillarMovedFlag:: ;C4A6
	ds 1

wMansionBathtubUnpluggedFlag:: ;C4A7
    ds 1

wDorm001BathroomTubUnplug:: ;C4A8
	ds 1

wc4a9:: ;c4a9
	ds 1

wMoDiskPasscode01FiledFlag:: ;C4AA
	ds 1
wMoDiskPasscode02FiledFlag:: ;C4AB
	ds 1
wMoDiskPasscode03FiledFlag:: ;C4AC
	ds 1

wBlackOutAreasPoweredFlag:: ;C4AD
	ds 1
wLabElevatorPoweredUpFlag:: ;C4AE
	ds 1

wPasscode01CheckedFlag:: ;C4AF
	ds 1
wPasscode02CheckedFlag:: ;C4B0
	ds 1
wPasscode03CheckedFlag:: ;C4B1
	ds 1

wLabElectronicDoorsUnlockFlag:: ;C4B2
	ds 1
wLabElectronicDoors2UnlockFlag:: ;C4B3
	ds 1

wTyrant1DefeatedFlag: ;C4B4
	ds 1

wChrisFoundRadioFlag:: ;c4b5
	ds 1

wFirstHunterKilledFlag:: ;c4b6
	ds 1

wRebeccaSavedFromDeathFlag:: ;c4b7
	ds 1

wChrisOrJillFoundInJailFlag:: ;c4b8
	ds 1

wBeforeTyrant1stBattleSceneFlag:: ;c4b9
	ds 1

wc4ba:: ;c4ba
	ds 1

wAfter1stTyrantSceneFlag:: ;c4bb
	ds 1

wc4bc:: ;c4bc
	ds 1

wLabAlertSceneWithChrisFlag:: ;c4bd
	ds 1

wChrisOrJillSavedFromJailFlag:: ;c4be
	ds 1

wSmallDinningRoomLittedCandleFlag:: ;C4BF
	ds 1

wTaxidermyRoomLightsFlag:: ;C4C0
	ds 1

wCourtyardStudyLightsFlag:: ;C4C1
	ds 1
wCatacombCrankWallStatueFlag:: ;C4C2
	ds 1

wUndergroundStatuePlacedFlag:: ;c4c3
	ds 1

wAfterJailEscapeSceneFlag:: ;c4c4
	ds 1

wChrisAndJillEscapingFromLabFlag:: ;c4c5
	ds 1

wLabEscapeRadioMessageReceivedFlag:: ;c4c6
	ds 1

wBeforeHeliportElevatorSceneFlag:: ;c4c7
	ds 1

wBrokenShotgunFallCeilingFlag:: ;c4c8
	ds 1

wTalkWithBarryInWarehouseRoomFlag:: ;c4c9
	ds 1

wBradRadioMsgAfterWarehouseFlag:: ;c4ca
	ds 1

wLoungeFireplaceLittedFlag:: ;C4CB
	ds 1
wBugCollectionButtonPushedFlag:: ;C4CC
	ds 1
wHiddenLibraryStatueLightsFlag:: ;C4CD
	ds 1
wFirearmsRoomDeskUnlocked:: ;C4CE
    ds 1

wc4cf:: ;c4cf
	ds 1

wc4d0:: ;c4d0
	ds 1

wc4d1:: ;c4d1
	ds 1

wc4d2:: ;c4d2
	ds 1

wc4d3:: ;c4d3
	ds 1

wArmorsRoomGasButtonPushedFlag:: ;C4D4
	ds 1

wDorm002ClosetMovedFlag:: ;c4d5
	ds 1

wXRayRoomBlueLightsFlag:: ;C4D6
	ds 1
wXRayRoomNormalLightsFlag:: ;C4D7
	ds 1

wLibrarySecretDoorOpenedFlag:: ;C4D8
	ds 1

wWolfMedalPlacedFlag:: ;C4D9
	ds 1
wEagleMedalPlacedFlag:: ;C4DA
	ds 1

wShowRopeInTrevorsTombFlag:: ;c4db
	ds 1

wTriggerTrevorTombSceneFlag:: ;c4dc
	ds 1

wMansionPasscodeFiledFlag:: ;C4DD
	ds 1

wAquariumWoodenBoxSunken:: ;C4DE
	ds 1

wProjectorSlidePlacedFlag:: ;C4DF
	ds 1

wMansion1FMapStepLadderPushed:: ;C4E0
	ds 1

wLabStepLadderPlacedFlag:: ;C4E1
	ds 1

wc4e2:: ;c4e2
	ds 1

wc4e3:: ;c4e3
	ds 1

wc4e4:: ;c4e4
	ds 1

wc4e5:: ;c4e5
	ds 1

wc4e6:: ;c4e6
	ds 1

wc4e7:: ;c4e7
	ds 1

wc4e8:: ;c4e8
	ds 1

wc4e9:: ;c4e9
	ds 1

wc4ea:: ;c4ea
	ds 1

wc4eb:: ;c4eb
	ds 1

wc4ec:: ;c4ec
	ds 1

wc4ed:: ;c4ed
	ds 1

wc4ee:: ;c4ee
	ds 1

wc4ef:: ;c4ef
	ds 1

wc4f0:: ;c4f0
	ds 1

wc4f1:: ;c4f1
	ds 1

wc4f2:: ;c4f2
	ds 1

wc4f3:: ;c4f3
	ds 1

wc4f4:: ;c4f4
	ds 1

wc4f5:: ;c4f5
	ds 1

wc4f6:: ;c4f6
	ds 1

wc4f7:: ;c4f7
	ds 1

wc4f8:: ;c4f8
	ds 1

wc4f9:: ;c4f9
	ds 1

wc4fa:: ;c4fa
	ds 1

wc4fb:: ;c4fb
	ds 1

wc4fc:: ;c4fc
	ds 1

wc4fd:: ;c4fd
	ds 1

wc4fe:: ;c4fe
	ds 1

wc4ff:: ;c4ff
	ds 1

;
; room items flags
;
; 0: item picked
; 1: item not picked
wRoomsItemsFlags::
wc500:: ;c500
	ds 256


wEnemiesAndObjectsFlags:: ;c600
wObjectEntitiesFlags::
wEnemiesFlags::
	ds 256

wc700:: ;c700
	ds $100


; stores all sprites draw data sorted by draw priority (Y-axis or Z-order)
; 10 bytes by sprite, 8 sprites max  (entities, room items, animation sprites)
;
; C80x + 0: Sprite draw priority value
; C80x + 1: Sprite id
; C80x + 2: Sprite id high
; C80x + 3: Sprite screen x
; C80x + 4: Sprite screen y
; C80x + 5: Sprite width
; C80x + 6: Sprite height
; C80x + 7: Sprite facing id
; C80x + 8: Sprite animation frame Id
; C80x + 9: Sprite animation Id
wSortedSpritesList:: ;C800
	ds 10 * 8

;wEndSortedSpritesList:: ;C84F





SECTION "sprites oam and tiles buffers", WRAM0 [$c900]

; oam buffers

wOAMBufferC9:: ; c900
	ds $100

wOAMBufferCA:: ; cA00
	ds $100

; sprites tiles buffers

wSpriteTilesBuffer:: ;CB00
	ds $100

wSpriteTilesBufferCC:: ;CC00
	ds $100

wSpriteTilesBufferCD:: ;CD00
	ds $100

wSpriteTilesBufferCE:: ;CE00
	ds $100

wSpriteTilesBufferCF:: ;CF00
	ds $100


SECTION "audio RAM",WRAMX,BANK[1]

	ds $DD00 - $D000

;================================
; audio ram
;================================


; audio channel #1 wram
;
; channel state
; bit 0: channel status flag (0: inactive, 1: active)
; bit 1: channel playback flag (0: muted, 1: unmuted )
wChannel1State:: ;DD00
	ds 1
wCh1NoteLength:: ;DD01
	ds 1
wCh1NextActionAddrLow:: ;DD02
	ds 1
wCh1NextActionAddrHigh:: ;DD03
	ds 1
wCh1FreqHigh:: ;DD04
	ds 1
wCh1FreqLow:: ;DD05
	ds 1
wDD06:: ;DD06
	ds 1
wCh1WavePattern:: ;DD07
	ds 1
wCh1Envelope:: ;DD08
	ds 1
wDD09:: ;DD09
	ds 1
wCh1EnvelopeTableTicks:: ;DD0A
	ds 1
wCh1EnvelopeTableAddrLow:: ;DD0B
	ds 1
wCh1EnvelopeTableAddrHigh:: ;DD0C
	ds 1
wCh1PitchBendTableTicks:: ;DD0D
	ds 1
wCh1PitchBendTableAddrLow:: ;DD0E
	ds 1
wCh1PitchBendTableAddrHigh:: ;DD0F
	ds 1
wCh1VibratoTableTicks:: ;DD10
	ds 1
wCh1VibratoTableAddrLow:: ;DD11
	ds 1
wCh1VibratoTableAddrHigh:: ;DD12
	ds 1
wCh1BranchCounter:: ;DD13
	ds 1
wChl1ActionId:: ;DD14
	ds 1
wCh1CheckBranchPlayCounterFlag:: ;DD15
	ds 1
wCh1NextActionAddrLowBkp:: ;DD16
	ds 1
wCh1NextActionAddrHighBkp:: ;DD17
	ds 1


; audio channel #2 wram
wChannel2State:: ;DD18
	ds 1
wCh2NoteLength:: ;wCh2NoteLength note length counter
	ds 1
wCh2NextActionAddrLow:: ;DD1A channel next note addr low
	ds 1
wCh2NextActionAddrHigh:: ;DD1B channel next note addr high
	ds 1
wCh2FreqHigh:: ;DD1C NR24 snd init & hight freq bits
	ds 1
wCh2FreqLow:: ;DD1D NR23 frequency low bits
	ds 1
wDD1E:: ;DD1E
	ds 1
wCh2WavePattern:: ;DD1F NR21 wave pattern
	ds 1
wCh2Envelope:: ;DD20 NR22 ch2 envelope
	ds 1
wDD21:: ;DD21
	ds 1
wCh2EnvelopeTableTicks:: ;DD22 envelope table counter var
	ds 1
wCh2EnvelopeTableAddrLow:: ;DD23 envelope table addr low
	ds 1
wCh2EnvelopeTableAddrHigh:: ;DD24 envelope table addr high
	ds 1
wCh2PitchBendTableTicks:: ;DD25 pitch bend table counter var
	ds 1
wCh2PitchBendTableAddrLow:: ;DD26 pitch bend table addr low
	ds 1
wCh2PitchBendTableAddrHigh:: ;DD27 pitch bend table addr high
	ds 1
wCh2VibratoTableTicks:: ;DD28 vibrato table counter
	ds 1
wCh2VibratoTableAddrLow:: ;DD29 vibrato table addr low
	ds 1
wCh2VibratoTableAddrHigh:: ;DD2A vibrato table addr high
	ds 1
wCh2BranchCounter:: ;DD2B branch counter
	ds 1
wChl2ActionId:: ;DD2C or branch tsp value
	ds 1
wCh2CheckBranchPlayCounterFlag:: ;DD2D
	ds 1
wCh2NextActionAddrLowBkp:: ;DD2E next action adress backup low
	ds 1
wCh2NextActionAddrHighBkp:: ;DD2F next action adress backup high
	ds 1


; audio channel #3 wram
wChannel3State:: ;DD30
	ds 1
wCh3NoteLength:: ;DD31
	ds 1
wCh3NextActionAddrLow:: ;DD32
	ds 1
wCh3NextActionAddrHigh:: ;DD33
	ds 1
wCh3FreqHigh:: ;DD34
	ds 1
wCh3FreqLow:: ;DD35
	ds 1
wDD36:: ;DD36
	ds 1
wCh3SoundLength:: ;DD37
	ds 1
wCh3Volume:: ;DD38
	ds 1
wDD39:: ;DD39
	ds 1
wCh3EnvelopeTableTicks:: ;DD3A
	ds 1
wCh3EnvelopeTableAddrLow:: ;DD3B
	ds 1
wCh3EnvelopeTableAddrHigh:: ;DD3C
	ds 1
wCh3PitchBendTableTicks:: ;DD3D
	ds 1
wCh3PitchBendTableAddrLow:: ;DD3E
	ds 1
wCh3PitchBendTableAddrHigh:: ;DD3F
	ds 1
wCh3VibratoTableTicks:: ;DD40
	ds 1
wCh3VibratoTableAddrLow:: ;DD41
	ds 1
wCh3VibratoTableAddrHigh:: ;DD42
	ds 1
wCh3BranchCounter:: ;DD43
	ds 1
wChl3ActionId:: ;DD44
	ds 1
wCh3CheckBranchPlayCounterFlag:: ;DD45
	ds 1
wCh3NextActionAddrLowBkp:: ;DD46
	ds 1
wCh3NextActionAddrHighBkp:: ;DD47
	ds 1


; audio channel #4 wram
wChannel4State:: ;DD48 enable channel
	ds 1
wCh4NoteLength:: ;DD49 note length counter
	ds 1
wCh4NextActionAddrLow:: ;DD4A channel next note addr low
	ds 1
wCh4NextActionAddrHigh:: ;DD4B channel next note addr high
	ds 1
wCh4LengthCounter:: ;DD4C snd init & counter/consecutive selection
	ds 1
wCh4PolyCounter:: ;DD4D polynomial counter
	ds 1
wDD4E:: ;DD4E
	ds 1
wCh4SoundLength:: ;DD4F sound length?
	ds 1
wCh4Envelope:: ;DD50 envelope
	ds 1
wDD51:: ;DD51
	ds 1
wCh4EnvelopeTableTicks:: ;DD52 envelope ticks counter var
	ds 1
wCh4EnvelopeTableAddrLow:: ;DD53 envelope table addr low
	ds 1
wCh4EnvelopeTableAddrHigh:: ;DD54 envelope table addr high
	ds 1
wCh4PolyCounterTableTicks:: ;DD55 poly counter ticks var
	ds 1
wCh4PolyCounterTableAddrLow:: ;DD56 poly counter table addr low
	ds 1
wCh4PolyCounterTableAddrHigh:: ;DD57 poly counter table addr high
	ds 1
wDD58:: ;DD58 unused vibrato effect on noise
	ds 1
wDD59:: ;DD59 unused vibrato effect on noise
	ds 1
wDD5A:: ;DD5A unused vibrato effect on noise
	ds 1
wCh4BranchCounter:: ;DD5B branch counter
	ds 1
wChl4ActionId:: ;DD5C
	ds 1
wCh4CheckBranchPlayCounterFlag:: ;DD5D
	ds 1
wCh4NextActionAddrLowBkp:: ;DD5E
	ds 1
wCh4NextActionAddrHighBkp:: ;DD5F
	ds 1



;audio control wram
wNoteLengthTableAddrLow:: ;DD60 note length table addr high
	ds 1

wNoteLengthTableAddrHigh:: ;DD61 note length table addr low
	ds 1

wChlUpdateFunctionAddrLow:: ;DD62 channel update function addr low
	ds 1
wChlUpdateFunctionAddrHigh:: ;DD63 channel update function addr high
	ds 1

wNoisePolyCounterValue:: ;DD64
	ds 1

wChannelActionId:: ;DD65
	ds 1

wChannelNoteId:: ;DD66 channel note id
	ds 1

wDD67:: ;DD67
	ds 1

wChannel1SfxAddrLow:: ;DD68
	ds 1

wChannel1SfxAddrHigh:: ;DD69
	ds 1

wChannel1SfxCounter:: ;DD6A
	ds 1

wChannel2SfxAddrLow:: ;DD6B
	ds 1

wChannel2SfxAddrHigh:: ;DD6C
	ds 1

wChannel2SfxCounter:: ;DD6D
	ds 1

wChannel3SfxAddrLow:: ;DD6E
	ds 1

wChannel3SfxAddrHigh:: ;DD6F
	ds 1

wChannel3SfxCounter:: ;DD70
	ds 1

wChannel4SfxAddrLow:: ;DD71
	ds 1

wChannel4SfxAddrHigh:: ;DD72
	ds 1

wChannel4SfxCounter:: ;DD73
	ds 1

wChannelStateVarAddrLow:: ;DD74
	ds 1

wChannelStateVarAddrHigh:: ;DD75
	ds 1

wNR50ChannelControl:: ;DD76
	ds 1

wSoundTempoCounter:: ;DD77
	ds 1

wSoundTempo:: ;DD78
	ds 1

wNR51SoundOutput:: ;DD79
	ds 1

wLRSoundEnabler:: ;DD7A
	ds 1

; ch1 = 0
; ch2 = 1
; ch3 = 2
; ch4 = 3
wChannelId:: ;DD7B
	ds 1

wChl1CurrentNoteId:: ;DD7C ch1 current note id
	ds 1

wChl2CurrentNoteId:: ;DD7D ch2 current note id
	ds 1

wChl3CurrentNoteId:: ;DD7E ch3 current note id
	ds 1



