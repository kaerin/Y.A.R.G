extends Node

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

	weapons[G.WEAP.SWORD] 	= {base_type = G.BaseType.Weap, base_name = G.Weap.Sword, damage = [[G.DmgType.Slash,6,12]], weight = 10, img_rect = Rect2(960,1472,32,32)}
	weapons[G.WEAP.DAGGER] 	= {base_type = G.BaseType.Weap, base_name = G.Weap.Dagger, damage = [[G.DmgType.Stab,1,4]], weight = 4, img_rect = Rect2(864,1472,32,32)}
	weapons[G.WEAP.CLUB] 	= {base_type = G.BaseType.Weap, base_name = G.Weap.Club, damage = [[G.DmgType.Blunt,2,6]], weight = 6, img_rect = Rect2(1760,1408,32,32)}
	weapons[G.WEAP.SPEAR] 	= {base_type = G.BaseType.Weap, base_name = G.Weap.Spear, damage = [[G.DmgType.Stab,1,10]], weight = 5, img_rect = Rect2(864,1504,32,32)}
	
	weapons[G.WEAP.FIST] 	= {base_type = G.BaseType.BodyWeap, base_name = G.Weap.Fist, damage = [[G.DmgType.Blunt,90,99]], weight = 0, img_rect = Rect2(864,928,32,32), droppable = false}
	weapons[G.WEAP.TEETH] 	= {base_type = G.BaseType.BodyWeap, base_name = G.Weap.Teeth, damage = [[G.DmgType.Blunt,2,3]], weight = 0, img_rect = Rect2(864,928,32,32), droppable = false}
	weapons[G.WEAP.CLAW] 	= {base_type = G.BaseType.BodyWeap, base_name = G.Weap.Claw, damage = [[G.DmgType.Slash,0,1]], weight = 0, img_rect = Rect2(864,928,32,32), droppable = false}
	weapons[G.WEAP.TAIL] 	= {base_type = G.BaseType.BodyWeap, base_name = G.Weap.Tail, damage = [[G.DmgType.Slash,1,2]], weight = 0, img_rect = Rect2(864,928,32,32), droppable = false}
	
	weapons[G.WEAP.SWORD] 	= {base_type = G.BaseType.Weap, base_name = G.Weap.Sword, post_name = "of fire", damage = [[G.DmgType.Slash,6,12],[G.DmgType.Fire,6,12]], weight = 10, img_rect = Rect2(960,1472,32,32)}
	weapons[G.WEAP.SWORD] 	= {base_type = G.BaseType.Weap, base_name = G.Weap.Sword, pre_name = "Flaming", damage = [[G.DmgType.Slash,6,12],[G.DmgType.Fire,6,12]], weight = 10, img_rect = Rect2(960,1472,32,32)}
	weapons[G.WEAP.SWORD] 	= {base_type = G.BaseType.Weap, base_name = G.Weap.Sword, pre_name = "Flaming", post_name = "of fire", damage = [[G.DmgType.Slash,6,12],[G.DmgType.Fire,6,12]], weight = 10, img_rect = Rect2(960,1472,32,32)}
	 #power punch for testing

#Change all text and enum to global variables

# ------------------------------- #
# ---------- ARMOR -------------- #
# ------------------------------- #

