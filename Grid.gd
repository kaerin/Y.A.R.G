extends TileMap

var tile_size = get_cell_size()
var half_tile_size = tile_size / 2

var grid_size = Vector2(10,10)
var grid = []

onready var object = preload("res://testobject.tscn")

func _ready():
	for x in range (grid_size.x):
		grid.append([])
		for y in range (grid_size.y):
			grid[x].append(null)
			
	var positions = []
	for n in range (5):
		var grid_pos = Vector2(randi() % int(grid_size.x), randi() % int(grid_size.y))
		if not grid_pos in positions:
			positions.append(grid_pos)
	
	for pos in positions:
		var new_object = object.instance()
		new_object.set_position(map_to_world(pos) + half_tile_size)
		grid[pos.x][pos.y] = new_object
		add_child(new_object)
	

func get_cell_contents(child, direction):
	var cell = world_to_map(child.position) + direction
	
	if cell.x < grid_size.x and cell.x >= 0:
		if cell.y < grid_size.y and cell.y >= 0:
			return grid[cell.x][cell.y]

func get_new_position(child, direction):
		var cur_pos = world_to_map(child.get_position())
		grid[cur_pos.x][cur_pos.y] = null

		var new_pos = cur_pos + direction
		grid[new_pos.x][new_pos.y] = child.get_name()
		print (new_pos)
		new_pos = map_to_world(new_pos) + half_tile_size
		return new_pos
		
func set_kill_me(child):
	var cur_pos = world_to_map(child.get_position())
	grid[cur_pos.x][cur_pos.y].queue_free()	
	grid[cur_pos.x][cur_pos.y] = null




#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
