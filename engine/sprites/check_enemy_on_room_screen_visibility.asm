; check if an enemy (zombie) is visible in the current room screen. Return true if
; is visible ($FF), if not, return false ($00)
;
; de: sprite data struct address
checkEnemyOnRoomScreenVisibility:: ;C4:6280
    ld hl, wZombieAndObjectVarId - wEntityStructData
    add hl, de
    ld a, [hl] ; get zombie ID
    or a ; 0
    jp z, Label3122FF
    cp a, $01
    jp z, Label31230F
    cp a, $02
    jp z, Label31231F
    cp a, $03
    jp z, Label31232A
    cp a, $04
    jp z, Label312335
    cp a, $05
    jp z, Label31233F
    cp a, $06
    jp z, Label31234A
    cp a, $07
    jp z, Label312355
    cp a, $08
    jp z, Label312360
    cp a, $09
    jp z, Label31236B
    cp a, $2E
    jp z, Label31237B
    cp a, $2F
    jp z, Label312386
    cp a, $30
    jp z, Label312396
    cp a, $31
    jp z, Label3123A0
    cp a, $32
    jp z, Label3123B0
    cp a, $33
    jp z, Label3123C0
    cp a, $34
    jp z, Label3123CB
    cp a, $35
    jp z, Label3123D6
    cp a, $36
    jp z, Label3123E0
    cp a, $37
    jp z, Label3123EB
    cp a, $3C
    jp z, Label3123FB
    cp a, $3D
    jp z, Label312406
    cp a, $3E
    jp z, Label312416
; visible by default
    ld a, $FF
    ret

enemyIsVisible: ;C4:62FA
    ld a, $FF
    ret
enemyIsNotVisible: ;C4:62FD
    xor a
    ret

Label3122FF: ;C4:62FF
    ld a, [wRoomCameraId]
    cp a, 4
    jp z, enemyIsVisible
    cp a, 5
    jp z, enemyIsVisible
    jp enemyIsNotVisible

Label31230F:
    ld a, [wRoomCameraId]
    cp a, 1
    jp z, enemyIsVisible
    cp a, 3
    jp z, enemyIsVisible
    jp enemyIsNotVisible

Label31231F:
    ld a, [wRoomCameraId]
    cp a, 2
    jp z, enemyIsVisible
    jp enemyIsNotVisible

Label31232A:
    ld a, [wRoomCameraId]
    cp a, 4
    jp nz, enemyIsNotVisible
    jp enemyIsVisible

Label312335:
    ld a, [wFirstZombieEventFlag]
    or a
    jp z, enemyIsNotVisible
    jp enemyIsVisible

Label31233F:
    ld a, [wRoomCameraId]
    cp a, 1
    jp nz, enemyIsNotVisible
    jp enemyIsVisible

Label31234A:
    ld a, [wRoomCameraId]
    cp a, 2
    jp nz, enemyIsNotVisible
    jp enemyIsVisible

Label312355:
    ld a, [wRoomCameraId]
    cp a, 4
    jp nz, enemyIsNotVisible
    jp enemyIsVisible

Label312360:
    ld a, [wRoomCameraId]
    cp a, 0
    jp nz, enemyIsNotVisible
    jp enemyIsVisible

Label31236B:
    ld a, [wRoomCameraId]
    cp a, 1
    jp z, enemyIsVisible
    cp a, 2
    jp z, enemyIsVisible
    jp enemyIsNotVisible

Label31237B:
    ld a, [wRoomCameraId]
    cp a, 6
    jp nz, enemyIsNotVisible
    jp enemyIsVisible

Label312386:
    ld a, [wRoomCameraId]
    cp a, 1
    jp z, enemyIsVisible
    cp a, 3
    jp z, enemyIsVisible
    jp enemyIsNotVisible

Label312396:
    ld a, [wRoomCameraId]
    or a
    jp nz, enemyIsNotVisible
    jp enemyIsVisible

Label3123A0:
    ld a, [wRoomCameraId]
    cp a, 4
    jp z, enemyIsVisible
    cp a, 5
    jp z, enemyIsVisible
    jp enemyIsNotVisible

Label3123B0:
    ld a, [wRoomCameraId]
    cp a, 1
    jp z, enemyIsVisible
    cp a, 2
    jp z, enemyIsVisible
    jp enemyIsNotVisible

Label3123C0:
    ld a, [wRoomCameraId]
    cp a, 3
    jp nz, enemyIsNotVisible
    jp enemyIsVisible

Label3123CB:
    ld a, [wRoomCameraId]
    cp a, 2
    jp nz, enemyIsNotVisible
    jp enemyIsVisible

Label3123D6:
    ld a, [wRoomCameraId]
    or a ; 0
    jp nz, enemyIsNotVisible
    jp enemyIsVisible

Label3123E0:
    ld a, [wRoomCameraId]
    cp a, 1
    jp nz, enemyIsNotVisible
    jp enemyIsVisible

Label3123EB:
    ld a, [wRoomCameraId]
    cp a, 3
    jp z, enemyIsVisible
    cp a, 4
    jp z, enemyIsVisible
    jp enemyIsNotVisible

Label3123FB:
    ld a, [wRoomCameraId]
    cp a, 5
    jp nz, enemyIsNotVisible
    jp enemyIsVisible

Label312406:
    ld a, [wRoomCameraId]
    cp a, 1
    jp z, enemyIsVisible
    cp a, 2
    jp z, enemyIsVisible
    jp enemyIsNotVisible

Label312416:
    ld a, [wRoomCameraId]
    cp a, 3
    jp nz, enemyIsNotVisible
    jp enemyIsVisible
