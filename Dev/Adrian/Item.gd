extends HBoxContainer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"


var item
var mouse_here
var pos_backup

onready var equip_panel = get_parent().get_parent().get_node("Equip") #how to better define this
onready var inventory = get_parent().get_parent().get_parent().get_parent().get_parent() #Get the Game node for diallog
onready var item_label = get_node("Template/Item")


func _ready():
	if item:					# does not work without an if. dunno why. data not populated or something.
		$Text.text = item.Name
		show()		

func _process(delta):
	if mouse_here:
		if Input.is_action_pressed("ui_mouse_left"):
			drag_item()
		elif Input.is_action_just_released("ui_mouse_left"):
			if get_drop_pos_valid(get_global_mouse_position()):
				item.set_equipped()
				print('equipped weaon ',inventory.weapon.get_equipped())
				if equip_panel.add_to_equipped(item):
					print("dropped in equip panel")
					queue_free()  #item gets copied into equipped, but deletion of object from inventory not yet completed
			elif pos_backup:
					rect_position = pos_backup
			
func drag_item():
	if not pos_backup:
		pos_backup = rect_position	# tried doing in ready and variable area, but always took parent control position	
	self.rect_global_position = get_global_mouse_position()	

func get_drop_pos_valid(mpos):
	var equip_pos = equip_panel.get_global_rect().position
	var equip_size = equip_panel.get_global_rect().size

	if mpos.x > equip_pos.x && mpos.x < equip_pos.x + equip_size.x:
		if mpos.y > equip_pos.y && mpos.y < equip_pos.y + equip_size.y:
			return true
	
	
	
func _on_Item_mouse_entered():
	mouse_here = true


func _on_Item_mouse_exited():
	mouse_here = false
