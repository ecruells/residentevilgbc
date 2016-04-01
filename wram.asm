
SECTION "WRAM Bank 0", WRAM0

wWorkRamStart:: ;c000
	ds $c100 - $c000

wButtonPressId:: ; c100
	ds 1

wc101:: ;c101
	ds 1

wCurrentRomBank:: ;c102
	ds 1

wc103:: ;c103
	ds 1

wc104:: ;c104
	ds 1

wLCDUpdate:: ;c105
;store screen fade-out/fade-id progression
	ds 1

wTilemapLookupTableLow:: ;C106
	ds 1

wTilemapLookupTableHigh:: ;C107
	ds 1

wVramBankSubBuffer:: ;C108
;when wVramBankSubBuffer overflow, add carry to wVramBankBuffer
;maybe c108 count tiles until vram bank 00 is full and change to the 01 bank
	ds 1

wVramBankBuffer:: ;C109
	ds 1

wRoomBGBankId:: ;c10A
	ds 1

wBGDataAddrBank:: ;C10B
	ds 1

policeCardXpos:: ;c10c
	ds 1

policeCardYpos:: ;c10d
	ds 1

wCursorPosId:: ;C10E
	ds 1

wLoadOrSave:: ;C10F
;00: load game mode
;01: save game mode
	ds 1

wUpKeyPressDown:: ;C110
	ds 1

wDownKeyPressDown:: ;C111
	ds 1

wPlayerSpeed:: ;c112
	ds 1

wSpriteTilesBufferLow:: ;C113
	ds 1

wSpriteTilesBufferHigh:: ;C114
	ds 1

wSprtPriorityTblLow:: ;C115 wSpriteC115Low
	ds 1

wSprtPriorityTblHigh:: ;C116 wSpriteC116High
	ds 1

wHDMAtrigger:: ;C117
;00 disabled
;01 enabled
	ds 1

wSprtPriorHeight:: ;c118
	ds 1

wc119:: ;c119 unused
	ds 1

wSpriteVRAMTilesNumberRelative:: ;c11a
	ds 1

wSelectedPlayer:: ;c11b
;00 chris
;01 jill
	ds 1

wc11c:: ;c11c
	ds 1

wc11d:: ;c11d
	ds 1

wc11e:: ;c11e
	ds 1

wRoomScreen:: ;c11F
	ds 1

wOAMDMAretOpcode:: ;C120
;store the ret opcode from OAM DMA transfer hram routine
;C9 ret or C8 ret z (if HDMA is enabled)
	ds 1

wCursorTilesWidth:: ;C121
	ds 1
wCursorTilesHeight:: ;C122
	ds 1

wMenuSelGridId:: ; C123
;00 map
;01 radio
;02 File
;03 Exit
;04 item 1
;05 item 2
;06 item 3
;07 item 4
;08 item 5
;09 item 6
;0A item 7
;0B item 8
;0C File books
;0E global map
;0D radio
;12 map detail
;80 use/equip | itembox cursor
;81 check
;82 combine
;84 item description
;E0 combine grid
;E4 combine item 1
;E5 combine item 2
;E6 combine item 3
;E7 combine item 4
;E8 combine item 5
;E9 combine item 6
;EA combine item 7
;EB combine item 8
;FF get item choice
	ds 1

wMenuMapEnable:: ;C124
;00: disable FF:enabled
	ds 1
wMenuRadioEnable:: ;C125
;00: disable FF:enabled
	ds 1
wMenuFileEnable:: ;C126
;00: disable FF:enabled
	ds 1
wMenuExitEnable:: ;C127
;00: disable FF:enabled
	ds 1

wSprtPriorWidth:: ;C128
	ds 1

wc129:: ;c129 unused
	ds 1

wCameraPosY:: ;C12A
	ds 1
wCameraPosX:: ;c12b
	ds 1
wCameraC12C:: ;C12C
	ds 1
wCameraC12D:: ;C12D
	ds 1
wSpriteSizeLow:: ;c12E
	ds 1
wSpriteSizeHigh:: ;c12F
	ds 1
wCameraZoomLow:: ;c130
	ds 1
wCameraZoomHigh:: ;c131
	ds 1
wCameraXAxisLowByte:: ;c132
	ds 1
wCameraXAxisHighByte:: ;c133
	ds 1
wCameraZAxisLowByte:: ;c134
	ds 1
wCameraZAxisHighByte:: ;c135
	ds 1
wCameraYAxisLowByte:: ;c136
	ds 1
wCameraYAxisHighByte:: ;c137
	ds 1
wCameraXPaddingLowByte:: ;c138
	ds 1
wCameraXPaddingHighByte:: ;c139
	ds 1
wCameraYPaddingLowByte:: ;c13A
	ds 1
wCameraYPaddingHighByte:: ;c13B
	ds 1
wCameraZPaddingLowByte:: ;c13C
	ds 1
wCameraZPaddingHighByte:: ;c13D
	ds 1
wSpriteLowPosXBuffer:: ;c13E
	ds 1
wSpriteHighPosXBuffer:: ;c13F
	ds 1
wSpriteLowPosZBuffer:: ;c140
	ds 1
wSpriteHighPosZBuffer:: ;c141
	ds 1
wSpriteLowPosYBuffer:: ;c142
	ds 1
wSpriteHighPosYBuffer:: ;c143
	ds 1
wSpriteScaleC144Low:: ;C144 relative to X pos
	ds 1
wSpriteScaleC145High:: ;C145 relative to X pos
	ds 1

wc146:: ;c146
	ds 1

wc147:: ;c147
	ds 1

wSpriteZoomLowByte:: ;c148 relative to Y pos
	ds 1
wSpriteZoomHighByte:: ;c149 relative to Y pos
	ds 1

wc14a:: ;c14a unused
	ds 1

wc14b:: ;c14b unused
	ds 1

wc14c:: ;c14c
	ds 1

wc14d:: ;c14d
	ds 1

wc14e:: ;c14e
	ds 1

wc14f:: ;c14f
	ds 1

wc150:: ;c150
	ds 1

wc151:: ;c151
	ds 1

wc152:: ;c152
	ds 1

wc153:: ;c153
	ds 1

wc154:: ;c154
	ds 1

wc155:: ;c155
	ds 1

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

wDoorSpriteAddressLow:: ;C15C
	ds 1

wDoorSpriteAddressHigh:: ;C15D
	ds 1

wDoorSpriteYPos:: ;C15E
	ds 1

wDoorSpriteXPos:: ;C15F
	ds 1

wDoorSprtTileBufferOffset:: ;C160
	ds 1

wc161:: ;c161
	ds 1

wDoorAnimationFrameCounter:: ;c162
	ds 1

roomItemSpriteXPos:: ;c163
	ds 1

roomItemSpriteYPos:: ;c164
	ds 1

wSpriteC165:: ;C165
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

wTurnLeftTimer:: ;C16B
	ds 1

wTurnRightTimer:: ;C16C
	ds 1

wPlayerCamFacing:: ;C16D
;player + camera facing
	ds 1

wCameraFacing:: ;c16E
;00 south
;04 south-west
;08 west
;0C north-west
;10 north
;14 north-east
;18 east
;1C south-east
	ds 1

wCameraC16F:: ;c16F
	ds 1

wLowColliderRightX:: ;c170
	ds 1
wHighColliderRightX:: ;c171
	ds 1
wLowColliderLeftX:: ;c172
	ds 1
wHighColliderLeftX:: ;c173
	ds 1
wLowColliderBottomY:: ;c174
	ds 1
wHighColliderBottomY:: ;c175
	ds 1
wLowColliderTopY:: ;c176
	ds 1
