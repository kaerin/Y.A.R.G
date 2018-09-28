extends TileMap

var tile_size = get_cell_size()
var half_tile_size = tile_size / 2

var grid_size = Vector2(16,16)
var grid = []
enum GRID_ITEMS {PLAYER, WALL, ITEM, ENEMY}

const INVALID = -999

onready var enemy = preload("res://Enemies/Enemy.tscn")
onready var item  = preload("res://Items/Item.tscn")
onready var Map = preload("res://Dev/Chris/Label.gd")
var start = Vector2()
var end = Vector2()

func _ready():
	create_grid()
	var map = Map.new()
	var mapgrid = map.map()
	print(mapgrid.size())
	for x in mapgrid.size():
		for y in mapgrid[x].size():
			var i = mapgrid[x][y]
			if i == "+":
				i = 0
			elif i == " ":
				i = 1
				grid[x][y] = "WALL"
			elif i == "S":
				i = 2
				start = Vector2(x,y)
			elif i == "E":
				i = 3
				end = Vector2(x,y)
			set_cell(x,y,int(i))
		
	add_enemies(3)
	var Player = get_node("Player")
#	var start_pos = update_child_pos(
	Player.set_position(map_to_world(map.start) + half_tile_size)

	#TEMP add random enemies for testing

func create_grid():
	for x in grid_size.x:
		grid.append([])
		for y in grid_size.y:
			grid[x].append(null)

func is_cell_empty(pos, direction = Vector2()):
	var grid_pos = world_to_map(pos) + direction
	if grid_pos.x < grid_size.x and grid_pos.x >= 0:
		if grid_pos.y < grid_size.y and grid_pos.y >= 0:
			return true if grid[grid_pos.x][grid_pos.y] == null else false
	return false

func update_child_pos(child_node):
	var grid_pos = world_to_map(child_node.get_position())
	grid[grid_pos.x][grid_pos.y] = null
	var new_grid_pos = grid_pos + child_node.direction
	grid[new_grid_pos.x][new_grid_pos.y] = child_node.type
	var target_pos = map_to_world(new_grid_pos) + half_tile_size
	return target_pos

func add_enemies(num = 1):
	var positions = []
	for n in num:
		var grid_pos = Vector2(randi() % int(grid_size.x), randi() % int(grid_size.y))
		print(grid_pos)
#		while not is_cell_empty(grid_pos):
#			print(grid_pos)
#			grid_pos = Vector2(randi() % int(grid_size.x), randi() % int(grid_size.y))
		print(grid_pos)
		positions.append(grid_pos)
	
	for pos in positions:
		var new_object = enemy.instance()
		new_object.set_position(map_to_world(pos) + half_tile_size)
		add_child(new_object)
		grid[pos.x][pos.y] = new_object.type
		

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

func set_grid_pos(e, pos):
	print("setting position ", pos)
	var cur_pos = world_to_map(e.get_position())
	var child_idx = grid[cur_pos.x][cur_pos.y].find(e)
	grid[cur_pos.x][cur_pos.y].remove(child_idx)
	grid[pos.x][pos.y].append(e)
	pos = map_to_world(pos) + half_tile_size
	pass

func set_new_grid_pos(child, direction):
	print("change position ",child.name)
	#delete old positon
	var cur_pos = world_to_map(child.get_position())
#	var child_idx = grid[cur_pos.x][cur_pos.y].find(child)
#	grid[cur_pos.x][cur_pos.y].remove(child_idx)
	
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

func get_item2(child): #Returns dropped item
	var cur_pos = world_to_map(child.get_position())
	if not grid[cur_pos.x][cur_pos.y].empty():
		#print (grid[cur_pos.x][cur_pos.y].size())
		for object in grid[cur_pos.x][cur_pos.y]:
			return object.item

func set_kill_me(child):
	var cur_pos = world_to_map(child.get_position())
	
	if not child.inventory.empty():
		for object in child.inventory:
			var new_object = item.instance()
			new_object.set_position(map_to_world(cur_pos) + half_tile_size)
			grid[cur_pos.x][cur_pos.y].append(new_object)
			new_object.object = object
			if child.weapon.inventory.size(): #if statements because the enemies are currentlly created with only item
				new_object.item = child.weapon.inventory[0] #Fully equipped enemeies carry many items, these needs to change
			elif child.armour.inventory.size():
				new_object.item = child.armour.inventory[0]
			elif child.wearable.inventory.size():
				new_object.item = child.wearable.inventory[0] #Drop a single item			
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
	