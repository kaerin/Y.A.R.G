extends Node

onready var dialog = load("res://Dialog/Msg.tscn")

var Dialog

func _ready():
	Dialog = dialog.instance()
	$Grid/Player.add_child(Dialog) #Create then show hide label as needed

