jillMapCursor: ;FC:4CF4
	dw $984D
	dw $993C
	dw $989C
	db $03, $01
	db $00, $50
	db $98, $3C
	db $99, $9C
	db $98, $03
	db $01, $01
;4D06
	db $6D, $98
	db $3C, $99
	db $9C, $98
	db $03, $01
	db $02, $70
	db $98, $3C
	db $99, $9C
	db $98, $03
	db $01, $03
jillFirstItemSlotCursor: ;4D18
	db $CD, $98
	db $DC, $99
	db $1C, $9A
	db $03, $02
	db $04, $D0
	db $98, $DC
	db $99, $1C
	db $9A, $03
	db $02, $05
;4D2A
	db $0D, $99
	db $DC, $99
	db $1C, $9A
	db $03, $02
	db $06, $10
	db $99, $DC
	db $99, $1C
	db $9A, $03
	db $02, $07
;4D3C
	db $4D, $99
	db $DC, $99
	db $1C, $9A
	db $03, $02
	db $08, $50
	db $99, $DC
	db $99, $1C
	db $9A, $03
	db $02, $09
;4D4E
	db $8D, $99
	db $DC, $99
	db $1C, $9A
	db $03, $02
	db $0A, $90
	db $99, $DC
	db $99, $1C
	db $9A, $03
	db $02, $0B
chrisMapCursor: ;4D60
	dw $984D ;cursor map position
	dw $993C ;unselected cursor tiles address
	dw $989C ;selected cursor tiles address
	db $03, $01 ;cursor tiles size (w,h)
	db $00, $50 ;00: grid id
	db $98, $3C
	db $99, $9C
	db $98, $03
	db $01, $01
;4D72
	db $6D, $98
	db $3C, $99
	db $9C, $98
	db $03, $01
	db $02, $70
	db $98, $3C
	db $99, $9C
	db $98, $03
	db $01, $03

chrisFirstItemSlotCursor: ;4D84
	db $0D, $99
	db $DC, $99
	db $1C, $9A
	db $03, $02
	db $04, $10
	db $99, $DC
	db $99, $1C
	db $9A, $03
	db $02, $05
;4D96
	db $4D, $99
	db $DC, $99
	db $1C, $9A
	db $03, $02
	db $06, $50
	db $99, $DC
	db $99, $1C
	db $9A, $03
	db $02, $07
;4DA8
	db $8D, $99
	db $DC, $99
	db $1C, $9A
	db $03, $02
	db $08, $90
	db $99, $DC
	db $99, $1C
	db $9A, $03
	db $02, $09
;4DBA
