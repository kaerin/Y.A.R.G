extends VBoxContainer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var inventory = get_parent().get_parent().get_parent() 
onready var item_label = get_parent().get_parent().get_parent().get_node("Template/Item")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass


func add_to_equipped(item):
	var add_item = item_label.duplicate()
	add_child(add_item)
	$Item/Text.text = item.Name
	add_item.show()
	return true


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
