extends KinematicBody2D

const UP 	= Vector2(0 ,-1)
const DOWN 	= Vector2(0 , 1)
const LEFT 	= Vector2(-1, 0)
const RIGHT	= Vector2(1 , 0)
const DIRS = [UP,DOWN,LEFT,RIGHT]

var hp = 0
var inventory
var weapon
var armour
var wearable
var type
var facing = true
var Name

var CHARTYPE = G.CHAR.ENEMY
var direction = Vector2()
var speed = 0
const MAX_SPEED = 200
var velocity = Vector2()
var is_moving = false
var target_pos = Vector2()
var target_direction = Vector2()
var inv

onready var player = get_node("../Player")
onready var grid_map = get_parent()
onready var dic_enemies = get_parent().get_parent().get_node("Dictionaries/Enemies").enemies
onready var dic_weapon = get_parent().get_parent().get_node("Dictionaries/Items").weapons
onready var dic_chest = get_parent().get_parent().get_node("Dictionaries/Items").chest
onready var dic_armour = get_parent().get_parent().get_node("Dictionaries/Items").armour
onready var dic_wear = get_parent().get_parent().get_node("Dictionaries/Items").wear
onready var dic_classes = get_node("/root/BaseNode/Dictionaries/Classes").classes
onready var Weapon = load("res://Items/Weapon.gd")
onready var Armour = load("res://Items/Armour.gd")
onready var Wearable = load("res://Items/Wearable.gd")
onready var Inventory = load("res://Inv/Inv.gd")

onready var Attrib = load("res://Player/Attributes.gd")
onready var Stats = load("res://Player/Stats.gd")
var attributes
var stats
var gold = 0

func _ready():
	print(G.MAT.CLOTH)
	attributes = Attrib.new()
	attributes.set_attributes(dic_classes[4]) #FIX this static index
	inv = Inventory.new()
	add_child(inv)
	stats = Stats.new()
	stats.set_weapon(inv.weapon) #1. get the weapon class from the inventory class and send it too the attrib class
	stats.set_wearable(inv.wearable) #1. get the weapon class from the inventory class and send it too the attrib class
	stats.set_armour(inv.armour) #1. get the weapon class from the inventory class and send it too the attrib class
	stats.set_attributes(attributes)
	
	
	player.connect("enemy_move", self, "set_move")
	type = grid_map.ENEMY
#	weapon = Weapon.new(G.CHAR.ENEMY) #enemies can be given the same weapon class and weapon inventory
#	armour = Armour.new(G.CHAR.ENEMY)
#	wearable = Wearable.new(G.CHAR.ENEMY)
	#TODO random instancing of enemies in dictionary
	var enemy = dic_enemies[randi() % dic_enemies.size()] #simplify
#	enemy = dic_enemies[0] #rat testing
	hp = randi() % (enemy.max_hp - enemy.min_hp) + enemy.min_hp
	hp += G.level #increase hp by level
	$Sprite/Label.text = enemy.base_name
	$Sprite.set_region_rect(enemy.img_rect)
	Name = enemy.base_name
	chg_name()
	
	#TEMP ONLY random item in inventory to test dropping
#	var temp = randi() % 3 + 1 #testing
#	temp = 3 #testing
#	if temp == 1:
	if enemy.base_name == G.En.Rat or enemy.base_name == G.En.Mole: #Rat short be a global constant not plain text
		inv.weapon.add_weapon(dic_weapon[G.WEAP.TEETH]) #add teeth weapon
		inv.weapon.inv[0].set_equipped(true) #equip teeth
	elif enemy.base_name == G.En.Turtle:
		inv.weapon.add_weapon(dic_weapon[G.WEAP.CLAW]) #add teeth weapon
		inv.weapon.inv[0].set_equipped(true) #equip teeth
	elif enemy.base_name == G.En.Bee:
		inv.weapon.add_weapon(dic_weapon[G.WEAP.TAIL]) #add teeth weapon
		inv.weapon.inv[0].set_equipped(true)
	else: #or add a random weapon to the inventory
		var rnd_item = randi() % (dic_weapon.size()) 
		while not dic_weapon[rnd_item].base_type == G.BaseType.Weap: #dont't assign body weapons to inventory
			rnd_item = randi() % (dic_weapon.size())
	#		inventory.append(dic_weapon[rnd_item])
		inv.weapon.add_weapon(dic_weapon[rnd_item]) #equip enemy with random base weapon
	#	elif temp == 2:
	var rnd_item = randi() % dic_armour[0].size() #change pick random location then random armour
	var i = randi() % 2
