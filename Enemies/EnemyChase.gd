extends EnemyState

func enter():
	enemy.speed = enemy.normal_speed * 1.2
	enemy.is_roaming = false
	enemy.is_chase = true
	
func process(delta):
	flip_sprite()
	var dir_to_player = enemy.position.direction_to(enemy.player.global_position)
	enemy.velocity.x = dir_to_player.x * enemy.speed * delta

func flip_sprite():
	if enemy.velocity.x < 0:
		enemy.sprite_2d.flip_h = false
	elif enemy.velocity.x > 0:
		enemy.sprite_2d.flip_h = true
