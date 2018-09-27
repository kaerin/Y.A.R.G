extends Node

signal display

func _ready():
	var i = 0
	while true:
		i += 1
		$Label.text = str(i)
		yield(get_node("Label"), "drawn")