extends Node

enum	WEAPONS {FIST, SWORD, DAGGER, CLUB, SPEAR}
enum	TYPE	{CLOTH, LEATHER, CHAIN, PLATE}
enum	LOC		{CHEST, HEAD, ARMS, LEGS}
enum	WEAR	{AMULET, NECKLACE, RING, EARING}


var weapons = {}
var chest	= {}
var armour	= []
var wear	= {}

func _ready():
	for i in range(2):
		armour.append({})

# ------------------------------- #
# ---------- WEAPONS ------------ #
# ------------------------------- #

	weapons[SWORD] 	= {base_type = 'Weapon', base_name = 'Sword', min_damage = 6, max_damage = 12 , damage_type = 'Slash', weight = 10}
	weapons[DAGGER] = {base_type = 'Weapon', base_name = 'Dagger', min_damage = 1, max_damage = 4, damage_type = 'Stab', weight = 4}
	weapons[CLUB] 	= {base_type = 'Weapon', base_name = 'Club', min_damage = 2, max_damage = 6, damage_type = 'Blunt', weight = 6}
	weapons[SPEAR] 	= {base_type = 'Weapon', base_name = 'Spear', min_damage = 1, max_damage = 10, damage_type = 'Stab', weight = 5}
	weapons[FIST] 	= {base_type = 'Weapon', base_name = 'Fist', min_damage = 90, max_damage = 99, damage_type = 'Blunt', weight = 0} #power punch for testing
	

# ------------------------------- #
# ---------- ARMOR -------------- #
# ------------------------------- #

#	chest[CLOTH] 	= {base_type = 'Armour', location = 'Chest', base_name = 'Cloth', armor_class = 2, res_slash = 0, res_stab = 0, res_blunt = 0, to_hit = 0, weight = 6}
#	chest[LEATHER] 	= {base_type = 'Armour', location = 'Chest', base_name = 'Leather', armor_class = 4, res_slash = 1, res_stab = 0, res_blunt = 2, to_hit = 0, weight = 6}
#	chest[CHAIN] 	= {base_type = 'Armour', location = 'Chest', base_name = 'Chain', armor_class = 6, res_slash = 2, res_stab = 1, res_blunt = 2, to_hit = -1, weight = 6}
#	chest[PLATE] 	= {base_type = 'Armour', location = 'Chest', base_name = 'Plate', armor_class = 8, res_slash = 4, res_stab = 2, res_blunt = 4, to_hit = -2, weight = 6}
	
	armour[CHEST][CLOTH] 	= {base_type = 'Armour', location = CHEST, loc_name = 'Chest', base_name = 'Cloth', armor_class = 2, res_slash = 0, res_stab = 0, res_blunt = 0, to_hit = 0, weight = 6}
	armour[CHEST][LEATHER]	= {base_type = 'Armour', location = CHEST, loc_name = 'Chest', base_name = 'Leather', armor_class = 4, res_slash = 1, res_stab = 0, res_blunt = 2, to_hit = 0, weight = 6}
	armour[CHEST][CHAIN] 	= {base_type = 'Armour', location = CHEST, loc_name = 'Chest', base_name = 'Chain', armor_class = 6, res_slash = 2, res_stab = 1, res_blunt = 2, to_hit = -1, weight = 6}
	armour[CHEST][PLATE] 	= {base_type = 'Armour', location = CHEST, loc_name = 'Chest', base_name = 'Plate', armor_class = 8, res_slash = 4, res_stab = 2, res_blunt = 4, to_hit = -2, weight = 6}
	
	armour[HEAD][CLOTH] 	= {base_type = 'Armour', location = HEAD, loc_name = 'Head', base_name = 'Cloth', armor_class = 2, res_slash = 0, res_stab = 0, res_blunt = 0, to_hit = 0, weight = 6}
	armour[HEAD][LEATHER]	= {base_type = 'Armour', location = HEAD, loc_name = 'Head', base_name = 'Leather', armor_class = 4, res_slash = 1, res_stab = 0, res_blunt = 2, to_hit = 0, weight = 6}
	armour[HEAD][CHAIN] 	= {base_type = 'Armour', location = HEAD, loc_name = 'Head', base_name = 'Chain', armor_class = 6, res_slash = 2, res_stab = 1, res_blunt = 2, to_hit = -1, weight = 6}
	armour[HEAD][PLATE] 	= {base_type = 'Armour', location = HEAD, loc_name = 'Head', base_name = 'Plate', armor_class = 8, res_slash = 4, res_stab = 2, res_blunt = 4, to_hit = -2, weight = 6}
	
	wear[AMULET] = {base_type = 'Wearable', type = 'Amulet', base_name = 'Amulet', bonus_ac = 0, bonus_dmg = 0}
	wear[NECKLACE] = {base_type = 'Wearable', type = 'Amulet', base_name = 'Necklace', bonus_ac = 0, bonus_dmg = 0}
	wear[RING] = {base_type = 'Wearable', type = 'Ring', base_name = 'Ring', bonus_ac = 0, bonus_dmg = 0}
	wear[EARING] = {base_type = 'Wearable', type = 'Ring', base_name = 'Ear Ring', bonus_ac = 0, bonus_dmg = 0}