extends Node
class_name  EnemyState

var state_machine : StateMachine
var node : EnemyBase:
	set (value):
		node = value
		enemy = value
	get:
		return node

var enemy : EnemyBase

func enter():
	pass
	
func exit():
	pass
