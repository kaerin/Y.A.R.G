extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var Blood = preload("res://Animations/Effects/Blood_Splatter/Blood.tscn")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


master func add_blood(node, direction, dmg):
	var j = Blood.instance()
	j.direction = direction
	j.particle_count = dmg	
	j.position = node.position
	if get_parent().level != G.Dlevel:
		j.hide()
	add_child(j)
	rpc('server_add_blood',node, direction, dmg)
	
remote func server_add_blood(node, direction, dmg):
	var j = Blood.instance()
	j.direction = direction
	j.particle_count = dmg	
	j.position = node.position
	if get_parent().level != G.Dlevel:
		j.hide()
	add_child(j)	