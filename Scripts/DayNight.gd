extends CanvasModulate

var time : float = 0.0

@export var gradient:GradientTexture1D

func _process(delta):
	time += delta
	var value = (sin(time - PI / 2) + 1.0) / 2.0
	self.color = gradient.gradient.sample(value)
