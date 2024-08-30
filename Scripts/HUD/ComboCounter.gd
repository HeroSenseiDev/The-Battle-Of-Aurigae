extends Control

var combo_counter = 0
var timer := Timer.new()


func _ready():
	HudSignals.connect("update_combo_counter", combo_update)
	add_child(timer)
	timer.one_shot = true

func _process(delta):
	if timer.time_left < 1:
		combo_counter = 0
		hide()
	%TimeLeft.text = str(int(timer.time_left))


func combo_update():
	show()
	combo_counter += 1
	%Counter.text = str(combo_counter)
	if timer.wait_time >= 10:
		timer.start(10)
	else:
		timer.start(timer.time_left + 2)
