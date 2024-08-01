extends CharacterBody2D
class_name EnemyBasea

var player : Player
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D

var speed = 500
var is_chase : bool 
var dead : bool = false
var is_hurted : bool = false
var direction : Vector2
var is_roaming : bool = true

@export var stateMachine : StateMachine
@export var knockback_force = 10
var knockback_dir
@onready var direction_timer = $Timers/DirectionTimer
@onready var hurted_timer = $Timers/HurtedTimer
@onready var health_component : HealthComponent = $HealthComponent


func _ready():
	health_component.onDead.connect(func(): die()) 
	health_component.onDamageTook.connect(func(): stateMachine.change_to("EnemyHurted"))
	player = get_tree().get_first_node_in_group("Player")

func _process(delta):
	flip_sprite()
	
func _physics_process(delta):
	velocity.y += gravity * delta

func flip_sprite():
	if velocity.x < 0:
		sprite_2d.flip_h = false
	elif velocity.x > 0:
		sprite_2d.flip_h = true

func die():
	pass
func hurted():
	animation_player.play("HitFlash")
	stateMachine.change_to("EnemyHurted")
	

func _on_direction_timer_timeout():
	direction_timer.wait_time = choose([1.5, 2.0, 2.5])
	if !is_chase:
		direction = choose([Vector2.RIGHT, Vector2.LEFT])
		velocity.x = 0
func choose(array):
	array.shuffle()
	return array.front()
