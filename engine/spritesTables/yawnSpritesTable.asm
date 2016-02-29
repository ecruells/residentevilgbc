
_yawnSpritesTable: ;FD:684B
;idle
	dw BANK(yawn_front_spritesheet), yawn_front_idle_anim_pointers ;$696B
	dw BANK(yawn_front_spritesheet), yawn_right_attack_anim_pointers ;69CB
	dw BANK(yawn_front_right_spritesheet), yawn_front_right_idle_anim_pointers ;$695B
	dw BANK(yawn_front_right_spritesheet), yawn_right_attack_anim_pointers ;69CB
	dw BANK(yawn_right_spritesheet), yawn_right_idle_anim_pointers ;$694B
	dw BANK(yawn_right_spritesheet), yawn_right_attack_anim_pointers ;69CB
	dw BANK(yawn_back_right_spritesheet), yawn_back_right_idle_anim_pointers ;$69BB
	dw BANK(yawn_back_right_spritesheet), yawn_right_attack_anim_pointers ;69CB
	dw BANK(yawn_back_spritesheet), yawn_back_idle_anim_pointers ;$69AB
	dw BANK(yawn_back_spritesheet), yawn_right_attack_anim_pointers ;69CB
	dw BANK(yawn_back_left_spritesheet), yawn_back_left_idle_anim_pointers ;$699B
	dw BANK(yawn_back_left_spritesheet), yawn_right_attack_anim_pointers ;69CB
	dw BANK(yawn_left_spritesheet), yawn_left_idle_anim_pointers ;$698B
	dw BANK(yawn_left_spritesheet), yawn_right_attack_anim_pointers ;69CB
	dw BANK(yawn_front_left_spritesheet), yawn_front_left_idle_anim_pointers ;$697B
	dw BANK(yawn_front_left_spritesheet), yawn_right_attack_anim_pointers ;69CB
;walk
	dw BANK(yawn_front_spritesheet), yawn_front_idle_anim_pointers ;$696B
	dw BANK(yawn_front_spritesheet), yawn_right_attack_anim_pointers ;69CB
	dw BANK(yawn_front_right_spritesheet), yawn_front_right_idle_anim_pointers ;$695B
	dw BANK(yawn_front_right_spritesheet), yawn_right_attack_anim_pointers ;69CB
	dw BANK(yawn_right_spritesheet), yawn_right_idle_anim_pointers ;$694B
	dw BANK(yawn_right_spritesheet), yawn_right_attack_anim_pointers ;69CB
	dw BANK(yawn_back_right_spritesheet), yawn_back_right_idle_anim_pointers ;$69BB
	dw BANK(yawn_back_right_spritesheet), yawn_right_attack_anim_pointers ;69CB
	dw BANK(yawn_back_spritesheet), yawn_back_idle_anim_pointers ;$69AB
	dw BANK(yawn_back_spritesheet), yawn_right_attack_anim_pointers ;69CB
	dw BANK(yawn_back_left_spritesheet), yawn_back_left_idle_anim_pointers ;$699B
	dw BANK(yawn_back_left_spritesheet), yawn_right_attack_anim_pointers ;69CB
	dw BANK(yawn_left_spritesheet), yawn_left_idle_anim_pointers ;$698B
	dw BANK(yawn_left_spritesheet), yawn_right_attack_anim_pointers ;69CB
	dw BANK(yawn_front_left_spritesheet), yawn_front_left_idle_anim_pointers ;$697B
	dw BANK(yawn_front_left_spritesheet), yawn_right_attack_anim_pointers ;69CB
;attack
	dw BANK(yawn_front_spritesheet), yawn_front_attack_anim_pointers
	dw BANK(yawn_front_spritesheet), yawn_right_dead_anim_pointers ;69DB
	dw BANK(yawn_front_right_spritesheet), yawn_front_right_attack_anim_pointers
	dw BANK(yawn_front_right_spritesheet), yawn_right_dead_anim_pointers ;69DB
	dw BANK(yawn_right_spritesheet), yawn_right_attack_anim_pointers
	dw BANK(yawn_right_spritesheet), yawn_right_dead_anim_pointers ;69DB
	dw BANK(yawn_back_right_spritesheet), yawn_back_right_attack_anim_pointers
	dw BANK(yawn_back_right_spritesheet), yawn_right_dead_anim_pointers ;69DB
	dw BANK(yawn_back_spritesheet), yawn_back_attack_anim_pointers
	dw BANK(yawn_back_spritesheet), yawn_right_dead_anim_pointers ;69DB
	dw BANK(yawn_back_left_spritesheet), yawn_back_left_attack_anim_pointers
	dw BANK(yawn_back_left_spritesheet), yawn_right_dead_anim_pointers ;69DB
	dw BANK(yawn_left_spritesheet), yawn_left_attack_anim_pointers
	dw BANK(yawn_left_spritesheet), yawn_right_dead_anim_pointers ;69DB
	dw BANK(yawn_front_left_spritesheet), yawn_front_left_attack_anim_pointers
	dw BANK(yawn_front_left_spritesheet), yawn_right_dead_anim_pointers ;69DB
