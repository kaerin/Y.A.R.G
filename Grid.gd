extends TileMap

var tile_size = get_cell_size()
var half_tile_size = tile_size / 2

var grid_size = Vector2(50,50)
var grid = []
enum GRID_ITEMS {EMPTY, PLAYER, WALL, ITEM, ENEMY}

const INVALID = -999

onready var enemy = preload("res://Enemies/Enemy.tscn")
onready var item  = preload("res://Items/Item.tscn")
onready var Map = preload("res://Dev/Chris/Label.gd")
var start = Vector2()
var end = Vector2()
var mapgrid

func _ready():
	create_grid()
	var map = Map.new()
	mapgrid = map.map()
	print(mapgrid.size())
	for x in mapgrid.size():
		for y in mapgrid[x].size():
			var i = mapgrid[x][y]
			var j = 0
			if i == "+":
				j = "0"
				grid[x][y] = EMPTY
			elif i == " ":
				j = "1"
				grid[x][y] = WALL
			elif i == "S":
				j = 2
				grid[x][y] = EMPTY
				start = Vector2(x,y)
			elif i == "E":
				j = 3
				grid[x][y] = EMPTY
				end = Vector2(x,y)
			set_cell(x,y,int(j))
		
	
	var Player = get_node("Player")
#	var start_pos = update_child_pos(
	Player.set_position(map_to_world(map.start) + half_tile_size)
	add_enemies(50)
	
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
			if grid[grid_pos.x][grid_pos.y] == EMPTY or grid[grid_pos.x][grid_pos.y] == ITEM:
				return true
			else:
				return false
	return false

func is_cell_enemy(pos, direction = Vector2()):
	var grid_pos = world_to_map(pos) + direction
	if grid_pos.x < grid_size.x and grid_pos.x >= 0:
		if grid_pos.y < grid_size.y and grid_pos.y >= 0:
			return true if grid[grid_pos.x][grid_pos.y] == ENEMY else false
	return false

func get_cell_node(pos, direction  = Vector2()):
	var grid_pos = world_to_map(pos) + direction
	for i in get_children():
		if i.is_in_group("Enemy"):
			if grid_pos == world_to_map(i.get_position()):
				return i

func update_child_pos(child_node):
	var grid_pos = world_to_map(child_node.get_position())
	grid[grid_pos.x][grid_pos.y] = EMPTY
	var new_grid_pos = grid_pos + child_node.direction
	grid[new_grid_pos.x][new_grid_pos.y] = child_node.type
	var target_pos = map_to_world(new_grid_pos) + half_tile_size
	return target_pos

func add_enemies(num = 1):
	var positions = []
	randomize()
	for n in num:
		var grid_pos = Vector2(randi() % int(grid_size.x), randi() % int(grid_size.y))
		while not is_cell_empty(map_to_world(grid_pos)):
			grid_pos = Vector2(randi() % int(grid_size.x), randi() % int(grid_size.y))
		positions.append(grid_pos)
	
	for pos in positions:
		var new_object = enemy.instance()
		new_object.set_position(map_to_world(pos) + half_tile_size)
		add_child(new_object)
		grid[pos.x][pos.y] = new_object.type

func get_item(child): #Returns dropped item
	var grid_pos = world_to_map(child.get_position())
	for i in get_children():
		if i.is_in_group("Item"):
			if grid_pos == world_to_map(i.get_position()):
				grid[grid_pos.x][grid_pos.y] = EMPTY
				var obj = i.item
				i.queue_free()
				return obj

func set_kill_me(child):
	var cur_pos = world_to_map(child.get_position())

	if not child.inventory.empty():
		for object in child.inventory:
			var new_object = item.instance()
			new_object.set_position(map_to_world(cur_pos) + half_tile_size)
			grid[cur_pos.x][cur_pos.y] = ITEM
			new_object.object = object
			if child.weapon.inventory.size(): #if statements because the enemies are currentlly created with only item
				new_object.item = child.weapon.inventory[0] #Fully equipped enemeies carry many items, these needs to change
			elif child.armour.inventory.size():
				new_object.item = child.armour.inventory[0]
			elif child.wearable.inventory.size():
				new_object.item = child.wearable.inventory[0] #Drop a single item			
			add_child(new_object)
	child.queue_free()
