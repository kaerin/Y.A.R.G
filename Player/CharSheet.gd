extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var charsheet_displayed
onready var Char_Visu = load("res://Player/Char_Visu.tscn")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	if Input.is_action_just_pressed("char_sheet") || (charsheet_displayed && Input.is_action_just_pressed("ui_inv")):
		_character_sheet()
		
func _character_sheet():
	if charsheet_displayed: 
		$CharSheet.queue_free()
		charsheet_displayed = false
	else:
		if not charsheet_displayed:
			charsheet_displayed = true
			var char_visu = Char_Visu.instance()
			add_child(char_visu)
			$CharSheet.update_char_sheet()	