wHighColliderTopY:: ;c177
	ds 1

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
wButtonAEventId:: ;c17E
;$00: nothing
;$01: open door
;$02: typewriter
;$03: getting item
;$04: item box
;$05: normal action
	ds 1

wCurrentSoundId:: ;C17F
	ds 1

wCurrentMusicId:: ;C180
	ds 1

wSavesNumber:: ;C181
	ds 1

wCheckEventIdA:: ;C182
	ds 1

wCheckEventIdB:: ;C183
	ds 1

wTigerStatueRotateDirection:: ;C184
	ds 1

wSelectedItemBoxSlotId:: ;C185
;32 item slots (00-1F)
	ds 1

wTriggerFile01:: ;C186
	ds 1
wTriggerFile02:: ;C187
	ds 1
wTriggerFile03:: ;C188
	ds 1
wTriggerFile04:: ;C189
	ds 1
wTriggerFile05:: ;C18A
	ds 1
wTriggerFile06:: ;C18B
	ds 1
wTriggerFile07:: ;C18C
	ds 1
wTriggerFile08:: ;C18D
	ds 1
wTriggerFile09:: ;C18E
	ds 1
wTriggerFile10:: ;C18F
	ds 1
wTriggerFile11:: ;C190
	ds 1
wTriggerFile12:: ;C191
	ds 1
wTriggerFile13:: ;C192
	ds 1
wTriggerFile14:: ;C193
	ds 1
wTriggerFile15:: ;C194
	ds 1
wTriggerFile16:: ;C195
	ds 1
wTriggerFile17:: ;C196
	ds 1
wTriggerFile18:: ;C197
	ds 1
wTriggerFile19:: ;C198
	ds 1
wTriggerFile20:: ;C199
	ds 1
wTriggerFile21:: ;C19A
	ds 1
wTriggerFile22:: ;C19B
	ds 1
wTriggerFile23:: ;C19C
	ds 1
wTriggerFile24:: ;C19D
	ds 1
wTriggerFile25:: ;C19E
	ds 1
wTriggerFile26:: ;C19F
	ds 1
wTriggerFile27:: ;C1A0
	ds 1
wTriggerFile28:: ;C1A1
	ds 1
wTriggerFile29:: ;C1A2
	ds 1
wTriggerFile30:: ;C1A3
	ds 1
wTriggerFile31:: ;C1A4
	ds 1
wTriggerFile32:: ;C1A5
	ds 1
wTriggerFile33:: ;C1A6
	ds 1
wTriggerFile34:: ;C1A7
	ds 1
wTriggerFile35:: ;C1A8
	ds 1
wTriggerFile36:: ;C1A9
	ds 1
wTriggerFile37:: ;C1AA
	ds 1
wTriggerFile38:: ;C1AB
	ds 1
wTriggerFile39:: ;C1AC
	ds 1

wc1ad:: ;c1ad
	ds 1

wFileBookmarkCursorPos:: ;C1AE
;13 bookmarks ($00 to $0C)
	ds 1

wAButtonPressDown:: ;C1AF
	ds 1

wAnimatedRoomSpritesFrameRate:: ;c1b0
	ds 1

wPoisonGasActivationByte:: ;C1B1
	ds 1

wc1b2:: ;c1b2
	ds 1

wc1b3:: ;c1b3
	ds 1

wc1b4:: ;c1b4
	ds 1

wc1b5:: ;c1b5
	ds 1

wDoorSpriteId:: ;C1B6
;00: single mansion door 1 (4 panels)
;01: single mansion door 2 (6 panels)
;02: single mansion door 3 (6 diamond panels)

;08: double mansion door 1
;09: double mansion door 2
;0A: double mansion door 3

	ds 1

wDoorPalleteId:: ;C1B7
;00: brown
;01: blue
;02: light brown
	ds 1

wFoundItemId:: ;C1B8
	ds 1

wQuickSaveFlagB9:: ;C1B9
	ds 1
wQuickSaveFlagBA:: ;C1BA
	ds 1

wc1bb:: ;c1bb
	ds 1

wQuickSaveFlagBC:: ;C1BC
	ds 1

wc1bd:: ;c1bd
	ds 1

wc1be:: ;c1be
	ds 1

wEventId:: ;c1bf
	ds 1

wScreenYPos:: ;c1c0
	ds 1

roomItemSpriteIdBuffer:: ;c1c1
	ds 1

spriteIdBuffer:: ;c1c2
	ds 1

wDoorAnimationType:: ;c1c3
;door type < 7C : normal sprite doors animations
;door type < 88 : Background type animations
;				  < 7E: stairs 1
;				  < 80: stairs 2
;				  < 82: stairs 3
;				  < 84: Ladder 1
;				  < 86: Rope
;				  = 14: Ladder 2
;door type >= 88 : Elevator animations
;				  < 8C: Mansion elevator
;				  < 90: Heliport elevator
	ds 1

wTimer:: ;c1c4 wFrameCounter
	ds 1

wc1c5:: ;c1c5
	ds 1

wLoadEventBgImagePal:: ;C1C6
	ds 1

wItemTriggerId:: ;C1C7
	ds 1

wSampleTempoLow:: ;c1c8
	ds 1

wSampleTempoHigh:: ;c1c9
	ds 1

wc1ca:: ;c1ca
	ds 1

wRoomMapXPosition:: ;C1CB
	ds 1
wRoomMapYPosition:: ;C1CC
	ds 1
wRoomMapWidth:: ;C1CD
	ds 1
wRoomMapHeight:: ;C1CE
	ds 1
wRoomMapRoomId:: ;C1CF
	ds 1
wRoomMapRoomIdHigh:: ;C1D0
	ds 1
wRoomMapHeightCounter:: ;C1D1
	ds 1

wBGDataAddrLow:: ;C1D2
	ds 1
wBGDataAddrHigh:: ;C1D3
	ds 1
wFileBookId:: ;C1D4
;00: filebook 1
;01: filebook 2
;02: filebook 3
	ds 1

wSpriteLowPosXCamX:: ;c1D5
	ds 1
wSpriteHighPosXCamX:: ;c1D6
	ds 1
wSpriteLowPosZcamZ:: ;c1D7
	ds 1
wSpriteHighPosZcamZ:: ;c1D8
	ds 1
wSpriteLowPosYCamY:: ;c1D9
	ds 1
wSpriteHighPosYCamY:: ;c1DA
	ds 1
wSpriteScaling1LowByte:: ;c1DB
	ds 1
wSpriteScaling1HighByte:: ;c1DC
	ds 1
wSpriteScaling2LowByte:: ;c1DD
	ds 1
wSpriteScaling2HighByte:: ;c1DE
	ds 1
wSpriteScaling3LowByte:: ;c1DF
	ds 1
wSpriteScaling3HighByte:: ;c1E0
	ds 1
wSpriteScaleValueA:: ;C1E1
	ds 1
wSpriteScaleValueB:: ;C1E2
	ds 1

wCameraType:: ;c1E3
; $normal
; $01: overhead
	ds 1

wButtonActionFacing:: ;C1E4
	ds 1

wSprtPriorXaxis:: ;C1E5
	ds 1
wSprtPriorY2axis:: ;C1E6
	ds 1


ItemIdSlot1:: ;C1E7
	ds 1
ItemIdSlot2:: ;C1E8
	ds 1
ItemIdSlot3:: ;C1E9
	ds 1
ItemIdSlot4:: ;C1EA
	ds 1
ItemIdSlot5:: ;C1EB
	ds 1
ItemIdSlot6:: ;C1EC
	ds 1
