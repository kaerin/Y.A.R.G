extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var hp = 5

onready var grid_map = get_parent()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
	#expand for interaction between player and object
func set_contact(damage):
	hp -= damage
	print(name, ' hp: ', hp)
	if hp <= 0:
		grid_map.set_kill_me(self)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
