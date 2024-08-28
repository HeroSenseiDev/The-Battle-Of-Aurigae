extends Area2D
class_name HitboxComponent

@export var damage: int = 1
var atacante

func _ready():
	if get_parent().name == "AttackDirector":
		atacante = get_parent().get_parent()
	else:
		atacante = get_parent()
	area_entered.connect(hit)
func hit(area):
	if area is HealthComponent:
		area.take_damage(damage, atacante)
