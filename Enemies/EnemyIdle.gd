extends EnemyState
@onready var idle_timer = $"../../Timers/Idle Timer"

func enter():
	idle_timer.start()
	enemy.animation_player.play("Idle")
	
func process(delta):
	enemy.velocity.x = 0


func _on_idle_timer_timeout():
	if enemy.is_roaming:
		state_machine.change_to("EnemyWander")
	elif enemy.is_chase:
		state_machine.change_to("EnemyChase")