#		inventory.append(dic_armour[i][rnd_item]) #0 should be random
	inv.armour.add_armour(dic_armour[i][rnd_item])
#	elif temp == 3:
	rnd_item = randi() % dic_wear.size() 
#		inventory.append(dic_wear[rnd_item])
	inv.wearable.add_wearable(dic_wear[rnd_item])
	$Timer.wait_time = randi() % 5 + 1



func chg_name():
	var pre = ["Rusty the", "Flaming", "Denim wearing", "Sparkling", "Normal", "Pathetic", "Crappy", "Super powered", "Moody"]
	var post = ["of dull colors.", "with spikes", "taking a dump", "that glows", "name Jonny", "that probably tastes funny"]
	Name = pre[randi() % pre.size()] + " " + Name + " " + post[randi() % post.size()]
	
#TEMP ONLY for basic player enemy interaction test.
func take_dmg(roll, dmg):
	if roll > inv.get_ac():
		hp -= dmg
		print("roll:",roll, " target:", inv.get_ac(), " ",Name, " took " + str(dmg) + " damage. HP:" + str(hp))
		if hp <= 0:
			grid_map.set_kill_me(self)
		else:
			attack() #Fight player
		
		
#after player moves all enemies are triggered to move from Grid_Map		
func attack():
	var roll = randi() % 20 + G.level
	print("Attacks with ", inv.weapon.get_name(), " rolls:", roll)
	player.take_dmg(roll, inv.get_damage()+G.level)
	
func set_move():
#	if not $Timer.is_stopped():
#		$Timer.stop()
	$Timer.wait_time = randi() % 5 + 1
	var i = 0
	while not grid_map.is_cell_empty(get_position(), direction):
		i += 1
		direction = Vector2()
		var temp = randi() % 5
		temp = randi() % 4
		if temp == 0:
			direction.x = -1
			if facing:
				facing = false
				$Sprite.set_flip_h(facing)
		elif temp == 1:
			direction.x = 1
			if not facing:
				facing = true
				$Sprite.set_flip_h(facing)
		elif temp == 2:
			direction.y = 1
		elif temp == 3:
			direction.y = -1
		if i > 10 or temp == 4:
			break

func _process(delta):
	if not is_moving and not direction == Vector2():
		target_direction = direction
		var attacking = false
		for i in DIRS:
			if grid_map.is_cell_player(get_position(), i):
				attack()
				attacking = true
		if grid_map.is_cell_empty(get_position(), target_direction) and not attacking:
			target_pos = grid_map.update_child_pos(self)
			is_moving = true
		elif grid_map.is_cell_player(get_position(), target_direction) and not attacking:
			attack() #Fight player
	elif is_moving:
		speed = MAX_SPEED
		velocity = speed * target_direction.normalized() * delta
		move_and_collide(velocity)
		
		var pos = get_position()
		var distance_to_target = Vector2(abs(target_pos.x - pos.x), abs(target_pos.y - pos.y))
		if abs(velocity.x) > distance_to_target.x:
			velocity.x = distance_to_target.x * target_direction.x
			is_moving = false
		if abs(velocity.y) > distance_to_target.y:
			velocity.y = distance_to_target.y * target_direction.y
			is_moving = false
	direction = Vector2()
#		if not direction == Vector2():
#
#			if grid_map.is_target_grid_valid(self,direction):
#				#check target cell contents in gridmap 
#				var obsticle = grid_map.has_target_grid_obsticle(self, direction)
#					#if empty move to position
#				if obsticle == null: 
#					position = grid_map.set_new_grid_pos(self, direction)
