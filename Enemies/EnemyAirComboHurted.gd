extends EnemyState
@onready var search_timer = $"../../Timers/SearchTimer"
@onready var direction_timer = $"../../Timers/DirectionTimer"

func enter():
	enemy.shock = true
	enemy.is_chase = false
	print("Dolor")

func process(_delta):
	print(enemy.player.is_air_combo)
	if enemy.velocity.y > 0:
		enemy.gravity = enemy.shock_gravity / 4
		
func state_exit():
	enemy.gravity = enemy.normal_gravity
	
	if enemy.player.is_air_combo == false:
		state_machine.change_to("EnemyWander")
