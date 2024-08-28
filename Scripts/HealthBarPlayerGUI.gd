extends TextureProgressBar
class_name HealthPlayerBar
@export var health_component : HealthComponent

func on_ready():
	max_value = health_component.max_health
	value = health_component.current_health
	
	health_component.onHealthChanged.connect(update_health)
	
func _process(delta: float) -> void:
		if value == 1:
			$AnimationPlayer.play("MegaShake")
		else:
			$AnimationPlayer.stop()
func update_health(current_health):
	value = current_health
	$AnimationPlayer.play("Temblor")
	if value <= 0:
		hide()
