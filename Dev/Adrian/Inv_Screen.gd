extends CanvasLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var inv = load("res://Inventory/Inventory.tscn")
onready var Weapon = load("res://Items/Weapon.gd")
onready var Armour = load("res://Items/Armour.gd")
onready var Wearable = load("res://Items/Wearable.gd")

onready var item_label = get_node("Template/Item")
onready var inv_panel = get_node("Container/Panels/Inv")

func _ready():
	pass
	

func show_inventory(weapon, armour, wearable):
	for j in weapon.inventory:
		var entry = item_label.duplicate()
		entry.item = j
		inv_panel.add_child(entry)
	
	for j in armour.inventory:
		var entry = item_label.duplicate()
		entry.item = j
		inv_panel.add_child(entry)

	for j in wearable.inventory:
		var entry = item_label.duplicate()
		entry.item = j
		inv_panel.add_child(entry)
