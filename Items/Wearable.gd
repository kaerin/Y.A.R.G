extends Reference

var Wearables = load("res://Items/Wearables.gd")
var active_amulet = 0
var active_ring = 1
var inventory = []

func _init(i):
	if i == G.CHAR.ENEMY:
		pass
	elif i == G.CHAR.PLAYER:
		print("Wearable reference initialised, adding large plastic clock amulet")
		var w = Wearables.new()
		inventory.append(w)
		inventory[0].set_name("Clock Amulet of the 80s")
		inventory[0].set_type(G.WearType.Amulet)
		inventory[0].set_bonus_ac(-1)
		w = Wearables.new()
		inventory.append(w)
		inventory[1].set_name("no ring")
		inventory[1].set_type(G.WearType.Ring)

func print():
	print("Executed debug print function from wearable class")

#Each item type has its own class: wepaon, armour, misc
#Weapons class contain weapons in inventory
#Repeat class for armor

func collect_wearable(item):
	inventory.push_front(item)
	active_ring += 1 #hack, dont do it this way
	active_amulet += 1 #hack, dont do it this way
func add_wearable(item, i = false):
	var w = Wearables.new()
	inventory.push_front(w)
	inventory[0].set_name(item.base_name)
	inventory[0].set_type(item.type)
	inventory[0].set_bonus_ac(item.bonus_ac)
	inventory[0].set_bonus_dmg(item.bonus_dmg)
	active_ring += 1 #hack, dont do it this way
	active_amulet += 1 #hack, dont do it this way
	if i:
		alter_stats(0,10)

func get_next_ring(i = active_ring):
	var size = inventory.size()
	i += 1
	if i == size:
		i = 0
	while not get_type(i) == G.WearType.Ring:
		i += 1
		if i == size:
			i = 0
	return i

func get_next_amulet(i = active_amulet):
	var size = inventory.size()
	i += 1
	if i == size:
		i = 0
	while not get_type(i) == G.WearType.Amulet:
		i += 1
		if i == size:
			i = 0
	return i

func get_ring_name(i = active_ring):
	return inventory[i].get_name()

func get_amulet_name(i = active_amulet):
	return inventory[i].get_name()

func get_name(i):
	return inventory[i].get_name()

func get_type(i):
	return inventory[i].get_type()

func equip_ring(i):
	active_ring = i

func equip_amulet(i):
	active_amulet = i
	
func get_bonus_ac():
	return get_ring_bonus_ac() + get_amulet_bonus_ac()
func get_ring_bonus_ac():
	return inventory[active_ring].get_bonus_ac()
func get_amulet_bonus_ac():
	return inventory[active_amulet].get_bonus_ac()


func get_bonus_dmg():
	return get_amulet_bonus_dmg() + get_ring_bonus_dmg()
func get_amulet_bonus_dmg():
	return inventory[active_amulet].get_bonus_dmg()
func get_ring_bonus_dmg():
	return inventory[active_ring].get_bonus_dmg()

func alter_stats(i,rng):
	var pre = ["Rusted", "Shiny", "Glowing", "Sparkly", "Red", "Golden", "Crappy", "Normal", "Mood"]
	var post = ["of brightness.", "of spikes", "of gas", "that glows", "of colors", "that tastes funny"]
	inventory[0].set_name(pre[randi() % pre.size()] + " " + get_name(0) + " " + post[randi() % post.size()])
	inventory[0].set_bonus_ac(randi() % rng)
	inventory[0].set_bonus_dmg(randi() % rng)
	