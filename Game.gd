extends Node

onready var dialog = load("res://Dialog/Msg.tscn")
onready var Stats = load("res://Dialog/Stats.tscn")
onready var Level = load("res://Map/Grid.tscn")

var Dialog
var stats
var level


func _ready():
	Dialog = dialog.instance()
	self.add_child(Dialog) #Create then show hide label as needed
	stats = Stats.instance()
	self.add_child(stats) #Create then show hide label as needed
	level = Level.instance()
	level.name = "Level-" + str(G.Dlevel)
	self.add_child(level)