extends Node

const DEF_IP = '127.0.0.1'
const DEF_PORT = 3117
const MAX_PLAYERS = 10

var players = {}
var data = { name = '', pos = Vector2() }

func create_server(i):
	data.name = i
	players[1] = data
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(DEF_PORT, MAX_PLAYERS)
	get_tree().set_network_peer(peer)
	print("Server created")
	get_tree().connect("network_peer_connected", self, "player_connected")

func join_server(i):
	print("joining server")
	data.name = i
	get_tree().connect('connected_to_server', self, 'connected_to_server')
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(DEF_IP, DEF_PORT)
	get_tree().set_network_peer(peer)

func connected_to_server():
	players[get_tree().get_network_unique_id()] = data
	rpc('send_player_info', get_tree().get_network_unique_id(), data)
	print("connected as client")

func player_connected():
	print("client connected")
	
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
	
	

remote func send_player_pos(id, pos):
	if players.has(id):
		print(players[id].name, pos)
		players[id].pos = pos
#		data.pos = pos
#	get_tree().find_node(id).rect_position(pos)

func send_pos(pos):
	rpc('send_player_pos', get_tree().get_network_unique_id(), pos)