checkWeaponAimButtonPress: ;45FA
    ld a, [wPressingBButton]
    or a
    jp nz, checkRotationInput ; B button is being pressed
; weapon aim button pressed
    ld a, [wEquippedItemId]
    cp a, BERRETTA
    jr z, setGunAimAnimation
    cp a, SHOTGUN
    jr z, setShotgunAimAnimation
    cp a, COMBAT_KNIFE
    jr z, setKnifeAimAnimation
    ret

setShotgunAimAnimation: ;FC:4611
    ld a, SHOTGUN_AIM_ANIM
    ld [wEntityAnimationId], a
    ld c, AIMING_UP
    ld a, [wButtonPressId]
    and a, UP_INPUT
    jr nz, .Label3F062A ; aiming up
    ld c, AIMING_DOWN
    ld a, [wButtonPressId]
    and a, DOWN_INPUT
    jr nz, .Label3F062A ; aiming down
 ; aiming front
    ld c, AIMING_FRONT
.Label3F062A
    ld a, c
    ld [wEntityAnimationFrameId], a
    ret

setGunAimAnimation: ;FC:462F
    ld a, GUN_AIM_ANIM
    ld [wEntityAnimationId], a
    ld c, AIMING_UP
    ld a, [wButtonPressId]
    and a, UP_INPUT
    jr nz, .Label3F0648  ; aiming up
    ld c, AIMING_DOWN
    ld a, [wButtonPressId]
    and a, DOWN_INPUT
    jr nz, .Label3F0648  ; aiming down
; aiming front
    ld c, AIMING_FRONT
.Label3F0648
    ld a, c
    ld [wEntityAnimationFrameId], a
    ret

setKnifeAimAnimation: ;FC:464D
    ld a, KNIFE_AIM_ANIM
    ld [wEntityAnimationId], a
    xor a ; swap frames
    ld [wEntityAnimationFrameId], a
    ret
;4657

checkShotgunShootInput: ;FC:4657
    ld a, [wButtonPressId]
    and a, B_INPUT
    jr z, stopShotgunAim ; stop aiming
; keep aiming
    ld c, AIMING_UP
    ld a, [wButtonPressId]
    and a, UP_INPUT
    jr nz, .updateAimingAnimationFrame ; is aiming up
    ld c, AIMING_DOWN
    ld a, [wButtonPressId]
    and a, DOWN_INPUT
    jr nz, .updateAimingAnimationFrame ; is aiming down
; is aiming front
    ld c, AIMING_FRONT
.updateAimingAnimationFrame
    ld a, c
    ld [wEntityAnimationFrameId], a
; check movement input
    call checkTurnLeftInputPress
    call checkTurnRightInputPress
; check shoot input
    ld a, [wButtonPressId]
    and a, A_INPUT
    ret z
    ld a, [wWeaponBlockTimer]
    or a
    ret nz ; weapon block time is running
; can shot again
    ld a, $08
    ld [wWeaponBlockTimer], a
    ld a, $82
    ld [wFiregunFramesId], a
    ld a, SHOTGUN_SFX
    call playSFX
    ld a, [wEntityAnimationFrameId]
    or a
    ret z ; return if shooting up
; can do damage only shooting front or down
    call detectEnemiesShotHit
    ret
stopShotgunAim: ;FC:469F
    ld a, IDLE_ANIM
    ld [wEntityAnimationId], a
    xor a
    ld [wEntityAnimationFrameId], a
    ret
;46A9

checkHandgunShotInput: ;FC:46A9
    ld a, [wButtonPressId]
    and a, B_INPUT
    jr z, stopHandgunAim
    ld c, AIMING_UP
    ld a, [wButtonPressId]
    and a, UP_INPUT
    jr nz, .updateAimingAnimationFrame ; is aiming up
    ld c, AIMING_DOWN
    ld a, [wButtonPressId]
    and a, DOWN_INPUT
    jr nz, .updateAimingAnimationFrame ; is aiming down
; is aiming front
    ld c, AIMING_FRONT
.updateAimingAnimationFrame
    ld a, c
    ld [wEntityAnimationFrameId], a
; check movement input
    call checkTurnLeftInputPress
    call checkTurnRightInputPress
    ld a, [wButtonPressId]
    and a, A_INPUT
    ret z
    ld a, [wWeaponBlockTimer]
    or a
    ret nz ; weapon block time is running
; can shot again
    ld a, $08
    ld [wWeaponBlockTimer], a
    ld a, $82
    ld [wFiregunFramesId], a
    ld a, FIREGUN_SFX
    call playSFX
    ld a, [wEntityAnimationFrameId]
    or a
    ret z
; can do damage only shooting front or down
    call detectEnemiesShotHit
    ret
stopHandgunAim: ;FC:46F1
    ld a, IDLE_ANIM
    ld [wEntityAnimationId], a
    xor a
    ld [wEntityAnimationFrameId], a
    ret
;46FB

knifeAimAnimationInput: ;FC:46FB
    ld a, [wButtonPressId]
    and a, B_INPUT
    jp z, stopKnifeAiming
    ld a, [wEntityAnimationFrameId]
    cp a, $10
    jr c, .increaseAnimTimer1
    cp a, $18
    jr c, .increaseAimTimer2
    cp a, $20
    jr c, .increaseAimTimer3
    cp a, $28
    jr c, .increaseAimTimer4
.increaseAnimTimer1
    inc a
    and a, $0F
    ld [wEntityAnimationFrameId], a
    jr checkKnifeInput
.increaseAimTimer2
    inc a
    ld [wEntityAnimationFrameId], a
    cp a, $18
    jr c, checkKnifeInput
    xor a
    ld [wEntityAnimationFrameId], a
    jr checkKnifeInput
.increaseAimTimer3
    inc a
    ld [wEntityAnimationFrameId], a
    cp a, $20
    jr c, checkKnifeInput
    xor a
    ld [wEntityAnimationFrameId], a
    jr checkKnifeInput
.increaseAimTimer4
    inc a
    ld [wEntityAnimationFrameId], a
    cp a, $28
    jr c, checkKnifeInput
    xor a
    ld [wEntityAnimationFrameId], a
    jr checkKnifeInput

checkKnifeInput:
    call checkTurnLeftInputPress
    call checkTurnRightInputPress
    ld a, [wEntityAnimationFrameId]
    cp a, $10
    ret nc
    ld a, [wButtonPressId]
    and a, A_INPUT
    jr z, stopKnifeAttack
    ld a, [wPressingAButton]
    or a
    ret nz ; attack button is being pressed
; start kinife attack (no hit detection implemented, only animation update)
    ld a, $FF
    ld [wPressingAButton], a
    ld a, [wButtonPressId]
    and a, UP_INPUT
    jr nz, .setKnifeUpAttack
    ld a, [wButtonPressId]
    and a, DOWN_INPUT
    jr nz, .setKnifeDownAttack
; set knife front attack
    ld a, KNIFE_FRONT_ATTACK
    ld [wEntityAnimationFrameId], a
    ret
.setKnifeUpAttack ;FC:4779
    ld a, KNIFE_UP_ATTACK
    ld [wEntityAnimationFrameId], a
    ret
.setKnifeDownAttack ;FC:477F
    ld a, KNIFE_DOWN_ATTACK
    ld [wEntityAnimationFrameId], a
    ret
;4785

stopKnifeAiming: ;FC:4785
    ld a, IDLE_ANIM
    ld [wEntityAnimationId], a
    xor a
    ld [wEntityAnimationFrameId], a
    ret

stopKnifeAttack: ;FC:478F
    xor a
    ld [wPressingAButton], a
    ret
;4794
