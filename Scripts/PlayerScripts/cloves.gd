extends Sprite2D
class_name  Cloves
@onready var animation_player = $AnimationPlayer
var player : Player
var sprite : Sprite2D = self

func _ready():
	sprite.visible = false
	player = get_tree().get_first_node_in_group("Player")
func attack():
	animation_player.play("Attack")
	sprite.visible = true

func _process(delta):
	if player.animsprite.flip_h:
		sprite.flip_h = true
	else:
		sprite.flip_h = false


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Attack":
		sprite.visible = false
