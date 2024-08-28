extends PlayerState
@export var raycast : RayCast2D
@export var wall_jump_pushback = 2500

func enter():
	player.animplayer.play("Slide")

func physics_process(_delta):
	
	if !player.is_on_floor():
		player.velocity.y = player.velocity.y * 0.8
		player.animplayer.play("Slide")

		if !raycast.is_colliding():
			state_machine.change_to("PlayerAirState")
			
	if player.is_on_floor():
		state_machine.change_to("PlayerGroundState")
		
func process(delta):
	wall_climb()
	wall_jump(delta)
	wall_slide()
	
func wall_climb():
	if Input.is_action_pressed("right_move") and Input.is_action_just_pressed("jump"):
		player.velocity.y = player.jump_force
		player.velocity.x = -wall_jump_pushback
		player.move_and_slide()
		state_machine.change_to("PlayerAirState")
	if Input.is_action_pressed("left_move") and Input.is_action_just_pressed("jump"):
		player.velocity.y = player.jump_force
		player.velocity.x = wall_jump_pushback
		player.move_and_slide()
		state_machine.change_to("PlayerAirState")
		
func wall_jump(_delta):
	var wall_normal = player.get_wall_normal()
	if Input.is_action_just_pressed("left_move") and wall_normal == Vector2.LEFT:
		player.velocity.x = wall_normal.x * player.speed * 5
		player.velocity.y = player.jump_force
		state_machine.change_to("PlayerAirState")
	if Input.is_action_just_pressed("right_move") and wall_normal == Vector2.RIGHT:
		player.velocity.x = wall_normal.x * player.speed * 5
		player.velocity.y = player.jump_force 
		state_machine.change_to("PlayerAirState")
	
func wall_slide():
	if Input.is_action_pressed("down_move"):
		player.velocity.y = player.velocity.y * 5
func is_facing_wall():
	return player.get_wall_normal().x == player.velocity.x
