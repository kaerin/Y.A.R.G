extends Node

var DEF_IP = '127.0.0.1'
const DEF_PORT = 3117
const MAX_PLAYERS = 10

var is_connected = false
var is_server = false
var is_client = false
var players = {}	#this represents all connected players, "Others" is for visual representation on grid ?
var data = { name = '', pos = Vector2(), Dlevel = 0 }

#creates server with following ip address and port ?
#..Only port is needed the ip address is itself
func _ready():
	get_tree().connect("network_peer_connected", self, "player_connected")
	get_tree().connect("network_peer_disconnected", self, "player_disconnected")
	get_tree().connect('connected_to_server', self, 'connected_to_server')
	get_tree().connect('connection_failed', self, 'connection_failed')
	get_tree().connect('server_disconnected', self, 'server_disconnected')

func _process(delta):
	if Input.is_action_just_pressed("debug") and not get_node("/root/BaseNode/Grid/Player/").chat_displayed:
		print(players)

func create_server(i):
	is_server = true
	data.name = i
	data.Dlevel = 0
	players[1] = data
	players[0] = data
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(DEF_PORT, MAX_PLAYERS)
	get_tree().set_network_peer(peer)
	
#Joins server and calls "connected to server" method once connected
#..emits the signal connected_to_server
func join_server(i):
	is_client = true
	data.name = i
	players[0] = data
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(DEF_IP, DEF_PORT)
	get_tree().set_network_peer(peer)

#connected client then executes sendplayerinfo method in all clients ?
#..and adds data to its own array of players
func connected_to_server():
	print("Connected to server")
	players[get_tree().get_network_unique_id()] = data
	is_connected = true
	get_node("/root/BaseNode/Grid").start()
#	rpc_id(1,'get_grid',G.Dlevel)
#	get_node("/root/BaseNode/Grid").sync_map()
#	rpc('send_player_info', get_tree().get_network_unique_id(), data)
#	print("connected as client")

#remote func get_grid(level):
#	var grid = get_node("/root/BaseNode/Grid")
#	rpc_id(get_tree().get_rpc_sender_id(), 'set_grid', grid.map_levels[level])
#remote func set_grid(data):
#	var grid = get_node("/root/BaseNode/Grid")
#	grid.
#remote func get_map(data):
#	var player = get_node("/root/BaseNode/Grid")
##	print(data)
#	player.map_levels.append(data)
#	player.start("S")

func player_connected(id):
	print("This client connected to us ", id)
	players[id] = data
	is_connected = true
	rpc_id(id, 'sending_pos', data.pos)
	rpc_id(id, 'get_player', id)
	if get_tree().is_network_server():
		get_node("/root/BaseNode/Grid").sync_map()
#	get_node("/root/BaseNode/Grid").start()
#		rpc_id(id, 'get_map', get_node("/root/BaseNode/Grid").map_levels[G.Dlevel])
	
	var other = load("res://Player/Others.tscn").instance()
	other.name = str(id)
	get_node("/root/BaseNode").add_child(other)
	other.id = id
	other.init(players[id])

remote func get_player(id):
	rpc_id(get_tree().get_rpc_sender_id(), 'set_player', id, players[id])
remote func set_player(id, data):
	players[id] = data

func player_disconnected(id):
	print("This client disconnected ", id)
	players.erase(id)
	var i = get_node("/root/BaseNode/"+str(id))
	if i:
		i.queue_free()

func connection_failed():
	print("Connection failed")
func server_disconnected():
	print("Server disconnected")
	is_connected = false

func sync_pos(pos):
	data.pos = pos
	rpc('syncing_pos', pos)
remote func syncing_pos(pos):
	var id = get_tree().get_rpc_sender_id()
#	print(id, pos)
	players[id].pos  = pos
	
#func sync_enemy(child, pos):
#	rpc('syncing_enemy', child, pos)
#remote func syncing_enemy(child, pos):
#	get_node(child).position = pos

func sync_dlevel(i):
	data.Dlevel = i
	rpc('syncing_dlevel', i)
remote func syncing_dlevel(i):
	var id = get_tree().get_rpc_sender_id()
	print("dlevel", id, "-", i)
	players[id].Dlevel = i


#	rpc('remove_player',id)
#
#sync func remove_player(id):
#	print("removing player ",id)
#	players.erase(id)
#	var i = get_node("/root/BaseNode/"+str(id))
#	if i:
#		i.queue_free()
#	print("players: ",players)
	
#this sends back all each players data to requesting client.
#shouldnt this just send just self data to requesting client, not everyones data ?	
#doesnt this result in a loop with each request triggering another request ?
#..not a loop only the server sends all the data out the rest just update the players array
#..the server wont call itself because its can only be called remotely

#function also adds another "other player" instance ?
#..this is simple way so each client can visualise the data

remote func send_player_info(id, info): #remote can only be called by remote clients
	pass
#	print("send player info ", id, " ", info)
#	players[id] = info #everyone updates players array
#	if get_tree().is_network_server(): #is network server
#		for peer_id in players:
#			print("Sending to ", peer_id, " data ", players[peer_id])
#			rpc('send_player_info', peer_id, players[peer_id]) #since only the server can call the function and it cant call itself there is no look

#	print("players: ",players)
#	if not id == get_tree().get_network_unique_id():
#		var other = load("res://Player/Others.tscn").instance()
#		other.name = str(id)
#	#	other.set_network_master(id)
#		get_node("/root/BaseNode").add_child(other)
#		other.id = id
#		other.init(info)
	
	

#updates clients position locally  ?
#..this is called by the function below to updates its own players array
#..the others node reads this data to show it visually
remote func send_player_pos(id, pos):
	pass
#	if players.has(id):
#		print("Remote player ", players[id].name, " moved ", pos)
#		players[id].pos = pos

#sends self updated pos data to all clients to update ?
#..send player position to all clients, see above, this updates all the remote client with with clients position

	
	
	
#a simialr thing could probably done with rset
#functions can be remote, sync, master or slave. 
#I dont understand the setup fully, I think some stuff is wrong
func send_chat(text):
	rpc('chat_msg', text)

sync func chat_msg(text):
	var from = N.players[get_tree().get_rpc_sender_id()].name
	var msg = from + ': ' + text
	print(msg)
	get_node("/root/BaseNode").Dialog.set_label_window(msg, true)
