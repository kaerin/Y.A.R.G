extends Reference

var Weapons = load("res://Items/Weapons.gd")
var inv = []

func _init():
	pass
#	if i == G.CHAR.ENEMY:
#		print("New enemy weapon class")
#		pass
#	elif i == G.CHAR.PLAYER:
#		print("Weapon reference initialised, adding fist as first weapon ")
#		var w = Weapons.new()
#		inv.push_front(w)
#		inv[0].set_name(G.Weap.Fist)
#		inv[0].set_dmg_type(G.WeapType.Blunt)
#		inv[0].set_dmg(91,92)
#		inv[0].set_sprite_rect(Rect2(864,928,32,32))
#		inv[0].set_equipped()
		

func print_test():
	print("Executed debug print function from weapon class")

#Each item type has its own class: wepaon, armour, misc
#Weapons class contain weapons in inventory
#Repeat class for armor

func add_item(item): #adding existing class weapons
	inv.push_front(item) 

func add2_weapon(item, i = false): #Adding base weapons from the dictionary
	print("this should not execute")
	var w = Weapons.new()
	inv.push_front(w)
	inv[0].set_name(item.base_name)
	inv[0].set_dmg_type(item.damage_type)
	inv[0].set_dmg(item.min_damage,item.max_damage)
	inv[0].set_sprite_rect(item.img_rect)
	inv[0].BaseType = item.base_type
	if item.has("droppable"):
		if item.droppable:
			inv[0].set_droppable(true)
		else:
			inv[0].set_droppable(false)
	#inventory[0].add_to_group("Weapon")
	#active += 1 #hack, dont do it this way
	if i:
		alter_stats(0,10)
		
func get_active_name():
	for n in inv:
		if n.is_equipped:
			return n.get_name()

func get_name(i = -1):
	if i < 0:
		return get_active_name()
	return inv[i].get_name()

func get_type():
	#return equipped.get_dmg_type()
	for n in inv:
		if n.is_equipped:
			return n.get_dmg_type()
			
func equip_weapon(equipped):
	equipped

func get_equipped():
	for n in inv:
		if n.is_equipped:
			return n
	
func get_dmg():
	#return equipped.get_damage()
	for n in inv:
		if n.is_equipped:
			return n.get_dmg()

func get_dmg_all(dmg):
	for n in inv:
		if n.is_equipped:
			for m in n.get_dmg_all():					#check all equipped wearables
				var i = 0
				while i < dmg.size():
					var k = dmg[i][0].find(m[0])	#check if res already exists
					if k >= 0:
						dmg[i][1] += m[1]			#if exists, add to existing
						dmg[i][2] += m[2]			#if exists, add to existing
						break						#break if found
					i += 1
				if i == dmg.size():					#if not found, append
					dmg.append(m.duplicate())		#duplicate, otherwise writes only reference to objects res
	return(dmg)	

func get_bonus_dmg():
	#return equipped[0].get_bonus_damage()
	for n in inv:
		if n.is_equipped:
			return n.get_bonus_dmg()
