
doorsPalette: ;00;2EEE
	dw doorsBGPalette
	dw doorsBGPalette+$40
	db BANK(doorsBGPalette), 0


titleScreenTilemapStruct:: ;00:2EF4
	dw titleScreenTilemap ; tiles data
	dw titleScreenTilemap+$14C0 ; tilemap indexes
	db BANK(titleScreenTilemap), 0
	dw titleScreenTilemap+$1628 ; bg map attributes
titleScreenPaletteStruct:: ;00:2EFC
	dw titleScreenPalette ; bg pal
	dw titleScreenPalette+$40 ; obj pal
	db BANK(titleScreenPalette), 0


playerSelectScreenTilemapStruct:: ;00:2F02
	dw characterSelectScreenTilesData
	dw characterSelectScreenTilesmap
	db BANK(characterSelectScreenTilesData), 0
	dw characterSelectScreenTilesmap+$252
; palette
	dw characterSelectScreenPalette
	dw characterSelectScreenPalette+$40
	db BANK(characterSelectScreenPalette), 0


loadSaveScreenTilemapStruct:: ;00:2F10
	dw LoadSaveMenuTiles
	dw loadSaveMenuIndexes
	db BANK(LoadSaveMenuTiles), 0
	dw loadSaveMenuIndexes+$18C
loadSaveScreenPaletteStruct:: ;00:2F18
	dw loadSaveMenuPalette
	dw loadSaveMenuPalette+$40
	db BANK(loadSaveMenuPalette), 0


mainMenuTilemapStruct:: ;00:2F1E
	dw mainMenuTilemap
	dw mainMenuTilemap+$920
	db BANK(mainMenuTilemap), 0
	dw mainMenuTilemap+$B72
; palette
	dw mainMenuPalette
	dw mainMenuPalette+$40
	db BANK(mainMenuPalette), 0

hotgenLogoTilemapStruct:: ;00:2F2C
	dw hotgenStudiosLogoTilemap
	dw hotgenStudiosLogoTilemap+$9A0
	db BANK(hotgenStudiosLogoTilemap), 0
	dw hotgenStudiosLogoTilemap+$B08
; palette
	dw hotgenStudiosLogoPalette
	dw hotgenStudiosLogoPalette+$40
	db BANK(hotgenStudiosLogoPalette), 0


deathScreenTilemapStruct:: ;00:2F3A
	dw deathScreenTilemap
	dw deathScreenTilemap+$6E0
	db BANK(deathScreenTilemap), 0
	dw deathScreenTilemap+$920
; palette
	dw deathScreenPalette
	dw deathScreenPalette+$40
	db BANK(deathScreenPalette), 0


pauseScreenTilemapStruct:: ;00:2F48
	dw pauseScreenTilemap
	dw pauseScreenTilemap+$870
	db BANK(pauseScreenTilemap), 0
	dw pauseScreenTilemap+$9D8
pauseScreenPaletteStruct:
	dw pauseScreenPalette
	dw pauseScreenPalette+$40
	db BANK(pauseScreenPalette), 0


stairsTypeATilemapStruct:: ;00:2F56
	dw stairsTypeATilemap
	dw stairsTypeATilemap+$210
	db BANK(stairsTypeATilemap), 0
	dw stairsTypeATilemap+$378
; palette
	dw stairsTypeAPalette
	dw stairsTypeAPalette+$40
	db BANK(stairsTypeAPalette), 0


stairsTypeBTilemapStruct:: ;00:2F64
	dw stairsTypeBTilemap
	dw stairsTypeBTilemap+$250
	db BANK(stairsTypeBTilemap), 0
	dw stairsTypeBTilemap+$3B8
; palette
	dw stairsTypeBPalette
	dw stairsTypeBPalette+$40
	db BANK(stairsTypeBPalette), 0

stairsTypeCTilemapStruct:: ;00:2F72
	dw stairsTypeBTilemap
	dw stairsTypeBTilemap+$250
	db BANK(stairsTypeBTilemap), 0
	dw stairsTypeBTilemap+$3B8
; palette
	dw stairsTypeBPalette
	dw stairsTypeBPalette+$40
	db BANK(stairsTypeBPalette), 0


ladderTypeATilemapStruct:: ;00:2F80
	dw ladderTilemap
	dw ladderTilemap+$60
	db BANK(ladderTilemap), 0
	dw ladderTilemap+$1C8
; palette
	dw ladderTilemapPalette
	dw ladderTilemapPalette+$40
	db BANK(ladderTilemapPalette), 0


ropeTilemapStruct:: ;00:2F8E
	dw ropeTilemap
	dw ropeTilemap+$50
	db BANK(ropeTilemap), 0
	dw ropeTilemap+$1B8
; palette
	dw ropeTilemapPalette
	dw ropeTilemapPalette+$40
	db BANK(ropeTilemapPalette), 0


ladderTypeBTilemapStruct:: ;00:2F9C
	dw ladderTilemap
	dw ladderTilemap+$60
	db BANK(ladderTilemap), 0
	dw ladderTilemap+$1C8
; palette
	dw ladderTilemapPalette
	dw ladderTilemapPalette+$40
	db BANK(ladderTilemapPalette), 0


itemBoxMenuTilemapStruct:: ;00:2FAA
	dw itemBoxMenuTilemap
	dw itemBoxMenuTilemap+$800
	db BANK(itemBoxMenuTilemap), 0
	dw itemBoxMenuTilemap+$A52
; palette
	dw itemBoxMenuPalette
	dw itemBoxMenuPalette+$40
	db BANK(itemBoxMenuPalette), 0


firstZombieSceneTilemapStruct:: ;00:2FB8
	dw firstZombieSceneTilemap
	dw firstZombieSceneTilemap+$CD0
	db BANK(firstZombieSceneTilemap), 0
	dw firstZombieSceneTilemap+$E38
; palette
	dw firstZombieScenePalette
	dw firstZombieScenePalette+$40
	db BANK(firstZombieScenePalette), 0

fallingStatueTilemapStruct:: ;00:2FC6
	dw fallingStatueTilemap
	dw fallingStatueTilemap+$F90
	db BANK(fallingStatueTilemap), 0
	dw fallingStatueTilemap+$10F8
fallingStatuePaletteStruct: ;00:2FCE
	dw fallingStatuePalette
	dw fallingStatuePalette+$40
	db BANK(fallingStatuePalette), 0

;event bg image table 2FD4
	dw $14
	dw firstZombieSceneTilemapStruct ; first zombie bg img
	db $14, $00
	dw fallingStatueTilemapStruct ; falling statue bg img
