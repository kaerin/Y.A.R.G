extends Reference

#var dic_classes = get_parent().get_parent().get_node("Dictionaries/Classes").classes

var strength = 0		#damage / tohit
var agility = 0			#AC
var fortitude = 0		#HP
var intelligence = 0	#spell point stuff
var cunning = 0			#sneaking, traps n stuff
var charm = 0			#buy sell stuff

func set_attributes(Class):
	print(Class)
	strength 		= Class.strength#dic_classes.classes[dic_classes.CLASS[G.PlayerClass]].strength
	agility 		= Class.agility#dic_classes.classes[dic_classes.CLASS[G.PlayerClass]].agility
	fortitude		= Class.fortitude#dic_classes.classes[dic_classes.CLASS[G.PlayerClass]].fortitude
	intelligence	= Class.intelligence#dic_classes.classes[dic_classes.CLASS[G.PlayerClass]].intelligence
	cunning			= Class.cunning#dic_classes.classes[dic_classes.CLASS[G.PlayerClass]].cunning
	charm			= Class.charm#dic_classes.classes[dic_classes.CLASS[G.PlayerClass]].charm
