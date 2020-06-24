
LoadGameText:
	db 1, 6 ; yx tile position
	db "LOAD  GAME"
	db 0 ; end of text

SaveGameText:
	db 1, 6 ; y x tile position
	db "SAVE  GAME"
	db 0 ; end of text

ChrisName:
	db "CHRIS "

JillName:
	db "JILL  "

EmptySlotText:
	db "EMPTY "
	db 0 ; end of text

MainHall1FSaveText:
	db "MHALL 1F "

StorSaveText:
	db "STOR1 1F "
	db "STOR2 1F "
	db "STOR3 1F "
	db "STOR4 1F "

SavesCounterText: ;575B
	db "01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 "

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


DoNotLoadText:
	db 12, 4 ; yx tile position
	db "DO NOT LOAD"
	db 0 ; end of text

DoNotSaveText:
	db 12, 4 ; yx tile position
	db "DO NOT SAVE"
	db 0 ; end of text
