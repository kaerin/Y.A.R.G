extends Node

onready var dic_items = get_parent().get_parent().get_parent().get_node("Dictionaries/Items")
onready var inv = load("res://Inventory/Inventory.tscn")
onready var Weapon = load("res://Items/Weapon.gd")
onready var Armour = load("res://Items/Armour.gd")
onready var Wearable = load("res://Items/Wearable.gd")
onready var Game = get_node("/root/BaseNode") #Get the Game node for diallog
onready var Inv_Visu = load("res://Inventory/Inventory_Visu.tscn")



#enum	LOC		{CHEST, HEAD, ARMS, LEGS}
#enum 	EQUIPPED {CHEST, HEAD, HANDS, FEET, LEGS, ARMS, WEAPON}
#enum 	WEAR {RING, AMULET}

var inv_displayed = false
var weapon
var armour
var wearable

func _ready():
	
	weapon = Weapon.new(G.CHAR.PLAYER) #enemies can be given the same weapon class and weapon inventory
	armour = Armour.new(G.CHAR.PLAYER)
	wearable = Wearable.new(G.CHAR.PLAYER)
	#could also have npc and companions to also have the same weapon class and inventory	
	#have helper functions like auto-equip highest dmg weapon to use for player or others

func _process(delta):
	if Input.is_action_just_pressed("ui_inv") || (inv_displayed && Input.is_action_just_pressed("char_sheet")):
		_inventory()

func get_damage():
		var damage #= randi() % (equipped[WEAPON].max_damage + 1 - equipped[WEAPON].min_damage) + equipped[WEAPON].min_damage
		print("AC:", armour.get_ac(), " Bonus:",wearable.get_bonus_ac())
		print("Bonus dmg:", wearable.get_bonus_dmg())
		#can do this add all damage and bonuses together
		#damage = weapon.get_damage() + ring.get_dmg_bonus() + amulet.get_dmg_bonus() 
		damage = weapon.get_damage() + wearable.get_bonus_dmg() #get damage from equipped weapon class, the same as inventory.weapon.get_damage() called from the player class
		print("Weapon damage: ", damage) #get the currently equppied weapons damage from the class
		Game.Dialog.print_label("Your weapon: " + weapon.get_active_name() + " did " + str(damage) + " damage.", 2)
		return(damage)

func get_ac():
	var ac
	ac = armour.get_ac() + wearable.get_bonus_ac()
	return ac
	
		
func get_dmg_text():
	var min_dmg = 0
	var max_dmg = 0
	var bonus_dmg = 0
	for n in weapon.inventory:
		if n.is_equipped:
			min_dmg += (n.get_min_dmg())
			max_dmg += (n.get_max_dmg())
			bonus_dmg += (n.get_bonus_dmg())
	for n in wearable.inventory:
		if n.is_equipped:
			bonus_dmg += (n.get_bonus_dmg())

	var dmg_string = str(min_dmg,"-",max_dmg)
	if bonus_dmg > 0:
		dmg_string += str("+",bonus_dmg) 
	elif bonus_dmg < 0:
		dmg_string += str(bonus_dmg)
	return(dmg_string)
	
func get_dmg_item_list():
	var list = []
	for n in weapon.inventory:
		if n.is_equipped:
			list.append(n)
			
	for n in wearable.inventory:
		if n.is_equipped:
			if n.get_bonus_dmg():
				list.append(n)
	return(list)
		

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