ItemIdSlot7:: ;C1ED
	ds 1
ItemIdSlot8:: ;C1EE
	ds 1
equipedItemId:: ;C1EF
	ds 1


wc1f0:: ;c1f0
	ds 1

wSpriteC1F1:: ;C1F1
	ds 1

wBgTransitionDirCounter:: ;C1F2
	ds 1

selectedGridId:: ;C1F3
	ds 1
selectedItemId:: ;C1F4
	ds 1

wc1f5:: ;c1f5
	ds 1

wc1f6:: ;c1f6
	ds 1

wc1f7:: ;c1f7
	ds 1

wMsgCharXpos:: ;C1F8
	ds 1
wMsgCharYpos:: ;C1F9
	ds 1

wChoiceId:: ;C1FA
;00: yes
;01: no
	ds 1

wBButtonPressDown:: ;C1FB
	ds 1

wCursorIdBuffer:: ;C1FC
	ds 1

wTypingCharsTrigger:: ;C1FD
	ds 1

wRoomMusicId:: ;C1FE
	ds 1

wc1ff:: ;c1ff
	ds 1


wVisitedRoom00Trigger:: ;C200
;19 visited rooms variables
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


wItemBoxSlot01:: ;C280
;item box slots, 32 slots in total
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

wNumericPanelKey01Value:: ;C2C0
	ds 1
wNumericPanelKey01PosY:: ;C2C1
	ds 1
wNumericPanelKey01PosX:: ;C2C2
	ds 1
wNumericPanelKey02Value:: ;C2C3
	ds 1
wNumericPanelKey02PosY:: ;C2C4
	ds 1
wNumericPanelKey02PosX:: ;C2C5
	ds 1
wNumericPanelKey03Value:: ;C2C6
	ds 1
wNumericPanelKey03PosY:: ;C2C7
	ds 1
wNumericPanelKey03PosX:: ;C2C8
	ds 1
wNumericPanelKey04Value:: ;C2C9
	ds 1
wNumericPanelKey04PosY:: ;C2CA
	ds 1
wNumericPanelKey04PosX:: ;C2CB
	ds 1
wNumericPanelKey05Value:: ;C2CC
	ds 1
wNumericPanelKey05PosY:: ;C2CD
	ds 1
wNumericPanelKey05PosX:: ;C2CE
	ds 1
wNumericPanelKey06Value:: ;C2CF
	ds 1
wNumericPanelKey06PosY:: ;C2D0
	ds 1
wNumericPanelKey06PosX:: ;C2D1
	ds 1
wNumericPanelKey07Value:: ;C2D2
	ds 1
wNumericPanelKey07PosY:: ;C2D3
	ds 1
wNumericPanelKey07PosX:: ;C2D4
	ds 1
wNumericPanelKey08Value:: ;C2D5
	ds 1
wNumericPanelKey08PosY:: ;C2D6
	ds 1
wNumericPanelKey08PosX:: ;C2D7
	ds 1
wNumericPanelKey09Value:: ;C2D8
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
wRotateFloor2AnimId:: ;C2E1
;boulder rotate floor
;00: bottom
;01: medium
;02: left
	ds 1

wRotateFloor1AnimId:: ;C2E2
;00: top
;01: medium
;02: left
;03: medium
;04: below
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

wElectronicUnlockFloorSelectId:: ;C2EA
;00: B2
;01: B3
;02: Cancel
	ds 1

wComputerPasswordMode:: ;C2EB
;00: Login Password
;01: E. Locks Password
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


wOverlapMaskAddrLow:: ;C2F9
	ds 1

wOverlapMaskAddrHigh:: ;C2FA
	ds 1

wOverlapC2FB:: ; C2FB
	ds 1

wOverlapC2FC:: ; C2FC
	ds 1

wOverlapC2FD:: ; C2FD
	ds 1

wOverlapC2FE:: ; C2FE
	ds 1

wSprtPriorYaxis:: ;C2FF
	ds 1


wCharSpritesData:: ;c300
; data for all character sprites (player and NPCs)
; 32 bytes for each sprite (8 sprites max)
; player sprite is always the first (c300), NPCs start at c320 to c3e0
; C3X0+00: sprite state
;		bit 7: sprite enabled
;		bit 6: sprite not visible
; c3X0+01: Sprite Y Pos Low Buffer
; c3X0+02: Sprite X Pos Low Buffer
; c3X0+03: Sprite Z Pos Low Buffer
; c3X0+04: Sprite X scale
; c3X0+05: Sprite Y scale
; C3X0+06: sprite animation Id
; C3X0+07: sprite animation frame Id/animation timer
; C3X0+09: sprite facing
; C3X0+0A: weapon firegun pause timer
; C3X0+0B: sprite Id
; C3X0+0C: firegun sprite frames
; C3X0+0D: Blood sprite frames
; C3X0+0E: health  20: full
; C3X0+0F: zombie/object trigger id
; C3X0+10: zombie/object trigger id High
; C3X0+11-C3X0+12: sprite X pos offset (low-hi signed 16bit number) camera distance correction?
; C3X0+13-C3X0+14: sprite Y pos offset (low-hi signed 16bit number) camera distance correction?
; C3X0+15-C3X0+16: sprite X position (low-hi signed 16bit number)
; C3X0+17-C3X0+18: sprite Y position (low-hi signed 16bit number)
; C3X0+19-C3X0+1A: sprite Z position (low-hi signed 16bit number) sprite elevation
; C3X0+1B: player input block timer
	ds 1
wSpriteYPosLowBuffer:: ;c301
	ds 1
wSpriteXPosLowBuffer:: ;c302
	ds 1
wSpriteZPosLowBuffer:: ;c303
	ds 1
wSpriteXscale:: ;c304
	ds 1
wSpriteYscale:: ;c305
	ds 1
wSpriteAnimationId:: ;c306
	ds 1
wSpriteAnimationLoopTimer:: ;c307
	ds 1
wSpriteDataC308:: ;c308
	ds 1
wSpriteFacing:: ;c309
	ds 1
wWeaponBlockTimer:: ;c30A
	ds 1
wSpriteId:: ;c30B
	ds 1
wFiregunFramesId:: ;c30C
	ds 1
wBloodFramesId:: ;c30D
	ds 1
wCharHealth:: ;c30E
	ds 1
wSprtScreenTrigger:: ;c30F object movement
	ds 1
wSprtDataC310:: ;c310
	ds 1
wSpritePosXoffsetLowByte:: ;c311
	ds 1
wSpritePosXoffsetHighByte:: ;c312
	ds 1
wSpritePosYoffsetLowByte:: ;c313
	ds 1
wSpritePosYoffsetHighByte:: ;c314
	ds 1
wSpritePosXLowByte:: ;c315
	ds 1
wSpritePosXHighByte:: ;c316
	ds 1
wSpritePosYLowByte:: ;c317
	ds 1
wSpritePosYHighByte:: ;c318
	ds 1
wSpritePosZLowByte:: ;c319
	ds 1
wSpritePosZHighByte:: ;c31A
	ds 1
wMoveInputBlockTimer:: ;c31B
	ds 1
wSpriteDataC31C::  ;c31C zombieRecoilTimer
	ds 1
wSpriteDataC31D::  ;c31D
	ds 1
wSpriteDataC31E::  ;c31E
	ds 1
wSpriteDataC31F::  ;c31F step ladder elevation mode
	ds 1

;rest of NPC sprites data
wNPCSpritesData:: ;c320
	ds 32 * 7

;wEndCharSpritesData:: ;C3FF


;triggers RAM

wDoorTriggers::
wEventMsgAtMainHallDoor:: ;c400
	ds 1

