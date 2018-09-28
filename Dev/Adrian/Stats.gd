extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func show_stats(item):
	if item.BaseType == "Armour":
		text = str("Name: ", item.get_name(), "\nEquipped: ", item.get_equipped(), "\nLocation Name: ", item.get_loc_name(), "\nAC: ", item.get_ac())
	elif	item.BaseType == "Weapon":
		text = str("Name: ", item.get_name(), "\nEquipped: ", item.get_equipped(), "\nDmg Type: ", item.get_dmg_type(), "\nMin Dmg: ", item.get_min_dmg(), "\nMax Dmg: ", item.get_max_dmg(), "\nBonus Dmg: ", item.get_bonus_dmg())
	elif item.BaseType == "Wearable":
		text = str("Name: ", item.get_name(), "\nEquipped: ", item.get_equipped(), "\nType: ", item.get_type(), "\nBonus AC: ", item.get_bonus_ac(), "\nBonus Dmg: ", item.get_bonus_dmg())
		
func delete_stats():
	text = ""	
	

