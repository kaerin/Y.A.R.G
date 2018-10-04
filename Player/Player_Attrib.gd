extends "res://Player/Player_Skills.gd"

onready var dic_classes = get_parent().get_parent().get_node("Dictionaries/Classes")

var strength = 0		#damage / tohit
var agility = 0			#AC
var fortitude = 0		#HP
var intelligence = 0	#spell point stuff
var cunning = 0			#sneaking, traps n stuff
var charm = 0			#buy sell stuff

func _ready():
	#print(dic_classes.classes[dic_classes.CLASS[G.PlayerClass]])
	strength 		= dic_classes.classes[dic_classes.CLASS[G.PlayerClass]].strength
	agility 		= dic_classes.classes[dic_classes.CLASS[G.PlayerClass]].agility
	fortitude		= dic_classes.classes[dic_classes.CLASS[G.PlayerClass]].fortitude
	intelligence	= dic_classes.classes[dic_classes.CLASS[G.PlayerClass]].intelligence
	cunning			= dic_classes.classes[dic_classes.CLASS[G.PlayerClass]].cunning
	charm			= dic_classes.classes[dic_classes.CLASS[G.PlayerClass]].charm
