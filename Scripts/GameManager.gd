extends Node
var current_checkpoint : Checkpoint
var teletransported = false
var player : Player
var normal_speed = 1800

@onready var phantom_camera : PhantomCamera2D
@export var magnitude : float = 10

var is_shaking : bool = false
var can_shake : bool = true
var shake_is_desactivated = true
var shake_amt : Vector2 = Vector2.ZERO



func shake():
	shake_is_desactivated = false
	is_shaking = true
	shake_amt = Vector2 (randf_range(-5, 5), randf_range(-5, 5)) * magnitude
	phantom_camera.global_position += shake_amt
func mega_shake():
	shake_is_desactivated = false
	is_shaking = true
	shake_amt = Vector2 (randf_range(-5, 5), randf_range(-5, 5)) * magnitude * 5
	phantom_camera.global_position += shake_amt
	
func desactivate_shake():
	is_shaking = false
	shake_is_desactivated = true
	phantom_camera.global_position = phantom_camera.global_position
