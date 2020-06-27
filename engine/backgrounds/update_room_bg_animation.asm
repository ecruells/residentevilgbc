updateRoomBgAnimationMasks:: ;01:4AFE
    ld a, [wRoomId]
    cp a, GREENHOUSE
    jp z, updateGreenhousePlantAnimation
    cp a, WATERFALL_GARDEN
    jp z, updateWaterfallGardenAnimation
    cp a, UNDERGROUND_WAREHOUSE
    jp z, updateUndergroundWarehouseSpiderweb
    ret

updateGreenhousePlantAnimation:: ;01:4B11
    ld a, [wHerbicideUsedFlag]
    or a
    ret nz
    ld a, [wRoomCameraId]
    cp a, 1
    jr z, .plantAnimMaskScreen1
    cp a, 2
    jr z, .plantAnimMaskScreen2
    ret
.plantAnimMaskScreen1 ;01:4B22
    ld a, 0
    ld [wRoomBgTileLeftX], a
    ld a, 18
    ld [wRoomBgTileRightX], a
    ld a, 10
    ld [wRoomBgTileTopY], a
    ld a, 16
    ld [wRoomBgTileBottomY], a
    ld hl, room06_01_fountain_plant_masks
    ld a, [wTicksCounter]
    ld c, a
    and a, 7 ; change mask every 8 ticks
    ret nz
    ld a, c
    and a, 31
    srl a
    srl a
    srl a ; get mask index ( (tick & 31) / 8 )
    ld c, a
    add a
    add a, c
    ld c, a
    ld b, 0
    add hl, bc
    jp loadRoomBackgroundArea
.plantAnimMaskScreen2
    ld a, 3
    ld [wRoomBgTileLeftX], a
    ld a, 16
    ld [wRoomBgTileRightX], a
    ld a, 8
    ld [wRoomBgTileTopY], a
    ld a, 11
    ld [wRoomBgTileBottomY], a
    ld hl, room06_02_fountain_plant_masks
    ld a, [wTicksCounter]
    ld c, a
    and a, 7 
    ret nz
    ld a, c
    and a, 31
    srl a
    srl a
    srl a
    ld c, a
    add a
    add a, c
    ld c, a
    ld b, 0
    add hl, bc
    jp loadRoomBackgroundArea

updateWaterfallGardenAnimation:: ;01:4B84
    ld a, [wCourtyardFloodgateClosedFlag]
    or a
    ret z
    ld a, [wRoomCameraId]
    cp a, 2
    jr z, .Label4B91
    ret
.Label4B91 ;01:4B91
    ld a, 9
    ld [wRoomBgTileLeftX], a
    ld a, 15
    ld [wRoomBgTileRightX], a
    ld a, 0
    ld [wRoomBgTileTopY], a
    ld a, 9
    ld [wRoomBgTileBottomY], a
    ld hl, room38_02_waterwall_masks
    ld a, [wTicksCounter]
    ld c, a
    and a, 7 ; change mask every 8 ticks
    ret nz
    ld a, c
    and a, 31
    ld c, a
    ld a, 31 ; reverse animation index (3,2,1,0,3,2,1,0...)
    sub a, c 
    srl a
    srl a
    srl a
    ld c, a ; get mask index ( 31 - (tick & 31) / 8 )
    add a
    add a, c
    ld c, a
    ld b, 0
    add hl, bc
    jp loadRoomBackgroundArea


; check if the player is facing in front of the blocked door in the underground warehouse (black tiger room),
; if the player is attacking with the knife, the bg mask will change until all the sprider web is removed.
;
updateUndergroundWarehouseSpiderweb:: ;014BC6
; check if player is facing the blocked door (west and south-west)
    ld a, [wEntityFacing]
    cp a, FACING_SOUTH_WEST+1
    ret nc
    cp a, FACING_NORTH_WEST
    ret c
; check if player position is in front of the blocked door
    positionVarGteX 320
    positionVarGteZ1AndLtZ2 -80, 112
.checkKnifeAttackAnimation
    ld a, [wEntityAnimationId]
    cp a, KNIFE_AIM_ANIM
    ret nz
    ld a, [wEntityAnimationFrameId]
    cp a, $14
    jr z, .incSpritedwebKnifeCuts
    cp a, $1C
    jr z, .incSpritedwebKnifeCuts
    cp a, $24
    jr z, .incSpritedwebKnifeCuts
    ret
.incSpritedwebKnifeCuts ;01:4C06
    ld a, [wSpiderwebKnifeCutsCounter]
    cp a, 3
    ret nc ; return if max cuts
    inc a
    ld [wSpiderwebKnifeCutsCounter], a
    cp a, 3
    jr nc, .reloadCleanRoomBg
    jp loadRoomScreenBackgroundMaskCaller
.reloadCleanRoomBg
    ld a, $FF
    ld [wDoorsLocksFlags+DOOR_50], a
    ld a, [wRoomId]
    ld l, a
    ld a, [wRoomIdHigh]
    ld h, a
    add hl, hl
    add hl, hl
    ld de, roomsBgLookupTable
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
    xor a ; 0
    ld [wRoomBgTileTopY], a
    ld a, 16
    ld [wRoomBgTileBottomY], a
    xor a ; 0
    ld [wRoomBgTileLeftX], a
    ld a, 20
    ld [wRoomBgTileRightX], a
    jp loadRoomScreenBackground

;01:4C42