extends TileMap

var tile_size = get_cell_size()
var half_tile_size = tile_size / 2
var enemy_factor = 25 #Lower to get more enemies
var grid_size = Vector2()
var grid = []
enum GRID_ITEMS {EMPTY, PLAYER, WALL, ITEM, ENEMY}
var FLOOR = ["Floor1","Floor2","Floor3","Floor4"]
var ROOF = ["Wall1","Wall2","Wall3","Wall4"]

const INVALID = -999

onready var enemy = preload("res://Enemies/Enemy.tscn")
onready var Admin = preload("res://Admin/Admin.tscn")
onready var item  = preload("res://Items/Item.tscn")
onready var Map = preload("res://Data/MapGen.gd")
onready var GridFloor = get_node("../GridFloor")
onready var Game = get_node("/root/BaseNode")
var start = Vector2()
var end = Vector2()
var hidden = Vector2()
var found_hidden = false
var mapgrid
var map_levels = []
var admin = false
var maxEnemies = 0
var numEnemies = 0

func _ready():
	start()
	
func _process(delta):
	if Input.is_action_just_pressed("admin"):
		if not admin:
			$Player.add_child(Admin.instance())
			admin = true
		else:
			$Player/Admin.queue_free()
			admin = false
	

func start(startpos = "S"):
	var Player = get_node("Player")
	if Game.stats:
		Game.stats.set_dungeon(G.Dlevel)
	if G.Dlevel < 0:
		print("You are on the surface")
		Player.set_position(map_to_world(Vector2(50,50)) + half_tile_size)
		grid_size = Vector2(100,100)
		create_grid()
		for x in grid_size.x:
			for y in grid_size.y:
				grid[x][y] = EMPTY
				set_cell(x,y,tile_set.find_tile_by_name(FLOOR[randi() % FLOOR.size()]))
		set_cellv(Vector2(50,50), tile_set.find_tile_by_name("StairDown1"))
		found_hidden = true
		end = Vector2(50,50)
		return
	var map = Map.new()
	if map_levels.size() <= G.Dlevel:
#		print("generating new map and saving to index:",G.Dlevel)
		mapgrid = map.map(Vector2(G.Dlevel+6,G.Dlevel+6))
		map_levels.append(mapgrid)
	else:
#		print("Using exising map for level:",G.Dlevel)
		mapgrid = map_levels[G.Dlevel]
		found_hidden = true
	grid_size = Vector2(G.Dlevel+6,G.Dlevel+6)
	create_grid()
#	print(mapgrid.size())
	for x in mapgrid.size():
		for y in mapgrid[x].size():
			var i = mapgrid[x][y]
			var j = -1
			if i == "+":
				j = tile_set.find_tile_by_name(FLOOR[randi() % FLOOR.size()])
				grid[x][y] = EMPTY
				maxEnemies += 1
			elif i == " ":
				j = tile_set.find_tile_by_name(ROOF[randi() % ROOF.size()])
				grid[x][y] = WALL
			elif i == "S":
				j = tile_set.find_tile_by_name("StairUp1")
				grid[x][y] = EMPTY
				start = Vector2(x,y)
			elif i == "E":
				j = tile_set.find_tile_by_name(FLOOR[randi() % FLOOR.size()])
				grid[x][y] = EMPTY
				end = Vector2(x,y)
			elif i == "H":
				j = tile_set.find_tile_by_name(FLOOR[randi() % FLOOR.size()])
				GridFloor.set_hidden(Vector2(x,y))
				hidden = Vector2(x,y)
				grid[x][y] = ITEM
			set_cell(x,y,int(j))
	for x in [-1,mapgrid.size()]:
		for y in range(-1,mapgrid[0].size()+1):
			set_cell(x,y,tile_set.find_tile_by_name(ROOF[randi() % ROOF.size()]))
	for y in [-1,mapgrid[0].size()]:
		for x in range(0,mapgrid.size()):
			set_cell(x,y,tile_set.find_tile_by_name(ROOF[randi() % ROOF.size()]))
	maxEnemies /= 2
	
	
