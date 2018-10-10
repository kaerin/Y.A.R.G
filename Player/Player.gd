extends KinematicBody2D

#const UP 	= Vector2(0 ,-1)
#const DOWN 	= Vector2(0 , 1)
#const LEFT 	= Vector2(-1, 0)
#const RIGHT	= Vector2(1 , 0)


onready var grid_map = get_parent()
onready var DicItems = get_node("/root/BaseNode/Dictionaries/Items")
onready var dic_classes = get_node("/root/BaseNode/Dictionaries/Classes").classes
onready var inv = get_node("Inv") #cause its labeled inv elswhere
onready var Game = get_node("/root/BaseNode")
onready var Attrib = load("res://Player/Attributes.gd")
onready var Stats = load("res://Player/Stats.gd")
onready var GenItems = load("res://Items/GenItems.gd")
onready var Combat = load("res://Player/Combat.gd")
onready var Skills = load("res://Player/Skills.gd")
onready var Spells = load("res://Player/Spells.gd")
#onready var weapons = load("res://Items/Weapon.gd") #load class
#onready var Map = get_node("../../Map")

var CHARTYPE = G.CHAR.PLAYER
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

var combat
var skills
var spells
var attributes
var stats

signal enemy_move

var Dialog
#var weap #weapon class

func _ready():
	var genItems = GenItems.new()
	
	inv.add_item(genItems.gen_weap(DicItems.weapons[G.WEAP.FIST]),true)
#	inv.weapon.inv[0].set_equipped(true)
	inv.add_item(genItems.gen_armour(DicItems.armour[G.LOC.CHEST][G.MAT.CLOTH]),true)
#	inv.armour.inv[0].set_equipped(true)
	inv.add_item(genItems.gen_wear(DicItems.wear[G.WEAR.NECKLACE]),true)
#	inv.wearable.inv[0].set_equipped(true)
	combat = Combat.new()
	skills = Skills.new()
	spells = Spells.new()
	
	type = grid_map.PLAYER
	if G.PlayerColor:
		modulate = G.PlayerColor
	attributes = Attrib.new()
	attributes.set_attributes(dic_classes[G.PlayerClass])
	stats = Stats.new()
	stats.set_weapon(inv.weapon) #1. get the weapon class from the inventory class and send it too the attrib class
	stats.set_wearable(inv.wearable) #1. get the weapon class from the inventory class and send it too the attrib class
	stats.set_armour(inv.armour) #1. get the weapon class from the inventory class and send it too the attrib class
	stats.set_attributes(attributes)
#	grid_map.create_grid()
#	grid_map.set_grid_pos(self, Map.start)

func _process(delta):

	if Input.is_action_just_pressed("ui_p"):
		var item = grid_map.get_item(self)
		if item:
			inv.add_item(item)
	if Input.is_action_just_pressed("level"):
		grid_map.chg_level(get_position()) #Make this better
	if Input.is_action_just_pressed("sell_items"):
		stats.gold += inv.sell_items() #simple function to sell all unequipped gear
	if Input.is_action_just_pressed("add_enemy"):
		Game.Dialog.print_label("You have added enemies")
		grid_map.add_enemies()
	if Input.is_action_just_pressed("next_level"):
		grid_map.chg_level(get_position(),1)
	if Input.is_action_just_pressed("prev_level"):
		grid_map.chg_level(get_position(),-1)
	if Input.is_action_just_pressed("rest"):
		stats.hp +=1000 #super healing
		if stats.hp > stats.hp_max:
			stats.hp = stats.hp_max
		print("Resting hp:",stats.hp)
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
			var enemy = grid_map.get_cell_node(get_position(), target_direction)
			if enemy:
				is_fighting = true
				$Timer.start()
				combat.attack(self,enemy)
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

func attack():
	print("Incorrect function")
	var enemy = grid_map.get_cell_node(get_position(), target_direction)
	if enemy:
		is_fighting = true
		var roll = randi() % 20
		enemy.take_dmg(roll, stats.get_dmg()) #weapon needs to get equippped
		$Timer.start()

func take_dmg(dmg):
#	print("Incorrect function")
#	stats.test_print_method() #4. Used as a trigger to call methods in wepaon from attrib
#	if roll > stats.get_res(dmg):
	stats.hp -= dmg		# THIS IS SHITTY. was working on resistance and just needed a hack here for now.
#	print("roll:",roll, " target:",stats.get_res(dmg), "You took " + str(dmg) + " damage. HP:" + str(hp))
	if stats.hp < 0:
		get_tree().change_scene("res://Scenes/End.tscn")

func _on_Timer_timeout():
	is_fighting = false