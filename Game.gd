extends Node

onready var dialog = load("res://Dialog/Msg.tscn")
onready var Stats = load("res://Dialog/Stats.tscn")
onready var Level = load("res://Map/Grid.tscn")

enum GRID_ITEMS {EMPTY, PLAYER, WALL, ITEM, ENEMY}

var Dialog
var stats


func _ready():
	Dialog = dialog.instance()
	self.add_child(Dialog) #Create then show hide label as needed
	stats = Stats.instance()
	self.add_child(stats) #Create then show hide label as needed
	var level = Level.instance()
	level.name = "Level-1"
	level.level = 1
	self.add_child(level)
	$Player.grid_map = get_node("Level-1")
	$Player.grid_map.start()
	self.set_network_master(get_tree().get_network_unique_id(),false)

func chg_lvl(spos):
	if not has_node("Level-"+str(G.Dlevel)):
		var level = Level.instance()
		level.name = "Level-"+str(G.Dlevel)
		level.level = G.Dlevel
		self.add_child(level)
		$Player.grid_map = get_node("Level-"+str(G.Dlevel))
		$Player.grid_map.start(spos)
	else:
		print("map node exists: ", G.Dlevel)
		$Player.grid_map = get_node("Level-"+str(G.Dlevel))
		$Player.grid_map.start(spos)