wc401:: ;c401
	ds 1

wc402:: ;c402
	ds 1

wc403:: ;c403
	ds 1

wBlockDoorToFirstZombie:: ;c404
	ds 1

wc405:: ;c405
	ds 1

wc406:: ;c406
	ds 1

wc407:: ;c407
	ds 1

wc408:: ;c408
	ds 1

wc409:: ;c409
	ds 1

wc40a:: ;c40a
	ds 1

wc40b:: ;c40b
	ds 1

wc40c:: ;c40c
	ds 1

wc40d:: ;c40d
	ds 1

wc40e:: ;c40e
	ds 1

wc40f:: ;c40f
	ds 1

wc410:: ;c410
	ds 1

wc411:: ;c411
	ds 1

wc412:: ;c412
	ds 1

wc413:: ;c413
	ds 1

wc414:: ;c414
	ds 1

wc415:: ;c415
	ds 1

wc416:: ;c416
	ds 1

wc417:: ;c417
	ds 1

wc418:: ;c418
	ds 1

wc419:: ;c419
	ds 1

wc41a:: ;c41a
	ds 1

wc41b:: ;c41b
	ds 1

wc41c:: ;c41c
	ds 1

wShedDoorLock:: ;C41D
	ds 1

wc41e:: ;c41e
	ds 1

wc41f:: ;c41f
	ds 1

wc420:: ;c420
	ds 1

wc421:: ;c421
	ds 1

wc422:: ;c422
	ds 1

wc423:: ;c423
	ds 1

wc424:: ;c424
	ds 1

wc425:: ;c425
	ds 1

wc426:: ;c426
	ds 1

wc427:: ;c427
	ds 1

wc428:: ;c428
	ds 1

wc429:: ;c429
	ds 1

wc42a:: ;c42a
	ds 1

wc42b:: ;c42b
	ds 1

wc42c:: ;c42c
	ds 1

wc42d:: ;c42d
	ds 1

wc42e:: ;c42e
	ds 1

wc42f:: ;c42f
	ds 1

wc430:: ;c430
	ds 1

wc431:: ;c431
	ds 1

wc432:: ;c432
	ds 1

wc433:: ;c433
	ds 1

wc434:: ;c434
	ds 1

wc435:: ;c435
	ds 1

wc436:: ;c436
	ds 1

wc437:: ;c437
	ds 1

wc438:: ;c438
	ds 1

wc439:: ;c439
	ds 1

wc43a:: ;c43a
	ds 1

wc43b:: ;c43b
	ds 1

wc43c:: ;c43c
	ds 1

wc43d:: ;c43d
	ds 1

wc43e:: ;c43e
	ds 1

wCourtyardElevatorPowered:: ;C43F
	ds 1

wc440:: ;c440
	ds 1

wc441:: ;c441
	ds 1

wc442:: ;c442
	ds 1

wHeliportElevatorPowered:: ;C443
	ds 1

wc444:: ;c444
	ds 1

wc445:: ;c445
	ds 1

wc446:: ;c446
	ds 1

wBoulderPassage2DoorLock:: ;C447
	ds 1

wc448:: ;c448
	ds 1

wBoulderPassage1DoorLock:: ;C449
	ds 1

wc44a:: ;c44a
	ds 1

wc44b:: ;c44b
	ds 1

wc44c:: ;c44c
	ds 1

wLaboratoryEntranceOpened:: ;C44D
	ds 1

wc44e:: ;c44e
	ds 1

wc44f:: ;c44f
	ds 1

wc450:: ;c450
	ds 1

wGuardhouseStatueMoved:: ;c451
	ds 1

wc452:: ;c452
	ds 1

wc453:: ;c453
	ds 1

wc454:: ;c454
	ds 1

wc455:: ;c455
	ds 1

wc456:: ;c456
	ds 1

wc457:: ;c457
	ds 1

wAquaTankStoreroomDoorUnlocked:: ;c458
	ds 1

wc459:: ;c459
	ds 1

wc45a:: ;c45a
	ds 1

wc45b:: ;c45b
	ds 1

wc45c:: ;c45c
	ds 1

wc45d:: ;c45d
	ds 1

wc45e:: ;c45e
	ds 1

wc45f:: ;c45f
	ds 1

wNumericPanelDoorUnlocked:: ;c460
	ds 1

wc461:: ;c461
	ds 1

wc462:: ;c462
	ds 1

wc463:: ;c463
	ds 1

wc464:: ;c464
	ds 1

wc465:: ;c465
	ds 1

wc466:: ;c466
	ds 1

wVisualDataRoomDoorLock:: ;c467
	ds 1

wc468:: ;c468
	ds 1

wc469:: ;c469
	ds 1

wc46a:: ;c46a
	ds 1

wc46b:: ;c46b
	ds 1

wc46c:: ;c46c
	ds 1

wc46d:: ;c46d
	ds 1

wc46e:: ;c46e
	ds 1

wLabResearcherRoomDoorLock:: ;c46F
	ds 1

wDetentionChamberPassageDoorLock:: ;c470
	ds 1

wc471:: ;c471
	ds 1

wLabElevatorLock:: ;c472
	ds 1
wc473:: ;c473
	ds 1

wc474:: ;c474
	ds 1

wc475:: ;c475
	ds 1

wc476:: ;c476
	ds 1

wc477:: ;c477
	ds 1

wc478:: ;c478
	ds 1

wc479:: ;c479
	ds 1

wc47a:: ;c47a
	ds 1

wc47b:: ;c47b
	ds 1

wCorridor0COneWayDoorOpen:: ;c47C
	ds 1
wCorridor24OneWayLockedDoorOpen:: ;c47D
	ds 1

wTyrantRoomDoorLock:: ;c47e
	ds 1

wc47f:: ;c47f
	ds 1



wEventsTriggers::
wEventFirstZombieScn:: ;c480
	ds 1

wEventFirstDinningRoomScn:: ;c481
	ds 1

wc482:: ;c482
	ds 1

wc483:: ;c483
	ds 1

wEventBackToMainHallJill:: ;c484
	ds 1
wPianoRoomSecretDoorTrigger:: ;c485
;00: close
;FF: open
	ds 1

wc486:: ;c486
	ds 1

wTriggerShieldKeyPlant:: ;c487
	ds 1

wc488:: ;c488
	ds 1

wc489:: ;c489
	ds 1

wc48a:: ;c48a
	ds 1

wTriggerBrokenStatue:: ;C48B
	ds 1

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
wPaintingPuzzleSwitch:: ;C492
	ds 1

wMoonCrestPlaced:: ;c493
	ds 1
wSunCrestPlaced:: ;c494
	ds 1
wStarCrestPlaced:: ;c495
	ds 1
wWindCrestPlaced:: ;c496
	ds 1

wc497:: ;c497
	ds 1

wTriggerCourtyardCascade:: ;c498
	ds 1

wc499:: ;c499
	ds 1

wDorm002EventTrigger:: ;C49A
;jill and werker conversation in werehouse
	ds 1

wFloodedRoomsTrigger:: ;C49B
    ds 1
wPlant42RootsTrigger:: ;C49C
	ds 1
wDorm003WhiteBookRemoved:: ;C49D
	ds 1
wDorm003RedBookPlaced:: ;C49E
	ds 1

wc49f:: ;c49f
	ds 1

wc4a0:: ;c4a0
	ds 1

wc4a1:: ;c4a1
	ds 1

wc4a2:: ;c4a2
	ds 1

wc4a3:: ;c4a3
	ds 1

wc4a4:: ;c4a4
	ds 1

wVisualDataRoomPanelButtonOpened:: ;C4A5
	ds 1
