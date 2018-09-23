extends Node

onready var dic_items = get_parent().get_parent().get_parent().get_node("Dictionaries/Items")
onready var inv = load("res://Inventory/Inventory.tscn")

var cur_weapon
var inventory = []
var cur_num = 0
var inv_state = false

func _ready():
	cur_weapon = dic_items.items[dic_items.ITEMS.FIST]

func _process(delta):
	if Input.is_action_just_pressed("ui_next_weap"):
		next_weap()
	if Input.is_action_just_pressed("ui_prev_weap"):
		prev_weap()
	if Input.is_action_just_pressed("ui_inv"):
		_inventory()
	

func get_damage():
		var damage = randi() % (cur_weapon.max_damage - cur_weapon.min_damage) + cur_weapon.min_damage
		print(cur_weapon.base_name, ' ',damage, ' damage')
		return(damage)


func set_add_item(item):
	if not item == null:
		inventory.append(item)
		print(inventory)
		
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
	cur_weapon = inventory[num-1]
	print("Weapon: ",cur_weapon.base_name)
	if inv_state:
		_inventory()
	
func _inventory():
	if inv_state:
		$Inventory.queue_free()
		inv_state = false
	else:
		var inv_dialog = inv.instance()
		add_child(inv_dialog)
		var i = 1
		for inv_item in inventory:
			var entry = $Inventory/VBox/Item.duplicate()
			$Inventory/VBox.add_child(entry)
			entry.get_child(1).text = inv_item.base_name
			entry.get_child(1).show()
			if i == cur_num:
				entry.get_child(0).show()
			i = i +1
		inv_state = true