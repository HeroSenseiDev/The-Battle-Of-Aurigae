extends PlayerState

@export var tick = 0
@export var acceleration = 60000
@export var friction = 60000

func enter():
	print("Hello from state Run!")
	
func physics_process(delta):
	player.animplayer.play("Run")
	move(player.input_axis)
	
func move(direction):
	if direction.x !=0:
		player.velocity.x = move_toward(player.velocity.x, direction.x * player.speed, player.acceleration * player.tick)
	elif direction.x == 0:
		player.velocity.x = move_toward(player.velocity.x, 0.0 , player.friction * player.tick)
		state_machine.change_to("Idle")
