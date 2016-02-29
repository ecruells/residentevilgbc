
run_north:
	dw $0000 ;x-axis
	dw $000E ;y-axis

run_north_west:
	dw $000C
	dw $000C

run_west:
	dw $000E
	dw $0000

run_south_west:
	dw $000C
	dw $FFF4

run_south:
	dw $0000
	dw $FFF2

run_south_east:
	dw $FFF4
	dw $FFF4

run_east:
	dw $FFF2
	dw $0000

run_north_east:
	dw $FFF4
	dw $000C
