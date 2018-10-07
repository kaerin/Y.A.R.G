extends Node

onready var dic_items = get_parent().get_parent().get_parent().get_node("Dictionaries/Items")
#onready var Inv = load("res://Inventory/Inventory.tscn")
onready var Weapon = load("res://Items/Weapon.gd")
onready var Armour = load("res://Items/Armour.gd")
onready var Wearable = load("res://Items/Wearable.gd")
onready var Game = get_node("/root/BaseNode") #Get the Game node for diallog
onready var Inv_Visu = load("res://Inv/Inv_Visu.tscn")
onready var parent = get_parent()


#enum	LOC		{CHEST, HEAD, ARMS, LEGS}
#enum 	EQUIPPED {CHEST, HEAD, HANDS, FEET, LEGS, ARMS, WEAPON}
#enum 	WEAR {RING, AMULET}

var inv_displayed = false
var weapon
var armour
var wearable

func _ready():
	
	weapon = Weapon.new(parent.CHARTYPE) #enemies can be given the same weapon class and weapon inventory
	armour = Armour.new(parent.CHARTYPE)
	wearable = Wearable.new(parent.CHARTYPE)
	#could also have npc and companions to also have the same weapon class and inventory	
	#have helper functions like auto-equip highest dmg weapon to use for player or others

func _process(delta):
	if parent.CHARTYPE == G.CHAR.PLAYER:
		if Input.is_action_just_pressed("ui_inv") || (inv_displayed && Input.is_action_just_pressed("char_sheet")):
			_inventory()

func get_damage():
	print("You are using the wrong get_damage function")
	var damage = 0 #= randi() % (equipped[WEAPON].max_damage + 1 - equipped[WEAPON].min_damage) + equipped[WEAPON].min_damage
#		print("AC:", armour.get_ac(), " Bonus:",wearable.get_bonus_ac())
#		print("Bonus dmg:", wearable.get_bonus_dmg())
	#can do this add all damage and bonuses together
	#damage = weapon.get_damage() + ring.get_dmg_bonus() + amulet.get_dmg_bonus() 
	
	if parent.CHARTYPE == G.CHAR.PLAYER: #FIX THIS
		damage = weapon.get_damage() + wearable.get_bonus_dmg() #get damage from equipped weapon class, the same as inventory.weapon.get_damage() called from the player class
	else:
		damage = weapon.get_damage() #FIX THIS
	
#		print("Weapon damage: ", damage) #get the currently equppied weapons damage from the class
	if parent.CHARTYPE == G.CHAR.PLAYER:
		Game.Dialog.print_label("Your weapon: " + weapon.get_active_name() + " did " + str(damage) + " damage.", 2)
	if not damage:
		damage = 0
	return(damage)

func find_rnd_item():
	var i = weapon.inv + armour.inv + wearable.inv
	var j = i[randi() % i.size()]
	while not j.droppable:#j.BaseType == G.BaseType.BodyWeap:
		j = i[randi() % i.size()]
#	print(j.Name)
	return j

func get_ac():
	print("You are using the wrong ac function, also should be a resistance function")
	var ac = armour.get_ac() + wearable.get_bonus_ac()
	return ac

func sell_items():
	if G.level < 0:
		var gold = 0
		var invErase = []
		var a = []
		for i in weapon.inv + armour.inv + wearable.inv:
			if not i.is_equipped:
				print("You sold ", i.Name)
				invErase.append(i)
		for i in invErase:
			gold += 1
			match i.BaseType:
				G.BaseType.Weap:
					weapon.inv.erase(i)
				G.BaseType.Armour:
					armour.inv.erase(i)
				G.BaseType.Wear:
					wearable.inv.erase(i)
		Game.Dialog.print_label("You sold stuff for " + str(gold) + " gold.")	
		return gold
				
	else:
		Game.Dialog.print_label("You cant sell in the dungeon")


		

func add_item(item):
	match item.BaseType:
		G.BaseType.Weap:
			weapon.collect_weapon(item) #collect new inventory weapon
			weapon.alter_stats(0,10 + G.level) #alter stats of normal weapon dropped by enemy
			Game.Dialog.print_label("You just collected a weapon name: " + item.get_name() + " type: " + item.get_dmg_type())
		G.BaseType.Armour:
			armour.collect_armour(item) #collect new inventory weapon
			armour.alter_stats(0,10 + G.level) #alter stats of normal weapon dropped by enemy
			Game.Dialog.print_label("You just collected some: " + item.get_name() + " for your " + item.get_loc_name())
		G.BaseType.Wear:
			wearable.collect_wearable(item) #collect new inventory weapon
			wearable.alter_stats(0,10 + G.level) #alter stats of normal weapon dropped by enemy
			Game.Dialog.print_label("You just collected a " + item.get_name())

func _inventory():
	if inv_displayed: 
		$Inventory.queue_free()
		inv_displayed = false
	else:
		if not inv_displayed:
			inv_displayed = true #To keep things clean only need to set something when its not
			var inv_visu= Inv_Visu.instance()
			add_child(inv_visu)
			inv_visu.update_inventory()
