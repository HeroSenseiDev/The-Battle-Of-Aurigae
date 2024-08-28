extends EnemyState
@onready var ray_cast_right_void: RayCast2D = $"../../RayCasts/RayCastRightVoid"
@onready var ray_cast_left_void: RayCast2D = $"../../RayCasts/RayCastLEFTVoid"

func enter():
	enemy.animation_player.play("FastRun")
	enemy.speed = enemy.normal_speed * 2
	enemy.is_roaming = false
	enemy.is_chase = true
	enemy.set_collision_mask_value(4, true)
	
	
func state_exit():
	print("saliendo de CHASE")
	enemy.set_collision_mask_value(4, false)
	
func physics_process(delta):
	if enemy.is_on_wall() and enemy.is_on_floor():
		enemy.velocity.y = enemy.jump_force
	if !enemy.is_on_floor():
		enemy.animation_player.play("Air")
		var dir_to_player = enemy.position.direction_to(enemy.player.global_position)
		enemy.velocity.x = dir_to_player.x * enemy.speed * delta
	if enemy.is_on_floor() and enemy.velocity.x > 0:
		enemy.animation_player.play("FastRun")
	if enemy.ray_cast_left.is_colliding() and enemy.ray_cast_right.is_colliding():
		var dir_to_player = enemy.position.direction_to(enemy.player.global_position)
		enemy.velocity.x = dir_to_player.x * enemy.speed * delta
		enemy.animation_player.play("FastRun")
	elif !ray_cast_left_void.is_colliding() or !ray_cast_right_void.is_colliding():
		enemy.animation_player.play("Idle")
		enemy.velocity.x = 0
		
	flip_sprite()

func flip_sprite() -> void:
	if enemy.velocity.x < 0:
		enemy.sprite_2d.flip_h = false
		$"../../Areas/AttackHitboxComponent/CollisionShape2D".position.x = -200
	elif enemy.velocity.x > 0:
		enemy.sprite_2d.flip_h = true
		$"../../Areas/AttackHitboxComponent/CollisionShape2D".position.x = 200
		
	


func _on_enemy_area_body_exited(body):
	print("salio: ", body.name)
	if body.name == "Kairos" and !enemy.is_dead:
		enemy.is_chase = false
		enemy.is_roaming = true
		enemy.set_collision_mask_value(4, false)
		state_machine.change_to("EnemySearch")
		

func _on_enemy_attack_area_body_entered(body):
	print("entro: ", body.name)
	if body.name == "Kairos" and !enemy.is_dead:
		enemy.set_collision_mask_value(4, false)
		state_machine.change_to("EnemyAttack")