;dead
	dw BANK(yawn_front_spritesheet), yawn_front_dead_anim_pointers
	dw BANK(yawn_front_spritesheet), yawn_right_dead_anim_pointers+16 ;69EB
	dw BANK(yawn_front_right_spritesheet), yawn_front_right_dead_anim_pointers
	dw BANK(yawn_front_right_spritesheet), yawn_right_dead_anim_pointers+16 ;69EB
	dw BANK(yawn_right_spritesheet), yawn_right_dead_anim_pointers
	dw BANK(yawn_right_spritesheet), yawn_right_dead_anim_pointers+16 ;69EB
	dw BANK(yawn_back_right_spritesheet), yawn_back_right_dead_anim_pointers
	dw BANK(yawn_back_right_spritesheet), yawn_right_dead_anim_pointers+16 ;69EB
	dw BANK(yawn_back_spritesheet), yawn_back_dead_anim_pointers
	dw BANK(yawn_back_spritesheet), yawn_right_dead_anim_pointers+16 ;69EB
	dw BANK(yawn_back_left_spritesheet), yawn_back_left_dead_anim_pointers
	dw BANK(yawn_back_left_spritesheet), yawn_right_dead_anim_pointers+16 ;69EB
	dw BANK(yawn_left_spritesheet), yawn_left_dead_anim_pointers
	dw BANK(yawn_left_spritesheet), yawn_right_dead_anim_pointers+16 ;69EB
	dw BANK(yawn_front_left_spritesheet), yawn_front_left_dead_anim_pointers
	dw BANK(yawn_front_left_spritesheet), yawn_right_dead_anim_pointers+16 ;69EB
;694B

;idle
yawn_right_idle_anim_pointers: ;$694B
	dw yawn_right_spritesheet+YAWN_IDLE_1
	dw yawn_right_spritesheet+YAWN_IDLE_2
	dw yawn_right_spritesheet+YAWN_IDLE_3
	dw yawn_right_spritesheet+YAWN_IDLE_4

	dw yawn_right_spritesheet+YAWN_IDLE_1
	dw yawn_right_spritesheet+YAWN_IDLE_2
	dw yawn_right_spritesheet+YAWN_IDLE_3
	dw yawn_right_spritesheet+YAWN_IDLE_4

yawn_front_right_idle_anim_pointers: ;$695B
	dw yawn_front_right_spritesheet+YAWN_IDLE_1
	dw yawn_front_right_spritesheet+YAWN_IDLE_2
	dw yawn_front_right_spritesheet+YAWN_IDLE_3
	dw yawn_front_right_spritesheet+YAWN_IDLE_4

	dw yawn_front_right_spritesheet+YAWN_IDLE_1
	dw yawn_front_right_spritesheet+YAWN_IDLE_2
	dw yawn_front_right_spritesheet+YAWN_IDLE_3
	dw yawn_front_right_spritesheet+YAWN_IDLE_4

yawn_front_idle_anim_pointers: ;$696B
	dw yawn_front_spritesheet+YAWN_IDLE_1
	dw yawn_front_spritesheet+YAWN_IDLE_2
	dw yawn_front_spritesheet+YAWN_IDLE_3
	dw yawn_front_spritesheet+YAWN_IDLE_4

	dw yawn_front_spritesheet+YAWN_IDLE_1
	dw yawn_front_spritesheet+YAWN_IDLE_2
	dw yawn_front_spritesheet+YAWN_IDLE_3
	dw yawn_front_spritesheet+YAWN_IDLE_4

yawn_front_left_idle_anim_pointers: ;$697B
	dw yawn_front_left_spritesheet+YAWN_IDLE_1
	dw yawn_front_left_spritesheet+YAWN_IDLE_2
	dw yawn_front_left_spritesheet+YAWN_IDLE_3
	dw yawn_front_left_spritesheet+YAWN_IDLE_4

	dw yawn_front_left_spritesheet+YAWN_IDLE_1
	dw yawn_front_left_spritesheet+YAWN_IDLE_2
	dw yawn_front_left_spritesheet+YAWN_IDLE_3
	dw yawn_front_left_spritesheet+YAWN_IDLE_4

