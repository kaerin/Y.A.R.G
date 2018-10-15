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
	var dmg_string = Char.stats.get_dmg_all()
	disp_txt_value("Damage:", Char.stats.convert_to_text(dmg_string))	

	var dmg_items = Char.stats.get_dmg_list()
	for n in dmg_items:
		disp_txt_value(str("- ",n.get_name()), Char.stats.convert_to_text(n.get_dmg_all()))	

func get_res():
	var res = Char.stats.get_res_all(1)
	disp_txt_value("Resistances:", res)		

# dont know whether to use above or below visual representation
	for i in G.DmgType:
		var a = ""
		var j = Char.stats.get_res_all()		
		for k in j:
			if i == k[0]:
				a = str(k[1])
				break
			else:
				a = "0"				
		disp_txt_value(i, a)	
	add_spacer()
	
	var res_items = Char.stats.get_res_list()
	for n in res_items:
		disp_txt_value(str("- ",n.get_name()), Char.stats.convert_to_text(n.get_res_all()))

############################
# Ease Of Use
############################

func disp_txt_value(txt,value):
	var stat1 = Item.duplicate()
	stat1.get_node("Text").text = txt
	stat1.get_node("Value").text = str(value)
	stat1.show()
	Stats.add_child(stat1)
	
func add_spacer():
	var stat1 = Item.duplicate()
	stat1.set_custom_minimum_size(Vector2(0,20)) 
	stat1.show()
	Stats.add_child(stat1)				

