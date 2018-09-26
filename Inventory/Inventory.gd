extends Node

onready var dic_items = get_parent().get_parent().get_parent().get_node("Dictionaries/Items")
onready var inv = load("res://Inventory/Inventory.tscn")
onready var Weapon = load("res://Items/Weapon.gd")
onready var Armour = load("res://Items/Armour.gd")
onready var Wearable = load("res://Items/Wearable.gd")
onready var Game = get_node("/root/BaseNode") #Get the Game node for diallog
#enum	LOC		{CHEST, HEAD, ARMS, LEGS}
#enum 	EQUIPPED {CHEST, HEAD, HANDS, FEET, LEGS, ARMS, WEAPON}
#enum 	WEAR {RING, AMULET}

var inventory = []
var inv_displayed = false
var equipped = []
var weapon
var armour
var wearable

func _ready():
	
#	equipped.resize(EQUIPPED.size())
#	equipped[WEAPON] = dic_items.weapons[dic_items.WEAPONS.FIST]
	weapon = Weapon.new() #enemies can be given the same weapon class and weapon inventory
	armour = Armour.new()
	wearable = Wearable.new()
	#could also have npc and companions to also have the same weapon class and inventory	
	#have helper functions like auto-equip highest dmg weapon to use for player or others


func _process(delta):
	if Input.is_action_just_pressed("ui_next_weap"):
		next_weap()
	if Input.is_action_just_pressed("ui_prev_weap"):
		prev_weap()
	if Input.is_action_just_pressed("ui_inv"):
		var toggle = true
		_inventory(toggle)
#		for i in weapon.inventory: #print weapon inventory
#			print(i.get_name())
		print(armour.get_equip_name(G.LOC.CHEST), " ", armour.get_equip_name(G.LOC.HEAD), " ", wearable.get_bonus_dmg())
	if Input.is_action_just_pressed("set_chest_armour"):
#		var loc = CHEST #location needs to be settablle some how
		set_armour(G.LOC.CHEST) #cycles through armour and sets
	if Input.is_action_just_pressed("set_head_armour"):
#		var loc = HEAD #location needs to be settablle some how
		set_armour(G.LOC.HEAD) #cycles through armour and sets
	if Input.is_action_just_pressed("set_ring"):
		set_wear(G.WEAR.RING)
	if Input.is_action_just_pressed("set_amulet"):
		set_wear(G.WEAR.AMULET)
	

func get_damage():
		var damage #= randi() % (equipped[WEAPON].max_damage + 1 - equipped[WEAPON].min_damage) + equipped[WEAPON].min_damage
		
#		print(equipped[WEAPON].base_name, ' ',damage, ' damage')
		print("Weapon damage: ", weapon.get_damage() ) #get the currently equppied weapons damage from the class
		#can do this add all damage and bonuses together
		#damage = weapon.get_damage() + ring.get_dmg_bonus() + amulet.get_dmg_bonus() 
		damage = weapon.get_damage() + wearable.get_bonus_dmg() #get damage from equipped weapon class, the same as inventory.weapon.get_damage() called from the player class
		Game.Dialog.print_label("Your weapon: " + weapon.get_name() + " did " + str(damage) + " damage.", 2)
		return(damage) 


func set_add_item(item):
	if not item == null:
		inventory.append(item)
		if inv_displayed:
			_inventory(false)
		#var Dialog = get_node("/root/BaseNode/Grid/Dialog")
#		Game.Dialog.print_label("You have collected a " + item.base_type + " " + item.base_name) #Set the label, Show label will timeout and hide after 1 second
		
		if item.base_type == G.BaseType.Weap:
			weapon.add_weapon(item) #adding weapon to weapon class inventory
			Game.Dialog.print_label("You just collected a weapon name: " + weapon.get_name(0) + " type: " + weapon.get_type(0), 2 )
		if item.base_type == G.BaseType.Armour:
			armour.add_armour(item)
			Game.Dialog.print_label("You just collected some: " + armour.get_name(0) + " for your " + str(armour.get_loc_name(0)), 2 )
		if item.base_type == G.BaseType.Wear:
			wearable.add_wearable(item)
			Game.Dialog.print_label("You just collected a " + wearable.get_name(0), 2 )

# This section needs to be changed eventually to drag and drop system from inventory to equipped --------------------
# and handle various item types in "Equipped" as in enum array above

