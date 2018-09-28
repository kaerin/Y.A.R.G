extends KinematicBody2D

const UP 	= Vector2(0 ,-1)
const DOWN 	= Vector2(0 , 1)
const LEFT 	= Vector2(-1, 0)
const RIGHT	= Vector2(1 , 0)

var hp = 0
var inventory = []
var weapon
var armour
var wearable
var type

var direction = Vector2()
var speed = 0
const MAX_SPEED = 200
var velocity = Vector2()
var is_moving = false
var target_pos = Vector2()
var target_direction = Vector2()

onready var player = get_node("../Player")
onready var grid_map = get_parent()
onready var dic_enemies = get_parent().get_parent().get_node("Dictionaries/Enemies").enemies
onready var dic_weapon = get_parent().get_parent().get_node("Dictionaries/Items").weapons
onready var dic_chest = get_parent().get_parent().get_node("Dictionaries/Items").chest
onready var dic_armour = get_parent().get_parent().get_node("Dictionaries/Items").armour
onready var dic_wear = get_parent().get_parent().get_node("Dictionaries/Items").wear
onready var Weapon = load("res://Items/Weapon.gd")
onready var Armour = load("res://Items/Armour.gd")
onready var Wearable = load("res://Items/Wearable.gd")

func _ready():
	player.connect("enemy_move", self, "set_move")
	type = grid_map.ENEMY
	weapon = Weapon.new(G.CHAR.ENEMY) #enemies can be given the same weapon class and weapon inventory
	armour = Armour.new(G.CHAR.ENEMY)
	wearable = Wearable.new(G.CHAR.ENEMY)
	#TODO random instancing of enemies in dictionary
	var rnd_enemy = randi() % dic_enemies.size()
	hp = randi() % (dic_enemies[rnd_enemy].max_hp - dic_enemies[rnd_enemy].min_hp) + dic_enemies[rnd_enemy].min_hp
	$Sprite/Label.text = dic_enemies[rnd_enemy].base_name
	
	#TEMP ONLY random item in inventory to test dropping
	var temp = randi() % 3 + 1 #testing
#	temp = 3 #testing
	if temp == 1:
		var rnd_item = randi() % dic_weapon.size() 
		inventory.append(dic_weapon[rnd_item])
		weapon.add_weapon(dic_weapon[rnd_item]) #equip enemy with random base weapon
	elif temp == 2:
		var rnd_item = randi() % dic_armour[0].size() #change pick random location then random armour
		var i = randi() % 2
		inventory.append(dic_armour[i][rnd_item]) #0 should be random
		armour.add_armour(dic_armour[i][rnd_item])
	elif temp == 3:
		var rnd_item = randi() % dic_wear.size() 
		inventory.append(dic_wear[rnd_item])
		wearable.add_wearable(dic_wear[rnd_item])


	
#TEMP ONLY for basic player enemy interaction test.
func set_contact(damage):
	hp -= damage
	print(name, ' hp: ', hp)
	if hp <= 0:
		grid_map.set_kill_me(self)
		
		
#after player moves all enemies are triggered to move from Grid_Map		
	
func set_move():
	direction = Vector2()
	if not is_queued_for_deletion(): #necessary, otherwise grid is updated with new position before being deleted
		var temp = randi() % 4
		if temp == 0:
			direction.x = 1
		elif temp == 1:
			direction.x = -1
		elif temp == 2:
			direction.y = 1
		elif temp == 3:
			direction.y = -1
#	if not grid_map.is_cell_empty(get_position(), direction):
#		print("cant go")
#		elif temp == 5:
#			direction = UP + RIGHT
#		elif temp == 6:
#			direction = RIGHT
#		elif temp == 7:
#			direction = DOWN + RIGHT
#		elif temp == 8:
#			direction = DOWN
#		elif temp == 9:
#			direction = Vector2()

func _process(delta):
	if not is_moving and not direction == Vector2():
		target_direction = direction
		if grid_map.is_cell_empty(get_position(), target_direction):
			target_pos = grid_map.update_child_pos(self)
			is_moving = true
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
