extends Node

const DEF_IP = '127.0.0.1'
const DEF_PORT = 3117
const MAX_PLAYERS = 10

var players = {}	#this represents all connected players, "Others" is for visual representation on grid ?
var data = { name = '', pos = Vector2() }

#creates server with following ip address and port ?
#..Only port is needed the ip address is itself
func _ready():
	get_tree().connect("network_peer_connected", self, "player_connected")
	get_tree().connect("network_peer_disconnected", self, "player_disconnected")

func create_server(i):
	data.name = i
	players[1] = data
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(DEF_PORT, MAX_PLAYERS)
	get_tree().set_network_peer(peer)
	print("Server created")
	
#Joins server and calls "connected to server" method once connected
#..emits the signal connected_to_server
func join_server(i):
	print("joining server")
	data.name = i
	get_tree().connect('connected_to_server', self, 'connected_to_server')
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(DEF_IP, DEF_PORT)
	get_tree().set_network_peer(peer)

#connected client then executes sendplayerinfo method in all clients ?
#..and adds data to its own array of players
func connected_to_server():
	players[get_tree().get_network_unique_id()] = data
	rpc('send_player_info', get_tree().get_network_unique_id(), data)
	print("connected as client")

func player_connected(id):
	print("client connected ", id)
	

func player_disconnected(id):
	print("client disconnected ", id)
	rpc('remove_player',id)

sync func remove_player(id):
	print("removing player ",id)
	players.erase(id)
	var i = get_node("/root/BaseNode/"+str(id))
	if i:
		i.queue_free()
	
#this sends back all each players data to requesting client.
#shouldnt this just send just self data to requesting client, not everyones data ?	
#doesnt this result in a loop with each request triggering another request ?
#..not a loop only the server sends all the data out the rest just update the players array
#..the server wont call itself because its can only be called remotely

#function also adds another "other player" instance ?
#..this is simple way so each client can visualise the data

remote func send_player_info(id, info): #remote can only be called by remote clients
#	print(info.name)
	if get_tree().is_network_server(): #is network server
		for peer_id in players:
			rpc_id(id, 'send_player_info', peer_id, players[peer_id]) #since only the server can call the function and it cant call itself there is no look
	players[id] = info #everyone updates players array
	
	var other = load("res://Player/Others.tscn").instance()
	other.name = str(id)
#	other.set_network_master(id)
	get_node("/root/BaseNode").add_child(other)
	other.id = id
	other.init(info)
	
	

#updates clients position locally  ?
#..this is called by the function below to updates its own players array
#..the others node reads this data to show it visually
remote func send_player_pos(id, pos):
	if players.has(id):
		print(players[id].name, pos)
		players[id].pos = pos
#		data.pos = pos
#	get_tree().find_node(id).rect_position(pos)

#sends self updated pos data to all clients to update ?
#..send player position to all clients, see above, this updates all the remote client with with clients position
func send_pos(pos):
	rpc('send_player_pos', get_tree().get_network_unique_id(), pos)
	
	
#a simialr thing could probably done with rset
#functions can be remote, sync, master or slave. 
#I dont understand the setup fully, I think some stuff is wrong

