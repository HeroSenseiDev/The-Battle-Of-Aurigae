extends Camera2D


@onready var phantom_camera = %PhantomCamera2D

func _ready():
	GameManager.phantom_camera = phantom_camera

func _process(delta):
	if GameManager.shake_is_desactivated == false:
		GameManager.shake()
	
