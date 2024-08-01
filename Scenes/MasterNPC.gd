extends Node2D

@onready var interaction_area : InteractionArea = $InteractionArea
@onready var sprite = $AnimatedSprite2D

@onready var resource = preload("res://Dialogue/Master/NuevoDialogo.dialogue")
var dailoguestart : String = "start"

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact():
	DialogueManager.show_example_dialogue_balloon(resource)
	await DialogueManager.dialogue_ended
