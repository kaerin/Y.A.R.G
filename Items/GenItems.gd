extends Reference

#onready var DicItems = load("res://Dictionaries/Items.gd")
var Weapons = load("res://Items/Weapons.gd")
var Armours = load("res://Items/Armours.gd")
var Wearables = load("res://Items/Wearables.gd")

func _init():
	pass

func chk_drop(i,j):
	if i.has("droppable"):
		if i.droppable:
			j.set_droppable(true)
		else:
			j.set_droppable(false)
	return j
	

func gen_weap(item):
#	var di = DicItems.new()
#	var item  = DicItems.weapons[i]
	var w = Weapons.new()
	w.set_name(item.base_name)
	w.set_dmg_type(item.damage_type)
	w.set_dmg(item.min_damage,item.max_damage)
	w.set_sprite_rect(item.img_rect)
	w.BaseType = item.base_type
	w = chk_drop(item, w)
	return w
	
func gen_armour(item):
	var a = Armours.new()
	a.set_name(item.base_name)
	a.set_mat(item.base_name)
	a.set_location(item.location)
	a.set_loc_name(item.loc_name)
	a.set_ac(item.armor_class)
	a.set_sprite_rect(item.img_rect)
	return a
	
func gen_wear(item):
	var w = Wearables.new()
	w.set_name(item.base_name)
	w.set_type(item.type)
	w.set_bonus_ac(item.bonus_ac)
	w.set_bonus_dmg(item.bonus_dmg)
	w.set_sprite_rect(item.img_rect)
	return w