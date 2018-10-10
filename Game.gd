extends Node

onready var dialog = load("res://Dialog/Msg.tscn")
onready var Stats = load("res://Dialog/Stats.tscn")

var Dialog
var stats


func _ready():
	Dialog = dialog.instance()
	$Grid/Player.add_child(Dialog) #Create then show hide label as needed
	stats = Stats.instance()
	$Grid/Player.add_child(stats) #Create then show hide label as needed
