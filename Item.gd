extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var grid_map = get_parent()
onready var dic_items = get_parent().get_parent().get_node("Dictionaries/Items").items

var items = {}

func _ready():
	#TODO random instancing of enemies in dictionary
	var rnd_item = randi() % dic_items.size()
	items = dic_items[rnd_item]
	$Label.text = items.base_name
	pass
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