#	var start_pos = update_child_pos(
	if startpos == "S":
		Player.set_position(map_to_world(start) + half_tile_size)
	if startpos == "E":
		Player.set_position(map_to_world(end) + half_tile_size)
	if found_hidden == true:
		set_cellv(end, tile_set.find_tile_by_name("StairDown1"))
#	Player.is_moving = false
#	update_child_pos(Player)
	add_enemies()
#	print("grid size",grid_size)
	#TEMP add random enemies for testing

func create_grid():
	grid = []
	for x in grid_size.x:
		grid.append([])
		for y in grid_size.y:
			grid[x].append(null)

func is_cell_empty(pos, direction = Vector2()):
	var grid_pos = world_to_map(pos) + direction
	if G.is_within(grid_pos,grid_size):
#	if grid_pos.x < grid_size.x and grid_pos.x >= 0:
#		if grid_pos.y < grid_size.y and grid_pos.y >= 0:
		if grid[grid_pos.x][grid_pos.y] == EMPTY or grid[grid_pos.x][grid_pos.y] == ITEM:
			return true
		else:
			return false
	return false

func is_cell_enemy(pos, direction = Vector2()):
	var grid_pos = world_to_map(pos) + direction
	if G.is_within(grid_pos,grid_size):
#	if grid_pos.x < grid_size.x and grid_pos.x >= 0:
#		if grid_pos.y < grid_size.y and grid_pos.y >= 0:
		return true if grid[grid_pos.x][grid_pos.y] == ENEMY else false
	return false

func is_cell_player(pos, direction = Vector2()):
	var grid_pos = world_to_map(pos) + direction
	if G.is_within(grid_pos,grid_size):
#	if grid_pos.x < grid_size.x and grid_pos.x >= 0:
#		if grid_pos.y < grid_size.y and grid_pos.y >= 0:
		return true if grid[grid_pos.x][grid_pos.y] == PLAYER else false
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
	if child_node.is_in_group("Player"):
		if new_grid_pos == hidden:
			set_cellv(end, tile_set.find_tile_by_name("StairDown1"))
			found_hidden = true
	
	return target_pos

func chg_level(pos, next = 0):
	pos = world_to_map(pos)
	var chg = false
	var spos
	var genmap = true
	if (pos == end and found_hidden and not next < 0) or next > 0:
		found_hidden = false
		G.Dlevel += 1
		chg = true
		spos = "S"
	elif (pos == start or next < 0 ) and G.Dlevel > -1:
		found_hidden = true
		G.Dlevel -= 1
		chg = true
		spos = "E"
	if chg:
		for i in get_children():
			if i.is_in_group("Enemy") or i.is_in_group("Item"):
				i.queue_free()
		self.clear()
		GridFloor.clear()
		start(spos)


func add_enemies(num = false):
	var numEnemies = 0
	for i in get_children():
		if i.is_in_group("Enemy"):
			numEnemies += 1
	if numEnemies > maxEnemies:
		return
	if G.Dlevel == -1:
		return
	if not num:
		num = int(grid_size.x*grid_size.y/enemy_factor)
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
	GridFloor.set_blood(cur_pos)
	grid[cur_pos.x][cur_pos.y] = EMPTY #Mark grid as empty
	var new_object = item.instance()
	new_object.set_position(map_to_world(cur_pos) + half_tile_size)
	grid[cur_pos.x][cur_pos.y] = ITEM #Mark grid with ITEM
	var j = child.inv.find_rnd_item() #.inv. wont work for player only enemy
#	while j.BaseType == G.BaseType.BodyWeap:
#		j = i[randi() % i.size()] #find a non body weapon item
	new_object.item = j
	add_child(new_object)
			
	child.queue_free()


func _on_EnemyTimer_timeout():
	$EnemyTimer.wait_time = randi() % 10 + 10
	add_enemies()
