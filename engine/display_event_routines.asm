copyNPC1DataToPlayerData: ;0E:5FD1
    push hl
    ld hl, wNPCEntitiesDataStructs
    ld de, wEntityStructData
    ld b, $20
.copyLoop
    ld a, [hli]
    ld [de], a
    inc de
    dec b
    jr nz, .copyLoop
    pop hl
    ret
;5FE2


updateJewelsStatuesStates: ;0E:5FE2
    ld a, [hli]
    or a ; 0
    jp z, rotateTigerStatueRight
    cp a, 1
    jp z, rotateTigerStatueLeft
    cp a, 2
    jp z, disableDinningRoomJewelStatue
    ret
;5FF2

rotateTigerStatueRight: ;0E:5FF2
    ld a, [wTigerStatueRotateDirection]
    dec a
    ld [wTigerStatueRotateDirection], a
    ret
;5FFA

rotateTigerStatueLeft: ;0E:5FFA
    ld a, [wTigerStatueRotateDirection]
    inc a
    ld [wTigerStatueRotateDirection], a
    ret
;6002

disableDinningRoomJewelStatue: ;0E:6002
    xor a
    ld [wObjectEntitiesFlags+JEWEL_STATUE_VARID], a
    ld a, $FF
    ld [wRoomsItemsFlags+ROOM01_BLUE_JEWEL], a
    ld [wBrokenJewelStatueFlag], a
    push hl
    ld de, wNPCEntitiesDataStructs
    ld b, 7
.findStatueDataLoop
    ld hl, wEntityState - wEntityStructData
    add hl, de
    ld a, [hl]
    and a, ENTITY_ENABLED_FLAG
    jr z, .Label3A026 ; if NPC1 is disabled
    ld hl, wEntityId - wEntityStructData
    add hl, de
    ld a, [hl]
    cp a, JEWEL_STATUE
    jr z, disableNPCSprite
.Label3A026
    ld a, e
    add a, $20
    ld e, a
    ld a, d
    adc a, $00
    ld d, a
    dec b
    jr nz, .findStatueDataLoop ; jump to next NPC
    pop hl
    ret
;6033

disableNPCSprite: ;0E:6033
    ld hl, wEntityState - wEntityStructData
    add hl, de
    ld [hl], 0 ; disable sprite
    pop hl
    ret
;603B


shakeScreen: ;0E:603B
    call haltCPU
    ld a, [wScreenYPos]
    sub a, 1
    ld [wScreenYPos], a
    call updateSceneBgAndAllSpritesCaller
    call haltCPU
    ld a, [wScreenYPos]
    add a, 2
    ld [wScreenYPos], a
    call updateSceneBgAndAllSpritesCaller
    call haltCPU
    ld a, [wScreenYPos]
    sub a, 2
    ld [wScreenYPos], a
    call updateSceneBgAndAllSpritesCaller
    call haltCPU
    ld a, [wScreenYPos]
    add a, 1
    ld [wScreenYPos], a
    call updateSceneBgAndAllSpritesCaller
    ret
;6074

eventScreenPanningUp: ;0E:6074
    ld b, 16 ; panning pixels
.panningLoop
    push bc
    ld a, [wScreenYPos]
    inc a ; panning up
    ld [wScreenYPos], a
    call updateSceneBgAndAllSpritesCaller
    call haltCPU
    call haltCPU
    pop bc
    dec b
    jr nz, .panningLoop
    ret
;608C

eventScreenPanningDown: ;0E:608C
    ld b, 16
.panningLoop
    push bc
    ld a, [wScreenYPos]
    dec a ; panning down
    ld [wScreenYPos], a
    call updateSceneBgAndAllSpritesCaller
    call haltCPU
    call haltCPU
    pop bc
    dec b
    jr nz, .panningLoop
    ret
;60A4


loadEventRoomBgCaller: ;0E:60A4
    ld a, [hli]
    ld [wRoomId], a
    xor a
    ld [wRoomIdHigh], a
    ld	a, [hli]
    ld [wRoomCameraId], a
    push hl
    call loadEventRoomBg
    pop hl
    ret
;0E:60B6


loadEventRoomBgMaskCaller: ;0E:60B6
    push hl
    call loadEventRoomBgMask
    pop hl
    ret
;60BC


