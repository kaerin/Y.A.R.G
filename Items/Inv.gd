extends Reference

#Class to store all common inventory function

var texture = load("res://Data/ProjectUtumno_full.png")
var sprite_rect = G.TODO_img

var BaseType = G.BaseType.Weap
var Name
var is_equipped

#set data
func set_sprite_rect(i):
	sprite_rect = i

func set_equipped():
	is_equipped = true

func set_not_equipped():
	is_equipped = false

func set_name(i):
	Name = i

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
