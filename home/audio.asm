muteAudio:: ;0246
	ld a, [wCurrentRomBank]
	push af
	ld a, BANK(clearSoundCaller)
	call bankSwitch
	call clearSoundCaller
	pop af
	jp bankSwitch


; a: music id
playMusic:: ;0256
	ld c, a
	ld a, [wCurrentRomBank]
	push af
	ld a, BANK(playMusicCaller)
	call bankSwitch
	ld a, c
	ld [wCurrentMusicId], a
	call playMusicCaller
	pop af
	jp bankSwitch


; a: audio sfx id
playSFX:: ;026B
    ld c, a
    ld a, [wCurrentRomBank]
    push af
    ld a, BANK(playSfxRoutineCaller)
    call bankSwitch
    ld a, c
    ld [wCurrentSoundId], a
    call playSfxRoutineCaller
    pop af
    jp bankSwitch