loadBarryEventData: ;0E:60BC
    ld de, wNPCEntitiesDataStructs+$60
    ld a, BARRY
    jr loadEntityEventData

loadEnemy9EData:
    ld de, wNPCEntitiesDataStructs+$80
    ld a, ENEMY_9E
    jr loadEntityEventData

loadZombieEventData:
    ld de, wNPCEntitiesDataStructs+$A0
    ld a, ZOMBIE
    jr loadEntityEventData

loadChrisEventData: ;0E:60D1
    ld de, wEntityStructData
    ld a, CHRIS
    jr loadEntityEventData

loadJillEventData:
    ld de, wNPCEntitiesDataStructs
    ld a, JILL
    jr loadEntityEventData

loadWeskerEventData:
    ld de, wNPCEntitiesDataStructs+$20
    ld a, WESKER
    jr loadEntityEventData

loadRebeccaEventData:
    ld de, wNPCEntitiesDataStructs+$40
    ld a, REBECCA

loadEntityEventData:
    push hl
    ld c, l
    ld b, h ; set pointer to bc
    push af ; store sprite Id
    pop af
    ld hl, wEntityId - wEntityStructData
    add hl, de
    ld [hl], a
    ld a, [wEntityHealth]
    ld hl, wEntityHealth - wEntityStructData
    add hl, de
    ld [hl], a ; set current player health to event sprites
    ld hl, wEntityState - wEntityStructData
    add hl, de
    ld [hl], ENTITY_ENABLED_FLAG | ENTITY_VISIBLE_FLAG
    ld hl, wEntityPositionX - wEntityStructData
    add hl, de
    ld a, [bc]
    ld [hli], a
    inc bc
    ld a, [bc]
    ld [hl], a ;wEntityPositionX+1
    inc bc
    ld hl, wEntityPositionZ - wEntityStructData
    add hl, de
    ld a, [bc]
    ld [hli], a
    inc bc
    ld a, [bc]
    ld [hl], a ;wEntityPositionZ+1
    inc bc
    ld hl, wEntityFacing - wEntityStructData
    add hl, de
    ld a, [bc]
    ld [hl], a
    inc bc
    inc bc
    ld hl, wEntityAnimationId - wEntityStructData
    add hl, de
    ld a, [bc]
    ld [hl], a
    inc bc
    ld hl, wEntityAnimationFrameId - wEntityStructData
    add hl, de
    ld a, [bc]
    ld [hl], a
    inc bc
    ld hl, wZombieAndObjectVarId - wEntityStructData
    add hl, de
    ld [hl], $FF
    ld hl, wEntityDataC31D - wEntityStructData
    add hl, de
    ld a, [bc]
    ld [hli], a
    inc bc
    ld a, [bc]
    ld [hl], a ;wEntityDataC31E
    pop hl
    ld de, 10
    add hl, de
    ret


eventDoorAnimation: ;0E:6142
    ld a, [hl]
    ld [wDoorAnimationType], a
    srl a
    srl a
    srl a
    ld [wDoorSpriteId], a
    ld a, [hli]
    and a, 7
    ld [wDoorPaletteId], a
    push hl
    call showEventDoorAnimation
    pop hl
    ret
;615B


eventScreenFadeIn: ;0E:615B
    push hl
    ld c, SET_FADE_IN-1
    call eventSceneScreenFade
    pop hl
    ret
;6163


eventScreenFadeOut: ;0E:6163
    push hl
    ld c, SET_FADE_OUT
    call eventSceneScreenFade
    pop hl
    ret
;616B


eventFrameDelay: ;0E:616B
    ld a, [hli]
    ld b, a
.loop3A16D
    push bc
    call haltCPU
    pop bc
    dec b
    jr nz, .loop3A16D
    ret
;6176


eventChangeScreen: ;0E:6176
    ld a, [hli]
    ld [wRoomCameraId], a
    push hl
    call loadEventRoomScreen
    pop hl
    call updateSceneBgAndAllSpritesCaller
    call updateSceneBgAndAllSpritesCaller
    ret
;6186


changeNPC4SpriteAnimFrame: ;0E:6186
    ld de, wNPCEntitiesDataStructs+$60
    jr Label3A1A7
changeNPC5SpriteAnimFrame:
    ld de, wNPCEntitiesDataStructs+$80
    jr Label3A1A7
