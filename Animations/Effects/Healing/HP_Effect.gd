extends Particles2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var parent = get_node("../..")

var duration = 0
var cycle = 0
var amount_ = 0

func _ready():
	emitting = true
	one_shot = false
	$Kill.wait_time = duration
	$Cycle.wait_time = cycle
	
func _on_Cycle_timeout():
	if not get_node("../..").is_in_group("Others"):			#Actual Players already RPC "dmg", "Others" would duplicate this
		parent.take_dmg(amount_, Vector2(0,0), false)

func _on_Kill_timeout():
	queue_free()