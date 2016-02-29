
walk_north:
	dw $0000 ;x-axis
	dw $0007 ;y-axis

walk_north_west:
	dw $0006
	dw $0006

walk_west:
	dw $0007
	dw $0000

walk_south_west:
	dw $0006
	dw $FFFA

walk_south:
	dw $0000
	dw $FFF9

walk_south_east:
	dw $FFFA
	dw $FFFA

walk_east:
	dw $FFF9
	dw $0000

walk_north_east:
	dw $FFFA
	dw $0006
