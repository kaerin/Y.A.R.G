extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

enum	ITEMS {SWORD, DAGGER, CLUB, SPEAR}

var items = {}



func _ready():
	items[SWORD] = {base_name = "Sword", min_damage = 6, max_damage = 12 }
	items[DAGGER] = {base_name = "Dagger", min_damage = 1, max_damage = 4}
	items[CLUB] = {base_name = "Club", min_damage = 2, max_damage = 6}
	items[SPEAR] = {base_name = "Spear", min_damage = 1, max_damage = 10}
	
		# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
