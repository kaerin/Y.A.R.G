extends TileMap

var tile_size = get_cell_size()
var half_tile_size = tile_size / 2
var enemy_factor = 25 #Lower to get more enemies
var grid_size = Vector2()
remote var grid = []

var FLOOR = ["Floor1","Floor2","Floor3","Floor4"]
var ROOF = ["Wall1","Wall2","Wall3","Wall4"]

const INVALID = -999

onready var enemy = preload("res://Enemies/Enemy.tscn")
onready var enemy_dummy = preload("res://Enemies/Enemy_Dummy.tscn")
onready var Admin = preload("res://Admin/Admin.tscn")
onready var item  = preload("res://Items/Item.tscn")
onready var Map = preload("res://Data/MapGen.gd")
onready var GridFloor = get_node("Grids/Floor")
onready var Game = get_node("/root/BaseNode")
onready var Player = get_node("../Player")
onready var Enemies = get_node("Enemies")
var start = Vector2()
var end = Vector2()
var hidden = Vector2()
var found_hidden = false
sync var mapgrid = []
sync var map_levels = [] #FIXME This value shouldnt be used, each node has its own mapgrid, this was used to store all maps
var admin = false
var maxEnemies = 0
var numEnemies = 0
sync var test = "one" #UNUSED?
var level = 0
var add_enemies = false

signal enemy_move
signal data_rcvd #used to wait for data

master func move_enemy():
#	print("moving ", self.name)
	emit_signal('enemy_move')

func _ready():
	if N.levels.has(G.Dlevel):
		print("Set network master to: ", N.levels[G.Dlevel])
		set_network_master(N.levels[G.Dlevel])
	else:
		print("Not setting newtwork master")
		
	if not N.is_connected and not get_tree().is_network_server(): #I dont think this is being used
		yield(N, "peer_connect") #I dont think this is being used
		
	if N.levels.has(G.Dlevel):
		print("Level owner:",N.levels[G.Dlevel])
	map_levels.append(true) #UNUSED?
#	if get_tree().is_network_server():
#		start()
	
#	self.set_network_master(1)
#	print("Calling a function normally")
#	test_master()
#	test_slave()
#	test_remote()
#	test_sync()
#	print("Calling a function with rpc")
#	rpc('test_master')
#	rpc('test_slave')
#	rpc('test_remote')
#	rpc('test_sync')
#
#master func test_master():
#	print("Master function executed")
#slave func test_slave():
#	print("Slave function executesd")
#remote func test_remote():
#	print("Remote function executed")
#sync func test_sync():
#	print("Sync function execute")
sync func set_master():
	set_network_master(get_tree().get_network_unique_id())

func _process(delta):

	if Input.is_action_just_pressed("debug") and not Player.chat_displayed:
		print("id", get_tree().get_network_unique_id())
		print("grid master is: ", self.get_network_master())
		print(N.levels)
		
#	if Input.is_action_just_pressed("admin") and not Player.chat_displayed:
#		if not admin:
#			Player.add_child(Admin.instance())
#			admin = true
#		else:
#			Player.get_node("Admin").queue_free()
#			admin = false

func sync_map():#UNUSED?
	rset("map_levels", map_levels) #UNUSED?

master func send_map():
	print("master sending map")
	var id = get_tree().get_rpc_sender_id()
	rpc_id(id, 'rcv_map', mapgrid)
slave func rcv_map(i):
	print("slave received map")
	mapgrid = i
	emit_signal('data_rcvd') #emit signal once data received
	
func start(startpos = "S"):
	if not N.is_connected and not get_tree().is_network_server():
		print("waiting on connection")
		yield(N, "peer_connect")
	if G.Dlevel < 1:
		print("You are on the surface")
		Player.set_position(map_to_world(Vector2(50,50)) + half_tile_size)
		N.sync_pos(Player.position)
		grid_size = Vector2(100,100)
		create_grid()
		for x in grid_size.x:
			for y in grid_size.y:
				grid[x][y] = Game.EMPTY
				set_cell(x,y,tile_set.find_tile_by_name(FLOOR[randi() % FLOOR.size()]))
#		set_cellv(Vector2(50,50), tile_set.find_tile_by_name("StairDown1"))
#		found_hidden = true
		end = Vector2(50,50)
		rpc("show_stairs")
		return
	var map = Map.new()
	
#	if map_levels.size() <= G.Dlevel:
##		print("generating new map and saving to index:",G.Dlevel)
#		mapgrid = map.map(Vector2(G.Dlevel+6,G.Dlevel+6))
#		self.set_network_master(get_tree().get_network_unique_id()) #Not sure this is the right thing to do
#		N.sync_lvl(get_tree().get_network_unique_id())
#		map_levels.append(mapgrid)
#		rset("map_levels", map_levels)
#	else:
##		print("Using exising map for level:",G.Dlevel)
#		mapgrid = map_levels[G.Dlevel]
#		self.set_network_master(false)#Not sure this is the right thing to do
#	if N.levels.has(G.Dlevel):
#		print("Levels: ",N.levels[G.Dlevel])
	if mapgrid == [] and not N.levels.has(G.Dlevel):# == get_tree().get_network_unique_id(): #and self.get_network_master() == get_tree().get_network_unique_id():
		print("Maps doesnt exists, creating")
		mapgrid = map.map(Vector2(G.Dlevel+6,G.Dlevel+6))
		self.set_network_master(get_tree().get_network_unique_id()) #Not sure this is the right thing to do
