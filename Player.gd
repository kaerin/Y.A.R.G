extends KinematicBody2D

const UP 	= Vector2(0 ,-1)
const DOWN 	= Vector2(0 , 1)
const LEFT 	= Vector2(-1, 0)
const RIGHT	= Vector2(1 , 0)

onready var grid_map = get_parent()
onready var dic_items = get_tree().get_root().get_node("Dictionaries/Items")
onready var inventory = get_node("Inventory")

var Dialog
	
func _process(delta):
	if Input.is_action_just_pressed("ui_p"):
		var item = grid_map.get_item(self)
		inventory.set_add_item(item)
	
	if Input.is_action_just_pressed("add_enemy"):
		Dialog = get_node("/root/BaseNode/Grid/Dialog")
		Dialog.set_label("You have added an enemy")
		Dialog.show_label() #Find label, Set label then show it, will timeout and hide after 1 second
		grid_map.add_enemies()
	
	var direction = Vector2()
	if Input.is_action_just_pressed("ui_up"):
		direction = UP
	elif Input.is_action_just_pressed("ui_down"):
		direction = DOWN
	elif Input.is_action_just_pressed("ui_left"):
		direction = LEFT
	elif Input.is_action_just_pressed("ui_right"):
		direction = RIGHT
	elif Input.is_action_just_pressed("ui_up_right"):
		direction = RIGHT + UP
	elif Input.is_action_just_pressed("ui_up_left"):
		direction = LEFT + UP
	elif Input.is_action_just_pressed("ui_down_left"):
		direction = LEFT + DOWN
	elif Input.is_action_just_pressed("ui_down_right"):
		direction = RIGHT + DOWN
		
	if direction:
		if grid_map.is_target_grid_valid(self,direction):		
			#check target cell contents in gridmap 
			var obsticle = grid_map.has_target_grid_obsticle(self, direction)
			#if empty move to player position
			if obsticle == null: 
				position = grid_map.set_new_grid_pos(self, direction)
			#TODO else set contact/damage with object
			else:
				#TEMP basic attack for testing
				var damage = inventory.get_damage()
				obsticle.set_contact(damage)
			#Only trigger turn if movement was valid	
			grid_map.set_enemy_move()
