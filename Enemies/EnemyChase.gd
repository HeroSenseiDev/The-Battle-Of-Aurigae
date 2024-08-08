extends EnemyState

func enter():
	GameManager.desactivate_shake()
	enemy.animation_player.play("FastRun")
	enemy.speed = enemy.normal_speed * 2
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
		
	


func _on_enemy_area_body_exited(body):
	enemy.is_chase = false
	enemy.is_roaming = true
	state_machine.change_to("EnemySearch")


func _on_enemy_attack_area_body_entered(body):
	if body.name == "Kairos":
		state_machine.change_to("EnemyAttack")
