
; tilemap bank
; tilemap pointer
; tiles data pointer
; tilemap attributes pointer
; palette bank
; palette pointer

mapMenuTilemapStruct: ;356B
; mansion only
	db BANK(mansionMapPreview01Data), $00
	dw mansionMapPreview01Data+$170 ; tilemap
	dw mansionMapPreview01Data ; tiles data
	dw mansionMapPreview01Data+$1C8 ; attributes
	db BANK(mapMenuPalette), $00
	dw mapMenuPalette

; mansion and warehouse (unused, bad palette indexes)
	; db BANK(mansionMapPreview02Data), $00
	; dw mansionMapPreview02Data+$240
	; dw mansionMapPreview02Data
	; dw mansionMapPreview02Data+$292
	; db BANK(mapMenuPalette), $00
	; dw mapMenuPalette

; mansion, courtyard and warehouse (unused)
	; db BANK(mansionMapPreview03Data), $00
	; dw mansionMapPreview03Data+$320
	; dw mansionMapPreview03Data
	; dw mansionMapPreview03Data+$378
	; db BANK(mapMenuPalette), $00
	; dw mapMenuPalette

; mansion, courtyard and warehouse (unused, same as 03)
	; db BANK(mansionMapPreview04Data), $00
	; dw mansionMapPreview04Data+$320
	; dw mansionMapPreview04Data
	; dw mansionMapPreview04Data+$378
	; db BANK(mapMenuPalette), $00
	; dw mapMenuPalette

fileBook01TilemapStruct: ;3577
	db BANK(filebook01Tilemap), $00
	dw filebook01Tilemap+$1A0
	dw filebook01Tilemap
	dw filebook01Tilemap+$1F8
	db BANK(itemCheckOptionPalette), $00
	dw itemCheckOptionPalette

fileBook02TilemapStruct: ;3583
	db BANK(filebook02Tilemap), $00
	dw filebook02Tilemap+$1C0
	dw filebook02Tilemap
	dw filebook02Tilemap+$218
	db BANK(itemCombineOptionPalette), $00
	dw itemCombineOptionPalette

fileBook03TilemapStruct: ;358F
	db BANK(filebook03Tilemap), $00
	dw filebook03Tilemap+$1A0
	dw filebook03Tilemap
	dw filebook03Tilemap+$1F8
	db BANK(itemUseEquipOptionPalette), $00
	dw itemUseEquipOptionPalette

itemCheckOptionTilemapStruct: ;359B
	db BANK(itemCheckOptionTilemap), $00
	dw itemCheckOptionTilemap+$100
	dw itemCheckOptionTilemap
	dw itemCheckOptionTilemap+$158
	db BANK(itemCheckOptionPalette), $00
	dw itemCheckOptionPalette

itemCombineOptionTilemapStruct: ;35A7
	db BANK(itemCombineOptionTilemap), $00
	dw itemCombineOptionTilemap+$100
	dw itemCombineOptionTilemap
	dw itemCombineOptionTilemap+$158
	db BANK(itemCombineOptionPalette), $00
	dw itemCombineOptionPalette

itemUseOptionTilemapStruct: ;35B3
	db BANK(itemUseOptionTilemap), $00
	dw itemUseOptionTilemap+$100
	dw itemUseOptionTilemap
	dw itemUseOptionTilemap+$158
	db BANK(itemUseEquipOptionPalette), $00
	dw itemUseEquipOptionPalette
