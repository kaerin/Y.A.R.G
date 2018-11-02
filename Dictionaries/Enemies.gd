extends Node

enum	ENEMIES {GNOME,RAT, TURTLE, MOLE, BEE}

var enemies = {}

func _ready():
	enemies[RAT] = {base_name = G.En.Rat, min_hp = 4, max_hp = 80, img_rect = Rect2(2016,2400,32,32) }
	enemies[TURTLE] = {base_name = G.En.Turtle, min_hp = 1, max_hp = 40, img_rect = Rect2(1344,2048,32,32) }
	enemies[MOLE] = {base_name = G.En.Mole, min_hp = 8, max_hp = 120, img_rect = Rect2(416,2112,32,32)  }
	enemies[GNOME] = {base_name = G.En.Gnome, min_hp = 8, max_hp = 120, img_rect = Rect2(416,2112,32,32)  }
	enemies[BEE] = {base_name = G.En.Bee, min_hp = 1, max_hp = 20, img_rect = Rect2(1984,1984,32,32) }
