extends RayCast2D
var raycast_dimension = 7
var ray_flip = false
# Called when the node enters the scene tree for the first time.
func _ready():
	self.target_position.x = raycast_dimension

func _process(delta):
	if ray_flip:
		self.target_position.x = -raycast_dimension
	else:
		self.target_position.x = raycast_dimension
