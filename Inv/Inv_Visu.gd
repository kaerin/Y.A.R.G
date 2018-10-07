extends CanvasLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

#onready var inv = load("res://Inventory/Inventory.tscn")
#onready var Weapon = load("res://Items/Weapon.gd")
#onready var Armour = load("res://Items/Armour.gd")
#onready var Wearable = load("res://Items/Wearable.gd")

onready var item_label = get_node("Template/Item")
onready var inv_panel = get_node("Container/Panels/Inv")
onready var equip_panel = get_node("Container/Panels/Equip")
onready var stats_panel = get_node("Container/Panels/Stats")
onready var inventory = get_parent()

var weapon
var armour
var wearable
	
func update_inventory():
	purge_inventory_screen()
	get_inventory()
	for j in weapon.inv:
		var entry = item_label.duplicate()
		entry.item = j
		if j.is_equipped:
			equip_panel.add_child(entry)
		else:
			inv_panel.add_child(entry)

	for j in armour.inv:
		var entry = item_label.duplicate()
		entry.item = j
		if j.is_equipped:
			equip_panel.add_child(entry)
		else:
			inv_panel.add_child(entry)

	for j in wearable.inv:
		var entry = item_label.duplicate()
		entry.item = j
		if j.is_equipped:
			equip_panel.add_child(entry)
		else:
			inv_panel.add_child(entry)

func purge_inventory_screen():
	var inv_list = inv_panel.get_children()
	print(inv_list)
	for n in inv_list:
		if n.is_in_group("Item"):
			n.queue_free()
	var equip_list = equip_panel.get_children()
	for n in equip_list:
		if n.is_in_group("Item"):
			n.queue_free()
	stats_panel.get_node("Text").text = ""
			
		
func get_inventory():
	weapon = inventory.weapon
	armour = inventory.armour
	wearable = inventory.wearable