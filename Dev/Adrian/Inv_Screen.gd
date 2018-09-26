extends PanelContainer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var inv = load("res://Inventory/Inventory.tscn")
onready var Weapon = load("res://Items/Weapon.gd")
onready var Armour = load("res://Items/Armour.gd")
onready var Wearable = load("res://Items/Wearable.gd")

onready var item_label = get_node("Template/Item")
onready var inv_panel = get_node("Sections/Inv")

func _ready():
	#var label = item_label.duplicate()
	#inv_panel.add_child(label)
	#label.get_node("Text").text = "test"
	#label.show()
	pass
	

func show_inventory(weapon, armour, wearable):
	var i = 0
	for j in weapon.inventory: # j = weapon.inventory[0] etc
		var item = item_label.duplicate()
		inv_panel.add_child(item)
		item.get_node("Text").text = j.Name # This is the same
		item.get_node("Text").hint_tooltip = weapon.inventory[i].Name
		item.show()
		i += 1
	
	i = 0
	for j in armour.inventory:
		var item = item_label.duplicate()
		inv_panel.add_child(item)
		item.get_node("Text").text = armour.inventory[i].Name
		item.get_node("Text").hint_tooltip = armour.inventory[i].Name
		item.show()
		i += 1

	i = 0
	for j in wearable.inventory:
		var item = item_label.duplicate()
		inv_panel.add_child(item)
		item.get_node("Text").text = wearable.inventory[i].Name
		item.get_node("Text").hint_tooltip = wearable.inventory[i].Name
		item.show()
		i += 1
