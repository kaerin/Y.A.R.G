extends Reference

var texture = load("res://Data/ProjectUtumno_full.png")
var sprite_rect = G.TODO_img

var Name
var Type
var is_active

########################
#set data
########################

func set_sprite_rect(i):
	sprite_rect = i

func set_active(i = true):
	is_active = i

func set_type(i):
	Type = i

func set_name(i):
	Name = i

#########################
#get data
#########################

func get_name():
	return Name

func get_type():
	return Type
	
func get_sprite_texture():
	return texture

func get_sprite_rect():
	return sprite_rect

func get_active():
	return is_active
