
; x, z
zombieMoveTable: ;FC:4489
.walk_north
	dw 0, 4

.walk_north_west
	dw 3, 3

.walk_west
	dw 4, 0

.walk_south_west
	dw 3, -3

.walk_south
	dw 0, -4

.walk_south_east
	dw -3, -3

.walk_east
	dw -4, 0

.walk_north_east
	dw -3, 3

zombieMoveBackwardTable: ;FC:44A9
.backward_walk_north
	dw 0, 8

.backward_walk_north_west
	dw 6, 6

.backward_walk_west
	dw 8, 0

.backward_walk_south_west
	dw 6, -6

.backward_walk_south
	dw 0, -8

.backward_walk_south_east
	dw -6, -6

.backward_walk_east
	dw -8, 0
	
.backward_walk_north_east
	dw -6, 6
