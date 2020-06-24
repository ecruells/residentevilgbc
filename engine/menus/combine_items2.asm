; second part of combine_items1 from bank 0
;
    db $40 ;jp z, UMBNo2AndUMBNo4Combine instruccion between bank0 & bank1
    jp combineNotMatch

checkYellow6Combine:
    ld a, [hl]
    cp a, UMB_NO7
    jp z, Yellow6AndUMBNo7Combine
    jp combineNotMatch

checkUMBNo7Combine:
    ld a, [hl]
    cp a, YELLOW_6
    jp z, Yellow6AndUMBNo7Combine
    jp combineNotMatch

checkUMBNo13Combine:
    ld a, [hl]
    cp a, NP_003
    jp z, NP003AndUMBNo13Combine
    jp combineNotMatch

waterAndUMBNo2Combine:
    ld a, NP_003
    ld [hl], a ;set target item as combining result
    ld a, EMPTY_BOTTLE
    ld [de], a
    jr finishCombine

UMBNo2AndUMBNo4Combine:
    ld a, YELLOW_6
    ld [hl], a
    ld a, EMPTY_BOTTLE
    ld [de], a
    jr finishCombine

NP003AndUMBNo4Combine:
    ld a, UMB_NO7
    ld [hl], a
    ld a, EMPTY_BOTTLE
    ld [de], a
    jr finishCombine

Yellow6AndUMBNo7Combine:
    ld a, UMB_NO13
    ld [hl], a
    ld a, EMPTY_BOTTLE
    ld [de], a
    jr finishCombine

NP003AndUMBNo13Combine:
    ld a, V_JOLT
    ld [hl], a
    ld a, EMPTY_BOTTLE
    ld [de], a

finishCombine:
    ld a, SAVE_TYPING_SFX ;$16
    call playSFX
    ld a, [wMainMenuSelectedCursorId]
    sub a, COMBINE_ITEM_MODE
    ld [wMainMenuSelectedCursorId], a ; return to normal item slot mode
    call displaySelectedItemName
    ld b, $20
    jp routineDelay
;405A

combineNotMatch: ;405A
    ld a, [hl] ;target item id
    cp a, WATER_BOTTLE
    jr z, Label4078
    cp a, UMB_NO2
    jr z, Label4078
    cp a, NP_003
    jr z, Label4078
    cp a, UMB_NO4
    jr z, Label4078
    cp a, YELLOW_6
    jr z, Label4078
    cp a, UMB_NO7
    jr z, Label4078
    cp a, UMB_NO13
    jr z, Label4078
    ret
Label4078 ;01:4078
    ld a, [de] ; selected item id
    cp a, WATER_BOTTLE ;water + water = water & empty bottle
    jr z, Label408A
    ld a, [hl] ; target item id
    cp a, WATER_BOTTLE
    jr z, Label408A
    ld a, EMPTY_BOTTLE
    ld [de], a
    ld a, EMPTY_BOTTLE
    ld [hl], a
    jr Label4090
Label408A
    ld a, WATER_BOTTLE
    ld [de], a
    ld a, EMPTY_BOTTLE
    ld [hl], a
Label4090
    ld a, CANCEL_SFX
    call playSFX
    ld a, [wMainMenuSelectedCursorId]
    sub a, COMBINE_ITEM_MODE
    ld [wMainMenuSelectedCursorId], a ; back to normal item slot mode
    call displaySelectedItemName
    ld b, $20
    jp routineDelay
;40A5