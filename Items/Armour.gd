extends Reference

enum	LOC		{CHEST, HEAD, ARMS, LEGS}
var Armours = load("res://Items/Armours.gd")
var active = [0,1,0,0]
var inventory = []

func _init():
	print("Armour reference initialised, adding t-shirt")
	var a = Armours.new()
	inventory.append(a)
	a = Armours.new()
	inventory.append(a)
	inventory[0].set_name("T-Shirt")
	inventory[0].set_location(CHEST)
	inventory[0].set_loc_name("Chest")
	inventory[0].set_ac(1)
	inventory[1].set_name("Hat")
	inventory[1].set_location(HEAD)
	inventory[1].set_loc_name("Head")
	inventory[1].set_ac(1)

func print():
	print("Executed debug print function from armour class")

func add_armour(item):
	var a = Armours.new()
	inventory.push_front(a)
	inventory[0].set_name(item.base_name)
	inventory[0].set_location(item.location)
	inventory[0].set_loc_name(item.loc_name)
	inventory[0].set_ac(item.armor_class)
	active[CHEST] = active[CHEST] + 1 #hack, dumb way of doing it, dont repeat, use an index
	active[HEAD] = active[HEAD] + 1 #hack, dumb way of doing it, dont repeat, use an index

func get_name(i):
	return inventory[i].get_name()

func get_location(i):
	return inventory[i].get_location()

func get_loc_name(i):
	return inventory[i].get_loc_name()

func equip_armour(loc, i):
	active[loc] = i

func get_equip_name(loc):
	return get_name(get_equip(loc))

func get_equip(loc):
	return active[loc]

func get_ac():
	return inventory[active].get_ac()
