extends CanvasLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var Char = get_parent().get_parent()
onready var Inventory = get_parent().get_parent().get_node("Inventory")
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
		
#	var attrib1 = Item.duplicate()
#	attrib1.get_node("Text").text = "Strength:"
#	attrib1.get_node("Value").text = str(Player.attributes.strength)
#	attrib1.show()
#	Attributes.add_child(attrib1)
#	var attrib2 = Item.duplicate()
#	attrib2.get_node("Text").text = "Dexterity:"
#	attrib2.get_node("Value").text = str(Player.attributes.agility)
#	attrib2.show()
#	Attributes.add_child(attrib2)
#	var attrib3 = Item.duplicate()
#	attrib3.get_node("Text").text = "Fortitude:"
#	attrib3.get_node("Value").text = str(Player.attributes.fortitude)
#	attrib3.show()
#	Attributes.add_child(attrib3)
#	var attrib4 = Item.duplicate()
#	attrib4.get_node("Text").text = "Intelligence:"
#	attrib4.get_node("Value").text = str(Player.attributes.intelligence)
#	attrib4.show()
#	Attributes.add_child(attrib4)
#	var attrib5 = Item.duplicate()
#	attrib5.get_node("Text").text = "Cunning:"
#	attrib5.get_node("Value").text = str(Player.attributes.cunning)
#	attrib5.show()
#	Attributes.add_child(attrib5)
#	var attrib6 = Item.duplicate()
#	attrib6.get_node("Text").text = "Charm:"
#	attrib6.get_node("Value").text = str(Player.attributes.charm)
#	attrib6.show()
#	Attributes.add_child(attrib6)

func update_stats():
	get_dmg()
	
	
func get_dmg():
	var dmg_string = Inventory.get_dmg_text()
	var stat1 = Item.duplicate()
	stat1.get_node("Text").text = "Damage:"
	stat1.get_node("Value").text = dmg_string
	stat1.show()
	Stats.add_child(stat1)				

	var dmg_items = Inventory.get_dmg_item_list()
	for n in dmg_items:
		var stat1items = Item.duplicate()
		stat1items.get_node("Text").text = str("- ",n.get_name())
		stat1items.get_node("Value").text = n.get_dmg_text()
		stat1items.show()
		Stats.add_child(stat1items)				
	
	stat1 = Item.duplicate()
	stat1.get_node("Text").text = "AC:"
	stat1.get_node("Value").text = str(Inventory.get_ac()) + " Armour:" + str(Inventory.armour.get_ac()) + " Wear:" + str(Inventory.wearable.get_bonus_ac())
	stat1.show()
	Stats.add_child(stat1)				

	stat1 = Item.duplicate()
	stat1.get_node("Text").text = "HP:"
	stat1.get_node("Value").text = str(Char.hp)
	stat1.show()
	Stats.add_child(stat1)
	
	stat1 = Item.duplicate()
	stat1.get_node("Text").text = "Gold:"
	stat1.get_node("Value").text = str(Char.gold)
	stat1.show()
	Stats.add_child(stat1)



#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
