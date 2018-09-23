extends Node

enum	ENEMIES {RAT, ANT, MOLE, BEE}

var enemies = {}

func _ready():
	enemies[RAT] = {base_name = "Rat", min_hp = 4, max_hp = 8 }
	enemies[ANT] = {base_name = "Ant", min_hp = 1, max_hp = 4 }
	enemies[MOLE] = {base_name = "Mole", min_hp = 8, max_hp = 12 }
	enemies[BEE] = {base_name = "Bee", min_hp = 1, max_hp = 2 }
