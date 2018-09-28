extends KinematicBody2D

#const UP 	= Vector2(0 ,-1)
#const DOWN 	= Vector2(0 , 1)
#const LEFT 	= Vector2(-1, 0)
#const RIGHT	= Vector2(1 , 0)


onready var grid_map = get_parent()
onready var dic_weapon = get_node("/root/BaseNode/Dictionaries/Items").weapons
onready var inventory = get_node("Inventory")
onready var Game = get_node("/root/BaseNode")
#onready var weapons = load("res://Items/Weapon.gd") #load class
#onready var Map = get_node("../../Map")

var direction = Vector2()
var speed = 0
const MAX_SPEED = 200
var velocity = Vector2()
var type
var grid
var is_moving = false
var target_pos = Vector2()
var target_direction = Vector2()

signal enemy_move

var Dialog
#var weap #weapon class

func _ready():
	type = grid_map.PLAYER
#	grid_map.create_grid()
#	grid_map.set_grid_pos(self, Map.start)

func _process(delta):
	
	if Input.is_action_just_pressed("ui_p"):
		var item2 = grid_map.get_item2(self)
		inventory.add_item(item2)
		
		var item = grid_map.get_item(self) #needed for the moment as it cleans up items fro grid
#		inventory.set_add_item(item)
		
		
#		weap.print() #use class
		
		# DELME example only below
#		var rnd_item = weap.create_rnd_item(dic_weapon) # so something like this then ? Preamble postamble would likely be internal calls in new class, instead of here
#		print(rnd_item)
#		print(rnd_item.base_name)
#		var pre_item = weap.preamble(rnd_item)
#		print(pre_item.base_name)
#		var new_name = weap.postamble(pre_item)
#		print(new_name.base_name)
		#DELME to here
		
	if Input.is_action_just_pressed("add_enemy"):
		Game.Dialog.print_label("You have added an enemy")
		grid_map.add_enemies()
	
	direction = Vector2()
	if Input.is_action_pressed("ui_up"):
		direction.y = -1
	elif Input.is_action_pressed("ui_down"):
		direction.y = 1
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
	elif Input.is_action_pressed("ui_right"):
		direction.x = 1
#	elif Input.is_action_pressed("ui_up_right"):
#		direction = RIGHT + UP
#	elif Input.is_action_pressed("ui_up_left"):
#		direction = LEFT + UP
#	elif Input.is_action_pressed("ui_down_left"):
#		direction = LEFT + DOWN
#	elif Input.is_action_pressed("ui_down_right"):
#		direction = RIGHT + DOWN
#	if not direction == Vector2():
#		speed = MAX_SPEED
#	else:
#		speed = 0
	
#	var target_pos = grid_map.update_child_pos(self)
#	set_position(target_pos)

	if not is_moving and not direction == Vector2():
		target_direction = direction
		if grid_map.is_cell_empty(get_position(), target_direction):
			target_pos = grid_map.update_child_pos(self)
			is_moving = true
		elif grid_map.is_cell_enemy(get_position(), target_direction):
			print("fight")
	elif is_moving:
		speed = MAX_SPEED
		velocity = speed * target_direction.normalized() * delta
		move_and_collide(velocity)
		
		var pos = get_position()
		var distance_to_target = Vector2(abs(target_pos.x - pos.x), abs(target_pos.y - pos.y))
		if abs(velocity.x) > distance_to_target.x:
			velocity.x = distance_to_target.x * target_direction.x
			is_moving = false
			emit_signal("enemy_move")
		if abs(velocity.y) > distance_to_target.y:
			velocity.y = distance_to_target.y * target_direction.y
			is_moving = false
			emit_signal("enemy_move")
#	if direction:
#
#		velocity = speed * direction.normalized() * delta
		if false:
			if grid_map.is_target_grid_valid(self,direction):		
				#check target cell contents in gridmap 
				var obsticle = grid_map.has_target_grid_obsticle(self, direction)
				#if empty move to player position
				if obsticle == null: 
					position = grid_map.set_new_grid_pos(self, direction)
				#TODO else set contact/damage with object
				else:
					#TEMP basic attack for testing
					var damage = inventory.get_damage() #can call the method in inventory
					damage = inventory.weapon.get_damage() #can call the method from the weapon class in inventory
					print (inventory.weapon.equipped) #can get active weapon index from inventory
					damage = inventory.weapon.equipped.get_damage() #can directly call get damage from a specific weapon in the weapon inventory
					#alter damage with environmental effects
					#damage = damage + environment.get_damage()
					obsticle.set_contact(inventory.get_damage()) #Use inventory get_damage for now
				#Only trigger turn if movement was valid	
				grid_map.set_enemy_move()
	