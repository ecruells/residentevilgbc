
mapSubmenuTilesDataPointers: ;356B
	db BANK(mansionMapPreview01Data), $00
	dw mansionMapPreview01Data+$170
	dw mansionMapPreview01Data ;4140
	dw mansionMapPreview01Data+$1C8
	db BANK(map_preview_pallete), $00
	dw map_preview_pallete

fileBook01TilesDataPointers: ;3577
	db BANK(fileBook01TilesData), $00
	dw fileBook01TilesData+$1A0
	dw fileBook01TilesData ;4DF0
	dw fileBook01TilesData+$1F8
	db BANK(itemCheckOptionPallete), $00
	dw itemCheckOptionPallete

fileBook02TilesDataPointers: ;3583
	db BANK(fileBook02TilesData), $00
	dw fileBook02TilesData+$1C0 ;5200
	dw fileBook02TilesData ;5040
	dw fileBook02TilesData+$218 ;5258
	db BANK(itemCombineOptionPallete), $00
	dw itemCombineOptionPallete

fileBook03TilesDataPointers: ;358F
	db BANK(fileBook03TilesData), $00
	dw fileBook03TilesData+$1A0
	dw fileBook03TilesData ;52B0
	dw fileBook03TilesData+$1F8
	db BANK(itemUseEquipOptionPallete), $00
	dw itemUseEquipOptionPallete

itemCheckOptionDataPointers: ;359B check option
	db BANK(itemCheckOptionData), $00
	dw itemCheckOptionData+$100
	dw itemCheckOptionData
	dw itemCheckOptionData+$158
	db BANK(itemCheckOptionPallete), $00
	dw itemCheckOptionPallete

itemCombineOptionDataPointers: ;35A7 ;combine option
	db BANK(itemCombineOptionData), $00
	dw itemCombineOptionData+$100
	dw itemCombineOptionData
	dw itemCombineOptionData+$158
	db BANK(itemCombineOptionPallete), $00
	dw itemCombineOptionPallete

itemUseEquipOptionDataPointers: ;35B3 use/equip option
	db BANK(itemUseEquipOptionData), $00;bank
	dw itemUseEquipOptionData+$100;tileIds
	dw itemUseEquipOptionData ;tileData
	dw itemUseEquipOptionData+$158;palIds
	db BANK(itemUseEquipOptionPallete), $00;pal bank
	dw itemUseEquipOptionPallete;pallete
