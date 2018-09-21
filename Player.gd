extends KinematicBody2D

const UP 	= Vector2(0 ,-1)
const DOWN 	= Vector2(0 , 1)
const LEFT 	= Vector2(-1, 0)
const RIGHT	= Vector2(1 , 0)

onready var grid_map = get_parent()

func _ready():
	pass
		
func _process(delta):

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
			#check target cell contents in gridmap 
			var grid_contents = grid_map.get_cell_contents(self, direction)
			print(grid_contents)
			#if empty move to position
			if grid_contents == null: 
				position = grid_map.get_new_position(self, direction)
			#else kill contents of cell
			else:
				grid_map.set_cell_kill(self, direction)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
