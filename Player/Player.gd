extends KinematicBody2D

#const UP 	= Vector2(0 ,-1)
#const DOWN 	= Vector2(0 , 1)
#const LEFT 	= Vector2(-1, 0)
#const RIGHT	= Vector2(1 , 0)
#enum GRID_ITEMS {EMPTY, PLAYER, WALL, ITEM, ENEMY}

#onready var grid_map = get_parent()
var grid_map setget set_gm
onready var DicItems = get_node("/root/BaseNode/Dictionaries/Items")
onready var dic_classes = get_node("/root/BaseNode/Dictionaries/Classes").classes
onready var inv = get_node("Inv") #cause its labeled inv elswhere
onready var Game = get_node("/root/BaseNode")
onready var Attrib = load("res://Player/Attributes.gd")
onready var Stats = load("res://Player/Stats.gd")
onready var GenItems = load("res://Items/GenItems.gd")
onready var Combat = load("res://Player/Combat.gd")
onready var Chat = load("res://Network/Chat.tscn")
onready var Admin = preload("res://Admin/Admin.tscn")
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
var chat_displayed
var admin = false
var id = 1
var last_request = Vector2(-1,-1)

var combat
var skills
var spells
var attributes
var stats

signal enemy_move

var Dialog
#var weap #weapon class

func chk_level():
	
	pass
#	Game.stats.set_level(stats.level)
remote func chk_grid():
	grid = get_node("../Level-"+str(G.Dlevel))
	print("Grid:",grid)

func set_gm(i):
	grid_map = i
	print(i)

func _ready():
	grid = get_node("../Level-"+str(G.Dlevel))
#	grid_map = get_node("../Level-"+str(G.Dlevel)) #hmmmm needs to be executed later
	print("ready")
	var genItems = GenItems.new()
	
	inv.add_item(genItems.gen_weap(DicItems.weapons[G.WEAP.SWORD]),true)
	inv.weapon.inv[0].set_bonus_dmg(4)
	inv.add_item(genItems.gen_armour(DicItems.armour[G.LOC.CHEST][G.MAT.CLOTH]),true)
	inv.armour.inv[0].set_bonus_res(3)
	inv.add_item(genItems.gen_wear(DicItems.wear[G.WEAR.NECKLACE]),true)
	inv.wearable.inv[0].set_bonus_dmg(1)
	inv.wearable.inv[0].set_bonus_res(2)
	combat = Combat.new()
	
	type = Game.PLAYER
	if G.PlayerColor:
		modulate = G.PlayerColor
	attributes = Attrib.new()
	attributes.set_attributes(dic_classes[G.PlayerClass])
	stats = Stats.new()
	stats.set_weapon(inv.weapon) #1. get the weapon class from the inventory class and send it too the attrib class
	stats.set_wearable(inv.wearable) #1. get the weapon class from the inventory class and send it too the attrib class
	stats.set_armour(inv.armour) #1. get the weapon class from the inventory class and send it too the attrib class
	stats.set_attributes(attributes)
	stats.connect("levelup", self, "chk_level")
#	grid_map.create_grid()
#	grid_map.set_grid_pos(self, Map.start)

func _process(delta):
	if Input.is_action_just_pressed("admin") and not chat_displayed and grid_map.is_network_master():
		if not admin:
			add_child(Admin.instance())
			admin = true
		else:
			var an = get_node("Admin")
			an.clear()
			an.queue_free()
			admin = false

	if Input.is_action_just_pressed("Quickslot_1"):		# <--- Ultra hack. temporary for testing spell stuff.
		$Spells.cast_spell1()								# <--- Ultra hack. temporary for testing spell stuff.			
	if Input.is_action_just_pressed("Quickslot_2"):		# <--- Ultra hack. temporary for testing spell stuff.
		$Spells.cast_spell2()								# <--- Ultra hack. temporary for testing spell stuff.			
	if Input.is_action_just_pressed("Chat"):
		chat()
	if Input.is_action_just_pressed("ui_p") and not chat_displayed:
		var item = grid_map.get_item(self)
		if item:
			inv.add_item(item)			
	if Input.is_action_just_pressed("level") and not chat_displayed:
		grid_map.chg_level(get_position()) #Make this better
	if Input.is_action_just_pressed("sell_items") and not chat_displayed:
		stats.gold += inv.sell_items() #simple function to sell all unequipped gear
