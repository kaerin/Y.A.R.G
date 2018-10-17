extends "res://Spells/Spell_Base.gd"

var amount			#how much
var cycle			#how often
var duration		#how long

#####################
# Set Functions
#####################

func set_amount(i):
	amount = i
	
func set_cycle(i):
	cycle = i	
	
func set_duration(i):
	duration = i
	
#####################
# Get Functions
#####################

func get_amount():
	return amount

func get_cycle():
	return cycle	
	
func get_duration():
	return duration


