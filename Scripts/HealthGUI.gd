extends Control


@export var health_bar : HealthPlayerBar
@export var player : Player


func _ready():
	if not player:
		player = get_tree().get_first_node_in_group("Player")
		
	health_bar.health_component = player.health_component
	health_bar.on_ready()
	#heart_container.heart_number = player.health_component.max_health
	#player.health_component.onHealthChanged.connect(health_bar.update_health)
