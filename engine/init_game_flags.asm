initGameFlags: ;C5:6273
    ld de, initialDoorsLocksFlags
    ld hl, wDoorsLocksFlags
    ld bc, 128
    call copyBytesData
    ld de, initialEventsFlags
    ld hl, wEventsFlags
    ld bc, 128
    call copyBytesData
    ld de, initialRoomsItemsFlags
    ld hl, wRoomsItemsFlags
    ld bc, 256
    call copyBytesData
    ld de, initialEnemiesAndObjectsFlags
    ld hl, wEnemiesAndObjectsFlags
    ld bc, 256
    call copyBytesData
    ld hl, wFilesFlags
    ld b, 4 ; set the first 4 files flags
.initFileFlagLoop
    ld [hl], $FF
    inc hl
    dec b
    jr nz, .initFileFlagLoop
; init special flags by selected player
    ld a, [wSelectedCharacter]
    or a
    jr z, .Label3162C4 ; not special flags for chris
; init jill flags
    ld a, $FF
    ld [wDoorsLocksFlags+DOOR_49], a
    ld [wMansionBathtubUnpluggedFlag], a
; disable flamethrowers for jill
    xor a
    ld [wRoomsItemsFlags+ROOM3D_FLAMETHROWER], a
    ld [wRoomsItemsFlags+ROOM43_FLAMETHROWER], a
    ret
.Label3162C4
	ret
;c5:62c5
