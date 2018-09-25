extends Node

onready var dialog = preload("res://Dialog/Msg.tscn")

var Dialog

func _ready():
	Dialog = dialog.instance()
	add_child(Dialog) #Create then show hide label as needed
