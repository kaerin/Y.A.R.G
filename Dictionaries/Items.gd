extends Node

enum	WEAPONS {FIST, SWORD, DAGGER, CLUB, SPEAR}
enum	CHEST	{CLOTH, LEATHER, CHAIN, PLATE}

var weapons = {}
var chest	= {}

func _ready():

# ------------------------------- #
# ---------- WEAPONS ------------ #
# ------------------------------- #

	weapons[SWORD] 	= {base_type = 'Weapon', base_name = 'Sword', min_damage = 6, max_damage = 12 , damage_type = 'Slash', weight = 10}
	weapons[DAGGER] = {base_type = 'Weapon', base_name = 'Dagger', min_damage = 1, max_damage = 4, damage_type = 'Stab', weight = 4}
	weapons[CLUB] 	= {base_type = 'Weapon', base_name = 'Club', min_damage = 2, max_damage = 6, damage_type = 'Blunt', weight = 6}
	weapons[SPEAR] 	= {base_type = 'Weapon', base_name = 'Spear', min_damage = 1, max_damage = 10, damage_type = 'Stab', weight = 5}
	weapons[FIST] 	= {base_type = 'Weapon', base_name = 'Fist', min_damage = 0, max_damage = 1, damage_type = 'Blunt', weight = 0}
	

# ------------------------------- #
# ---------- ARMOR -------------- #
# ------------------------------- #

	chest[CLOTH] 	= {base_type = 'Chest', base_name = 'Cloth', armor_class = 2, res_slash = 0, res_stab = 0, res_blunt = 0, to_hit = 0, weight = 6}
	chest[LEATHER] 	= {base_type = 'Chest', base_name = 'Leather', armor_class = 4, res_slash = 1, res_stab = 0, res_blunt = 2, to_hit = 0, weight = 6}
	chest[CHAIN] 	= {base_type = 'Chest', base_name = 'Chain', armor_class = 6, res_slash = 2, res_stab = 1, res_blunt = 2, to_hit = -1, weight = 6}
	chest[PLATE] 	= {base_type = 'Chest', base_name = 'Plate', armor_class = 8, res_slash = 4, res_stab = 2, res_blunt = 4, to_hit = -2, weight = 6}
	
	