changeNPC6SpriteAnimFrame:
    ld de, wNPCEntitiesDataStructs+$A0
    jr Label3A1A7
changePlayerSpriteAnimFrame:
    ld de, wEntityStructData
    jr Label3A1A7
changeNPC1SpriteAnimFrame: ;0E:619A
    ld de, wNPCEntitiesDataStructs
    jr Label3A1A7
changeNPC2SpriteAnimFrame: ;0E:619F
    ld de, wNPCEntitiesDataStructs+$20
    jr Label3A1A7
changeNPC3SpriteAnimFrame: ;0E:61A4
    ld de, wNPCEntitiesDataStructs+$40
Label3A1A7:
    push hl
    ld c, l
    ld b, h
    ld hl, wEntityAnimationId - wEntityStructData
    add hl, de
    ld a, [bc]
    ld [hl], a
    inc bc
    ld hl, wEntityAnimationFrameId - wEntityStructData
    add hl, de
    ld a, [bc]
    ld [hl], a
    pop hl
    inc hl
    inc hl
    call updateSceneBgAndAllSpritesCaller
    ret
;61BE

showLabAlertVoiceEventMessage: ;0E:61BE
    ld de, $6485 ; wrong message name pointer. TODO: fix this
    ld c, $F8
    jr showCharEventMessage
showMisteriousVoiceEventMessage:
    ld de, misteriousVoiceMessageName
    ld c, BANK(misteriousVoiceMessageName)
    jr showCharEventMessage
showBradEventMessage:
    ld de, bradMessageName
    ld c, BANK(bradMessageName)
    jr showCharEventMessage
showRichardEventMessage:
    ld de, richardMessageName
    ld c, BANK(richardMessageName)
    jr showCharEventMessage
showEnricoEventMessage:
    ld de, enricoMessageName
    ld c, BANK(enricoMessageName)
    jr showCharEventMessage
showBarryEventMessage:
    ld de, barryMessageName
    ld c, BANK(barryMessageName)
    jr showCharEventMessage
showChrisEventMessage:
    ld de, chrisMessageName
    ld c, BANK(chrisMessageName)
    jr showCharEventMessage
showJillEventMessage:
    ld de, jillMessageName
    ld c, BANK(jillMessageName)
    jr showCharEventMessage
showWeskerEventMessage:
    ld de, weskerMessageName
    ld c, BANK(weskerMessageName)
    jr showCharEventMessage
showRebeccaEventMessage:
    ld de, rebeccaMessageName
    ld c, BANK(rebeccaMessageName)
; hl: message pointer address
showCharEventMessage
    call clearEventMessagebox
    push hl
    ldhl 16, 0 ; message position (y,x)
    call displayEventMessage
    pop hl
    ld a, [hli]
    ld e, a
    ld a, [hli]
    ld d, a
    push hl
    ld a, [wTextCharTileXPos]
    ld l, a
    ld a, [wTextCharTileYPos]
    ld h, a
    call displayEventAutoTypingMessage
    pop hl
    ret
;621F


clearEventMessagebox: ;0E:621F
    push bc
    push de
    push hl
    ldhl 16, 0 ; position yx
    ld de, ClearThreeTextLines
    ld c, BANK(ClearThreeTextLines)
    call displayEventMessage
    pop hl
    pop de
    pop bc
    ret


changeNPC4Facing: ;0E:6231
    ld de, wNPCEntitiesDataStructs+$60
    jr Label3A252
changeNPC5Facing:
    ld de, wNPCEntitiesDataStructs+$80
    jr Label3A252
changeNPC6Facing:
    ld de, wNPCEntitiesDataStructs+$A0
    jr Label3A252
changePlayerFacing:
    ld de, wEntityStructData
    jr Label3A252
changeNPC1Facing:
    ld de, wNPCEntitiesDataStructs
    jr Label3A252
changeNPC2Facing:
    ld de, wNPCEntitiesDataStructs+$20
    jr Label3A252
changeNPC3Facing:
    ld de, wNPCEntitiesDataStructs+$40
Label3A252:
    ld a, [hli]
    push hl
    cp a, $80
    jr c, rotateSpriteFacingCCW
; rotate the sprite facing clockwise
rotateSpriteFacingCW:
    and a, $7F
    ld b, a
