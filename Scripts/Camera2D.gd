extends Camera2D

#
@export var phantom_camera : PhantomCamera2D

func _ready():
	GameManager.phantom_camera = phantom_camera
	pass

func _process(_delta):
	if GameManager.shake_is_desactivated == false:
		GameManager.shake()
	
