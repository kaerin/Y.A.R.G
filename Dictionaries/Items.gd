extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

enum	WEAPON {SWORD, DAGGER}

var weapon = {}



func _ready():
	weapon[0] = {base_name = "sword", min_damage = 2, max_damage = 8 }
	weapon[1] = {base_name = "dagger", min_damage = 1, max_damage = 4}
	print(weapon)
	
		# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
