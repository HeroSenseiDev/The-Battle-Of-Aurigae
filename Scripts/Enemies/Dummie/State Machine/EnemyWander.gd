extends EnemyState
@onready var ray_cast_2d = $"../../RayCastLEFT"
@onready var ray_cast_right = $"../../RayCastRIGHT"
@onready var search_timer = $"../../Timers/SearchTimer"


func enter():
	GameManager.desactivate_shake()
	enemy.speed = enemy.normal_speed
	enemy.direction = enemy.choose([Vector2.RIGHT, Vector2.LEFT])
	enemy.animation_player.play("Run")

func process(delta):
	if enemy.is_chase == true:
		state_machine.change_to("EnemyChase")
	move(delta)
	if !enemy.ray_cast_left.is_colliding() and enemy.is_on_floor():
		enemy.direction = Vector2.RIGHT
	if !enemy.ray_cast_right.is_colliding() and enemy.is_on_floor():
		enemy.direction = Vector2.LEFT

	
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
		if !enemy.is_chase == true:
			search_timer.wait_time = choose([8.0, 10.0, 12.5])
			state_machine.change_to("EnemySearch")
func choose(array):
	array.shuffle()
	return array.front()


func _on_enemy_area_body_entered(body):
	if body.name == "Kairos":
		enemy.is_chase = true
		enemy.animation_player.play("FastRun")
		state_machine.change_to("EnemyChase")