#	chest[CLOTH] 	= {base_type = 'Armour', location = 'Chest', base_name = 'Cloth', armor_class = 2, res_slash = 0, res_stab = 0, res_blunt = 0, to_hit = 0, weight = 6}
#	chest[LEATHER] 	= {base_type = 'Armour', location = 'Chest', base_name = 'Leather', armor_class = 4, res_slash = 1, res_stab = 0, res_blunt = 2, to_hit = 0, weight = 6}
#	chest[CHAIN] 	= {base_type = 'Armour', location = 'Chest', base_name = 'Chain', armor_class = 6, res_slash = 2, res_stab = 1, res_blunt = 2, to_hit = -1, weight = 6}
#	chest[PLATE] 	= {base_type = 'Armour', location = 'Chest', base_name = 'Plate', armor_class = 8, res_slash = 4, res_stab = 2, res_blunt = 4, to_hit = -2, weight = 6}
	
	armour[G.LOC.CHEST][G.MAT.CLOTH] 	= {base_type = G.BaseType.Armour, location = G.LOC.CHEST, loc_name = 'Chest', base_name = 'Cloth', armor_class = 2, res_slash = 0, res_stab = 0, res_blunt = 0, to_hit = 0, weight = 6, img_rect = Rect2(1824,1120,32,32)}
	armour[G.LOC.CHEST][G.MAT.LEATHER]	= {base_type = G.BaseType.Armour, location = G.LOC.CHEST, loc_name = 'Chest', base_name = 'Leather', armor_class = 4, res_slash = 1, res_stab = 0, res_blunt = 2, to_hit = 0, weight = 6, img_rect = Rect2(1504,1216,32,32)}
	armour[G.LOC.CHEST][G.MAT.CHAIN] 	= {base_type = G.BaseType.Armour, location = G.LOC.CHEST, loc_name = 'Chest', base_name = 'Chain', armor_class = 6, res_slash = 2, res_stab = 1, res_blunt = 2, to_hit = -1, weight = 6, img_rect = Rect2(1472,1184,32,32)}
	armour[G.LOC.CHEST][G.MAT.PLATE] 	= {base_type = G.BaseType.Armour, location = G.LOC.CHEST, loc_name = 'Chest', base_name = 'Plate', armor_class = 8, res_slash = 4, res_stab = 2, res_blunt = 4, to_hit = -2, weight = 6, img_rect = Rect2(480,1216,32,32)}
	
	armour[G.LOC.HEAD][G.MAT.CLOTH] 	= {base_type = G.BaseType.Armour, location = G.LOC.HEAD, loc_name = 'Head', base_name = 'Cloth', armor_class = 2, res_slash = 0, res_stab = 0, res_blunt = 0, to_hit = 0, weight = 6, img_rect = Rect2(1440,1152,32,32)}
	armour[G.LOC.HEAD][G.MAT.LEATHER]	= {base_type = G.BaseType.Armour, location = G.LOC.HEAD, loc_name = 'Head', base_name = 'Leather', armor_class = 4, res_slash = 1, res_stab = 0, res_blunt = 2, to_hit = 0, weight = 6, img_rect = Rect2(1312,1152,32,32)}
	armour[G.LOC.HEAD][G.MAT.CHAIN] 	= {base_type = G.BaseType.Armour, location = G.LOC.HEAD, loc_name = 'Head', base_name = 'Chain', armor_class = 6, res_slash = 2, res_stab = 1, res_blunt = 2, to_hit = -1, weight = 6, img_rect = Rect2(1824,1152,32,32)}
	armour[G.LOC.HEAD][G.MAT.PLATE] 	= {base_type = G.BaseType.Armour, location = G.LOC.HEAD, loc_name = 'Head', base_name = 'Plate', armor_class = 8, res_slash = 4, res_stab = 2, res_blunt = 4, to_hit = -2, weight = 6, img_rect = Rect2(1664,1152,32,32)}
	
	wear[G.WEAR.AMULET] 	= {base_type = G.BaseType.Wear, type = 'Amulet', base_name = 'Amulet', bonus_ac = 0, bonus_dmg = 0, img_rect = Rect2(224,1120,32,32)} #type should probably be an index not a word
	wear[G.WEAR.NECKLACE] 	= {base_type = G.BaseType.Wear, type = 'Amulet', base_name = 'Necklace', bonus_ac = 0, bonus_dmg = 0, img_rect = Rect2(64,1120,32,32)}
	wear[G.WEAR.RING] 		= {base_type = G.BaseType.Wear, type = 'Ring', base_name = 'Ring', bonus_ac = 0, bonus_dmg = 0, img_rect = Rect2(416,1376,32,32)}
	wear[G.WEAR.EARING] 	= {base_type = G.BaseType.Wear, type = 'Ring', base_name = 'Ear Ring', bonus_ac = 0, bonus_dmg = 0, img_rect = Rect2(384,1376,32,32)}