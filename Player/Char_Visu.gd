extends CanvasLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var Char = get_parent().get_parent()
onready var Inventory = get_parent().get_parent().get_node("Inv")
onready var Item = get_node("Template/Item")
onready var Attributes = get_node("Cont/HBox/Attributes")
onready var Stats = get_node("Cont/HBox/Stats")
onready var Spacer = get_node("Template/Spacer")

var min_dmg
var max_dmg
var bonus_dmg

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func update_char_sheet():
	update_attributes()
	update_stats()
		
func update_attrib(i,j):
	var k = Item.duplicate()
	k.get_node("Text").text = i + ":"
	k.get_node("Value").text = str(j)
	k.show()
	Attributes.add_child(k)
		
func update_attributes():
	for i in range(6):
		var j = Char.attributes.get_attrib(i)
		update_attrib(j[0], j[1])


func update_stats():
	get_dmg()
	add_spacer()
	get_res()
	add_spacer()
	disp_txt_value("HP:",Char.stats.hp)
	add_spacer()
	disp_txt_value("Gold:",Char.stats.gold)
	add_spacer()
	disp_txt_value("Exp:",Char.stats.expr)
	add_spacer()
	disp_txt_value("Level:",Char.stats.level)
	
	
func get_dmg():
	var dmg_string = Char.stats.get_dmg_text(-1)
	var stat1 = Item.duplicate()
	stat1.get_node("Text").text = "Damage:"
	stat1.get_node("Value").text = dmg_string
	stat1.show()
	Stats.add_child(stat1)				

	var dmg_items = Char.stats.get_dmg_list()
	for n in dmg_items:
		var stat1items = Item.duplicate()
		stat1items.get_node("Text").text = str("- ",n.get_name())
		stat1items.get_node("Value").text = n.get_dmg_text()
		stat1items.show()
		Stats.add_child(stat1items)				

func get_res():
	var res = Char.stats.get_res_text()
	var stat1 = Item.duplicate()
	stat1.get_node("Text").text = "Res:"
	stat1.get_node("Value").text = res
	stat1.show()
	Stats.add_child(stat1)				
	
	var attrib_res = Char.attributes.get_attrib(1)	#fixed value, crappy solution
	var stat1attrib = Item.duplicate()
	stat1attrib.get_node("Text").text = str("- ",attrib_res[0])
	stat1attrib.get_node("Value").text = str(attrib_res[1])
	stat1attrib.show()
	Stats.add_child(stat1attrib)				
	
	var res_items = Char.stats.get_res_list()
	for n in res_items:
		var stat1items = Item.duplicate()
		stat1items.get_node("Text").text = str("- ",n.get_name())
		stat1items.get_node("Value").text = str(n.get_res_text())
		stat1items.show()
		Stats.add_child(stat1items)				
		
	#stat1 = Item.duplicate()
	#stat1.get_node("Text").text = "AC:"
	#stat1.get_node("Value").text = str(Inventory.get_ac()) + " Armour:" + str(Inventory.armour.get_ac()) + " Wear:" + str(Inventory.wearable.get_bonus_ac())
	#stat1.show()
	#Stats.add_child(stat1)
	
func disp_txt_value(txt,value):
	var stat1 = Item.duplicate()
	stat1.get_node("Text").text = txt
	stat1.get_node("Value").text = str(value)
	stat1.show()
	Stats.add_child(stat1)
	
func get_gold():
	var stat1 = Item.duplicate()
	stat1.get_node("Text").text = "Gold:"
	stat1.get_node("Value").text = str(Char.stats.gold)
	stat1.show()
	Stats.add_child(stat1)
	
func add_spacer():
	var stat1 = Item.duplicate()
	stat1.set_custom_minimum_size(Vector2(0,20)) 
	stat1.show()
	Stats.add_child(stat1)				
	



#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
