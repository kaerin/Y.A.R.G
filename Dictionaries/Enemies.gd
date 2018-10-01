extends Node

enum	ENEMIES {RAT, TURTLE, MOLE, BEE}

var enemies = {}

func _ready():
	enemies[RAT] = {base_name = "Rat", min_hp = 4, max_hp = 8, img_rect = Rect2(2016,2400,32,32) }
	enemies[TURTLE] = {base_name = "Turtle", min_hp = 1, max_hp = 4, img_rect = Rect2(1344,2048,32,32) }
	enemies[MOLE] = {base_name = "Mole", min_hp = 8, max_hp = 12, img_rect = Rect2(416,2112,32,32)  }
	enemies[BEE] = {base_name = "Bee", min_hp = 1, max_hp = 2, img_rect = Rect2(1984,1984,32,32) }
