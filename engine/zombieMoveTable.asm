
zombieMoveTable: ;FC:4489
;walk_north
	dw $0000
	dw $0004
;walk_north_west
	dw $0003
	dw $0003
;walk_west
	dw $0004
	dw $0000
;walk_south_west
	dw $0003
	dw $FFFD
;walk_south
	dw $0000
	dw $FFFC
;walk_south_east
	dw $FFFD
	dw $FFFD
;walk_east
	dw $FFFC
	dw $0000
;walk_north_east
	dw $FFFD
	dw $0003

zombieMoveBackwardTable: ;FC:44A9
;backward_walk_north
	dw $0000
	dw $0008
;backward_walk_north_west
	dw $0006
	dw $0006
;backward_walk_west
	dw $0008
	dw $0000
;backward_walk_south_west
	dw $0006
	dw $FFFA
;backward_walk_south
	dw $0000
	dw $FFF8
;backward_walk_south_east
	dw $FFFA
	dw $FFFA
;backward_walk_east
	dw $FFF8
	dw $0000
;backward_walk_north_east
	dw $FFFA
	dw $0006
