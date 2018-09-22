extends KinematicBody2D

const UP 	= Vector2(0 ,-1)
const DOWN 	= Vector2(0 , 1)
const LEFT 	= Vector2(-1, 0)
const RIGHT	= Vector2(1 , 0)

onready var grid_map = get_parent()
onready var dic_items = get_tree().get_root().get_node("Dictionaries/Items")
onready var inventory = get_node("Inventory")



func _ready():
	pass
	
	
		
func _process(delta):
	
	#TODO only temporary to test weapon changes
	if Input.is_action_just_pressed("ui_select"):
		get_node("Inventory").set_change_weapon()

	#Handles movement in 8 directions
	var is_moving = Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_up_right") or Input.is_action_pressed("ui_up_left") or Input.is_action_pressed("ui_down_right") or Input.is_action_pressed("ui_down_left")

	if is_moving:
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
		if not direction == Vector2():

			#Check target grid point is valid
			if grid_map.is_target_grid_valid(self,direction):		
				#check target cell contents in gridmap 
				var grid_contents = grid_map.has_target_grid_obsticle(self, direction)
				#if empty move to player position
				if grid_contents == null: 
					position = grid_map.set_new_grid_pos(self, direction)
				#TODO else set contact/damage with object
				else:
					var damage = inventory.get_damage()
					grid_contents.set_contact(damage)
				#Only trigger turn if movement was valid	
				grid_map.set_enemy_move()
		direction = Vector2()
