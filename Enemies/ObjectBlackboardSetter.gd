extends Node
@export var health_component : HealthComponent
@export var keys : BlackboardKeys
@export var blackboard : Blackboard

func _ready():
	health_component.onDead.connect(Dead())
	blackboard.set_value(keys.death_key, health_component.onDead)
	
func Dead():
	blackboard.set_value(keys.death_key, health_component.onDead)
