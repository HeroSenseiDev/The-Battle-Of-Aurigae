extends Area2D


@export var phantom_camera : PhantomCamera2D

func _ready():
	body_entered.connect(actor_entered)
	body_exited.connect(actor_exited)

func actor_entered(body):
	phantom_camera.set_priority(10) 
	
	
	if phantom_camera.get_follow_mode() == phantom_camera.Constants.FollowMode.GROUP:
		phantom_camera.append_follow_group_node(body)
		
func actor_exited(body):
	phantom_camera.set_priority(0)
	
	if phantom_camera.get_follow_mode() == phantom_camera.Constants.FollowMode.GROUP:
		phantom_camera.erase_follow_group_node(body)
