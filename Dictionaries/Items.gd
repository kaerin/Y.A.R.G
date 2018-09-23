extends Node

enum	ITEMS {FIST, SWORD, DAGGER, CLUB, SPEAR}

var items = {}

func _ready():
	items[SWORD] = {base_name = "Sword", min_damage = 6, max_damage = 12 }
	items[DAGGER] = {base_name = "Dagger", min_damage = 1, max_damage = 4}
	items[CLUB] = {base_name = "Club", min_damage = 2, max_damage = 6}
	items[SPEAR] = {base_name = "Spear", min_damage = 1, max_damage = 10}
	items[FIST] = {base_name = "Fist", min_damage = 0, max_damage = 1}
	
		# Called when the node is added to the scene for the first time.
	# Initialization here

