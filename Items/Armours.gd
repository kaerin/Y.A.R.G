extends Reference

#Class to store all wepaon information

var texture = load("res://Data/ProjectUtumno_full.png")
var sprite_rect = Rect2(1472,1184,32,32)

var BaseType = G.BaseType.Armour
var Name
var is_equipped
var Location
var LocName
var ArmourClass = 0
var BonusAC = 0

#set data
func set_equipped():
	is_equipped = true

func set_not_equipped():
	is_equipped = false
	
func set_name(i):
	Name = i

func set_location(i):
	Location = i
	
func set_loc_name(i):
	LocName = i

func set_ac(i):
	ArmourClass = i

func set_bonus_ac(i):
	BonusAC = i
	
func set_unequip():
	is_equipped = false		

#get data
func get_equipped():
	return is_equipped

func get_name():
	return Name
	
func get_sprite_texture():
	return texture

func get_sprite_rect():
	return sprite_rect

func get_location():
	return Location

func get_loc_name():
	return LocName
	
func get_ac(): #weapon total damage
	return get_armour_ac() + get_bonus_ac()

func get_armour_ac(): #weapon damage
	return ArmourClass

func get_bonus_ac():
	return BonusAC

func get_all_stats():	
	return str("Name: ", get_name(), "\nEquipped: ", get_equipped(), "\nLocation Name: ", get_loc_name(), "\nAC: ", get_ac())
