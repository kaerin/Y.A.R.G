extends CanvasLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var Player = get_parent().get_parent()
onready var Inventory = get_parent().get_parent().get_node("Inventory")
onready var Item = get_node("Template/Item")
onready var Attributes = get_node("Cont/HBox/Attributes")
onready var Stats = get_node("Cont/HBox/Stats")

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
		
		
func update_attributes():		
	var attrib1 = Item.duplicate()
	attrib1.get_node("Text").text = "Strength:"
	attrib1.get_node("Value").text = str(Player.strength)
	Attributes.add_child(attrib1)
	var attrib2 = Item.duplicate()
	attrib2.get_node("Text").text = "Dexterity:"
	attrib2.get_node("Value").text = str(Player.dexterity)
	Attributes.add_child(attrib2)
	var attrib3 = Item.duplicate()
	attrib3.get_node("Text").text = "Intelligence:"
	attrib3.get_node("Value").text = str(Player.intelligence)
	Attributes.add_child(attrib3)
	
func update_stats():
	min_dmg = 0
	max_dmg = 0
	bonus_dmg = 0
	for n in Inventory.weapon.inventory:
		if n.is_equipped:
			min_dmg += (n.get_min_dmg())
			max_dmg += (n.get_max_dmg())
			bonus_dmg += (n.get_bonus_dmg())

	var dmg_string = str(min_dmg,"-",max_dmg)
	if bonus_dmg > 0:
		dmg_string += str("+",bonus_dmg) 
	elif bonus_dmg < 0:
		dmg_string += str("-",bonus_dmg) 

	var stat1 = Item.duplicate()
	stat1.get_node("Text").text = "Damage:"
	stat1.get_node("Value").text = dmg_string
	Stats.add_child(stat1)				
	pass	




#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
