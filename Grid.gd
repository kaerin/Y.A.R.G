extends TileMap

var tile_size = get_cell_size()
var half_tile_size = tile_size / 2

var grid_size = Vector2(8,8)
var grid = []
var Dialog

const INVALID = -999

onready var enemy = preload("res://Enemies/Enemy.tscn")
onready var item  = preload("res://Items/Item.tscn")
onready var dialog = preload("res://Dialog/Msg.tscn")

func _ready():
	Dialog = dialog.instance()
	add_child(Dialog) #Create then show hide label as needed
	for x in range (grid_size.x):
		grid.append([])
		for y in range (grid_size.y):
			grid[x].append([])
	add_enemies(3)

	#TEMP add random enemies for testing

func add_enemies(num = 1):
	var positions = []
	randomize()
	for n in range (num):
		var grid_pos = Vector2(randi() % int(grid_size.x), randi() % int(grid_size.y))
		if not grid_pos in positions:
			positions.append(grid_pos)
	
	for pos in positions:
		var new_object = enemy.instance()
		new_object.set_position(map_to_world(pos) + half_tile_size)
		grid[pos.x][pos.y].append(new_object)
		add_child(new_object)

func is_target_grid_valid(child, direction):
	var new_pos = world_to_map(child.get_position()) + direction
	if new_pos.x < grid_size.x and new_pos.x >= 0:
		if new_pos.y < grid_size.y and new_pos.y >= 0:
			return true
	
func has_target_grid_obsticle(child, direction):
		var new_pos = world_to_map(child.position) + direction
		if not grid[new_pos.x][new_pos.y].empty():
			for obsticle in grid[new_pos.x][new_pos.y]:
				if obsticle.is_in_group("Player") or obsticle.is_in_group("Enemy"):
			 		return obsticle


func set_new_grid_pos(child, direction):
		#delete old positon
		var cur_pos = world_to_map(child.get_position())
		var child_idx = grid[cur_pos.x][cur_pos.y].find(child)
		grid[cur_pos.x][cur_pos.y].remove(child_idx)
		
		#grid[cur_pos.x][cur_pos.y] = null
		#set new positon
		var new_pos = cur_pos + direction
		grid[new_pos.x][new_pos.y].append(child)
		new_pos = map_to_world(new_pos) + half_tile_size
		return new_pos


func get_item(child):
	var cur_pos = world_to_map(child.get_position())
	if not grid[cur_pos.x][cur_pos.y].empty():
		#print (grid[cur_pos.x][cur_pos.y].size())
		for object in grid[cur_pos.x][cur_pos.y]:
			if object.is_in_group("Item"):
				var item = object.object
				grid[cur_pos.x][cur_pos.y].remove(grid[cur_pos.x][cur_pos.y].find(object))
				object.queue_free()
				return item

func set_kill_me(child):
	var cur_pos = world_to_map(child.get_position())
	
	if not child.inventory.empty():
		for object in child.inventory:
			var new_object = item.instance()
			new_object.set_position(map_to_world(cur_pos) + half_tile_size)
			grid[cur_pos.x][cur_pos.y].append(new_object)
			new_object.object = object			
			add_child(new_object)

	var child_idx = grid[cur_pos.x][cur_pos.y].find(child)
	grid[cur_pos.x][cur_pos.y][child_idx].queue_free()
	grid[cur_pos.x][cur_pos.y].remove(child_idx)
			


#After player action, trigger all enemies to move
func set_enemy_move():
	var children = get_children()	
	for child in children:
		if child.is_in_group("Enemy"):
			child.set_move()
	