wLabSlideRoomPillarMoved:: ;C4A6
	ds 1
wMansionBathroomTubUnplug:: ;C4A7
    ds 1
wDorm001BathroomTubUnplug:: ;C4A8
	ds 1

wc4a9:: ;c4a9
	ds 1

wMoDiskPasscode01Filed:: ;C4AA
	ds 1
wMoDiskPasscode02Filed:: ;C4AB
	ds 1
wMoDiskPasscode03Filed:: ;C4AC
	ds 1

wBlackOutAreasPowered:: ;C4AD
	ds 1
wLabElevatorPowered:: ;C4AE
	ds 1

wPasscode01Enter:: ;C4AF
	ds 1
wPasscode02Enter:: ;C4B0
	ds 1
wPasscode03Enter:: ;C4B1
	ds 1

wElectronicLockUnlock1:: ;C4B2
	ds 1
wElectronicLockUnlock2:: ;C4B3
	ds 1

wTyrant1Defeated: ;C4B4
	ds 1

wc4b5:: ;c4b5
	ds 1

wc4b6:: ;c4b6
	ds 1

wc4b7:: ;c4b7
	ds 1

wc4b8:: ;c4b8
	ds 1

wc4b9:: ;c4b9
	ds 1

wc4ba:: ;c4ba
	ds 1

wc4bb:: ;c4bb
	ds 1

wc4bc:: ;c4bc
	ds 1

wc4bd:: ;c4bd
	ds 1

wc4be:: ;c4be
	ds 1

wCandleRoomLight:: ;C4BF
	ds 1

wTaxidermyRoomLight:: ;C4C0
	ds 1

wMansionStudyLights:: ;C4C1
	ds 1
wCatacombStatueWallTrigger:: ;C4C2
	ds 1

wc4c3:: ;c4c3
	ds 1

wc4c4:: ;c4c4
	ds 1

wc4c5:: ;c4c5
	ds 1

wc4c6:: ;c4c6
	ds 1

wc4c7:: ;c4c7
	ds 1

wc4c8:: ;c4c8
	ds 1

wc4c9:: ;c4c9
	ds 1

wc4ca:: ;c4ca
	ds 1

wLoungeFireplaceLitted:: ;C4CB
	ds 1
wBugCollectionButtonPushed:: ;C4CC
	ds 1
wLibraryStatueLightTrigger:: ;C4CD
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

wArmorsRoomGasButtonPushed:: ;C4D4
	ds 1

wc4d5:: ;c4d5
	ds 1

wXrayRoomBlueLight:: ;C4D6
	ds 1
wXrayRoomNormalLight:: ;C4D7
	ds 1

wLibrarySecretDoorTrigger:: ;C4D8
	ds 1

wWolfMedalPlaced:: ;C4D9
	ds 1
wEagleMedalPlaced:: ;C4DA
	ds 1

wc4db:: ;c4db
	ds 1

wc4dc:: ;c4dc
	ds 1

wPasscodeTrigger:: ;C4DD
	ds 1
wAquariumWoodenBoxSunken:: ;C4DE
	ds 1
wProjectorSlidePlaced:: ;C4DF
	ds 1

wMansion1FMapStepLadderPushed:: ;C4E0
	ds 1

wLabStepLadderPushed:: ;C4E1
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

wRoomItemsTriggers::
wTriggerInkRibbonMainHall:: ;c500
	ds 1
wTriggerHandgunMainHall:: ;c501
	ds 1
wTriggerGoldenShieldDRoom:: ;c502
	ds 1

wDinningRoomShieldKey:: ;c503
	ds 1

wTriggerJewelDinningRoom:: ;c504
	ds 1

wSafeRoomSerum:: ;c505
	ds 1

wc506:: ;c506
	ds 1

wTriggerMansion1FMap:: ;c507
	ds 1

wExhibitionRoomInkRibbon:: ;c508
	ds 1

wKennethClip1:: ;c509
	ds 1

wKennethClip2:: ;c50a
	ds 1

wc50b:: ;c50b
	ds 1

wc50c:: ;c50c
	ds 1

wc50d:: ;c50d
	ds 1

wc50e:: ;c50e
	ds 1

wc50f:: ;c50f
	ds 1

wFirearmsDeskShells:: ;c510
	ds 1

wGreenhouseArmorKey:: ;c511
	ds 1

wFirearmsClip:: ;c512
	ds 1

wPianoRoomGoldEmblemTrigger:: ;c513
;00: removed
;FF: placed
	ds 1

wFirearmsRoomDeskEmpty:: ;c514
	ds 1

wc515:: ;c515
	ds 1

wc516:: ;c516
	ds 1

wNorthEastCorridorHerb:: ;c517
	ds 1

wLShapedCoddidorClip:: ;c518
	ds 1

wc519:: ;c519
	ds 1

wEastStairsCorridor1FHerb:: ;c51a
	ds 1

wKeepersRoomClip:: ;c51b
	ds 1

wKeepersRoomFile:: ;c51c
	ds 1

wKeepersRoomShells:: ;c51d
	ds 1

wc51e:: ;c51e
	ds 1

wc51f:: ;c51f
	ds 1

wc520:: ;c520
	ds 1

wc521:: ;c521
	ds 1

wc522:: ;c522
	ds 1

wc523:: ;c523
	ds 1

wc524:: ;c524
	ds 1

wc525:: ;c525
	ds 1

wc526:: ;c526
	ds 1

wBlueJewelPlaced:: ;C527
	ds 1
wRedJewelPlaced:: ;C528
	ds 1

wShedSquareCrank:: ;c529
	ds 1

wShedSmallKey:: ;c52a
	ds 1

wMirrorRoomHerb:: ;c52b
	ds 1

wMirrorRoomInkRibbon:: ;c52c
	ds 1

wc52d:: ;c52d
	ds 1

wLivingRoomShotgunPlaced:: ;c52e
	ds 1

wDinningRoomGoldEmblemPlaced:: ;C52F
	ds 1
wPianoRoomWoodEmblemTrigger:: ;c530
;00: removed
;FF: placed
	ds 1

wBrokenShotgunPlaced:: ;c531
	ds 1

wc532:: ;c532
	ds 1

wc533:: ;c533
	ds 1

wc534:: ;c534
	ds 1

wc535:: ;c535
	ds 1

wc536:: ;c536
	ds 1

wc537:: ;c537
	ds 1

wc538:: ;c538
	ds 1

wc539:: ;c539
	ds 1

wc53a:: ;c53a
	ds 1

wc53b:: ;c53b
	ds 1

wc53c:: ;c53c
	ds 1

wc53d:: ;c53d
	ds 1

wc53e:: ;c53e
	ds 1

wc53f:: ;c53f
	ds 1

wc540:: ;c540
	ds 1

wFireplace2FMapEnabled:: ;c541
	ds 1

wLoungeHerb:: ;c542
	ds 1

wc543:: ;c543
	ds 1

wEastTerraceHallwaySmallKey:: ;c544
	ds 1

wc545:: ;c545
	ds 1

wc546:: ;c546
	ds 1

wSunCrestShowcaseOpened:: ;c547
	ds 1

w2FWesternCorridorHerb3:: ;c548
	ds 1

w2FWesternCorridorHerb2:: ;c549
	ds 1

w2FWesternCorridorHerb1:: ;c54a
	ds 1

wBedroomLighter:: ;c54b
	ds 1

wBedroomShells:: ;c54c
	ds 1

wBedroomHerb:: ;c54d
	ds 1

wc54e:: ;c54e
	ds 1

wc54f:: ;c54f
	ds 1

