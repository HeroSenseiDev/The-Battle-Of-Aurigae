extends PlayerState

@export var raycast : RayCast2D

func process(_delta):
	if raycast.is_colliding():
		if raycast.get_collider().name == "TileMap":
			state_machine.change_to("PlayerWallState")
			
	player.velocity.y = 0
	if player.is_dashing == true:
		if player.animsprite.flip_h:
			player.velocity.x = -player.dash_speed
		else:
			player.velocity.x = player.dash_speed

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Dash":
		if player.is_on_floor():
			state_machine.change_to("PlayerGroundState")
		else:
			state_machine.change_to("PlayerAirState")
			
			
