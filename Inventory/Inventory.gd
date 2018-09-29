extends Node

onready var dic_items = get_parent().get_parent().get_parent().get_node("Dictionaries/Items")
onready var inv = load("res://Inventory/Inventory.tscn")
onready var Weapon = load("res://Items/Weapon.gd")
onready var Armour = load("res://Items/Armour.gd")
onready var Wearable = load("res://Items/Wearable.gd")
onready var Game = get_node("/root/BaseNode") #Get the Game node for diallog
onready var new_inventory = load("res://Dev/Adrian/Inventory_window.tscn")



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
	if Input.is_action_just_pressed("ui_inv"):
		_inventory()
	
func get_damage():
		var damage #= randi() % (equipped[WEAPON].max_damage + 1 - equipped[WEAPON].min_damage) + equipped[WEAPON].min_damage
		print("Weapon damage: ", weapon.get_damage() ) #get the currently equppied weapons damage from the class
		#can do this add all damage and bonuses together
		#damage = weapon.get_damage() + ring.get_dmg_bonus() + amulet.get_dmg_bonus() 
		damage = weapon.get_damage() + wearable.get_bonus_dmg() #get damage from equipped weapon class, the same as inventory.weapon.get_damage() called from the player class
		Game.Dialog.print_label("Your weapon: " + weapon.get_name() + " did " + str(damage) + " damage.", 2)
		return(damage) 

func add_item(item):
	if item.BaseType == G.BaseType.Weap:
		weapon.collect_weapon(item) #collect new inventory weapon
		weapon.alter_stats(0,10) #alter stats of normal weapon dropped by enemy
		Game.Dialog.print_label("You just collected a weapon name: " + item.get_name() + " type: " + item.get_dmg_type())
	if item.BaseType == G.BaseType.Armour:
		armour.collect_armour(item) #collect new inventory weapon
		armour.alter_stats(0,10) #alter stats of normal weapon dropped by enemy
		Game.Dialog.print_label("You just collected some: " + item.get_name() + " for your " + item.get_loc_name())
	if item.BaseType == G.BaseType.Wear:
		wearable.collect_wearable(item) #collect new inventory weapon
		wearable.alter_stats(0,10) #alter stats of normal weapon dropped by enemy
		Game.Dialog.print_label("You just collected a " + item.get_name())

func _inventory():
	if inv_displayed: 
		$Inventory.queue_free()
		inv_displayed = false
	else:
		if not inv_displayed:
			inv_displayed = true #To keep things clean only need to set something when its not
			var new_inv = new_inventory.instance()
			add_child(new_inv)
			new_inv.update_inventory()
