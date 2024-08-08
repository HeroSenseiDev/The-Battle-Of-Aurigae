extends EnemyState


func enter():
	GameManager.desactivate_shake()
	enemy.animation_player.play("Searching")
	enemy.velocity.x = 0



func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Searching":
		if enemy.is_roaming:
			state_machine.change_to("EnemyWander")
		elif enemy.is_chase:
			state_machine.change_to("EnemyChase")
