extends PlayerState
@export var raycast : RayCast2D
var air_jump = true
var gravity_multiplier: float = 1
func enter():
	air_jump = true
	
func process(delta):
	player.animplayer.play("Jump")
	
	if raycast.is_colliding() and player.is_on_wall_only():
		if raycast.get_collider().name == "TileMap":
			state_machine.change_to("PlayerWallState")
			
	
	move(player.input_axis)
	if player.is_on_floor():
		player.can_roll = true
		player.land_tween()
		state_machine.change_to("PlayerGroundState")
		
	#if  player.velocity.y > 0 and player.is_air_combo:
		#player.stateMachine.change_to("PlayerAirAttack")
		
	if player.velocity.y < 0:
		player.animplayer.play("Jump")
		return
		
	if player.velocity.y > 0 :
		player.animplayer.play("Fall") #Falling animation
		player.velocity.y += player.gravity * gravity_multiplier * delta
func is_facing_wall():
	return player.get_wall_normal().x == player.velocity.x

func move(direction):
	if direction.x !=0:
		player.velocity.x = move_toward(player.velocity.x, direction.x * player.speed, player.acceleration * player.tick)
	elif direction.x == 0:
		player.velocity.x = move_toward(player.velocity.x, 0.0 , player.friction * player.tick)
func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		if air_jump:
			player.velocity.y = player.jump_force * 0.9
			player.jump_tween()
			player.jump_dust_instantiate()
			air_jump = false
	elif event.is_action_pressed("attack"):
		if player.can_attack == true:
			state_machine.change_to("PlayerAttackState")
	elif player.dash_counter > 0 and event.is_action_pressed("dash"):
			player.jump_dust_instantiate()
			player.dash_counter -= 1
			print(player.dash_counter)
			print(player.candash)
			player.is_dashing = true
			player.candash = false
			player.can_dash.start()
			player.dashing.start()
			player.animplayer.play("Dash")
			state_machine.change_to("PlayerDashState")
		
		
