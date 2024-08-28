extends CharacterBody2D
class_name Player


@export var normal_speed = 950
@export var dash_speed = 3000
@export var roll_speed = 2000
@onready var hitbox_component = $AttackDirector/HitboxComponent
@export var speed = 950
@export var tick = 70
@export var acceleration = 5
@export var friction = 7

var can_roll
@onready var roll_cooldown: Timer = $Timers/RollCooldown


var collected_keys = ""

var savedJumpPosition: Vector2

@onready var can_dash = $Timers/CanDash
@onready var dashing = $Timers/Dashing

#@onready var color_rect = $"../ColorRect"
#@onready var fanimation_player = $"../ColorRect/AnimationPlayer"


var candash = true
var is_dashing: bool
@export var dash_counter = 1
var dash_counter_start

@export var jump_force = -3900
@export var jump_particles: PackedScene
@export var health_component: HealthComponent
@export var attack_cooldown: Timer
var can_attack: bool = true

@export var wall_raycast: RayCast2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var stateMachine: StateMachine

@onready var animsprite: Sprite2D = $Sprite2D
@export var animplayer: AnimationPlayer


var input_axis: Vector2

var max_health = 2
var health = 0

func _ready():
	roll_cooldown.one_shot = true
	can_roll = true
	$AttackDirector/HitboxComponent/CollisionShape2D.disabled = true
	can_attack = true
	if can_attack == false:
		can_attack = true
	health_component.onDead.connect(func(): dead())
	health_component.onDamageTook.connect(func(): hurted())
	health = max_health
	GameManager.player = self
	
	dash_counter_start = dash_counter
	speed = normal_speed

func _process(_delta):
	flip_sprite()
	#respawn_decitiom()
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y = velocity.y / 10
func _physics_process(delta):
	input_axis.x = Input.get_axis("left_move", "right_move")
	move_and_slide()
	apply_gravity(delta)
	
func flip_sprite():
	if velocity.x < 0:
		animsprite.flip_h = true
		wall_raycast.ray_flip = true
	elif velocity.x > 0:
		animsprite.flip_h = false
		wall_raycast.ray_flip = false
			
func horizontal_jump_animation():
	if velocity.x > 0 and !is_on_floor(): animplayer.play("Hurted")
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("down_move") and is_on_floor():
		position.y += 1.5
		
func dead():
	respawn()
	
	
func jump_dust_instantiate():

	var instance = jump_particles.instantiate()
	print("instancie particula")
	add_sibling(instance)
	
	instance.global_position = global_position + Vector2(-10, 20)
		
#func _unhandled_input(event) -> void:
	##if Input.is_action_just_pressed("interact"):
		##var actionable = actionable_finder.get_overlapping_areas()
		##if actionable.size() > 0:
			##print("Hay NPC en el area")
			##actionable[0].action()
			##return
		##else:
			##return;
			#
func hurted():
	animplayer.play("Hurted")
	stateMachine.change_to("PlayerHurtedState")
	$SFX/Damage.play()
	await get_tree().create_timer(0.5).timeout
	$SFX/Damage.stop()

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.y = clampf(velocity.y, -25000, 15000)

#func respawn_decitiom():
	#if global_position.y > 2200:
		#health_component.take_damage(1, self)
		#print("Tengo que hacer respawn")
		#fanimation_player.play("fade")
		#get_tree().create_timer(0.2)
		#respawn()
		#
func respawn():
	var reposition: Vector2 = savedJumpPosition
	global_position = Vector2(reposition.x + -100, reposition.y + -200)
	speed = 0
	await get_tree().create_timer(0.3).timeout
	speed = normal_speed
	
func save_last_jump_position():
	savedJumpPosition = global_position

func _on_attack_cooldown_timeout():
	can_attack = true
	$Timers/AttackCooldown.start()
	

func _on_dashing_timeout():
	is_dashing = false


func _on_can_dash_timeout():
	candash = true


func _on_roll_cooldown_timeout() -> void:
	can_roll = true
