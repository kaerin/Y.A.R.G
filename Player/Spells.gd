extends Node

onready var Heal = load("res://Spells/Heal.gd")
onready var Damage = load("res://Spells/Damage.gd")
onready var Buff = load("res://Spells/Buff.gd")
onready var Effects = get_node("../Effects")
onready var parent = get_parent()

#var inv_displayed = false
var heal
var damage
var buff

func _ready():
	heal = Heal.new() 
	damage = Damage.new()
	buff = Buff.new()
	
func cast_spell():
	Effects.healing(heal.spells[0].get_duration())	# <---- Ultra hack. will clean up later as below.
	
	#need way to add cyclical health boosts here, x amount y times. (plus other types of spells)
	#likely add a insatnced scene under spells that handles this, easy handling of timers and self destruction in node tree.
	#Then multiple healing types are possible in parallel. plus something like dispell magic can just kill all children
	#under Spells.
	#instanced child under Spells should call animation effects instead of here. this should just create child under spells
	#and pass relevant spell data across.
	
	#Quickslots, (temporarily a call from Player node) should be a divided bar across the bottom of GUI that you can drag and drop spells/skills into.
	#pressing 1 to 10 or clicking on them should cast/activate them.
	

	