.loop3A25B
    push bc
    push de
    ld hl, wEntityFacing - wEntityStructData
    add hl, de
    ld a, [hl]
    sub a, 2
    and a, $1F
    ld [hl], a
    call haltCPU
    call haltCPU
    call haltCPU
    call updateSceneBgAndAllSpritesCaller
    pop de
    pop bc
    dec b
    jr nz, .loop3A25B
    pop hl
    ret

; rotate the sprite facing counter clockwise
rotateSpriteFacingCCW: ;0E:627A
    ld b, a
.loop3A27B
    push bc
    push de
    ld hl, wEntityFacing - wEntityStructData
    add hl, de
    ld a, [hl]
    add a, 2
    and a, $1F
    ld [hl], a
    call haltCPU
    call haltCPU
    call haltCPU
    call updateSceneBgAndAllSpritesCaller
    pop de
    pop bc
    dec b
    jr nz, .loop3A27B
    pop hl
    ret


playEventSFX: ;0E:629A
    ld a, [hli]
    ld c, a
    push hl
    call playSFX
    pop hl
    ret
;62A2


moveWalkBackwardNPC4: ;0E:62A2
    ld de, wNPCEntitiesDataStructs+$60
    jr Label3A2C3
moveWalkBackwardNPC5:
    ld de, wNPCEntitiesDataStructs+$80
    jr Label3A2C3
moveWalkBackwardNPC6:
    ld de, wNPCEntitiesDataStructs+$A0
    jr Label3A2C3
moveWalkBackwardPlayer:
    ld de, wEntityStructData
    jr Label3A2C3
moveWalkBackwardNPC1:
    ld de, wNPCEntitiesDataStructs
    jr Label3A2C3
moveWalkBackwardNPC2:
    ld de, wNPCEntitiesDataStructs+$20
    jr Label3A2C3
moveWalkBackwardNPC3:
    ld de, wNPCEntitiesDataStructs+$40
Label3A2C3
    ld a, [hli]
    push hl
    ld b, a
moveLoop
    push bc
    push de
    ld hl, wEntityFacing - wEntityStructData
    add hl, de
    ld a, [hl]
    add a, 16 ; reverse facing
    and a, FACING_NORTH_EAST
    ld bc, entityWalkTable
	; apply facing offset
    add a, c
    ld c, a
    ld a, 0
    adc a, b
    ld b, a
    ld hl, wEntityPositionX - wEntityStructData
    add hl, de
    ld a, [bc]
    add a, [hl]
    ld [hli], a
    inc bc ; wEntityPositionX+1
    ld a, [bc]
    adc a, [hl]
    ld [hli], a
	; add move offset to Ypos
    inc bc ; wEntityPositionZ
    ld a, [bc]
    add a, [hl]
    ld [hli], a
    inc bc ; wEntityPositionZ+1
    ld a, [bc]
    adc a, [hl]
    ld [hli], a
	; change sprite animation
    ld hl, wEntityAnimationId - wEntityStructData
    add hl, de
    ld [hl], WALK_ANIM
	; change frame id
    ld hl, wEntityAnimationFrameId - wEntityStructData
    add hl, de
    ld a, [hl]
    sub a, 2
    and a, $3F
    ld [hl], a
	; update sprite
    call haltCPU
    call updateSceneBgAndAllSpritesCaller
    pop de
    pop bc
    dec b
    jr nz, moveLoop
    pop hl
    ret
;630A


moveWalkingEventNPC4: ;0E:630A
    ld de, wNPCEntitiesDataStructs+$60
    jr Label3A32B
moveWalkingEventNPC5:
    ld de, wNPCEntitiesDataStructs+$80
    jr Label3A32B
moveWalkingEventNPC6:
    ld de, wNPCEntitiesDataStructs+$A0
    jr Label3A32B
moveWalkingEventPlayer:
    ld de, wEntityStructData
    jr Label3A32B
moveWalkingEventNPC1:
    ld de, wNPCEntitiesDataStructs
    jr Label3A32B
moveWalkingEventNPC2:
    ld de, wNPCEntitiesDataStructs+$20
    jr Label3A32B
moveWalkingEventNPC3:
    ld de, wNPCEntitiesDataStructs+$40
Label3A32B
    ld a, [hli]
    push hl
    ld b, a ; steps counter