#		N.sync_lvl(get_tree().get_network_unique_id())
		N.sync_lvl()
		map_levels.append(mapgrid) #UNUSED?
		add_enemies = true
	else:
		if not N.levels[G.Dlevel] == get_tree().get_network_unique_id():
			print("Map exists at ", self.get_network_master())
			print("sending map")
			rpc('send_map')
			print("waiting for map")
			yield(self,'data_rcvd') #wait for signal to indicate data has been received
		print(mapgrid)
		add_enemies = false
		for i in $Enemies.get_children():
			if i.is_in_group("Enemy"):
				i.show()
	
	if startpos == "E":
		found_hidden = true
#	print(mapgrid)
	grid_size = Vector2(G.Dlevel+6,G.Dlevel+6)
	create_grid()
#	print(mapgrid.size())
	for x in mapgrid.size():
		for y in mapgrid[x].size():
			var i = mapgrid[x][y]
			var j = -1
			if i == "+":
				j = tile_set.find_tile_by_name(FLOOR[randi() % FLOOR.size()])
				grid[x][y] = Game.EMPTY
				maxEnemies += 1
			elif i == " ":
				j = tile_set.find_tile_by_name(ROOF[randi() % ROOF.size()])
				grid[x][y] = Game.WALL
			elif i == "S":
				j = tile_set.find_tile_by_name("StairUp1")
				grid[x][y] = Game.EMPTY
				start = Vector2(x,y)
			elif i == "E":
				j = tile_set.find_tile_by_name(FLOOR[randi() % FLOOR.size()])
				grid[x][y] = Game.EMPTY
				end = Vector2(x,y)
			elif i == "H":
				j = tile_set.find_tile_by_name(FLOOR[randi() % FLOOR.size()])
				GridFloor.set_hidden(Vector2(x,y))
				hidden = Vector2(x,y)
				grid[x][y] = Game.ITEM
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
	N.sync_pos(Player.position)
	if found_hidden == true:
		rpc("show_stairs",G.Dlevel)
#		set_cellv(end, tile_set.find_tile_by_name("StairDown1"))
#	Player.is_moving = false
#	update_child_pos(Player)
	if add_enemies:
		add_enemies()
#	print("grid size",grid_size)
	#TEMP add random enemies for testing
	rpc('get_enemies')
	rpc_id(get_network_master(),'get_grid')

master func get_grid():
	rset_id(get_tree().get_rpc_sender_id(),'grid',grid)

func create_grid():
	grid = []
	for x in grid_size.x:
		grid.append([])
		for y in grid_size.y:
			grid[x].append(null)

func is_cell_empty(pos, direction = Vector2()):
	var grid_pos = world_to_map(pos) + direction
#	print(grid[grid_pos.x][grid_pos.y])
	if G.is_within(grid_pos,grid_size):
#		print("in grid")
#	if grid_pos.x < grid_size.x and grid_pos.x >= 0:
#		if grid_pos.y < grid_size.y and grid_pos.y >= 0:
		if grid[grid_pos.x][grid_pos.y] == Game.EMPTY or grid[grid_pos.x][grid_pos.y] == Game.ITEM:
#			print("return true")
			return true
		else:
#			print("return false")
			return false
	return false

func is_cell_enemy(pos, direction = Vector2()):
	var grid_pos = world_to_map(pos) + direction
	if G.is_within(grid_pos,grid_size):
#	if grid_pos.x < grid_size.x and grid_pos.x >= 0:
#		if grid_pos.y < grid_size.y and grid_pos.y >= 0:
		return true if grid[grid_pos.x][grid_pos.y] == Game.ENEMY else false
	return false

func is_cell_player(pos, direction = Vector2()):
	var grid_pos = world_to_map(pos) + direction
	if G.is_within(grid_pos,grid_size):
#	if grid_pos.x < grid_size.x and grid_pos.x >= 0:
#		if grid_pos.y < grid_size.y and grid_pos.y >= 0:
		return true if grid[grid_pos.x][grid_pos.y] == Game.PLAYER else false
	return false

func get_cell_node(pos, direction  = Vector2()):
	var grid_pos = world_to_map(pos) + direction
	for i in Enemies.get_children():
		if i.is_in_group("Enemy"):
			if grid_pos == world_to_map(i.get_position()):
				return i

func update_child_pos(child_node):
	var grid_pos = world_to_map(child_node.get_position())
	grid[grid_pos.x][grid_pos.y] = Game.EMPTY
	var new_grid_pos = grid_pos + child_node.direction
	grid[new_grid_pos.x][new_grid_pos.y] = child_node.type
	rset('grid',grid)
	var target_pos = map_to_world(new_grid_pos) + half_tile_size
	if child_node.is_in_group("Player"):
		N.sync_pos(target_pos)
