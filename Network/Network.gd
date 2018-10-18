extends Node

const DEF_IP = '127.0.0.1'
const DEF_PORT = 3117
const MAX_PLAYERS = 10

var players = {}	#this represents all connected players, "Others" is for visual representation on grid ?
var data = { name = '', pos = Vector2() }

#creates server with following ip address and port ?
func create_server(i):
	data.name = i
	players[1] = data
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(DEF_PORT, MAX_PLAYERS)
	get_tree().set_network_peer(peer)
	print("Server created")
	get_tree().connect("network_peer_connected", self, "player_connected")

#Joins server and calls "connected to server" method once connected
func join_server(i):
	print("joining server")
	data.name = i
	get_tree().connect('connected_to_server', self, 'connected_to_server')
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(DEF_IP, DEF_PORT)
	get_tree().set_network_peer(peer)

#connected client then executes sendplayerinfo method in all clients ?
func connected_to_server():
	players[get_tree().get_network_unique_id()] = data
	rpc('send_player_info', get_tree().get_network_unique_id(), data)
	print("connected as client")

func player_connected():
	print("client connected")
	
#this sends back all each players data to requesting client.
#shouldnt this just send just self data to requesting client, not everyones data ?	
#doesnt this result in a loop with each request triggering another request ?

#function also adds another "other player" instance ?

remote func send_player_info(id, info):
	print(info.name)
	if get_tree().is_network_server():
		for peer_id in players:
			rpc_id(id, 'send_player_info', peer_id, players[peer_id])
	players[id] = info
	
	var other = load("res://Player/Others.tscn").instance()
	other.name = str(id)
	other.set_network_master(id)
	get_node("/root/BaseNode").add_child(other)
	other.id = id
	other.init(info)
	
	

#updates clients position locally  ?
remote func send_player_pos(id, pos):
	if players.has(id):
		print(players[id].name, pos)
		players[id].pos = pos
#		data.pos = pos
#	get_tree().find_node(id).rect_position(pos)

#sends self updated pos data to all clients to update ?
func send_pos(pos):
	rpc('send_player_pos', get_tree().get_network_unique_id(), pos)