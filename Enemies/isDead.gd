class_name IsDead
extends ConditionLeaf

@export var keys : BlackboardKeys


func tick(actor : Node, blackboard: Blackboard):
	var is_dead : bool = blackboard.get_value(keys.death_key)
	
	if is_dead:
		return SUCCESS
	else:
		return FAILURE

