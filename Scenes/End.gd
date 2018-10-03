extends Node

func _ready():
	G.level = 0

func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Start.tscn")
