extends Reference

#Class to store all common inventory function

var texture = load("res://Data/ProjectUtumno_full.png")
var sprite_rect = G.TODO_img

var Name
var is_equipped
var droppable = true
var PackedData = {}

#set data
func packBase():
	PackedData['Sprite_Rect'] = sprite_rect
	PackedData['Name'] = Name
	PackedData['Texture'] = texture

func unpackBase():
	sprite_rect = PackedData['Sprite_Rect']
	Name = PackedData['Name']

func set_sprite_rect(i):
	sprite_rect = i

func set_equipped(i = true):
	is_equipped = i

func set_droppable(i = true): 
	droppable = i

func set_name(i):
	Name = i

#func set_unequip(): #Use set_equipped(false)
#	is_equipped = false	

#get data
func get_equipped():
	return is_equipped

func get_name():
	return Name
	
func get_sprite_texture():
	return texture

func get_sprite_rect():
	return sprite_rect

func get_droppable():
	return droppable
