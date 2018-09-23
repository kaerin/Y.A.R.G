extends Node

enum	WEAPONS {FIST, SWORD, DAGGER, CLUB, SPEAR}

var weapons = {}

func _ready():
	weapons[SWORD] = {base_name = "Sword", min_damage = 6, max_damage = 12 }
	weapons[DAGGER] = {base_name = "Dagger", min_damage = 1, max_damage = 4}
	weapons[CLUB] = {base_name = "Club", min_damage = 2, max_damage = 6}
	weapons[SPEAR] = {base_name = "Spear", min_damage = 1, max_damage = 10}
	weapons[FIST] = {base_name = "Fist", min_damage = 0, max_damage = 1}
	
		# Called when the node is added to the scene for the first time.
	# Initialization here

