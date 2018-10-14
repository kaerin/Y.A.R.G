extends Reference

var Wearables = load("res://Items/Wearables.gd")
#var active_amulet = 0
#var active_ring = 1
var inv = []

func _init(i):
	pass
#	if i == G.CHAR.ENEMY:
#		pass
#	elif i == G.CHAR.PLAYER:
##		print("Wearable reference initialised, adding large plastic clock amulet")
#		var w = Wearables.new()
#		inv.append(w)
#		inv[0].set_name("Clock Amulet of the 80s")
#		inv[0].set_type(G.WearType.Amulet)
#		inv[0].set_bonus_ac(-1)
#		inv[0].set_bonus_dmg(1)
#		inv[0].set_equipped()
#		#inventory[0].add_to_group("Wearable")
#		w = Wearables.new()
#		inv.append(w)
#		inv[1].set_name("Toy ring")
#		inv[1].set_type(G.WearType.Ring)
#		inv[1].set_equipped()
		#inventory[1].add_to_group("Wearable")	
		
func print():
	print("Executed debug print function from wearable class")

#Each item type has its own class: wepaon, armour, misc
#Weapons class contain weapons in inventory
#Repeat class for armor

func add_item(item):
	inv.push_front(item)

func add_dmg(dmg):
	var types = []
	for type in dmg:
		types.append(type)
	for wear in inv:
		if wear.is_equipped:
			var BonusDmg = wear.BonusDmg
			for bonus in wear.Dmg:
				if types.has(bonus[0]):
					var j = 0
					for i in dmg:
						if i[0] == bonus[0]: #If the type matches add the bonus
							dmg[j] += randi() % (bonus[2] - bonus[1]) + bonus[1] + BonusDmg
						j += 1
				else:
					dmg.append([bonus[0],randi() % (bonus[2] - bonus[1]) + bonus[1] + BonusDmg]) #else add the extra dmg type
	return dmg

func add_res_specific(type):
	var res = 0
	for n in inv:
		if n.is_equipped:
			res += n.get_res_specific(type)
	return res

func add2_wearable(item, i = false):
	print("this should not execute")
	var w = Wearables.new()
	inv.push_front(w)
	inv[0].set_name(item.base_name)
	inv[0].set_type(item.type)
	inv[0].set_bonus_ac(item.bonus_ac)
	inv[0].set_bonus_dmg(item.bonus_dmg)
	inv[0].set_sprite_rect(item.img_rect)
	#inventory[0].add_to_group("Wearable")
	if i:
		alter_stats(0,10)

#func get_ring_name():
#	for i in inventory:
#		if i.WearType == G.WearType.Ring and i.is_active:
#			return i.get_name() +"zzz"
#
#func get_amulet_name(i = active_amulet):
#	return inventory[i].get_name()

func get_name(i):
	return inv[i].get_name()

func get_type(i):
	return inv[i].get_type()

#func equip_ring(i):
#	active_ring = i
#
#func equip_amulet(i):
#	active_amulet = i
	
func get_bonus_ac():
	var ac = 0
	for n in inv:
		if n.is_equipped:
			ac += n.get_bonus_ac()
	return ac
	
#func get_ring_bonus_ac():
#	return inventory[active_ring].get_bonus_ac() #fix mne
#func get_amulet_bonus_ac():
#	return inventory[active_amulet].get_bonus_ac() #fix mne

func get_res_all(res):
	for n in inv:
		if n.is_equipped:
			for m in n.get_res():					#check all equipped wearables
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

func get_bonus_dmg():
	var dmg = 0
	for n in inv:
		if n.is_equipped:
			dmg += n.get_bonus_dmg()
	return dmg
#func get_amulet_bonus_dmg():
#	return inventory[active_amulet].get_bonus_dmg() #fix mne
#func get_ring_bonus_dmg():
#	return inventory[active_ring].get_bonus_dmg() #fix mne


	