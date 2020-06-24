jillMainMenuCursorsDataTable: ;FC:4CF4
; map option
	dw $984D		; options tiles map address
	dw $993C		; unselected options tiles map address
	dw $989C		; selected options tiles map address
	db 3, 1			; single option tiles size (w,h)
	db 0			; cursor Id

; radio option 
	dw $9850
	dw $993C
	dw $989C
	db 3, 1
	db 1

; file option
	dw $986D
	dw $993C
	dw $989C
	db 3, 1
	db 2

; exit option
	dw $9870
	dw $993C
	dw $989C
	db 3, 1
	db 3

jillItemSlotsCursorsDataTable: ;4D18
; slot 1
	dw $98CD		; item slot map address
	dw $99DC		; unselected item slot tiles map address
	dw $9A1C		; selected item slot tiles map address
	db 3, 2			; item slot tiles size (w,h)
	db 4			; cursor id

; slot 2
	dw $98D0
	dw $99DC
	dw $9A1C
	db 3, 2
	db 5

; slot 3
	dw $990D
	dw $99DC
	dw $9A1C
	db 3, 2
	db 6

; slot 4
	dw $9910
	dw $99DC
	dw $9A1C
	db 3, 2
	db 7

; slot 5
	dw $994D
	dw $99DC
	dw $9A1C
	db 3, 2
	db 8

; slot 6
	dw $9950
	dw $99DC
	dw $9A1C
	db 3, 2
	db 9

; slot 7
	dw $998D
	dw $99DC
	dw $9A1C
	db 3, 2
	db 10

; slot 8
	dw $9990
	dw $99DC
	dw $9A1C
	db 3, 2
	db 11

chrisMainMenuCursorsDataTable: ;4D60
; map option
	dw $984D		; options tiles map address
	dw $993C		; unselected options tiles map address
	dw $989C		; selected options tiles map address
	db 3, 1			; single option tiles size (w,h)
	db 0			; cursor Id

; radio option 
	dw $9850
	dw $993C
	dw $989C
	db 3, 1
	db 1

; file option
	dw $986D
	dw $993C
	dw $989C
	db 3, 1
	db 2
	
; exit option
	dw $9870
	dw $993C
	dw $989C
	db 3, 1
	db 3

chrisItemSlotsCursorsDataTable: ;4D84
; slot 1
	dw $990D
	dw $99DC
	dw $9A1C
	db 3, 2
	db 4

; slot 2
	dw $9910
	dw $99DC
	dw $9A1C
	db 3, 2
	db 5

; slot 3
	dw $994D
	dw $99DC
	dw $9A1C
	db 3, 2
	db 6

; slot 4
	dw $9950
	dw $99DC
	dw $9A1C
	db 3, 2
	db 7

; slot 5
	dw $998D
	dw $99DC
	dw $9A1C
	db 3, 2
	db 8

; slot 6
	dw $9990
	dw $99DC
	dw $9A1C
	db 3, 2
	db 9
