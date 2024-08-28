extends PlayerState
@export var cloves : Cloves

@export var attack_sfx : AudioStreamPlayer

func enter():
	print("Hello from Attack State")
	player.animplayer.play("Attack")
	attack_sfx.play()
	#cloves.attack()
func process(_delta):
	move(player.input_axis)
	
func move(direction):
	if direction.x !=0:
		player.velocity.x = move_toward(player.velocity.x, direction.x * player.speed, player.acceleration * player.tick)
	elif direction.x == 0:
		player.velocity.x = move_toward(player.velocity.x, 0.0 , player.friction * player.tick)
		
func state_exit():
	print("saliendo de attack")
	GameManager.desactivate_shake()
	player.can_attack = false
	player.attack_cooldown.start()
	
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Attack":
		player.can_attack = false
		player.attack_cooldown.start()
		if player.is_on_floor(): state_machine.change_to("PlayerGroundState")
		else: state_machine.change_to("PlayerAirState")