#		Game.stats.set_gold(stats.gold)
	if Input.is_action_just_pressed("add_enemy") and not chat_displayed:
		Game.Dialog.print_label("You have added enemies")
		grid_map.rpc('add_enemies')
	if Input.is_action_just_pressed("next_level") and not chat_displayed:
		grid_map.chg_level(get_position(),1)
	if Input.is_action_just_pressed("prev_level") and not chat_displayed:
		grid_map.chg_level(get_position(),-1)
	if Input.is_action_just_pressed("rest") and not chat_displayed:
		stats.hp +=1000 #super healing
		if stats.hp > stats.hp_max:
			stats.hp = stats.hp_max
		print("Resting hp:",stats.hp)
		get_node("../Level-"+str(G.Dlevel)).rpc("move_enemy")
	direction = Vector2()
	if Input.is_action_pressed("ui_up") and not chat_displayed:
		direction.y = -1
	elif Input.is_action_pressed("ui_down") and not chat_displayed:
		direction.y = 1
	if Input.is_action_pressed("ui_left") and not chat_displayed:
		direction.x = -1
		if facing:
			facing = false
			$Sprite.set_flip_h(facing)
	elif Input.is_action_pressed("ui_right") and not chat_displayed:
		direction.x = 1
		if not facing:
			facing = true
			$Sprite.set_flip_h(facing)

	if not is_moving and not direction == Vector2():
		target_direction = direction
#		print(target_direction)
		#Wrong way to do this but update cell if player
		if type == Game.PLAYER:
			if not last_request == (get_position() + target_direction):
				last_request = get_position() + target_direction
				grid_map.update_cell(get_position(), target_direction)
			else:
				if $ReqTimer.is_stopped():
					$ReqTimer.start()
		if grid_map.is_cell_empty(get_position(), target_direction):
			target_pos = grid_map.update_child_pos(self)
			is_moving = true
		elif grid_map.is_cell_enemy(get_position(), target_direction) and not is_fighting:
			var node = grid_map.get_cell_node(get_position(), target_direction)
			if node && node.is_in_group("Enemy"):
				is_fighting = true
				$Timer.start()
				node.rpc('attacked', stats.get_dmg(), get_tree().get_network_unique_id(), target_direction)
				#combat.attack(self,enemy)
	elif is_moving:
		if N.is_connected:
			$Name.text = N.players[get_tree().get_network_unique_id()].name
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
			get_node("../Level-"+str(G.Dlevel)).rpc("move_enemy")
		if abs(velocity.y) > distance_to_target.y:
			velocity.y = distance_to_target.y * target_direction.y
			is_moving = false
			get_node("../Level-"+str(G.Dlevel)).rpc("move_enemy")

remote func attacked(dmg, direction):
	dmg = combat.attack(dmg,self)
	take_dmg(dmg, direction)
	
remote func gain_exp(Exp):
	stats.expr += Exp
	Game.stats.set_exp(stats.expr)	

func take_dmg(dmg, direction = Vector2(0,0), blood_splatter = true):
	stats.hp -= dmg		# THIS IS SHITTY. was working on resistance and just needed a hack here for now.
	if stats.hp < 0:
		grid_map.update_grid_cts(get_position(), Game.EMPTY)
		get_tree().change_scene("res://Scenes/End.tscn")
	else:
		if not dmg == 0:
			$Effects.dmg_counter(dmg)
		if dmg > 0 && blood_splatter:
			$Effects.blood_splatter(direction, dmg)

func _on_Timer_timeout():
	is_fighting = false
	
func chat():
	if chat_displayed: 
		$Chat.queue_free()
		chat_displayed = false
	else:
		chat_displayed = true #To keep things clean only need to set something when its not
		var chat = Chat.instance()
		add_child(chat)

func _on_ReqTimer_timeout():
	last_request = Vector2(-1,-1)
