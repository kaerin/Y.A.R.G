extends Reference

var Weapons = load("res://Items/Weapons.gd")
var inventory = []

func _init(i):
	if i == G.CHAR.ENEMY:
		print("New enemy weapon class")
	elif i == G.CHAR.PLAYER:
		print("Weapon reference initialised, adding fist as first weapon ")
		var w = Weapons.new()
		inventory.push_front(w)
		inventory[0].set_name(G.Weap.Fist)
		inventory[0].set_dmg_type(G.WeapType.Blunt)
		inventory[0].set_damage(91,92)

func print():
	print("Executed debug print function from weapon class")

#Each item type has its own class: wepaon, armour, misc
#Weapons class contain weapons in inventory
#Repeat class for armor

func collect_weapon(item):
	inventory.push_front(item) #directly copy dropped item into inventory
	#active += 1 #hack, dont do it this way

func add_weapon(item, i = false):
	var w = Weapons.new()
	inventory.push_front(w)
	inventory[0].set_name(item.base_name)
	inventory[0].set_dmg_type(item.damage_type)
	inventory[0].set_damage(item.min_damage,item.max_damage)
	#active += 1 #hack, dont do it this way
	if i:
		alter_stats(0,10)

func get_name():
	return name()

func get_type():
	#return equipped.get_dmg_type()
	for n in inventory:
		if n._is_equipped:
			return n.get_dmg_type()
			
func equip_weapon(equipped):
	equipped

func get_equipped():
	for n in inventory:
		if n.is_equipped:
			return n
	
func get_damage():
	#return equipped.get_damage()
	for n in inventory:
		if n._is_equipped:
			return n.get_damage()
	
func get_bonus_damage():
	#return equipped[0].get_bonus_damage()
	for n in inventory:
		if n._is_equipped:
			return n.get_bonus_damage()


func alter_stats(i,rng):
	var pre = ["Rusted", "Sharp", "Spikey", "Red", "Golden", "Crappy", "Normal", "Basic", "Serrated"]
	var post = ["of spikes", "of bluntness", "that is on fire", "made of plastic"]
	inventory[0].set_name(pre[randi() % pre.size()] + " " + get_name() + " " + post[randi() % post.size()])
	inventory[0].set_bonus_dmg(randi() % rng)

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


	