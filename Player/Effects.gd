extends Node

onready var Blood = preload("res://Animations/Effects/Blood_Splatter/Blood.tscn")
onready var Dmg_Counter = preload("res://Animations/Effects/Damage_Counter/Dmg_Count.tscn")
onready var Healing = preload("res://Animations/Effects/Healing/Healing.tscn")
onready var Bleeding = preload("res://Animations/Effects/Healing/Bleeding.tscn")
	
	
#############################
### Display blood splatter
#############################

func blood_splatter(direction, dmg): 
	set_blood_splatter(direction, dmg)
	rpc('set_blood_splatter', direction, dmg, get_parent().is_in_group('Player'))	#<---- functional, but maybe theres a better way

remote func set_blood_splatter(direction, dmg , is_player = false):
	var node = get_obj_root(is_player)
	var j = Blood.instance()	# <--- maybe consider instancing to grid_map, so is not deleted by early enemy death.
	j.direction = direction
	j.particle_count = dmg	
#	if node.is_in_group("Enemy"):
	j.position = node.position	# <--- Not sure why this is necessary
	add_effect(node, j, true)
	
#############################
## Display damage counter
#############################	
	
func dmg_counter(dmg):
	set_dmg_counter(dmg)
	rpc('set_dmg_counter', dmg, get_parent().is_in_group('Player')) #<---- functional, but maybe theres a better way
	
remote func set_dmg_counter(dmg, is_player = false):
	var node = get_obj_root(is_player)
	var j = Dmg_Counter.instance()
	j.dmg = dmg
	add_effect(node, j)
	
#############################
## effect for HP (damage or healing etc)
#############################

func healing(i):
	var node = get_obj_root(get_parent().is_in_group('Player'), false)	
	var j = Healing.instance()
	j.duration = i.get_duration()
	j.cycle = i.get_cycle()
	j.amount_ = i.get_amount()
	add_effect(node, j)
	rpc('set_healing', j.duration, j.cycle, j.amount, get_parent().is_in_group('Player')) #<---- functional, but maybe theres a better way

remote func set_healing(i_duration, i_cycles, i_amount, is_player=false):
	var node = get_obj_root(is_player, true)
	var j = Healing.instance()
	j.duration = i_duration
	j.cycle = i_cycles
	j.amount_ = i_amount
	add_effect(node, j)
	
func bleeding(i):
	var node = get_obj_root(get_parent().is_in_group('Player'), false)	
	var j = Bleeding.instance()
	j.duration = i.get_duration()
	j.cycle = i.get_cycle()
	j.amount_ = i.get_amount()
	add_effect(node, j)
	rpc('set_bleeding', j.duration, j.cycle, j.amount, get_parent().is_in_group('Player')) #<---- functional, but maybe theres a better way
	
remote func set_bleeding(i_duration, i_cycles, i_amount, is_player=false):
	var node = get_obj_root(is_player, true)
	var j = Bleeding.instance()
	j.duration = i_duration
	j.cycle = i_cycles
	j.amount_ = i_amount
	add_effect(node, j)

############################
# Repetative functions
############################

func get_obj_root(is_player, is_client=true):
	var node = get_parent()
	if is_player && is_client:
		var id = get_tree().get_rpc_sender_id()
		node = get_node('../..').get_node(str(id))	
	return node

func add_effect(node, j, effect_after_death=false):		#will expand "effect after death later"
#	if node.is_in_group("Enemy"):
	if effect_after_death == true:
		node.get_node("../..").add_child(j)  # <--- adds to grid map. doesnt delete by death. (eg. blood splatter)
	else:
		node.get_node("Effects").add_child(j)
#	else:	
#		node.get_node("Effects").add_child(j)


	