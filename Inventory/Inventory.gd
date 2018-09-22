extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var dic_items = get_parent().get_parent().get_parent().get_node("Dictionaries/Items")

var cur_weapon
var inventory = []



func _ready():
	cur_weapon = dic_items.items[dic_items.ITEMS.DAGGER]
	pass


func get_damage():
		var damage = randi() % (cur_weapon.max_damage - cur_weapon.min_damage) + cur_weapon.min_damage
		print(cur_weapon.base_name, ' ',damage, ' damage')
		return(damage)


func set_add_item(item):
	if not item == null:
		inventory.append(item)
		print(inventory)