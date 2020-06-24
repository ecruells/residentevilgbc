checkFAidSprayUsage: ;5597
    ld a, EMPTY
    ld [hl], a
    ld a, MAX_HEALTH
    ld [wEntityHealth], a
    jp finishHealItemUsage

checkGreenHerbUsage: ;55A2
    ld a, EMPTY
    ld [hl], a
    ld c, 12
    call applyHeal
    jp finishHealItemUsage

checkRedHerbUsage: ;55AD
    ld a, EMPTY
    ld [hl], a
    ld c, 12
    call applyHeal
    jp finishHealItemUsage

checkBlueHerbUsage: ;55B8
    ld a, EMPTY
    ld [hl], a
    ld c, 12
    call applyHeal
    jp finishHealItemUsage

; c: heal value
applyHeal: ;55C3
    ld a, [wEntityHealth]
    add a, c
    ld [wEntityHealth], a
    cp a, MAX_HEALTH+1
    ret c ; if health <= MAX_HEALTH then return
; else, limit health value
    ld a, MAX_HEALTH
    ld [wEntityHealth], a
    ret
;55D3