extends Node

onready var Blood = preload("res://Animations/Effects/Blood_Splatter/Blood.tscn")
onready var Dmg_Counter = preload("res://Animations/Effects/Damage_Counter/Dmg_Count.tscn")
	
func blood_splatter(direction):
	set_blood_splatter(direction)
	rpc('set_blood_splatter', direction, get_parent().is_in_group('Player'))	#<---- functional, but maybe theres a better way

remote func set_blood_splatter(direction, is_player = false):
	var node = get_parent()
	if is_player:
		var id = get_tree().get_rpc_sender_id()
		node = get_node('../..').get_node(str(id))
	var i = Blood.instance()
	i.direction = direction
	node.add_child(i)
	
func dmg_counter(dmg):
	set_dmg_counter(dmg)
	rpc('set_dmg_counter', dmg, get_parent().is_in_group('Player')) #<---- functional, but maybe theres a better way
	
remote func set_dmg_counter(dmg, is_player = false):
	var node = get_parent()
	if is_player:
		var id = get_tree().get_rpc_sender_id()
		node = get_node('../..').get_node(str(id))
	var i = Dmg_Counter.instance()
	i.dmg = dmg
	node.add_child(i)
	
	