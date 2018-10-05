extends Label

onready var classes = load("res://Dictionaries/Classes.gd")
onready var class_choice = get_node("Template/Button")
onready var class_vbox	= get_node("VBox_Class")

func _ready():
	var j = classes.new()
	add_child(j)
	var i = 0
	for n in classes.CLASS:
		var choice = class_choice.duplicate()
		choice.text = j.Name[classes.CLASS[n]]
		choice.show()
		choice.connect("pressed", self, "ButtonPressed", [n])
		class_vbox.add_child(choice)
		i = i + 1

func ButtonPressed(n):
	class_vbox.get_parent().get_node("cur_class").text = n
	G.PlayerClass = classes.CLASS[n]

func _on_Button_pressed():
	#print(self.get_name())
	G.PlayerColor = $VBoxContainer/PlayerCol.color
	get_tree().change_scene("res://Game.tscn")

