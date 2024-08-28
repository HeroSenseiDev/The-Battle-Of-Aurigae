extends ProgressBar
class_name RollCooldownBar

@export var player: Player
func _ready():
	if not player:
		player = get_tree().get_first_node_in_group("Player")
	max_value = player.roll_cooldown.wait_time * 100
	
func _process(delta):
	value = 100 - (player.roll_cooldown.time_left * 100)
	#if value <= 0:
	#	visible = 0
	#else:
	#	visible = 1
