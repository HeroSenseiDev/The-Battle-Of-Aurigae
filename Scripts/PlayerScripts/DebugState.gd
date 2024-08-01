extends Label

@onready var state_machine = $"../StateMachine"

func _process(delta):
	self.text = state_machine.state.name
