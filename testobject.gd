extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const UP 	= Vector2(0 ,-1)
const DOWN 	= Vector2(0 , 1)
const LEFT 	= Vector2(-1, 0)
const RIGHT	= Vector2(1 , 0)

var hp = 5
var direction = Vector2()

onready var grid_map = get_parent()

func _ready():
	pass
	
#expand for interaction between player and object
func set_contact(damage):
	hp -= damage
	print(name, ' hp: ', hp)
	if hp <= 0:
		grid_map.set_kill_me(self)
		
		
#after player moves all enemies are triggered to move from Grid_Map		
func set_move():
	if not is_queued_for_deletion(): #necessary, otherwise grid is updated with new position before being deleted
		var temp = randi() % 9 + 1
		if temp == 1:
			direction = DOWN + LEFT
		elif temp == 2:
			direction = LEFT
		elif temp == 3:
			direction = UP + LEFT
		elif temp == 4:
			direction = UP
		elif temp == 5:
			direction = UP + RIGHT
		elif temp == 6:
			direction = RIGHT
		elif temp == 7:
			direction = DOWN + RIGHT
		elif temp == 8:
			direction = DOWN
		elif temp == 9:
			direction = Vector2()
			
		if not direction == Vector2():
			
				#check grid map array bounds
				if grid_map.is_target_inside_grid(self, direction):
					
					#check target cell contents in gridmap 
					var grid_contents = grid_map.get_cell_contents(self, direction)
					
					#if empty move to position
					if grid_contents == null: 
						position = grid_map.get_new_position(self, direction)		

		
	
		
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
