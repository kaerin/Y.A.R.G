extends KinematicBody2D

const UP 	= Vector2(0 ,-1)
const DOWN 	= Vector2(0 , 1)
const LEFT 	= Vector2(-1, 0)
const RIGHT	= Vector2(1 , 0)
const DIRS = [UP,DOWN,LEFT,RIGHT]

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

onready var player = get_node("/root/BaseNode/Player")
onready var grid_map = get_parent().get_parent()
onready var Game = get_node("/root/BaseNode")
onready var dic_enemies = Game.get_node("Dictionaries/Enemies").enemies
onready var dic_weapon = Game.get_node("Dictionaries/Items").weapons
onready var dic_chest = Game.get_node("Dictionaries/Items").chest
onready var dic_armour = Game.get_node("Dictionaries/Items").armour
onready var dic_wear = Game.get_node("Dictionaries/Items").wear
onready var dic_classes = get_node("/root/BaseNode/Dictionaries/Classes").classes
onready var Weapon = load("res://Items/Weapon.gd")
onready var Armour = load("res://Items/Armour.gd")
onready var Wearable = load("res://Items/Wearable.gd")
onready var Inventory = load("res://Inv/Inv.gd")
onready var Spells = load("res://Spells/Spells.gd")
onready var GenItems = load("res://Items/GenItems.gd")
onready var Combat = load("res://Player/Combat.gd")

onready var Attrib = load("res://Player/Attributes.gd")
onready var Stats = load("res://Player/Stats.gd")
var attributes
var stats
var genItems
var combat
var skills
var spells
var enemy

func _ready():
#	print(G.MAT.CLOTH)
	combat = Combat.new()
	genItems = GenItems.new()
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
	type = Game.ENEMY
#	weapon = Weapon.new(G.CHAR.ENEMY) #enemies can be given the same weapon class and weapon inventory
#	armour = Armour.new(G.CHAR.ENEMY)
#	wearable = Wearable.new(G.CHAR.ENEMY)
	#TODO random instancing of enemies in dictionary
	var enemyIndex = randi() % (dic_enemies.size()+2)
	if enemyIndex >= dic_enemies.size():
		enemyIndex = 0 #Hack to make more gnomes
	enemy = dic_enemies[enemyIndex] #simplify
#	enemy = dic_enemies[1] #new enemy testing
	stats.hp = randi() % (enemy.max_hp - enemy.min_hp) + enemy.min_hp
	stats.hp += G.Dlevel #increase hp by level
	$Sprite/Label.text = enemy.base_name
	$Sprite.set_region_rect(enemy.img_rect)
	Name = enemy.base_name
	chg_name()
	
	#TEMP ONLY random item in inventory to test dropping
#	var temp = randi() % 3 + 1 #testing
#	temp = 3 #testing
#	if temp == 1:
	if enemy.base_name == G.En.Rat or enemy.base_name == G.En.Mole: #Rat short be a global constant not plain text
		inv.add_item(genItems.gen_weap(dic_weapon[G.WEAP.TEETH]),true)
#		inv.weapon.inv[0].set_equipped(true) #equip teeth
	elif enemy.base_name == G.En.Turtle:
		inv.add_item(genItems.gen_weap(dic_weapon[G.WEAP.CLAW]),true) #add teeth weapon
#		inv.weapon.inv[0].set_equipped(true) #equip teeth
	elif enemy.base_name == G.En.Bee:
		inv.add_item(genItems.gen_weap(dic_weapon[G.WEAP.TAIL]),true) #add teeth weapon
#		inv.weapon.inv[0].set_equipped(true)
	else: #or add a random weapon to the inventory
		var rnd_item = randi() % (dic_weapon.size()) 
		while not dic_weapon[rnd_item].base_type == G.BaseType.Weap: #dont't assign body weapons to inventory
			rnd_item = randi() % (dic_weapon.size())
	#		inventory.append(dic_weapon[rnd_item])
		inv.add_item(genItems.gen_weap(dic_weapon[rnd_item]),true) #equip enemy with random base weapon
#		inv.weapon.inv[0].set_equipped(true)
	#	elif temp == 2:
	 #change pick random location then random armour
	var i = randi() % 2
	var rnd_item = randi() % dic_armour[i].size()
#		inventory.append(dic_armour[i][rnd_item]) #0 should be random
	var equip = false
	if enemy.base_name == G.En.Gnome:
		equip = true
	else:
		inv.add_item(genItems.gen_armour(dic_armour[G.LOC.CHEST][G.MAT.SKIN]),true) #skin armour
	inv.add_item(genItems.gen_armour(dic_armour[i][rnd_item]),equip)
#	elif temp == 3:
	rnd_item = randi() % dic_wear.size() 
#		inventory.append(dic_wear[rnd_item])
	inv.add_item(genItems.gen_wear(dic_wear[rnd_item]),equip)
	$Timer.wait_time = randi() % 10 + 1



func chg_name():
	var pre = ["Rusty the", "Flaming", "Denim wearing", "Sparkling", "Normal", "Pathetic", "Crappy", "Super powered", "Moody"]
	var post = ["of dull colors.", "with spikes", "taking a dump", "that glows", "name Jonny", "that probably tastes funny"]
	Name = pre[randi() % pre.size()] + " " + Name + " " + post[randi() % post.size()]
	
#TEMP ONLY for basic player enemy interaction test.
func take_dmg(dmg):
#	print("Incorrect function")
#	if roll > stats.get_res(dmg):
#		hp -= dmg[0][1]		# THIS IS SHITTY. was working on resistance and just needed a hack here for now.
#		print("roll:",roll, " target:", stats.get_res(dmg), " ",Name, " took " + str(dmg) + " damage. HP:" + str(hp))
	stats.hp -= dmg
	if stats.hp <= 0:
		var i = stats.attacker
		i.stats.expr += 10
		Game.stats.set_exp(i.stats.expr)
		grid_map.set_kill_me(self)
	else:
		combat.attack(self,player) #Fight player
		
		
#after player moves all enemies are triggered to move from Grid_Map		
func attack():
	print("Incorrect function")
	var roll = randi() % 20 + G.Dlevel
	print("Attacks with ", inv.weapon.get_name(), " rolls:", roll)
	player.take_dmg(roll, stats.get_dmg())#+G.Dlevel)
	#this should call for each individual attack type. but im out of time.
	#hacked above in Take_damage that only first attack does acctual damage.
	
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
	if N.is_server:
		if not is_moving and not direction == Vector2():
			target_direction = direction
			var attacking = false
			for i in DIRS:
				if grid_map.is_cell_player(get_position(), i):
					combat.attack(self, player)
					attacking = true
			if grid_map.is_cell_empty(get_position(), target_direction) and not attacking:
				target_pos = grid_map.update_child_pos(self)
				is_moving = true
				rpc('sync_move', target_pos, target_direction)
			elif grid_map.is_cell_player(get_position(), target_direction) and not attacking:
				combat.attack(self,player) #Fight player
		elif is_moving:
			speed = MAX_SPEED
			velocity = speed * target_direction.normalized() * delta
			move_and_collide(velocity)
			
			var pos = get_position()
			var distance_to_target = Vector2(abs(target_pos.x - pos.x), abs(target_pos.y - pos.y))
			if abs(velocity.x) > distance_to_target.x:
				velocity.x = distance_to_target.x * target_direction.x
				is_moving = false
#				rpc('sync_move', target_pos)
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
