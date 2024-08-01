extends EnemyState

func enter():
	enemy.hurted_SFX.play()
	GameManager.shake()
	enemy.is_hurted = true
	enemy.direction = Vector2.ZERO
	enemy.hurted_timer.start()

func process(delta):
	knockback()
	
func knockback():
	if enemy.knockback_jump:
		enemy.velocity = enemy.health_component.knockback_vector * enemy.knockback_force
		enemy.velocity.y += enemy.knockback_jump_force
		enemy.speed = 0
	else:
		enemy.velocity = enemy.health_component.knockback_vector * enemy.knockback_force
		enemy.velocity.y = 0
		enemy.speed = 0

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Hurted":
		GameManager.desactivate_shake()
		state_machine.change_to("EnemyWander")

