extends Reference

#every item class
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
# mostly me writing ideas down that how it should be.


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


func print():
	print("Executed print function from weapon class")


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


	