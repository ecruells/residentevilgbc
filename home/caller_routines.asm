updateEnemyBloodSpritesCaller:: ;00:0829
    ld a, [wCurrentRomBank]
    push af
    ld a, BANK(updateEnemyBloodSprite)
    call bankSwitch
    call updateEnemyBloodSprite
    pop af
    jp bankSwitch

pushSpriteDrawDataInSortedSpritesListCaller:: ;00:0839
	ld a, [wCurrentRomBank]
    push af
    ld a, BANK(pushSpriteDrawDataInSortedSpritesList)
    call bankSwitch
    call pushSpriteDrawDataInSortedSpritesList
    pop af
    jp bankSwitch

loadRoomPalettesCaller:: ;00:0849
    ld a, BANK(loadRoomPalettes)
    call bankSwitch
    call loadRoomPalettes
    ld a, $01
    jp bankSwitch

updateZombieAndObjectsAnimationCaller: ;00:0856
    ld hl, updateZombieAndObjectsAnimation
    ld a, BANK(updateZombieAndObjectsAnimation)
    jp goToJumpFuncHL

checkLabPCKeyboardInputsCaller: ;085E
    ld hl, checkLabPCKeyboardInputs
    ld a, BANK(checkLabPCKeyboardInputs)
    jp goToJumpFuncHL

checkELocksFloorSelectInputCaller: ;0866
    ld hl, checkELocksFloorSelectInput
    ld a, BANK(checkELocksFloorSelectInput)
    jp goToJumpFuncHL

updateItemboxCursorCaller: ;086E
    ld hl, updateItemboxCursor
    ld a, BANK(updateItemboxCursor)
    jp goToJumpFuncHL

applyWaterEffectOnSpriteCaller:: ;00:0876
    ld a, BANK(applyWaterEffectOnSprite)
    call bankSwitch
    call applyWaterEffectOnSprite
    ld a, $01
    jp bankSwitch

applyBgOverlapMaskOnSpriteCaller:: ;00:0883
    ld a, BANK(applyBgOverlapMaskOnSprite)
    call bankSwitch
    call applyBgOverlapMaskOnSprite
    ld a, $01
    jp bankSwitch

initSelectedCharacterGameDataCaller:: ;00:0890
    ld hl, initSelectedCharacterGameData
    ld a, BANK(initSelectedCharacterGameData)
    jp goToJumpFuncHL

updateRoomGasDamageCaller: ;00:0898
    ld hl, updateRoomGasDamage
    ld a, BANK(updateRoomGasDamage)
    jp goToJumpFuncHL

checkEnemyBoundariesCaller: ;00:08A0
    ld hl, checkEnemyBoundaries
    ld a, BANK(checkEnemyBoundaries)
    jp goToJumpFuncHL

updatePlayerInputsCaller: ;00:08A8
    call applyPlayerElevationCaller
    ld hl, updatePlayerInputs
    ld a, BANK(updatePlayerInputs)
    jr goToJumpFuncHL

initGameFlagsCaller:: ;00:08B2
    ld a, BANK(initGameFlags)
    ld hl, initGameFlags
    jr goToJumpFuncHL

loadMenuItemsSpritesCaller:: ;00:08B9
    ld a, BANK(loadMenuItemsSprites)
    ld hl, loadMenuItemsSprites
    jr goToJumpFuncHL

loadEquippedItemSpriteCaller:: ;00:08C0
    ld a, BANK(loadEquippedItemSprite)
    ld hl, loadEquippedItemSprite
    jr goToJumpFuncHL

loadItemboxItemSpriteCaller:: ;00:08C7
    ld a, BANK(loadItemboxItemSprite)
    ld hl, loadItemboxItemSprite
    jr goToJumpFuncHL

loadItemBigSpriteCaller:: ;00:08CE
    ld a, BANK(loadItemBigSprite)
    ld hl, loadItemBigSprite
    jr goToJumpFuncHL

updateTitleScreenCursorOptionsCaller:: ;00:08D5
    ld a, BANK(updateTitleScreenCursorOptions)
    ld hl, updateTitleScreenCursorOptions
    jr goToJumpFuncHL

sortSpriteListByDrawPriorityCaller:: ;00:08DC
    ld hl, sortSpriteListByDrawPriority
    ld a, BANK(sortSpriteListByDrawPriority)
    jr goToJumpFuncHL

loadRoomScreenSpritesCaller:: ;00:08E3
    ld hl, loadRoomScreenSprites ;$4000
    ld a, BANK(loadRoomScreenSprites) ;$FB
    jr goToJumpFuncHL

checkSpritesCollisionCaller:: ;00:08EA
    ld hl, checkSpritesCollision
    ld a, BANK(checkSpritesCollision)
    jr goToJumpFuncHL

checkRoomsCollidersCollisionCaller: ;00:08F1
    ld hl, checkRoomsCollidersCollision
    ld a, BANK(checkRoomsCollidersCollision)
    jr goToJumpFuncHL

checkEspecialRoomCollidersCollisionCaller:: ;00:08F8
    ld hl, checkEspecialRoomCollidersCollision
    ld a, BANK(checkEspecialRoomCollidersCollision)
    jr goToJumpFuncHL

checkRoomsActionsCaller:: ;00:08FF
    ld a, BANK(checkRoomsActions)
    ld hl, checkRoomsActions
    jr goToJumpFuncHL

loadRoomEntitiesDataCaller:: ;00:0906
    ld a, BANK(loadRoomEntitiesData)
    ld hl, loadRoomEntitiesData
    jr goToJumpFuncHL

checkRoomBoundariesCaller:: ;00:090D
    ld hl, checkRoomBoundaries
    ld a, BANK(checkRoomBoundaries)
    jr goToJumpFuncHL

checkRoomCameraChangeCaller:: ;00:0914
    ld hl, checkRoomCameraChange
    ld a, BANK(checkRoomCameraChange)
    jr goToJumpFuncHL

applyPlayerElevationCaller:: ;00:091B
    ld hl, applyPlayerElevation
    ld a, BANK(applyPlayerElevation)
    jr goToJumpFuncHL

goToJumpFuncHL:: ;00:0922
	jp jumpToHLRoutineA

checkNumericPanelInputsCaller:: ;00:0925
    ld hl, checkNumericPanelInput
    ld a, BANK(checkNumericPanelInput)
    jr goToJumpFuncHL

updateNumericPanelSpritesCaller:: ;00:092C
    ld hl, updateNumericPanelSprites
    ld a, BANK(updateNumericPanelSprites)
    jr goToJumpFuncHL

checkEnemyOnRoomScreenVisibilityCaller:: ;00:0933
    ld hl, checkEnemyOnRoomScreenVisibility
    ld a, BANK(checkEnemyOnRoomScreenVisibility)
    jr label93F

checkObjectOnRoomScreenVisibilityCaller: ;00:093A
    ld hl, checkObjectOnRoomScreenVisibility
    ld a, BANK(checkObjectOnRoomScreenVisibility)
label93F:
    jp jumpToHLRoutineB

loadRoomScreenBackgroundMaskCaller:: ;00:0942
    ld hl, loadRoomScreenBackgroundMask
    ld a, BANK(loadRoomScreenBackgroundMask)
    jp goToJumpFuncHL
