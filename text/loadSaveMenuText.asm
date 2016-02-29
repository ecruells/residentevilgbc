
LoadGameText:
	db $01, $06 ;y & x tile position
	db "LOAD  GAME"
	db $00 ; end of text

SaveGameText:
	db $01, $06 ;y & x tile position
	db "SAVE  GAME"
	db $00 ; end of text

ChrisName:
	db "CHRIS "

JillName:
	db "JILL  "

EmptySlotText:
	db "EMPTY "
	db $00

MainHall1FSaveText:
	db "MHALL 1F "

StorSaveText:
	db "STOR1 1F "
	db "STOR2 1F "
	db "STOR3 1F "
	db "STOR4 1F "

SavesCounterText: ;575B
	db "01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 "