.loop3A32E
    push bc
    push de
    ld hl, wEntityFacing - wEntityStructData
    add hl, de
    ld a, [hl]
    and a, FACING_NORTH_EAST  ; max facing value
    ld bc, entityWalkTable
	; apply facing offset
    add a, c
    ld c, a
    ld a, 0
    adc a, b
    ld b, a
	; add move offset to Xpos
    ld hl, wEntityPositionX - wEntityStructData
    add hl, de
    ld a, [bc]
    add a, [hl]
    ld [hli], a
    inc bc ; wEntityPositionX+1
    ld a, [bc]
    adc a, [hl]
    ld [hli], a
	; add move offset to Ypos
    inc bc ; wEntityPositionZ
    ld a, [bc]
    add a, [hl]
    ld [hli], a
    inc bc ; wEntityPositionZ+1
    ld a, [bc]
    adc a, [hl]
    ld [hli], a
	; change sprite animation
    ld hl, wEntityAnimationId - wEntityStructData
    add hl, de
    ld [hl], WALK_ANIM
    ld hl, wEntityAnimationFrameId - wEntityStructData
    add hl, de
    ld a, [hl]
    add a, 2
    and a, $3F
    ld [hl], a
	; update sprite
    call haltCPU
    call updateSceneBgAndAllSpritesCaller
    pop de
    pop bc
    dec b
    jr nz, .loop3A32E
    pop hl
    ret
;6370


moveRunningEventNPC4: ;0E:6370
    ld de, wNPCEntitiesDataStructs+$60
    jr Label3A387
moveRunningEventPlayer:
    ld de, wEntityStructData
    jr Label3A387
moveRunningEventNPC1:
    ld de, wNPCEntitiesDataStructs
    jr Label3A387
moveRunningEventNPC2:
    ld de, wNPCEntitiesDataStructs+$20
    jr Label3A387
moveRunningEventNPC3:
    ld de, wNPCEntitiesDataStructs+$40
Label3A387
    ld a, [hli]
    push hl
    ld b, a ; steps counter
.loop3A38A
    push bc
    push de
    ld hl, wEntityFacing - wEntityStructData
    add hl, de
    ld a, [hl]
    and a, FACING_NORTH_EAST
    ld bc, entityRunTable
	; apply facing offset
    add a, c
    ld c, a
    ld a, 0
    adc a, b
    ld b, a
	; add move offset to Xpos
    ld hl, wEntityPositionX - wEntityStructData
    add hl, de
    ld a, [bc]
    add a, [hl]
    ld [hli], a
    inc bc ; wEntityPositionX+1
    ld a, [bc]
    adc a, [hl]
    ld [hli], a
	; add move offset to Ypos
    inc bc ; wEntityPositionZ
    ld a, [bc]
    add a, [hl]
    ld [hli], a
    inc bc ; wEntityPositionZ+1
    ld a, [bc]
    adc a, [hl]
    ld [hli], a
	; change sprite animation
    ld hl, wEntityAnimationId - wEntityStructData
    add hl, de
    ld [hl], RUN_ANIM
	; change frame id
    ld hl, wEntityAnimationFrameId - wEntityStructData
    add hl, de
    ld a, [hl]
    add a, 2
    and a, $3F
    ld [hl], a
	; update sprite
    call haltCPU
    call updateSceneBgAndAllSpritesCaller
    pop de
    pop bc
    dec b
    jr nz, .loop3A38A
    pop hl
    ret
;63CC

updateSceneBgAndAllSpritesCaller: ;0E:63CC
    push hl
    call updateSceneBgAndAllSprites
    pop hl
    ret

INCLUDE "events/entity_walk_table.asm" ;63D2
INCLUDE "events/entity_run_table.asm" ;63F2

; reset all chars data, but player health
resetAllCharsData: ;0E:6412
    ld a, [wEntityHealth]
    push af
    ld de, wEntityStructData
    ld bc, 256
Loop3A41C
    xor a
    ld [de], a ; reset data
    inc de
    dec bc
    ld a, b
    or a, c
    jr nz, Loop3A41C
    pop af
    ld [wEntityHealth], a ; restore health
    ret
;6429

eventBgImage: ;0E:6429
    ld a, [hli]
    ld [wLoadEventBgImagePal], a
    push hl
    call showEventBgImage
    pop hl
    ret
;6433