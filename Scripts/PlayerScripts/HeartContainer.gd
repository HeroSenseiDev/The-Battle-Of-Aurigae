extends HBoxContainer
class_name HeartContainer

@export var health_component : HealthComponent
var heart_number : int = 5

var heart_texture = preload("res://vida.png")

func _ready() -> void:
	await owner.ready
	
	if health_component != null:
		health_component.onHealthChanged.connect(update_health)
		heart_number = health_component.max_health
		
	for i in range(get_child_count(), heart_number):
		create_heart()
	update_heart_visibility()
		
func update_health(value):
	heart_number = value
	update_heart_visibility()
func create_heart():
	var heart_sprite = TextureRect.new()
	add_child(heart_sprite)
	
	heart_sprite.texture = heart_texture
	heart_sprite.expand_mode = TextureRect.EXPAND_KEEP_SIZE
	heart_sprite.stretch_mode = TextureRect.STRETCH_KEEP_CENTERED
	
func update_heart_visibility():
	for heart_index in range(get_child_count()):
		get_child(heart_index).visible = heart_number > heart_index
