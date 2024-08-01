extends EnemyState


func process(delta):
	knockback()

func knockback():
	enemy.velocity = (enemy.health_component.knockback_vector * enemy.knockback_force)
	enemy.speed = 0
	enemy.move_and_slide()



func _on_animation_player_animation_finished(anim_name):
	if anim_name == "HitFlash":
		state_machine.change_to("EnemyRoaming")
