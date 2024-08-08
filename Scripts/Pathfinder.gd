extends Node2D

var tilemap : TileMap
var graph
var face = preload("res://Scenes/face.tscn")

var cell_size = 16


func _ready():
	graph = AStar2D.new()
	tilemap = find_parent("Main").find_child("TileMap")
	createMap()

#func connectPoints():
func _draw():
	var points = graph.get_point_ids()
	for point in points:
		var closeRight = -1
		var closeLeft = -1
		var pos = graph.get_point_position(point)
		var type = cellType(pos, true, true)
		
		for newPoint in points:
			var newPos = graph.get_point_position(newPoint)
			if type[1] == 0 and newPos[1] == pos[1] and newPos[0] > pos[0]:
				if closeRight < 0 or newPos[0] < graph.get_point_position(closeRight)[0]:
					closeRight = newPoint
			if type[0] == -1:
				if newPos[0] == pos[0] - cell_size and newPos[1] >= pos[1]:
					if closeLeft < 0 or newPos[1] < graph.get_point_position(closeLeft)[1]:
						closeLeft = newPoint
						
		if closeRight >= 0:
			graph.connect_points(point, closeRight)
			draw_line(pos, graph.get_point_position(closeRight), Color(255, 0, 0))
			
		if closeLeft >= 0:
			graph.connect_points(point, closeLeft)
			draw_line(pos, graph.get_point_position(closeLeft), Color(255, 0, 0))

func createMap():
	if tilemap != null:
		var space_state = get_world_2d().direct_space_state
		var cells = tilemap.get_used_cells(0)
		
		for cell in cells:
			var type = cellType(cell)
			if type and type != Vector2(0, 0):
				create_points(cell)
				
				if type[0] == -1:
					var pos = tilemap.map_to_local(Vector2i(cell[0] - 1, cell[1]))
					var posTo = Vector2(pos[0], pos[1] + 1000)
					var parameters = PhysicsRayQueryParameters2D.create(pos, posTo)
					var results = space_state.intersect_ray(parameters)
					if results:
						create_points(tilemap.local_to_map(results.position))
	print(graph.get_point_ids().size())
	
func cellType(pos, global = false, isAbove = false):
	if global:
		pos = tilemap.local_to_map(pos)
	if isAbove:
		pos = Vector2i(pos[0], pos[1] + 1)
	var cells = tilemap.get_used_cells(0)
	
	if (Vector2i(pos[0], pos[1] - 1)) in cells:
		return null
		
	var results = Vector2(0, 0)
	
	if Vector2i(pos[0] -1, pos[1] - 1) in cells:
		results[0] = 1
	elif !Vector2i(pos[0] -1, pos[1]) in cells:
		results[0] = -1
		
	if Vector2i(pos[0] + 1, pos[1] - 1) in cells:
		results[1] = 1
	elif !(Vector2i(pos[0] + 1, pos[1]) in cells):
		results[1] = -1
	return results
	
func create_points(cell):
	var above = Vector2i(cell[0], cell[1] - 1)
	var pos = tilemap.map_to_local(above) + Vector2(cell_size/2, cell_size/2)
	if graph.get_point_position(graph.get_closest_point(pos)) == pos:
		return
	
	var instance = face.instantiate() 
	instance.position = pos
	add_child(instance)
	graph.add_point(graph.get_available_point_id(), pos)
