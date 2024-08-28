extends EnemyState
@onready var ray_cast_2d = $"../../RayCasts/RayCastLEFT"
@onready var ray_cast_right = $"../../RayCasts/RayCastRIGHT"
@onready var search_timer = $"../../Timers/SearchTimer"
@onready var direction_timer = $"../../Timers/DirectionTimer"


func enter():
	direction_timer.start()
	search_timer.start()
	enemy.speed = enemy.normal_speed
	enemy.direction = enemy.choose([Vector2.RIGHT, Vector2.LEFT])
	enemy.animation_player.play("Run")

func state_exit():
	print("saliendo de wander")
	search_timer.stop()
	direction_timer.stop()
func process(delta):
	if enemy.is_chase == true:
		state_machine.change_to("EnemyChase")
	move(delta)
	if !enemy.ray_cast_left.is_colliding() and enemy.is_on_floor():
		enemy.direction = Vector2.RIGHT
	if !enemy.ray_cast_right.is_colliding() and enemy.is_on_floor():
		enemy.direction = Vector2.LEFT
	if enemy.is_on_wall():
		enemy.direction = enemy.choose([Vector2.RIGHT, Vector2.LEFT])

	
func move(delta):
	if enemy.is_chase == false:
		enemy.animation_player.play("Run")
		enemy.velocity.x = enemy.direction.x * enemy.speed * delta
	if enemy.direction == Vector2.RIGHT:
		enemy.sprite_2d.flip_h = true
	elif enemy.direction == Vector2.LEFT:
		enemy.sprite_2d.flip_h = false
	elif enemy.is_chase == true:
		enemy.animation_player.play("FastRun")
		state_machine.change_to("EnemyChase")
	enemy.is_roaming = true


func _on_search_timer_timeout():
	if enemy.is_roaming == true:
		if !enemy.is_chase:
			if !enemy.shock:
				search_timer.wait_time = choose([8.0, 10.0, 12.5])
				search_timer.stop()
				direction_timer.stop()
				state_machine.change_to("EnemySearch")
			
func choose(array):
	array.shuffle()
	return array.front()


func _on_enemy_area_body_entered(body):
	if body.name == "Kairos" and !enemy.is_dead:
		enemy.is_chase = true
		enemy.animation_player.play("FastRun")
		state_machine.change_to("EnemyChase")
		search_timer.stop()
		
func _on_direction_timer_timeout():
	direction_timer.wait_time = choose([3.0, 4.0])
	if !enemy.is_chase:
		enemy.direction = choose([Vector2.RIGHT, Vector2.LEFT])
		enemy.velocity.x = 0
