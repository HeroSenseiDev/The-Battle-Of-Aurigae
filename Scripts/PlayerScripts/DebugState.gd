extends Label

@onready var state_machine = $"../StateMachine"

func _process(_delta):
	self.text = state_machine.state.name
