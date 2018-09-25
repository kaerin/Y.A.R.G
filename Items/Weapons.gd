extends Reference

#Class to store all wepaon information

var Name
var Type
var MinDamage
var MaxDamage #etc

#set data
func set_name(i):
	Name = i

func set_type(i):
	Type = i

func set_damage(i,j):
	MinDamage = i
	MaxDamage = j

#get data
func get_name():
	return Name

func get_type():
	return Type
	
func get_damage():
	return randi() % (MaxDamage - MinDamage) + MinDamage
