extends PlayerState
@export var knockbackforce = 5
var hit_position
@export var hurtsfx : AudioStreamPlayer
@onready var damage = $"../../SFX/Damage"

func enter():
	hurtsfx.play()
	player.animplayer.play("Hurted")
	HitStopManager.hit_stop_medium()
	$"../../AttackDirector/HitboxComponent/Cloves".visible = false
func process(delta):
	knockback()
func knockback():
	player.velocity = (player.health_component.knockback_vector * knockbackforce)
	player.velocity.y = player.jump_force * 0.5
	player.move_and_slide()
	

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Hurted":
		if player.is_on_floor(): state_machine.change_to("PlayerGroundState")
		else: state_machine.change_to("PlayerAirState")
