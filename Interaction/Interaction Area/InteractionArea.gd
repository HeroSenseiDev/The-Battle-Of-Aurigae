extends Area2D
class_name InteractionArea

@export var action_name: String = "Interact"

var interact: Callable = func ():
	pass





func _on_body_entered():
	InteractionManager.register_area(self)


func _on_body_exited():
	InteractionManager.unregister_area(self)