yawn_left_idle_anim_pointers: ;$698B
	dw yawn_left_spritesheet+YAWN_IDLE_1
	dw yawn_left_spritesheet+YAWN_IDLE_2
	dw yawn_left_spritesheet+YAWN_IDLE_3
	dw yawn_left_spritesheet+YAWN_IDLE_4

	dw yawn_left_spritesheet+YAWN_IDLE_1
	dw yawn_left_spritesheet+YAWN_IDLE_2
	dw yawn_left_spritesheet+YAWN_IDLE_3
	dw yawn_left_spritesheet+YAWN_IDLE_4

yawn_back_left_idle_anim_pointers: ;$699B
	dw yawn_back_left_spritesheet+YAWN_IDLE_1
	dw yawn_back_left_spritesheet+YAWN_IDLE_2
	dw yawn_back_left_spritesheet+YAWN_IDLE_3
	dw yawn_back_left_spritesheet+YAWN_IDLE_4

	dw yawn_back_left_spritesheet+YAWN_IDLE_1
	dw yawn_back_left_spritesheet+YAWN_IDLE_2
	dw yawn_back_left_spritesheet+YAWN_IDLE_3
	dw yawn_back_left_spritesheet+YAWN_IDLE_4

yawn_back_idle_anim_pointers: ;$69AB
	dw yawn_back_spritesheet+YAWN_IDLE_1
	dw yawn_back_spritesheet+YAWN_IDLE_2
	dw yawn_back_spritesheet+YAWN_IDLE_3
	dw yawn_back_spritesheet+YAWN_IDLE_4

	dw yawn_back_spritesheet+YAWN_IDLE_1
	dw yawn_back_spritesheet+YAWN_IDLE_2
	dw yawn_back_spritesheet+YAWN_IDLE_3
	dw yawn_back_spritesheet+YAWN_IDLE_4

yawn_back_right_idle_anim_pointers: ;$69BB
	dw yawn_back_right_spritesheet+YAWN_IDLE_1
	dw yawn_back_right_spritesheet+YAWN_IDLE_2
	dw yawn_back_right_spritesheet+YAWN_IDLE_3
	dw yawn_back_right_spritesheet+YAWN_IDLE_4

	dw yawn_back_right_spritesheet+YAWN_IDLE_1
	dw yawn_back_right_spritesheet+YAWN_IDLE_2
	dw yawn_back_right_spritesheet+YAWN_IDLE_3
	dw yawn_back_right_spritesheet+YAWN_IDLE_4

;attack 69CB
yawn_right_attack_anim_pointers:
	dw yawn_right_spritesheet+YAWN_ATTACK

yawn_front_right_attack_anim_pointers:
	dw yawn_front_right_spritesheet+YAWN_ATTACK

yawn_front_attack_anim_pointers:
	dw yawn_front_spritesheet+YAWN_ATTACK

yawn_front_left_attack_anim_pointers:
	dw yawn_front_left_spritesheet+YAWN_ATTACK

yawn_left_attack_anim_pointers:
	dw yawn_left_spritesheet+YAWN_ATTACK

yawn_back_left_attack_anim_pointers:
	dw yawn_back_left_spritesheet+YAWN_ATTACK

yawn_back_attack_anim_pointers:
	dw yawn_back_spritesheet+YAWN_ATTACK

yawn_back_right_attack_anim_pointers:
	dw yawn_back_right_spritesheet+YAWN_ATTACK

;dead 69DB
yawn_right_dead_anim_pointers:
	dw yawn_right_spritesheet+YAWN_DEAD

yawn_front_right_dead_anim_pointers:
	dw yawn_front_right_spritesheet+YAWN_DEAD

yawn_front_dead_anim_pointers:
	dw yawn_front_spritesheet+YAWN_DEAD

yawn_front_left_dead_anim_pointers:
	dw yawn_front_left_spritesheet+YAWN_DEAD

yawn_left_dead_anim_pointers:
	dw yawn_left_spritesheet+YAWN_DEAD

yawn_back_left_dead_anim_pointers:
	dw yawn_back_left_spritesheet+YAWN_DEAD

yawn_back_dead_anim_pointers:
	dw yawn_back_spritesheet+YAWN_DEAD

yawn_back_right_dead_anim_pointers:
	dw yawn_back_right_spritesheet+YAWN_DEAD

;69EB
