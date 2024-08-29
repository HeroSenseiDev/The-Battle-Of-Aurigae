extends PlayerState



func process(_delta):
	move(player.input_axis)
	dash()
	player.dash_counter = player.dash_counter_start
	
	if !player.is_on_floor():
		await get_tree().create_timer(0.1).timeout
		state_machine.change_to("PlayerAirState")
	
func move(direction):
	if direction.x !=0:
		player.velocity.x = move_toward(player.velocity.x, direction.x * player.speed, player.acceleration * player.tick)
		player.animplayer.play("Run")
	elif direction.x == 0:
		player.velocity.x = move_toward(player.velocity.x, 0.0 , player.friction * player.tick)
		player.animplayer.play("Idle")
		
func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		player.save_last_jump_position()
		player.jump_dust_instantiate()
		player.jump_tween()
		player.velocity.y = player.jump_force
		state_machine.change_to("PlayerAirState")
	elif event.is_action_pressed("attack"):
		if player.can_attack:
			state_machine.change_to("PlayerAttackState")
	#elif event.is_action_pressed("ui_accept"):
		#player.is_air_combo = true
		#state_machine.change_to("PlayerAttackState")
		
	elif event.is_action_pressed("down_move"):
		player.position.y += 1.5
		
func dash():
	if player.dash_counter > 0:
		if player.can_roll and Input.is_action_just_pressed("Roll"):
			player.dash_counter -= 1
			player.is_dashing = true
			player.candash = false
			player.can_dash.start()
			player.dashing.start()
			player.animplayer.play("Roll")
			state_machine.change_to("PlayerRollState")
			
