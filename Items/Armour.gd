extends Reference

var Armours = load("res://Items/Armours.gd")
var active = 0
var inventory = []

func _init():
	print("Armour reference initialised, adding t-shirt")
	var a = Armours.new()
	inventory.push_front(a)
	inventory[0].set_name("T-Shirt")
	inventory[0].set_base_type("Chest")
	inventory[0].set_ac(1)

func print():
	print("Executed debug print function from armour class")

func add_armour(item):
	var a = Armours.new()
	inventory.push_front(a)
	inventory[0].set_name(item.base_name)
	inventory[0].set_base_type(item.base_type)
	inventory[0].set_ac(item.armor_class)
	active = active + 1

func get_name(i = active):
	return inventory[i].get_name()

func get_type(i = active):
	return inventory[i].get_base_type()

func equip_armour(i):
	active = i
	
func get_ac():
	return inventory[active].get_ac()
