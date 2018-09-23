extends KinematicBody2D

const UP 	= Vector2(0 ,-1)
const DOWN 	= Vector2(0 , 1)
const LEFT 	= Vector2(-1, 0)
const RIGHT	= Vector2(1 , 0)

onready var grid_map = get_parent()
onready var dic_items = get_tree().get_root().get_node("Dictionaries/Items")
onready var inventory = get_node("Inventory")

func _process(delta):

	if Input.is_action_just_pressed("ui_p"):
		var item = grid_map.get_item(self)
		inventory.set_add_item(item)
	
	if Input.is_action_just_pressed("ui_next_weap"):
		inventory.next_weap()
	if Input.is_action_just_pressed("ui_prev_weap"):
		inventory.prev_weap()
		

	#Handles movement in 8 directions
#	var is_moving = Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_up_right") or Input.is_action_pressed("ui_up_left") or Input.is_action_pressed("ui_down_right") or Input.is_action_pressed("ui_down_left")
#	if is_moving: #Why test for a direction to set a variable only then to test for a direction to set a variable?
	
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
	#if not direction == Vector2(): #an emtpy vector will be false only need to test that the vector has any value
	if direction:
		var is_moving = true #What is_moving used for?
		#Check target grid point is valid
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
	direction = Vector2()
