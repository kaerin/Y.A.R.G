extends Node

onready var dic_items = get_parent().get_parent().get_parent().get_node("Dictionaries/Items")

var cur_weapon
var inventory = []
var cur_num = 0

func _ready():
	cur_weapon = dic_items.items[dic_items.ITEMS.FIST]
	pass


func get_damage():
		var damage = randi() % (cur_weapon.max_damage - cur_weapon.min_damage) + cur_weapon.min_damage
		print(cur_weapon.base_name, ' ',damage, ' damage')
		return(damage)


func set_add_item(item):
	if not item == null:
		inventory.append(item)
		print(inventory)
		
func next_weap():
	var size = inventory.size()
	if size:
		cur_num = cur_num + 1
		if cur_num > size:
			cur_num = size
		change_weapon(cur_num)
	
func prev_weap():
	var size = inventory.size()
	if size:
		cur_num = cur_num - 1
		if cur_num < 1:
			cur_num = 1
		change_weapon(cur_num)
	
func change_weapon(num):
	cur_weapon = inventory[num-1]
	print("Weapon: ",cur_weapon.base_name)