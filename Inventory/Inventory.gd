extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var dic_items = get_parent().get_parent().get_parent().get_node("Dictionaries/Items")

var cur_weapon



func _ready():
	cur_weapon = dic_items.weapon[dic_items.WEAPON.DAGGER]
	pass


func get_damage():
		var damage = randi() % cur_weapon.max_damage + cur_weapon.min_damage
		print(cur_weapon.base_name, ' ',damage, ' damage')
		return(damage)



#TODO temporary basic function for testing chaging weapons
func set_change_weapon():
	if cur_weapon.base_name == "dagger":
		cur_weapon = dic_items.weapon[dic_items.WEAPON.SWORD]
		print('changed to sword')
	else:
		cur_weapon = dic_items.weapon[dic_items.WEAPON.DAGGER]
		print('changed to dagger')