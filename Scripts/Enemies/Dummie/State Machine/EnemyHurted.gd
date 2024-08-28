extends EnemyState
@export var hurted_timer : Timer
func enter():
	hurted_timer.start()
	knockback()
	enemy.hurted_SFX.play()
	GameManager.shake()
	enemy.is_hurted = true
	enemy.direction = Vector2.ZERO
	enemy.sprite_2d.material.set_shader_parameter("Enabled", true)


func knockback() -> void:
	enemy.velocity = enemy.health_component.knockback_vector * enemy.knockback_force
	enemy.velocity.y = 0
	enemy.speed = 0

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Hurted":
		state_machine.change_to("EnemyWander")

func state_exit():
	print("saliendo de hurted")
	GameManager.desactivate_shake()
	enemy.sprite_2d.material.set_shader_parameter("Enabled", false)
	enemy.is_hurted = false
	hurted_timer.stop()

func _on_timer_timeout():
	enemy.velocity.x = 0
	hurted_timer.stop()
