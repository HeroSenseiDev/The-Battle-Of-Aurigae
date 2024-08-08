extends CharacterBody2D
class_name EnemyBase
@onready var hurted_timer = $Timers/HurtedTimer
@onready var knockback_duration = $"Timers/Knockback Duration"
@export var knockback_jump : bool
@export var knockback_jump_force : float
@onready var ray_cast_left = $RayCastLEFT
@onready var ray_cast_right = $RayCastRIGHT
@onready var enemy_area = $EnemyArea


var speed = 30000
var normal_speed = 30000
var knockback_force = 4

var is_chase : bool = false
var is_dead : bool = false
var is_hurted : bool = false
var direction : Vector2
var is_roaming : bool = true
@onready var sprite_2d = $Sprite2D
@export var hurted_SFX : AudioStreamPlayer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var state_machine = $StateMachine

@onready var animation_player = $AnimationPlayer

@onready var health_component :  HealthComponent = $HealthComponent
@onready var direction_timer = $Timers/DirectionTimer
@export var idle_in_edges : bool
var player : Player

func _ready():

	player = get_tree().get_first_node_in_group("Player")
	health_component.onDead.connect(func(): dead())
	health_component.onDamageTook.connect(func(): hurted())
	animation_player.play("Idle")
	
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()
	
	
func flip_sprite():
	if direction == Vector2.RIGHT:
		sprite_2d.flip_h = true
	elif direction == Vector2.LEFT:
		sprite_2d.flip_h = false


func hurted():
	animation_player.play("Hurted")
	state_machine.change_to("EnemyHurted")
	
func dead():
	queue_free()

func _on_direction_timer_timeout():
	direction_timer.wait_time = choose([3.0, 4.0])
	if !is_chase:
		direction = choose([Vector2.RIGHT, Vector2.LEFT])
		velocity.x = 0
func choose(array):
	array.shuffle()
	return array.front()


func tween():
	var tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "modulate", Color.RED, 0.4)
	tween.tween_property(self, "modulate", Color.WHITE, 0.4)



