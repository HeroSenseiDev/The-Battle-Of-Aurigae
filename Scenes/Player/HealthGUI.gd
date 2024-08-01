extends Control


@export var heart_container : HeartContainer
@export var player : Player


func _ready():
	if not player:
		player = get_tree().get_first_node_in_group("Player")
		
	heart_container.heart_number = player.health_component.max_health
	player.health_component.onHealthChanged.connect(heart_container.update_health)
