extends CharacterBody2D
class_name FirstEnemy

var speed = -800
var normal_speed
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var knockbackforce = 15
@onready var player : Player

@onready var explosion : PackedScene = preload("res://explosion.tscn")

@onready var hurtedsfx = $SFX/Hurted

@onready var health_component = $HealthComponent

var facing_right = false
var dead = false
@export var health : HealthComponent

func _ready(): 
	normal_speed = speed
	$AnimationPlayer.play("Run")
	health_component.onDead.connect(func(): die()) 
	health_component.onDamageTook.connect(func(): hurted())
	player = get_tree().get_first_node_in_group("Player")
	


func _physics_process(delta):
	velocity.y += gravity * delta
	if !$RayCast2D.is_colliding() and is_on_floor():
		flip()

	velocity.x = speed
	move_and_slide()

func flip():
	$AnimationPlayer.play("Run")
	facing_right = !facing_right
	$Sprite2D.flip_h = not $Sprite2D.flip_h
	if facing_right:
		speed = abs(speed)
		$RayCast2D.position.x = 57
	else:
		speed = abs(speed) * -1
		$RayCast2D.position.x = -57

func die():
	dead = true
	speed = 0
	$AnimationPlayer.play("Die")
	
func combo_hurted():
	velocity.y = player.jump_force
	speed = 0
	if velocity.y > 0:
		velocity.y = 0
func hurted():
	if player.is_air_combo == true:
		combo_hurted()
	else:
		hurtedsfx.play()
		knockback()
		move_and_slide()
		explosion_particle()
		speed = 0
		GameManager.shake()
		$HitFlashAnimationPlayer.play("HitFlash")
		$Timer.start()
	

func explosion_particle():
	var instance = explosion.instantiate()
	print("instancie particula")
	add_sibling(instance)
	
	instance.global_position = global_position

func knockback():
	velocity = (health_component.knockback_vector * knockbackforce)
	move_and_slide()
	
func _on_timer_timeout():
	GameManager.desactivate_shake()
	speed = -1000
	if dead == true:
		speed = 0
	if facing_right:
		speed = abs(speed)
		$RayCast2D.position.x = 57
	else:
		speed = abs(speed) * -1
		$RayCast2D.position.x = -57