#		N.rpc("sending pos", target_pos)
		if new_grid_pos == hidden:
			rpc("show_stairs",G.Dlevel)
#			set_cellv(end, tile_set.find_tile_by_name("Sta
#	if child_node.is_in_group("Enemy"):
#		N.sync_enemy(child_node.get_path(), target_pos)
	return target_pos


sync func show_stairs(i):
	if i == G.Dlevel:
		set_cellv(end, tile_set.find_tile_by_name("StairDown1"))
		found_hidden = true

func chg_level(pos, next = 0):
	var lvlEmpty = false
	for i in N.players:
		if N.players[i].Dlevel == G.Dlevel:
			lvlEmpty = true
			break
	print("Level ", str(G.Dlevel), " empty? ", str(lvlEmpty))
	pos = world_to_map(pos)
	var chg = false
	var spos
	var genmap = true
	
	if (pos == end and found_hidden and not next < 0) or next > 0:
		found_hidden = false
		G.Dlevel += 1
		chg = true
		spos = "S"
	elif (pos == start or next < 0 ) and G.Dlevel > 1: #change 1 to 0 to go to ground level
		found_hidden = true
		G.Dlevel -= 1
		chg = true
		spos = "E"
	if chg:
		for i in $Enemies.get_children():
			if i.is_in_group("Enemy"):
				i.hide()
		N.rpc('sync_dlevel', G.Dlevel)
#		for i in get_children(): #Dont kill enemies
#			if i.is_in_group("Enemy") or i.is_in_group("Item"):
#				i.queue_free()
		self.clear()
		GridFloor.clear()
		Game.chg_lvl(spos)
		Player.chk_grid()


master func add_enemies(num = false):
#	if N.is_server:
	var numEnemies = 0
	for i in Enemies.get_children():
		if i.is_in_group("Enemy"):
			numEnemies += 1
	if numEnemies > maxEnemies:
		return
	if G.Dlevel == 0:
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
		var pos2 = (map_to_world(pos) + half_tile_size)
		new_object.set_position(pos2)
		Enemies.add_child(new_object)
		grid[pos.x][pos.y] = new_object.type
		rset('grid',grid)
		new_object.set_name(new_object.get_name())			#annoying BS that wont work without this. Godot adds @ symbols to instanced names, which dont copy properly when setting same name to another node. 
		
		#Vars for RPC call, only for readability
		var a = new_object.get_name()
		var b = new_object.enemy
		var c = new_object.get_node('Sprite').get_region_rect()
		rpc('server_add_enemies', pos2, a, b, c)
		#var name_ = new_object.get_name()
		#print('new name ' + new_object.get_name())
		#print('sent name ' + name_)

master func get_enemies():
	var id = get_tree().get_rpc_sender_id()
	for i in $Enemies.get_children():
		if i.is_in_group('Enemy'):
			print(i.get_name())
			rpc_id(id, 'server_add_enemies', i.position, i.get_name(), i.enemy, i.get_node('Sprite').get_region_rect())

remote func server_add_enemies(pos2, node_name, enemy, region):
#	print("server add enemies ", node_name)
#	print($Enemies.find_node(node_name,false,false))
	if not $Enemies.find_node(node_name,false,false):
		var new_object = enemy_dummy.instance()
		new_object.enemy = enemy
		new_object.set_position(pos2)
		new_object.set_name(node_name)
		new_object.get_node('Sprite').set_region_rect(region)
		Enemies.add_child(new_object)

func get_item(child): #Returns dropped item
	var grid_pos = world_to_map(child.get_position())
	for i in get_children():
		if i.is_in_group("Item"):
			if grid_pos == world_to_map(i.get_position()):
				grid[grid_pos.x][grid_pos.y] = Game.EMPTY
				rset('grid',grid)
				var obj = i.item
				i.queue_free()
				return obj

func set_kill_me(child):
	var cur_pos = world_to_map(child.get_position())
	GridFloor.set_blood(cur_pos)
	grid[cur_pos.x][cur_pos.y] = Game.EMPTY #Mark grid as empty
	var new_object = item.instance()
	new_object.set_position(map_to_world(cur_pos) + half_tile_size)
	grid[cur_pos.x][cur_pos.y] = Game.ITEM #Mark grid with ITEM
	rset('grid',grid)
	var j = child.inv.find_rnd_item() #.inv. wont work for player only enemy
#	while j.BaseType == G.BaseType.BodyWeap:
#		j = i[randi() % i.size()] #find a non body weapon item
	new_object.item = j
	add_child(new_object)
	rpc('server_kill_me', child.get_name())
	child.queue_free()

remote func server_kill_me(name_):
	print('to kill ' + name_)
	if Enemies.has_node(name_):
		Enemies.get_node(name_).queue_free()

func _on_EnemyTimer_timeout(): #Auto start turned off
	$Enemies/EnemyTimer.wait_time = randi() % 60 + 60
	add_enemies()
