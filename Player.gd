extends KinematicBody2D

const UP 	= Vector2(0 ,-1)
const DOWN 	= Vector2(0 , 1)
const LEFT 	= Vector2(-1, 0)
const RIGHT	= Vector2(1 , 0)

onready var grid_map = get_parent()
onready var dic_weapon = get_node("/root/BaseNode/Dictionaries/Items").weapons
onready var inventory = get_node("Inventory")
onready var weapons = load("res://Items/Weapon.gd") #load class

var Dialog
var weap #weapon class

func _ready():
	weap = weapons.new() #create

func _process(delta):
	if Input.is_action_just_pressed("ui_p"):
		var item = grid_map.get_item(self)
		inventory.set_add_item(item)
		weap.print() #use class
		
		# DELME example only below
		var rnd_item = weap.create_rnd_item(dic_weapon) # so something like this then ? Preamble postamble would likely be internal calls in new class, instead of here
		print(rnd_item)
		print(rnd_item.base_name)
		var pre_item = weap.preamble(rnd_item)
		print(pre_item.base_name)
		var new_name = weap.postamble(pre_item)
		print(new_name.base_name)
		#DELME to here
	
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
