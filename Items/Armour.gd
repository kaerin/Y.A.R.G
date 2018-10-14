extends Reference

var Armours = load("res://Items/Armours.gd")
var active = [0,1,0,0]
var inv = []

func _init(i):
	pass
#	if i == G.CHAR.ENEMY:
#		pass
##		print("New enemy armour class")
#	elif i == G.CHAR.PLAYER:
##		print("Armour reference initialised, adding t-shirt")
#		var a = Armours.new()
#		inv.append(a)
#		a = Armours.new()
#		inv.append(a)
#		inv[0].set_name("T-Shirt")
#		inv[0].set_mat(G.Mat.Cloth)
#		inv[0].set_location(G.LOC.CHEST)
#		inv[0].set_loc_name(G.Loc.Chest)
#		inv[0].set_sprite_rect(Rect2(1824,1120,32,32))
#		inv[0].set_equipped()
#		inv[0].set_ac(1)
#		inv[1].set_name("Hat")
#		inv[1].set_mat(G.Mat.Cloth)
#		inv[1].set_location(G.LOC.HEAD)
#		inv[1].set_loc_name(G.Loc.Head)
#		inv[1].set_sprite_rect(Rect2(1440,1152,32,32))
#		inv[1].set_ac(1)
#		inv[1].set_equipped()
		#inventory[1].add_to_group("Armour")
		
func print():
	print("Executed debug print function from armour class")

func add_item(item):
	inv.push_front(item)
#	active[G.LOC.CHEST] += 1 #hack, dumb way of doing it, dont repeat, use an index
#	active[G.LOC.HEAD] += 1 #hack, dumb way of doing it, dont repeat, use an index
func add2_armour(item, i = false):
	print("this should not execute")
	var a = Armours.new()
	inv.push_front(a)
	inv[0].set_name(item.base_name)
	inv[0].set_mat(item.base_name)
	inv[0].set_location(item.location)
	inv[0].set_loc_name(item.loc_name)
	inv[0].set_ac(item.armor_class)
	inv[0].set_sprite_rect(item.img_rect)
	#inventory[0].add_to_group("Armour")
	active[G.LOC.CHEST] += 1 #hack, dumb way of doing it, dont repeat, use an index
	active[G.LOC.HEAD] += 1 #hack, dumb way of doing it, dont repeat, use an index
	if i:
		alter_stats(0,10)

func get_name(i):
	return inv[i].get_name()

func get_location(i):
	return inv[i].get_location()

func get_loc_name(i):
	return inv[i].get_loc_name()

func equip_armour(loc, i):
	active[loc] = i

func get_equip_name(loc):
	return get_name(get_equip(loc))

func get_equip(loc):
	return active[loc]

func get_res_all(res):
	for n in inv:
		if n.is_equipped:
			for m in n.get_res():					#check all equipped armour
				var i = 0
				while i < res.size():
					var k = res[i][0].find(m[0])	#check if res already exists
					if k >= 0:
						res[i][1] += m[1]			#if exists, add to existing
						break						#break if found
					i += 1
				if i == res.size():					#if not found, append
					res.append(m.duplicate())		#duplicate, otherwise writes only reference to objects res
	return(res)

func get_res_specific(type):
	var res = 0
	for n in inv:
		if n.is_equipped:
			res += n.get_res_specific(type)
	return res

#func get_ac():
#	var ac = 0
#	for n in inv:
#		if n.is_equipped:
#			ac += n.get_ac()
#	return ac
	
func get_armour_ac(loc):
	var ac = 0
	for n in inv:
		if n.is_equipped:
			ac += n.get_armour_ac()
	return ac
	
func get_bonus_ac(loc):
	var ac = 0
	for n in inv:
		if n.is_equipped:
			ac += n.get_bonus_ac()
	return ac


