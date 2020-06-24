initSelectedCharacterGameData:: ;04:4C5C
    ld a, 3
    ld [wTigerStatueRotateDirection], a
    ld a, [wSelectedCharacter]
    or a
    jp nz, initJillGameData

initChrisGameData:
; init carry items
    ld a, COMBAT_KNIFE
    ld [wItemIdSlot1], a
    ld a, F_AID_SPRAY
    ld [wItemIdSlot2], a
    ld a, EMPTY
    ld [wEquippedItemId], a
    ld a, EMPTY
; init sprite state
    ld [wEntityAnimationId], a ; 0
    ld a, ENTITY_ENABLED_FLAG
    ld [wEntityState], a
    ld a, CHRIS
    ld [wEntityId], a
    xor a
    ld [wEntityAnimationFrameId], a
    ld [wFiregunFramesId], a
    ld [wBloodFramesId], a
    ld a, MAX_HEALTH
    ld [wEntityHealth], a
; init menu option
    xor a
    ld [wMenuRadioEnable], a ; disable radio option
    ld [wMenuMapEnable], a ; disable maps option
    ld a, $FF
    ld [wMenuFileEnable], a ; enable files option
    ld [wMenuExitEnable], a ; enable exit menu option
    ret

initJillGameData: ;04:4CA5
; init carry items
    ld a, BERRETTA
    ld [wItemIdSlot1], a
    ld a, COMBAT_KNIFE
    ld [wItemIdSlot2], a
    ld a, F_AID_SPRAY
    ld [wItemIdSlot3], a
    ld a, EMPTY
    ld [wEquippedItemId], a
    ld a, EMPTY
; init sprite state
    ld [wEntityAnimationId], a
    ld a, ENTITY_ENABLED_FLAG
    ld [wEntityStructData], a
    ld a, JILL
    ld [wEntityId], a
    xor a
    ld [wEntityAnimationFrameId], a
    ld [wFiregunFramesId], a
    ld [wBloodFramesId], a
    ld a, MAX_HEALTH
    ld [wEntityHealth], a
; init menu option
    xor a
    ld [wMenuRadioEnable], a
    ld [wMenuMapEnable], a
    ld a, $FF
    ld [wMenuFileEnable], a
    ld [wMenuExitEnable], a
    ret
