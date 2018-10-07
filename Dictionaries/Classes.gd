extends Node

enum 	CLASS {FIGHTER, MAGE, THIEF, DEMI_GOD, ENEMY}

var classes = {}

var Name = []

func _ready():
	classes[FIGHTER] 	= {strength = 14, agility = 12, fortitude = 14, intelligence = 7, cunning = 9, charm = 9}
	classes[MAGE] 		= {strength = 7, agility = 9, fortitude = 9, intelligence = 14, cunning = 12, charm = 14}
	classes[THIEF] 		= {strength = 9, agility = 14, fortitude = 12, intelligence = 9, cunning = 12, charm = 9}
	classes[DEMI_GOD] 	= {strength = 99, agility = 99, fortitude = 99, intelligence = 99, cunning = 99, charm = 99}
	
	classes[ENEMY]		= {strength = 6, agility = 5, fortitude = 4, intelligence = 3, cunning = 2, charm = 1} #Generic enemy
	
	for i in CLASS.size():
		Name.append([])
	Name[FIGHTER] = "Tank the tanky tank"
	Name[MAGE] = "Special sky fairy"
	Name[THIEF] = "Some theiving bastard"
	Name[DEMI_GOD] = "All charcter's smooshed as one"

