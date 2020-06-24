; get axes scale factors. If we project 4 vertices in a square shape, the proyected plane with these factors
; results in a slightly rectangular plane, because the X axis factor is bigger than Y axis factor
;
getAxesScaleFactors:: ;01:564A
    ld hl, 56 ; x scale factor
    ld de, 46 ; y scale factor
    ld bc, 65 ; z scale factor
; before load factor values, check for special rooms cameras x-axis scale factor
    ld a, [wRoomId]
    cp a, PIANO_ROOM
    jp z, Label5681
    cp a, NORTH_EAST_CORRIDOR_1F
    jp z, Label568A
    cp a, WEST_STAIRCASE_2F
    jp z, Label5693
    cp a, WAY_TO_GUARDHOUSE
    jp z, Label569F
    cp a, AQUA_TANK_ENTRANCE
    jp z, Label56A7
    cp a, LAB_CENTRAL_CLOISTER
    jp z, Label56B9
    cp a, EMERGENCY_TUNNEL
    jp z, Label56B0
    cp a, OPERATING_MORGE_ROOM
    jp z, Label56C2
    jp loadAxesScaleFactors

Label5681:
    ld a, [wRoomCameraId]
    cp a, 1
    jr nz, loadAxesScaleFactors
    jr setSpecialXScaleFactor
Label568A:
    ld a, [wRoomCameraId]
    cp a, 6
    jr nz, loadAxesScaleFactors
    jr setSpecialXScaleFactor
Label5693:
    ld a, [wRoomCameraId]
    or a
    jr z, .Label569D
    cp a, 2
    jr nz, loadAxesScaleFactors
.Label569D
    jr setSpecialXScaleFactor
Label569F:
    ld a, [wRoomCameraId]
    or a
    jr nz, loadAxesScaleFactors
    jr setSpecialXScaleFactor
Label56A7:
    ld a, [wRoomCameraId]
    cp a, 4
    jr nz, loadAxesScaleFactors
    jr setSpecialXScaleFactor
Label56B0:
    ld a, [wRoomCameraId]
    cp a, 5
    jr nz, loadAxesScaleFactors
    jr setSpecialXScaleFactor
Label56B9:
    ld a, [wRoomCameraId]
    cp a, 4
    jr nz, loadAxesScaleFactors
    jr setSpecialXScaleFactor
Label56C2:
    ld a, [wRoomCameraId]
    cp a, 4
    jr nz, loadAxesScaleFactors
    jr setSpecialXScaleFactor
setSpecialXScaleFactor:
    ld hl, 46 ; special x factor, this result in a symmetric scale with y-axis

loadAxesScaleFactors:: ;01:56CE
    ld a, l
    ld [wXScaleFactor], a
    ld a, h
    ld [wXScaleFactor+1], a
    ld a, e
    ld [wYScaleFactor], a
    ld a, d
    ld [wYScaleFactor+1], a
    ld a, c
    ld [wZScaleFactor], a
    ld a, b
    ld [wZScaleFactor+1], a
    ret