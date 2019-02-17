extends Node

onready var Blood = preload("res://Animations/Effects/Blood_Splatter/Blood.tscn")
onready var Dmg_Counter = preload("res://Animations/Effects/Damage_Counter/Dmg_Count.tscn")
onready var Healing = preload("res://Animations/Effects/Healing/Healing.tscn")
onready var Bleeding = preload("res://Animations/Effects/Healing/Bleeding.tscn")
	
	
#############################
### Display blood splatter
#############################

func blood_splatter(direction, dmg):
	var node = get_obj_root(true)
	if node.is_in_group('Player'):
		if node.has_node(str('../Level-',G.Dlevel,'/Effects')):  
			node.get_node(str('../Level-',G.Dlevel,'/Effects')).add_blood(node, direction, dmg)# <--- adds to grid map. doesnt delete by death. (eg. blood splatter)
	elif node.is_in_group('Enemy'):
		if node.has_node(str('../../Effects')):  
			node.get_node(str('../../Effects')).add_blood(node, direction, dmg)# <--- adds to grid map. doesnt delete by death. (eg. blood splatter)
	
#	set_blood_splatter(direction, dmg, true)
#	rpc('set_blood_splatter', direction, dmg, false, G.Dlevel)

remote func set_blood_splatter(direction, dmg, is_master=false):
	var node = get_obj_root(is_master)
	var j = Blood.instance()
	j.direction = direction
	j.particle_count = dmg	
	j.position = node.position
	add_effect(node, j)
	
#############################
## Display damage counter
#############################	
	
func dmg_counter(dmg):
	set_dmg_counter(dmg, true)
	rpc('set_dmg_counter', dmg)
	
remote func set_dmg_counter(dmg, is_master=false):
	var node = get_obj_root(is_master)
	var j = Dmg_Counter.instance()
	j.dmg = dmg
	add_effect(node, j)
	
#############################
## effect for HP (damage or healing etc)
#############################

func healing(j):
	set_healing(j.duration, j.cycle, j.amount, true)
	rpc('set_healing', j.duration, j.cycle, j.amount)

remote func set_healing(i_duration, i_cycles, i_amount, is_master=false):
	var node = get_obj_root(is_master)
	var j = Healing.instance()
	j.duration = i_duration
	j.cycle = i_cycles
	j.amount_ = i_amount
	add_effect(node, j)
	
func bleeding(j):
	set_bleeding(j.duration, j.cycle, j.amount, true)
	rpc('set_bleeding', j.duration, j.cycle, j.amount)
	
remote func set_bleeding(i_duration, i_cycles, i_amount, is_master=false):
	var node = get_obj_root(is_master)
	var j = Bleeding.instance()
	j.duration = i_duration
	j.cycle = i_cycles
	j.amount_ = i_amount
	add_effect(node, j)

############################
# Repetative functions
############################

func get_obj_root(is_master=true):
	var node = get_parent()
	if node.is_in_group('Player') && not(is_master):
		var id = get_tree().get_rpc_sender_id()
		node = get_node('../..').get_node(str(id))	
	return node

func add_effect(node, j):
	node.get_node("Effects").add_child(j)	# <--- adds to object, deleted by death (eg. spell effect)


	