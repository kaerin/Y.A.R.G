extends HBoxContainer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

enum	DROP_POS {INVENTORY, EQUIP, DROP}

var item
var mouse_here
var pos_backup

onready var equip_panel 		= get_parent().get_parent().get_node("Equip") #how to better define this
onready var inv_panel 			= get_parent().get_parent().get_node("Inv") #how to better define this
onready var inventory 			= get_parent().get_parent().get_parent().get_parent().get_parent() #Get the Game node for diallog
onready var inventory_visu 		= get_parent().get_parent().get_parent().get_parent() #Get the Game node for diallog
onready var item_label 			= get_node("Template/Item")
onready var stats 				= get_parent().get_parent().get_node("Stats/Text")

func _ready():
	if item:					# does not work without an if. dunno why. data not populated or something.
		$Text.text = item.Name
		show()		

func _process(delta):
	if mouse_here:
		if Input.is_action_pressed("ui_mouse_left"):
			drag_item()
			
		elif Input.is_action_just_released("ui_mouse_left"):
			if get_drop_pos_area(get_global_mouse_position()) == DROP_POS.EQUIP:
				unequip_equippped_item(item)	#
				item.set_equipped()
				print("equipped ",item.get_name())
				inventory_visu.update_inventory()
				
			elif get_drop_pos_area(get_global_mouse_position()) == DROP_POS.INVENTORY:
				item.set_not_equipped()
				print("unequipped ",item.get_name())
				inventory_visu.update_inventory()
				
			elif get_drop_pos_area(get_global_mouse_position()) == DROP_POS.DROP:
					rect_position = pos_backup #Later change to drop onto grid pos


func unequip_equippped_item(item):
	if item.BaseType == "Weapon":
		for n in inventory.weapon.inventory:
			if n.is_equipped:
				n.set_unequip()
				print(n.get_name(), " unequipped")
	if item.BaseType == "Wearable":
		for n in inventory.wearable.inventory:
			if n.Type == item.Type:
				if n.is_equipped:
					n.set_unequip()
					print(n.get_name(), " unequipped")
	if item.BaseType == "Armour":
		for n in inventory.armour.inventory:
			if n.Location == item.Location:
				if n.is_equipped:
					n.set_unequip()
					print(n.get_name(), " unequipped")

func get_drop_pos_area(mpos):
	var equip_pos = equip_panel.get_global_rect().position
	var equip_size = equip_panel.get_global_rect().size

	if mpos.x > equip_pos.x && mpos.x < equip_pos.x + equip_size.x:
		if mpos.y > equip_pos.y && mpos.y < equip_pos.y + equip_size.y:
			return DROP_POS.EQUIP
	
	var inv_pos = inv_panel.get_global_rect().position
	var inv_size = inv_panel.get_global_rect().size

	if mpos.x > inv_pos.x && mpos.x < inv_pos.x + inv_size.x:
		if mpos.y > inv_pos.y && mpos.y < inv_pos.y + inv_size.y:
			return DROP_POS.INVENTORY
	
	return DROP_POS.DROP

func drag_item():
	if not pos_backup:
		pos_backup = rect_position	# tried doing in ready and variable area, but always took parent control position	
	self.rect_global_position = get_global_mouse_position()	
	
func _on_Item_mouse_entered():
	stats.show_stats(item)
	mouse_here = true

func _on_Item_mouse_exited():
	stats.delete_stats()
	mouse_here = false
