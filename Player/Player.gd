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
var is_fighting = false
var target_pos = Vector2()
var target_direction = Vector2()
var facing = false
var hp = 100
var hp_max = 100
var strength = 18
var dexterity = 10
var intelligence = 9

signal enemy_move

var Dialog
#var weap #weapon class

func _ready():
	type = grid_map.PLAYER
	if G.PlayerColor:
		modulate = G.PlayerColor
#	grid_map.create_grid()
#	grid_map.set_grid_pos(self, Map.start)

func _process(delta):
	if hp < 0:
		get_tree().change_scene("res://End.tscn")
	if Input.is_action_just_pressed("ui_p"):
		var item = grid_map.get_item(self)
		if item:
			inventory.add_item(item)
	if Input.is_action_just_pressed("level"):
		grid_map.chg_level(get_position()) #Make this better
		
	if Input.is_action_just_pressed("add_enemy"):
		Game.Dialog.print_label("You have added an enemy")
		grid_map.add_enemies()
	if Input.is_action_just_pressed("next_level"):
		grid_map.chg_level(get_position(),true)
	if Input.is_action_just_pressed("rest"):
		hp +=1
		if hp > hp_max:
			hp = hp_max
		print("Resting hp:",hp)
		emit_signal("enemy_move")
	direction = Vector2()
	if Input.is_action_pressed("ui_up"):
		direction.y = -1
	elif Input.is_action_pressed("ui_down"):
		direction.y = 1
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
		if facing:
			facing = false
			$Sprite.set_flip_h(facing)
	elif Input.is_action_pressed("ui_right"):
		direction.x = 1
		if not facing:
			facing = true
			$Sprite.set_flip_h(facing)
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
#		print(target_direction)
		if grid_map.is_cell_empty(get_position(), target_direction):
			target_pos = grid_map.update_child_pos(self)
			is_moving = true
		elif grid_map.is_cell_enemy(get_position(), target_direction) and not is_fighting:
			print("fight")
			is_fighting = true
			var enemy = grid_map.get_cell_node(get_position(), target_direction)
			if enemy:
				enemy.set_contact(inventory.get_damage()) #weapon needs to get equippped
			$Timer.start()
	elif is_moving:
		speed = MAX_SPEED
		velocity = speed * target_direction.normalized() * delta
#		print(velocity)
		move_and_collide(velocity)
		
		var pos = get_position()
		var distance_to_target = Vector2(abs(target_pos.x - pos.x), abs(target_pos.y - pos.y))
#		print(distance_to_target)
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

func take_dmg(dmg = 0):
	hp -= dmg
	print("You took " + str(dmg) + " damage. HP:" + str(hp))

func _on_Timer_timeout():
	is_fighting = false
