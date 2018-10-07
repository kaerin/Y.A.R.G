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
	
func get_bonus_dmg():
	#return equipped[0].get_bonus_damage()
	for n in inv:
		if n.is_equipped:
			return n.get_bonus_dmg()


func alter_stats(i,rng):
	var pre = ["Rusted", "Sharp", "Spikey", "Red", "Golden", "Crappy", "Normal", "Basic", "Serrated"]
	var post = ["of spikes", "of bluntness", "that is on fire", "made of plastic"]
	inv[0].set_name(pre[randi() % pre.size()] + " " + get_name(0) + " " + post[randi() % post.size()])
	inv[0].set_bonus_dmg(randi() % rng)

#every item class, instead of just weapons
#perhaps a single item class could work for every item type
#meaning everything has a min max damage, armor class, etc etc.
#anything unecessary eg. damage for armor is set to null and ignored
#when combining the stats of all items in Player stats.
#Player Armor class = is total of Armor class of all equipped items
#Player min damage = is total of min damage of all items
#
#when displaying item stats in a dialog, only show stats that are not null
#would result in only one data structure being used everywhere. shoudl alos
#allow for easy future expansion of "features" 
#below is just an example of random junk with exagerated variable names for readability.
# mostly me writing ideas down than how it should be.


#var type	#dictates location for equip
#var name

#var min_damage
#var max_damage
#var damage_type

#var armor_class		#null for weapon
#var weight

#var fire_resistance
#var water_resistance
#var lightning_resistance
#var physical_resistance

#var fatigue_rate	#if ever wanted to add fatigue system later.





#func init_item(base_item_to_create) #eg sword
	
#func add_preamble_bonus()
	#	% chance based on item Tier level and other random crap
	# preamble adds stat xyz bonuses and preamble text to name
	# eg "flaming" modifies damage type to fire from physical
	# should be possible mulitple times, eg "sharp" "flaming" "sword"
	
#func add_postamble_bonus()
	#	% chance based on item Tier level and other random crap
	# preamble adds stat xyz stat bonuses and preamble text to name
	# adds postamble to name. eg "stupidity"
	
#resulting item -> sharp flaming sword of stupidity
# sword base stats + ( +damage , damage type = fire, intelligence_bonus -= 3328)
# something like that. should allow for exponential possibilities of items
# basically same concept for enemies

#where to store base item stats ? (sword, dagger, helmet, cap, shield)
#where to store Pre/Postamble deffinitions ? (flaming, clumsiness, sharp )


	