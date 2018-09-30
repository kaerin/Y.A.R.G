extends Reference

var Armours = load("res://Items/Armours.gd")
var active = [0,1,0,0]
var inventory = []

func _init(i):
	if i == G.CHAR.ENEMY:
		pass
#		print("New enemy armour class")
	elif i == G.CHAR.PLAYER:
		print("Armour reference initialised, adding t-shirt")
		var a = Armours.new()
		inventory.append(a)
		a = Armours.new()
		inventory.append(a)
		inventory[0].set_name("T-Shirt")
		inventory[0].set_mat(G.Mat.Cloth)
		inventory[0].set_location(G.LOC.CHEST)
		inventory[0].set_loc_name(G.Loc.Chest)
		inventory[0].set_ac(1)
		inventory[1].set_name("Hat")
		inventory[1].set_mat(G.Mat.Cloth)
		inventory[1].set_location(G.LOC.HEAD)
		inventory[1].set_loc_name(G.Loc.Head)
		inventory[1].set_ac(1)
		#inventory[1].add_to_group("Armour")
		
func print():
	print("Executed debug print function from armour class")

func collect_armour(item):
	inventory.push_front(item)
	active[G.LOC.CHEST] += 1 #hack, dumb way of doing it, dont repeat, use an index
	active[G.LOC.HEAD] += 1 #hack, dumb way of doing it, dont repeat, use an index
func add_armour(item, i = false):
	var a = Armours.new()
	inventory.push_front(a)
	inventory[0].set_name(item.base_name)
	inventory[0].set_mat(item.base_name)
	inventory[0].set_location(item.location)
	inventory[0].set_loc_name(item.loc_name)
	inventory[0].set_ac(item.armor_class)
	#inventory[0].add_to_group("Armour")
	active[G.LOC.CHEST] += 1 #hack, dumb way of doing it, dont repeat, use an index
	active[G.LOC.HEAD] += 1 #hack, dumb way of doing it, dont repeat, use an index
	if i:
		alter_stats(0,10)

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

func get_ac(loc):
	return inventory[get_equip(loc)].get_ac() #needs fixing
func get_armour_ac(loc):
	return inventory[get_equip(loc)].get_armour_ac() #needs fixing
func get_bonus_ac(loc):
	return inventory[get_equip(loc)].get_bonus_ac() #needs fixing


func alter_stats(i,rng):
	var pre = ["Rusted", "Shiny", "Glowing", "Sparkly", "Red", "Golden", "Crappy", "Normal", "Mood"]
	var post = ["of brightness.", "of spikes", "of gas", "that glows", "of colors", "that tastes funny"]
	inventory[0].set_name(pre[randi() % pre.size()] + " " + get_name(0) + " " + post[randi() % post.size()])
	inventory[0].set_bonus_ac(randi() % rng)