extends ProgressBar
class_name RollCooldownBar

@export var player: Player
func _ready():
	if not player:
		player = get_tree().get_first_node_in_group("Player")
		max_value = player.roll_cooldown.wait_time * 1000
		
	
func _process(delta):
	value = max_value - (player.roll_cooldown.time_left * 1000)
	
	#if value <= 0:
	#	visible = 0
	#else:
	#	visible = 1