func set_wear(type): #armour could be done this way
	var msg = "You equiped "
	if type == G.WEAR.RING:
		wearable.equip_ring(wearable.get_next_ring())
		msg += wearable.get_ring_name()  + " AC: " + str(wearable.get_ring_bonus_ac()) + " Dmg: " + str(wearable.get_ring_bonus_dmg())
	if type == G.WEAR.AMULET:
		wearable.equip_amulet(wearable.get_next_amulet())
		msg += wearable.get_amulet_name()  + " AC: " + str(wearable.get_amulet_bonus_ac()) + " Dmg: " + str(wearable.get_amulet_bonus_dmg())
	Game.Dialog.print_label(msg,2)

func set_armour(loc):
	var i = armour.active[loc]
	var size = armour.inventory.size() - 1
	i += 1
	if i > size:
		i = 0
	while not loc == armour.get_location(i):
		i += 1
		if i > size:
			i = 0	
	armour.equip_armour(loc, i)
	Game.Dialog.print_label("You equiped " + str(armour.get_loc_name(i)) + " armour: " + armour.get_equip_name(loc) + " AC:" + str(armour.get_armour_ac(loc)) + " bonus:" + str(armour.get_bonus_ac(loc)), 2)
	if inv_displayed:
		_inventory(false)

func next_weap():
	var i = weapon.active
	var size = weapon.inventory.size() - 1
	i += 1
	if i > size:
		i = size
	change_weapon(i)
	
func prev_weap():
	var i = weapon.active
	var size = weapon.inventory.size()
	i -= 1
	if i < 0:
		i = 0
	change_weapon(i)
	
func change_weapon(num):
#	if inventory[num-1].base_type == 'Weapon':		#QUICK FIX to stop equipping Chest armor as weapon, not final solution.
#		equipped[WEAPON] = inventory[num-1]
#		print("Weapon: ",equipped[WEAPON].base_name)
#	else:
#		print('num: ',num, ' not a weapon')
	weapon.equip_weapon(num)
	Game.Dialog.print_label("Your equiped weapon: " + weapon.get_name() + " Bonus dmg:" + str(weapon.get_bonus_damage()), 2 )
	if inv_displayed:
		_inventory(false)
		
		
# ---------------------------------------------------------------------------------------------------------
# A lot of this should probably go inventory scene
# Then pass data to that script for displaying and setting
func _inventory(toggle):

	if inv_displayed and toggle: #You assign toggle to a variable previously then pass that variable then reference the same variable
		$Inventory.queue_free()
		inv_displayed = false
	else:

		if not inv_displayed:
			var inv_dialog = inv.instance()
			add_child(inv_dialog)
			inv_displayed = true #To keep things clean only need to set something when its not
				
		var inv_list = $Inventory/HBox/VBox_Inv.get_children()
		for n in inv_list:
			if not n.get_name() == "Title":
				n.queue_free()
				
		var i = 1
		
		for inv_item in inventory:
			var entry = $Inventory/Template/Item.duplicate()
			$Inventory/HBox/VBox_Inv.add_child(entry)
			entry.get_child(1).text = inv_item.base_name
			entry.get_child(1).show()
	#		if i == cur_num:
	#				entry.get_child(0).show()
	#		i = i +1
	
	
		var equip_list = $Inventory/HBox/VBox_Equip.get_children()
		for n in equip_list:
			if not n.get_name() == "Title":
				n.queue_free()
		var armour_list = $Inventory/HBox/VBox_Armour.get_children()
		for a in armour_list:
			if not a.get_name() == "Title":
				a.queue_free()
		
		var equip_item = weapon.get_name()
		if not equip_item == null:
			var entry = Label.new()#$Inventory/HBox/VBox_Equip/Label.new()
			$Inventory/HBox/VBox_Equip.add_child(entry)
#				entry.text = equipped[WEAPON].base_name
			entry.text = equip_item
		
		for equip_armour in [armour.get_equip_name(G.LOC.CHEST),armour.get_equip_name(G.LOC.HEAD)]:
			if not equip_armour == null:
				var entry = Label.new()#$Inventory/HBox/VBox_Equip/Label.new()
				$Inventory/HBox/VBox_Armour.add_child(entry)
	#				entry.text = equipped[WEAPON].base_name
				entry.text = equip_armour
