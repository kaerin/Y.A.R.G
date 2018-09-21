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


	#TODO random object placement for testing
	var positions = []
	randomize()
	
	for n in range (5):
		var grid_pos = Vector2(randi() % int(grid_size.x), randi() % int(grid_size.y))
		if not grid_pos in positions:
			positions.append(grid_pos)
	
	for pos in positions:
		var new_object = object.instance()
		new_object.set_position(map_to_world(pos) + half_tile_size)
		grid[pos.x][pos.y] = new_object
		add_child(new_object)




func is_target_inside_grid(child, direction):
	var cur_pos = world_to_map(child.get_position())
	var new_pos = cur_pos + direction
	if new_pos.x < grid_size.x and new_pos.x >= 0:
		if new_pos.y < grid_size.y and new_pos.y >= 0:
			return true
	
func get_cell_contents(child, direction):
	var cell = world_to_map(child.position) + direction
	
	if cell.x < grid_size.x and cell.x >= 0:
		if cell.y < grid_size.y and cell.y >= 0:
			return grid[cell.x][cell.y]

func get_new_position(child, direction):
		var cur_pos = world_to_map(child.get_position())
		grid[cur_pos.x][cur_pos.y] = null

		var new_pos = cur_pos + direction
		grid[new_pos.x][new_pos.y] = child
		new_pos = map_to_world(new_pos) + half_tile_size
		return new_pos




func set_kill_me(child):
	var cur_pos = world_to_map(child.get_position())
	grid[cur_pos.x][cur_pos.y].queue_free()	
	grid[cur_pos.x][cur_pos.y] = null
			



func set_enemy_move():
	var children = get_children()
	var children_enemy = []
	
	for enemy in children:
		if enemy.is_in_group("Enemy"):
			children_enemy.append(enemy)
			
	for enemy in children_enemy:
		enemy.set_move()
	