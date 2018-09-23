extends Node

onready var dic_items = get_parent().get_parent().get_parent().get_node("Dictionaries/Items")
onready var inv = load("res://Inventory/Inventory.tscn")

enum EQUIPPED {HEAD, CHEST, HANDS, FEET, LEGS, ARMS, WEAPON}

var inventory = []
var cur_num = 0
var inv_displayed = false
var equipped = []


func _ready():
	equipped.resize(EQUIPPED.size())
	equipped[WEAPON] = dic_items.weapons[dic_items.WEAPONS.FIST]


func _process(delta):
	if Input.is_action_just_pressed("ui_next_weap"):
		next_weap()
	if Input.is_action_just_pressed("ui_prev_weap"):
		prev_weap()
	if Input.is_action_just_pressed("ui_inv"):
		var toggle = true
		_inventory(toggle)
	

func get_damage():
		var damage = randi() % (equipped[WEAPON].max_damage + 1 - equipped[WEAPON].min_damage) + equipped[WEAPON].min_damage
		print(equipped[WEAPON].base_name, ' ',damage, ' damage')
		return(damage)


func set_add_item(item):
	if not item == null:
		inventory.append(item)
		if inv_displayed:
			_inventory(false)

# This section needs to be changed eventually to drag and drop system from inventory to equipped --------------------
# and handle various item types in "Equipped" as in enum array above

func next_weap():
	var size = inventory.size()
	if size:
		cur_num = cur_num + 1
		if cur_num > size:
			cur_num = size
		change_weapon(cur_num)
	
func prev_weap():
	var size = inventory.size()
	if size:
		cur_num = cur_num - 1
		if cur_num < 1:
			cur_num = 1
		change_weapon(cur_num)
	
func change_weapon(num):
	if inventory[num-1].base_type == 'Weapon':		#QUICK FIX to stop equipping Chest armor as weapon, not final solution.
		equipped[WEAPON] = inventory[num-1]
		print("Weapon: ",equipped[WEAPON].base_name)
	else:
		print('num: ',num, ' not a weapon')
	if inv_displayed:
		_inventory(false)
		
		
# ---------------------------------------------------------------------------------------------------------		
func _inventory(toggle):

	if inv_displayed and toggle:
		$Inventory.queue_free()
		inv_displayed = false
	else:

		if not inv_displayed:
			var inv_dialog = inv.instance()
			add_child(inv_dialog)

		inv_displayed = true
				
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
	
		for equip_item in equipped:
			if not equip_item == null:
				var entry = Label.new()#$Inventory/HBox/VBox_Equip/Label.new()
				$Inventory/HBox/VBox_Equip.add_child(entry)
				entry.text = equipped[WEAPON].base_name
			