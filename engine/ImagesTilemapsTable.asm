
doorsPallete: ;00;2EEE
	dw doorsBGPallete ;$00, $59
	dw doorsBGPallete+$40 ;$40, $59
	db BANK(doorsBGPallete), $00

TitleLookupTable:: ;00:2EF4
	dw TitleScreen ;tiles data
	dw TitleScreen+$14C0 ;tilemap indexes
	db BANK(TitleScreen), $00 ; bank
	dw TitleScreen+$1628 ;pallete indexes

TitlePalLookupTable:: ;00:2EFC
	dw TitleScreenPal ;bg pal
	dw TitleScreenPal+$40 ;obj pal
	db BANK(TitleScreenPal), $00 ;bank

PlayerSelectScrnMapTable:: ;00:2F02
	dw PlayerSelectScreen ; $D8, $57
	dw PlayerSelectScreenIndexes ; $D8, $62
	db BANK(PlayerSelectScreen), $00
	dw PlayerSelectScreenIndexes+$252
;00:2F0A
	dw PlayerSelectScreenPallete
	dw PlayerSelectScreenPallete+$40
	db BANK(PlayerSelectScreenPallete), $00

LoadSaveScrnTable:: ;00:2F10
	dw LoadSaveMenuTiles ;5740
	dw loadSaveMenuIndexes
	db BANK(LoadSaveMenuTiles), $00
	dw loadSaveMenuIndexes+$18C

LoadSaveScrnPalTable:: ;00:2F18
	dw loadSaveMenuPal
	dw loadSaveMenuPal+$40
	db BANK(loadSaveMenuPal), $00

MainMenuMapTable:: ;00:2F1E
	dw MainMenuBgData ;$4000
	dw MainMenuBgData+$920 ;$4920
	db BANK(MainMenuBgData), $00
	dw MainMenuBgData+$B72 ;$4B72
;pallete
	dw MainMenuPallete ;$4DC4
	dw MainMenuPallete+$40 ;$4E04
	db BANK(MainMenuPallete), $00

HotGenStudiosSplashMaptable:: ;00:2F2C
	dw hotGenLogoBGData ;4000
	dw hotGenLogoBGData+$9A0
	db BANK(hotGenLogoBGData), $00
	dw hotGenLogoBGData+$B08
;pallete
	dw hotGenLogoPallete
	dw hotGenLogoPallete+$40
	db BANK(hotGenLogoPallete), $00

ChrisDeathScrnMapTable:: ;00:2F3A
	dw chrisDeathScreenData
	dw chrisDeathScreenData+$6E0
	db BANK(chrisDeathScreenData), $00
	dw chrisDeathScreenData+$920

	dw chrisDeathScreenPallete
	dw chrisDeathScreenPallete+$40
	db BANK(chrisDeathScreenPallete), $00

PauseScreenMapTable:: ;00:2F48
	dw pauseScreenData
	dw pauseScreenData+$870
	db BANK(pauseScreenData), $00
	dw pauseScreenData+$9D8

	dw pauseScreenPallete
	dw pauseScreenPallete+$40
	db BANK(pauseScreenPallete), $00

Stairs1TransitionMapTable:: ;00:2F56
	dw stairAtilemapData ;db $00, $40
	dw stairAtilemapData+$210 ;db $10, $42
	db BANK(stairAtilemapData), $00
	dw stairAtilemapData+$378 ;db $78, $43

	dw stairAtilemapPallete ;db $E0, $44
	dw stairAtilemapPallete+$40 ;db $20, $45
	db BANK(stairAtilemapPallete), $00

Stairs2TransitionMapTable:: ;00:2F64
	dw stairBtilemapData ;db $20, $45
	dw stairBtilemapData+$250 ;db $70, $47
	db BANK(stairBtilemapData), $00
	dw stairBtilemapData+$3B8 ;db $D8, $48

	dw stairBtilemapPallete ;db $40, $4A
	dw stairBtilemapPallete+$40 ;db $80, $4A
	db BANK(stairBtilemapPallete), $00

Stairs3TransitionMapTable:: ;00:2F72
	dw stairBtilemapData ;db $20, $45
	dw stairBtilemapData+$250 ;db $70, $47
	db BANK(stairBtilemapData), $00
	dw stairBtilemapData+$3B8 ;db $D8, $48

	dw stairBtilemapPallete ;db $40, $4A
	dw stairBtilemapPallete+$40 ;db $80, $4A
	db BANK(stairBtilemapPallete), $00

Ladder1TransitionMapTable:: ;00:2F80
	dw ladderTilemapData ;db $80, $4A
	dw ladderTilemapData+$60 ;db $E0, $4A
	db BANK(ladderTilemapData), $00
	dw ladderTilemapData+$1C8 ;db $48, $4C

	dw ladderTilemapPallete ;db $B0, $4D
	dw ladderTilemapPallete+$40 ;db $F0, $4D
	db BANK(ladderTilemapPallete), $00

RopeTransitionMapTable:: ;00:2F8E
	dw ropeTilemapData ;db $F0, $4D
	dw ropeTilemapData+$50 ;db $40, $4E
	db BANK(ropeTilemapData), $00
	dw ropeTilemapData+$1B8 ;db $A8, $4F

	dw ropeTilemapPallete ;db $10, $51
	dw ropeTilemapPallete+$40 ;db $50, $51
	db BANK(ropeTilemapPallete), $00

Ladder2TransitionMapTable:: ;00:2F9C
	dw ladderTilemapData ;db $80, $4A
	dw ladderTilemapData+$60 ;db $E0, $4A
	db BANK(ladderTilemapData), $00
	dw ladderTilemapData+$1C8 ;db $48, $4C

	dw ladderTilemapPallete ;db $B0, $4D
	dw ladderTilemapPallete+$40 ;db $F0, $4D
	db BANK(ladderTilemapPallete), $00

ItemBoxMapTable:: ;00:2FAA
	dw itemBoxMenuData ;$4EBC
	dw itemBoxMenuData+$800 ;$56BC
	db BANK(itemBoxMenuData), $00
	dw itemBoxMenuData+$A52 ;$590E
;pallete
	dw itemBoxMenuPallete ;$5B60
	dw itemBoxMenuPallete+$40 ;$5BA0
	db BANK(itemBoxMenuPallete), $00

FirstZombieScrnMapTable:: ;00:2FB8
	dw firstZombieScene ;$00, $40
	dw firstZombieScene+$CD0 ;$D0, $4C
	db BANK(firstZombieScene), $00 ;$C4
	dw firstZombieScene+$E38 ;$38, $4E

	dw firstZombieScenePal ;$A0, $4F
	dw firstZombieScenePal+$40 ;$E0, $4F
	db BANK(firstZombieScenePal), $00

FallingStatueScrnMapTable:: ;00:2FC6
	dw fallingStatueScreenData
	dw fallingStatueScreenData+$F90
	db BANK(fallingStatueScreenData), $00
	dw fallingStatueScreenData+$10F8
fallingStatueBgImgPal: ;00:2FCE
	dw fallingStatueScreenPal
	dw fallingStatueScreenPal+$40
	db BANK(fallingStatueScreenPal), $00

;event bg image table 2FD4
	db $14, $00
	dw FirstZombieScrnMapTable ; $B8, $2F ;first zombie bg img
	db $14, $00
	dw FallingStatueScrnMapTable ;falling statue bg img
