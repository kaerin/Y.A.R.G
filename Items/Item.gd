extends Node

onready var grid_map = get_parent()
onready var dic_weapon = get_parent().get_parent().get_node("Dictionaries/Items").weapons
onready var dic_chest = get_parent().get_parent().get_node("Dictionaries/Items").chest
#onready var Weapons = load("res://Items/Weapons.gd")
#onready var Armours = load("res://Items/Armours.gd")

var object = {}
var item

func _ready():
#	weapon = Weapons.new()
#	armour = Armours.new()
	#TODO random instancing of enemies in dictionary
#	$Label.text = object.base_name
	$Label.text = item.get_name()