wc550:: ;c550
	ds 1

wc551:: ;c551
	ds 1

wAtticMoonCrest:: ;c552
	ds 1

wc553:: ;c553
	ds 1

wEastTerraceClip:: ;c554
	ds 1

wTaxidermyRoomRedJewel:: ;c555
	ds 1

wTaxidermyRoomDroppedItem:: ;c556
	ds 1

wc557:: ;c557
	ds 1

wc558:: ;c558
	ds 1

wc559:: ;c559
	ds 1

wLibraryFile:: ;c55a
	ds 1

wc55b:: ;c55b
	ds 1

wMaterialsRoomShells1:: ;c55c
	ds 1

wMaterialsRoomShells2:: ;c55d
	ds 1

wMaterialsRoomBattery:: ;c55e
	ds 1

wHelipadLookoutRoomClip:: ;c55f
	ds 1

wc560:: ;c560
	ds 1

wc561:: ;c561
	ds 1

wc562:: ;c562
	ds 1

wc563:: ;c563
	ds 1

wc564:: ;c564
	ds 1

wc565:: ;c565
	ds 1

wc566:: ;c566
	ds 1

wc567:: ;c567
	ds 1

wc568:: ;c568
	ds 1

wc569:: ;c569
	ds 1

wc56a:: ;c56a
	ds 1

wc56b:: ;c56b
	ds 1

wc56c:: ;c56c
	ds 1

wc56d:: ;c56d
	ds 1

wc56e:: ;c56e
	ds 1

wc56f:: ;c56f
	ds 1

wc570:: ;c570
	ds 1

wc571:: ;c571
	ds 1

wSouthPassageHexCrank:: ;c572
	ds 1

wc573:: ;c573
	ds 1

wc574:: ;c574
	ds 1

wc575:: ;c575
	ds 1

wc576:: ;c576
	ds 1

wc577:: ;c577
	ds 1

wc578:: ;c578
	ds 1

wc579:: ;c579
	ds 1

wc57a:: ;c57a
	ds 1

wc57b:: ;c57b
	ds 1

wc57c:: ;c57c
	ds 1

wc57d:: ;c57d
	ds 1

wc57e:: ;c57e
	ds 1

wc57f:: ;c57f
	ds 1

wc580:: ;c580
	ds 1

wc581:: ;c581
	ds 1

wc582:: ;c582
	ds 1

wc583:: ;c583
	ds 1

wc584:: ;c584
	ds 1

wc585:: ;c585
	ds 1

wc586:: ;c586
	ds 1

wc587:: ;c587
	ds 1

wc588:: ;c588
	ds 1

wc589:: ;c589
	ds 1

wc58a:: ;c58a
	ds 1

wc58b:: ;c58b
	ds 1

wc58c:: ;c58c
	ds 1

wc58d:: ;c58d
	ds 1

wc58e:: ;c58e
	ds 1

wc58f:: ;c58f
	ds 1

wc590:: ;c590
	ds 1

wDorm001Redbook:: ;c591
	ds 1

wc592:: ;c592
	ds 1

wc593:: ;c593
	ds 1

wc594:: ;c594
	ds 1

wc595:: ;c595
	ds 1

wc596:: ;c596
	ds 1

wc597:: ;c597
	ds 1

wc598:: ;c598
	ds 1

wc599:: ;c599
	ds 1

wc59a:: ;c59a
	ds 1

wc59b:: ;c59b
	ds 1

wc59c:: ;c59c
	ds 1

wDorm002File:: ;c59d
	ds 1

wc59e:: ;c59e
	ds 1

wc59f:: ;c59f
	ds 1

wc5a0:: ;c5a0
	ds 1

wc5a1:: ;c5a1
	ds 1

wc5a2:: ;c5a2
	ds 1

wc5a3:: ;c5a3
	ds 1

wc5a4:: ;c5a4
	ds 1

wc5a5:: ;c5a5
	ds 1

wc5a6:: ;c5a6
	ds 1

wc5a7:: ;c5a7
	ds 1

wAquaTankStoreroomClip1:: ;c5a8
	ds 1

wAquaTankStoreroomClip2:: ;c5a9
	ds 1

wAquaTankStoreroomShell1:: ;c5aa
	ds 1

wAquaTankStoreroomShell2:: ;c5ab
	ds 1

wAquaTankStoreroomDorm03Key:: ;c5ac
	ds 1

wc5ad:: ;c5ad
	ds 1

wc5ae:: ;c5ae
	ds 1

wc5af:: ;c5af
	ds 1

wc5b0:: ;c5b0
	ds 1

wc5b1:: ;c5b1
	ds 1

wc5b2:: ;c5b2
	ds 1

wc5b3:: ;c5b3
	ds 1

wEmergencyTunnelBattery:: ;c5b4
	ds 1

wc5b5:: ;c5b5
	ds 1

wc5b6:: ;c5b6
	ds 1

wc5b7:: ;c5b7
	ds 1

wc5b8:: ;c5b8
	ds 1

wc5b9:: ;c5b9
	ds 1

wc5ba:: ;c5ba
	ds 1

wc5bb:: ;c5bb
	ds 1

wc5bc:: ;c5bc
	ds 1

wc5bd:: ;c5bd
	ds 1

wc5be:: ;c5be
	ds 1

wc5bf:: ;c5bf
	ds 1

wc5c0:: ;c5c0
	ds 1

wc5c1:: ;c5c1
	ds 1

wc5c2:: ;c5c2
	ds 1

wc5c3:: ;c5c3
	ds 1

wc5c4:: ;c5c4
	ds 1

wc5c5:: ;c5c5
	ds 1

wc5c6:: ;c5c6
	ds 1

wc5c7:: ;c5c7
	ds 1

wEastStoreroomHerbicide:: ;c5c8
	ds 1

wEastStoreroomFAidSpray:: ;c5c9
	ds 1

wEastStoreroomShells:: ;c5ca
	ds 1

wEastStoreroomClip:: ;c5cb
	ds 1

wc5cc:: ;c5cc
	ds 1

wc5cd:: ;c5cd
	ds 1

wc5ce:: ;c5ce
	ds 1

wPaintingsRoomStarCrest:: ;c5cf
	ds 1

wc5d0:: ;c5d0
	ds 1

wc5d1:: ;c5d1
	ds 1

wc5d2:: ;c5d2
	ds 1

wc5d3:: ;c5d3
	ds 1

wc5d4:: ;c5d4
	ds 1

wc5d5:: ;c5d5
	ds 1

wc5d6:: ;c5d6
	ds 1

wc5d7:: ;c5d7
	ds 1

wc5d8:: ;c5d8
	ds 1

wc5d9:: ;c5d9
	ds 1

wc5da:: ;c5da
	ds 1

wc5db:: ;c5db
	ds 1

wc5dc:: ;c5dc
	ds 1

wc5dd:: ;c5dd
	ds 1

wc5de:: ;c5de
	ds 1

wc5df:: ;c5df
	ds 1

wc5e0:: ;c5e0
	ds 1

wc5e1:: ;c5e1
	ds 1

wc5e2:: ;c5e2
	ds 1

wc5e3:: ;c5e3
	ds 1

wc5e4:: ;c5e4
	ds 1

wc5e5:: ;c5e5
	ds 1

wc5e6:: ;c5e6
	ds 1

wc5e7:: ;c5e7
	ds 1

wc5e8:: ;c5e8
	ds 1

wc5e9:: ;c5e9
	ds 1

wc5ea:: ;c5ea
	ds 1

wc5eb:: ;c5eb
	ds 1

wc5ec:: ;c5ec
	ds 1

