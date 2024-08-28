extends EnemyState


func enter():
	enemy.animation_player.play("Searching")
	enemy.velocity.x = 0

func state_exit():
	print("saliendo del search")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Searching":
		if enemy.is_roaming:
			state_machine.change_to("EnemyWander")
		elif enemy.is_chase:
			state_machine.change_to("EnemyChase")
