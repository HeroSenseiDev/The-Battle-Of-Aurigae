extends PlayerState

@export var raycast : RayCast2D
@onready var roll_coyote: Timer = $"../../Timers/RollCoyote"

func enter():
	player.health_component.set_collision_layer_value(2, false)
	player.set_collision_mask_value(4, false)

func process(delta) -> void:
	if !player.is_on_floor():
		roll_coyote.start()
	#player.set_collision_mask_value(2, false)
	#if raycast.is_colliding():
		#if raycast.get_collider().name == "TileMap":
			#state_machine.change_to("PlayerWallState")
			
	player.velocity.y = 0
	if player.is_dashing == true:
		if player.animsprite.flip_h:
			player.velocity.x = -player.roll_speed
		else:
			player.velocity.x = player.roll_speed

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Roll":
		if player.is_on_floor():
			player.can_roll = false
			player.health_component.set_collision_layer_value(2, true)
			player.set_collision_mask_value(4, true)
			player.animsprite.position.y = 78
			state_machine.change_to("PlayerGroundState")
		else:
			player.can_roll = false
			player.health_component.set_collision_layer_value(2, true)
			player.set_collision_mask_value(4, true)
			player.animsprite.position.y = 78
			state_machine.change_to("PlayerAirState")

func state_exit():
	player.roll_cooldown.start()
	player.can_roll = false
	roll_coyote.stop()
	player.animsprite.position.y = 78
	GameManager.desactivate_shake()
	player.health_component.set_collision_layer_value(2, true)
	player.set_collision_mask_value(4, true)
	


func _on_roll_coyote_timeout() -> void:
	state_machine.change_to("PlayerAirState")
