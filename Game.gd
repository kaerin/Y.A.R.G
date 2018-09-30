extends Node

onready var dialog = load("res://Dialog/Msg.tscn")

var Dialog

func _ready():
	Dialog = dialog.instance()
	$Grid/Player/Camera2D.add_child(Dialog) #Create then show hide label as needed

