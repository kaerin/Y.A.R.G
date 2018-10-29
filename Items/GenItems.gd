extends Reference

#onready var DicItems = load("res://Dictionaries/Items.gd")
var Weapons = load("res://Items/Weapons.gd")
var Armours = load("res://Items/Armours.gd")
var Wearables = load("res://Items/Wearables.gd")

func _init():
	randomize()

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
	w.set_sprite_rect(item.img_rect)
	w.BaseType = item.base_type
	
	for j in item.damage:
		w.add_dmg(j)
	
	w = chk_drop(item, w)
	if item.has("post_name") or item.has("pre_name"):
		w.set_name(item.pre_name + " " +  item.base_name + " " + item.post_name)
	else:
		var pre = ["Rusted","Sharp","Spikey","Red","Golden","Green","Crappy","Normal","Basic","Serrated","Super","Grand","Legendary","Rare","Unique","Ornamental"]
		var post = ["of spikes","of bluntness","that is on fire","made of plastic","covered in blood","cutting air","of distraction","with razors"]
		w.set_name(pre[randi() % pre.size()] + " " + w.get_name() + " " + post[randi() % post.size()])
		w.set_bonus_dmg(randi() % (G.Dlevel+1))
		w.gen_rpc_data()
	return w
	
func gen_armour(item):
	var a = Armours.new()
	a.set_name(item.base_name)
	a.set_mat(item.base_name)
	a.set_location(item.location)
	a.set_loc_name(item.loc_name)
#	a.set_ac(item.armor_class)
	for j in item.res:
		a.add_res(j)
	a.set_sprite_rect(item.img_rect)
	a = chk_drop(item, a)
	if item.has("post_name") or item.has("pre_name"):
		a.set_name(item.pre_name + " " +  item.base_name + " " + item.post_name)
	else:
		var pre = ["Rusted","Shiny","Glowing","Sparkly","Red","Golden","Crappy","Normal","Dented","Scratched","Heavily dented","Typical","Superb"]
		var post = ["of brightness","with shoulder pads","puffy vest","of armour","of colors","that tastes funny","that shimmers","- tank armour"]
		a.set_name(pre[randi() % pre.size()] + " " + a.get_name() + " " + post[randi() % post.size()])
		a.set_bonus_res(randi() % (G.Dlevel+1))
	return a
	
func gen_wear(item):
	var w = Wearables.new()
	w.set_name(item.base_name)
	w.set_type(item.type)
	w.set_bonus_res(item.bonus_res)
	w.set_bonus_dmg(item.bonus_dmg)
	
	var types = G.ResType.keys()
	var i = types[randi() % types.size()]
	var j = randi() % (G.Dlevel + 1) + 9 #+99 testing
	w.add_res(i,j)
	
	types = G.DmgType.keys() #For when its different
	i = types[randi() % types.size()]
	j = randi() % (G.Dlevel + 1) + 2 #testing
	var k = j + randi() % (G.Dlevel + 1) + 3 #testing
	w.add_dmg(i,j,k)
	
	w.set_sprite_rect(item.img_rect)
	w = chk_drop(item, w)
	var pre = ["Rusted","Shiny","Glowing","Sparkly","Red","Golden","Crappy","Normal","Mood","Talking","Tiny","Oversized","Typcial"]
	var post = ["of brightness","of sparks","of flames","that glows","in rainbow colors","that tastes funny","in blood","of joy"]
	w.set_name(pre[randi() % pre.size()] + " " + w.get_name() + " " + post[randi() % post.size()])
	w.set_bonus_res(randi() % (G.Dlevel+1))
	w.set_bonus_dmg(randi() % (G.Dlevel+1))
	return w