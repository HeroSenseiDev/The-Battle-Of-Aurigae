extends PlayerState

func enter():
	print("Hello from state Jump!")
	
func process(delta):
	player.animplayer.play("Jump")
func physics_process(delta):
	if player.is_on_floor():
			player.velocity.y = player.jump_force
			player.jump_particles.emitting = true
			if player.is_on_floor():
				state_machine.change_to("Idle")