wc5ed:: ;c5ed
	ds 1

wc5ee:: ;c5ee
	ds 1

wc5ef:: ;c5ef
	ds 1

wc5f0:: ;c5f0
	ds 1

wc5f1:: ;c5f1
	ds 1

wc5f2:: ;c5f2
	ds 1

wc5f3:: ;c5f3
	ds 1

wc5f4:: ;c5f4
	ds 1

wc5f5:: ;c5f5
	ds 1

wc5f6:: ;c5f6
	ds 1

wc5f7:: ;c5f7
	ds 1

wc5f8:: ;c5f8
	ds 1

wc5f9:: ;c5f9
	ds 1

wc5fa:: ;c5fa
	ds 1

wc5fb:: ;c5fb
	ds 1

wc5fc:: ;c5fc
	ds 1

wc5fd:: ;c5fd
	ds 1

wc5fe:: ;c5fe
	ds 1

wc5ff:: ;c5ff
	ds 1

wEnemyAndObjectsVars:: ;c600
	ds 1

wc601:: ;c601
	ds 1

wc602:: ;c602
	ds 1

wc603:: ;c603
	ds 1

wc604:: ;c604
	ds 1

wc605:: ;c605
	ds 1

wc606:: ;c606
	ds 1

wc607:: ;c607
	ds 1

wc608:: ;c608
	ds 1

wc609:: ;c609
	ds 1

wc60a:: ;c60a
	ds 1

wc60b:: ;c60b
	ds 1

wc60c:: ;c60c
	ds 1

wc60d:: ;c60d
	ds 1

wc60e:: ;c60e
	ds 1

wc60f:: ;c60f
	ds 1

wc610:: ;c610
	ds 1

wc611:: ;c611
	ds 1

wc612:: ;c612
	ds 1

wc613:: ;c613
	ds 1

wc614:: ;c614
	ds 1

wc615:: ;c615
	ds 1

wc616:: ;c616
	ds 1

wc617:: ;c617
	ds 1

wc618:: ;c618
	ds 1

wc619:: ;c619
	ds 1

wc61a:: ;c61a
	ds 1

wc61b:: ;c61b
	ds 1

wc61c:: ;c61c
	ds 1

wc61d:: ;c61d
	ds 1

wc61e:: ;c61e
	ds 1

wc61f:: ;c61f
	ds 1

wc620:: ;c620
	ds 1

wc621:: ;c621
	ds 1

wc622:: ;c622
	ds 1

wc623:: ;c623
	ds 1

wc624:: ;c624
	ds 1

wc625:: ;c625
	ds 1

wc626:: ;c626
	ds 1

wc627:: ;c627
	ds 1

wc628:: ;c628
	ds 1

wc629:: ;c629
	ds 1

wc62a:: ;c62a
	ds 1

wc62b:: ;c62b
	ds 1

wc62c:: ;c62c
	ds 1

wc62d:: ;c62d
	ds 1

wc62e:: ;c62e
	ds 1

wc62f:: ;c62f
	ds 1

wc630:: ;c630
	ds 1

wc631:: ;c631
	ds 1

wc632:: ;c632
	ds 1

wc633:: ;c633
	ds 1

wc634:: ;c634
	ds 1

wc635:: ;c635
	ds 1

wc636:: ;c636
	ds 1

wc637:: ;c637
	ds 1

wc638:: ;c638
	ds 1

wc639:: ;c639
	ds 1

wc63a:: ;c63a
	ds 1

wc63b:: ;c63b
	ds 1

wc63c:: ;c63c
	ds 1

wc63d:: ;c63d
	ds 1

wc63e:: ;c63e
	ds 1

wc63f:: ;c63f
	ds 1

wc640:: ;c640
	ds 1

wc641:: ;c641
	ds 1

wc642:: ;c642
	ds 1

wc643:: ;c643
	ds 1

wc644:: ;c644
	ds 1

wc645:: ;c645
	ds 1

wc646:: ;c646
	ds 1

wc647:: ;c647
	ds 1

wc648:: ;c648
	ds 1

wc649:: ;c649
	ds 1

wc64a:: ;c64a
	ds 1

wc64b:: ;c64b
	ds 1

wc64c:: ;c64c
	ds 1

wc64d:: ;c64d
	ds 1

wc64e:: ;c64e
	ds 1

wc64f:: ;c64f
	ds 1

wc650:: ;c650
	ds 1

wc651:: ;c651
	ds 1

wc652:: ;c652
	ds 1

wc653:: ;c653
	ds 1

wc654:: ;c654
	ds 1

wc655:: ;c655
	ds 1

wc656:: ;c656
	ds 1

wc657:: ;c657
	ds 1

wc658:: ;c658
	ds 1

wc659:: ;c659
	ds 1

wc65a:: ;c65a
	ds 1

wc65b:: ;c65b
	ds 1

wc65c:: ;c65c
	ds 1

wc65d:: ;c65d
	ds 1

wc65e:: ;c65e
	ds 1

wc65f:: ;c65f
	ds 1

wc660:: ;c660
	ds 1

wc661:: ;c661
	ds 1

wc662:: ;c662
	ds 1

wc663:: ;c663
	ds 1

wc664:: ;c664
	ds 1

wc665:: ;c665
	ds 1

wc666:: ;c666
	ds 1

wc667:: ;c667
	ds 1

wc668:: ;c668
	ds 1

wc669:: ;c669
	ds 1

wc66a:: ;c66a
	ds 1

wc66b:: ;c66b
	ds 1

wc66c:: ;c66c
	ds 1

wc66d:: ;c66d
	ds 1

wc66e:: ;c66e
	ds 1

wc66f:: ;c66f
	ds 1

wc670:: ;c670
	ds 1

wc671:: ;c671
	ds 1

wc672:: ;c672
	ds 1

wc673:: ;c673
	ds 1

wc674:: ;c674
	ds 1

wc675:: ;c675
	ds 1

wc676:: ;c676
	ds 1

wc677:: ;c677
	ds 1

wc678:: ;c678
	ds 1

wc679:: ;c679
	ds 1

wc67a:: ;c67a
	ds 1

wc67b:: ;c67b
	ds 1

wc67c:: ;c67c
	ds 1

wc67d:: ;c67d
	ds 1

wc67e:: ;c67e
	ds 1

wc67f:: ;c67f
	ds 1

wc680:: ;c680
	ds 1

wc681:: ;c681
	ds 1

wc682:: ;c682
	ds 1

wc683:: ;c683
	ds 1

wc684:: ;c684
	ds 1

wc685:: ;c685
	ds 1

wc686:: ;c686
	ds 1

wc687:: ;c687
	ds 1

wc688:: ;c688
	ds 1

wc689:: ;c689
	ds 1

wc68a:: ;c68a
	ds 1

wc68b:: ;c68b
	ds 1

wc68c:: ;c68c
	ds 1

wc68d:: ;c68d
	ds 1

wc68e:: ;c68e
	ds 1

wc68f:: ;c68f
	ds 1

wc690:: ;c690
	ds 1

wc691:: ;c691
	ds 1

wc692:: ;c692
	ds 1

wc693:: ;c693
	ds 1

wc694:: ;c694
	ds 1

wc695:: ;c695
	ds 1

wc696:: ;c696
	ds 1

wc697:: ;c697
	ds 1

wc698:: ;c698
	ds 1

wc699:: ;c699
	ds 1

wc69a:: ;c69a
	ds 1

wc69b:: ;c69b
	ds 1

wc69c:: ;c69c
	ds 1

wc69d:: ;c69d
	ds 1

wc69e:: ;c69e
	ds 1

wc69f:: ;c69f
	ds 1

