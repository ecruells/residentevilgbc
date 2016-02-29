
DoNotLoadText:
	db $0C, $04 ;y & x tile position
	db "DO NOT LOAD"
	db $00 ; end of text

DoNotSaveText:
	db $0C, $04 ;y & x tile position
	db "DO NOT SAVE"
	db $00 ; end of text