wc6a0:: ;c6a0
	ds 1

wc6a1:: ;c6a1
	ds 1

wc6a2:: ;c6a2
	ds 1

wc6a3:: ;c6a3
	ds 1

wc6a4:: ;c6a4
	ds 1

wc6a5:: ;c6a5
	ds 1

wc6a6:: ;c6a6
	ds 1

wc6a7:: ;c6a7
	ds 1

wc6a8:: ;c6a8
	ds 1

wc6a9:: ;c6a9
	ds 1

wc6aa:: ;c6aa
	ds 1

wc6ab:: ;c6ab
	ds 1

wc6ac:: ;c6ac
	ds 1

wc6ad:: ;c6ad
	ds 1

wc6ae:: ;c6ae
	ds 1

wc6af:: ;c6af
	ds 1

wc6b0:: ;c6b0
	ds 1

wc6b1:: ;c6b1
	ds 1

wc6b2:: ;c6b2
	ds 1

wc6b3:: ;c6b3
	ds 1

wc6b4:: ;c6b4
	ds 1

wc6b5:: ;c6b5
	ds 1

wc6b6:: ;c6b6
	ds 1

wc6b7:: ;c6b7
	ds 1

wc6b8:: ;c6b8
	ds 1

wc6b9:: ;c6b9
	ds 1

wc6ba:: ;c6ba
	ds 1

wc6bb:: ;c6bb
	ds 1

wc6bc:: ;c6bc
	ds 1

wc6bd:: ;c6bd
	ds 1

wc6be:: ;c6be
	ds 1

wc6bf:: ;c6bf
	ds 1

wc6c0:: ;c6c0
	ds 1

wc6c1:: ;c6c1
	ds 1

wc6c2:: ;c6c2
	ds 1

wc6c3:: ;c6c3
	ds 1

wc6c4:: ;c6c4
	ds 1

wc6c5:: ;c6c5
	ds 1

wc6c6:: ;c6c6
	ds 1

wc6c7:: ;c6c7
	ds 1

wc6c8:: ;c6c8
	ds 1

wc6c9:: ;c6c9
	ds 1

wc6ca:: ;c6ca
	ds 1

wc6cb:: ;c6cb
	ds 1

wc6cc:: ;c6cc
	ds 1

wc6cd:: ;c6cd
	ds 1

wc6ce:: ;c6ce
	ds 1

wc6cf:: ;c6cf
	ds 1

wc6d0:: ;c6d0
	ds 1

wc6d1:: ;c6d1
	ds 1

wc6d2:: ;c6d2
	ds 1

wc6d3:: ;c6d3
	ds 1

wc6d4:: ;c6d4
	ds 1

wc6d5:: ;c6d5
	ds 1

wc6d6:: ;c6d6
	ds 1

wc6d7:: ;c6d7
	ds 1

wc6d8:: ;c6d8
	ds 1

wc6d9:: ;c6d9
	ds 1

wc6da:: ;c6da
	ds 1

wc6db:: ;c6db
	ds 1

wc6dc:: ;c6dc
	ds 1

wc6dd:: ;c6dd
	ds 1

wc6de:: ;c6de
	ds 1

wc6df:: ;c6df
	ds 1

wc6e0:: ;c6e0
	ds 1

wc6e1:: ;c6e1
	ds 1

wc6e2:: ;c6e2
	ds 1

wc6e3:: ;c6e3
	ds 1

wc6e4:: ;c6e4
	ds 1

wc6e5:: ;c6e5
	ds 1

wc6e6:: ;c6e6
	ds 1

wc6e7:: ;c6e7
	ds 1

wc6e8:: ;c6e8
	ds 1

wc6e9:: ;c6e9
	ds 1

wc6ea:: ;c6ea
	ds 1

wc6eb:: ;c6eb
	ds 1

wc6ec:: ;c6ec
	ds 1

wc6ed:: ;c6ed
	ds 1

wc6ee:: ;c6ee
	ds 1

wc6ef:: ;c6ef
	ds 1

wc6f0:: ;c6f0
	ds 1

wTriggerJewelStatue2F:: ;C6F1
	ds 1

wc6f2:: ;c6f2
	ds 1

wc6f3:: ;c6f3
	ds 1

wc6f4:: ;c6f4
	ds 1

wResearcherRoomShelfNotMoved:: ;C6F5
	ds 1
wResearcherRoomShelfMoved:: ;C6F6
	ds 1

wc6f7:: ;c6f7
	ds 1

wc6f8:: ;c6f8
	ds 1

wc6f9:: ;c6f9
	ds 1

wc6fa:: ;c6fa
	ds 1

wc6fb:: ;c6fb
	ds 1

wc6fc:: ;c6fc
	ds 1

wc6fd:: ;c6fd
	ds 1

wc6fe:: ;c6fe
	ds 1

wc6ff:: ;c6ff
	ds 1

wc700:: ;c700
	ds $100


spritePriorityTable:: ;C800
;stores sprites draw priority data
;10 bytes of data per 8 chars
;C80x + 0: Sprite Y-sort value
;C80x + 1: Sprite ID
;C80x + 2: $00
;C80x + 3: Sprite X Pos
;C80x + 4: Sprite Y Pos
;C80x + 5: Sprite X scale
;C80x + 6: Sprite Y scale
;C80x + 7: Sprite facing
;C80x + 8: Sprite animation frame Id/animation timer
;C80x + 9: Sprite animation ID
	ds 10 * 8

;wEndSpritePriorityTable:: ;C84F





SECTION "OAMBuffers", WRAM0 [$c900]

wOAMBufferC9:: ; c900
	ds $CA00 - $C900

wOAMBufferCA:: ; cA00
	ds $CB00 - $CA00

;sprites tiles buffers

wSpriteTilesBuffer:: ;CB00
	ds $CC00 - $CB00

wSpriteTilesBufferCC:: ;CC00
	ds $CD00 - $CC00

wSpriteTilesBufferCD:: ;CD00
	ds $CE00 - $CD00

wSpriteTilesBufferCE:: ;CE00
	ds $CF00 - $CE00

wSpriteTilesBufferCF:: ;CF00
	ds $D000 - $CF00


SECTION "sound RAM",WRAMX,BANK[1]

	ds $DD00 - $D000

;music ram

;audio channel #1 wram
wChannel1State:: ;DD00
;channel status
;bit 0: channel enabled
;bit 1: play channel
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
wCh1DD15:: ;DD15
	ds 1
wCh1NextActionAddrLowBkp:: ;DD16
	ds 1
wCh1NextActionAddrHighBkp:: ;DD17
	ds 1


;audio channel #2 wram
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
wCh2DD2D:: ;DD2D
	ds 1
wCh2NextActionAddrLowBkp:: ;DD2E next action adress backup low
	ds 1
wCh2NextActionAddrHighBkp:: ;DD2F next action adress backup high
	ds 1


;audio channel #3 wram
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
wCh3DD45:: ;DD45
	ds 1
wCh3NextActionAddrLowBkp:: ;DD46
	ds 1
wCh3NextActionAddrHighBkp:: ;DD47
	ds 1


;audio channel #4 wram
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
wCh4DD5D:: ;DD5D
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

wDD66:: ;DD66 channel note id
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

wChannelId:: ;DD7B
;ch1 = 0
;ch2 = 1
;ch3 = 2
;ch4 = 3
	ds 1

wChl1CurrentNoteId:: ;DD7C ch1 current note id
	ds 1

wChl2CurrentNoteId:: ;DD7D ch2 current note id
	ds 1

wChl3CurrentNoteId:: ;DD7E ch3 current note id
	ds 1














