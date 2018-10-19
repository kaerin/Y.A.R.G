extends Label

onready var classes = load("res://Dictionaries/Classes.gd")
onready var class_choice = get_node("Template/Button")
onready var class_vbox	= get_node("VBox_Class")

func _ready():
	$IPadr.text = N.DEF_IP
	randomize()
	$VBoxContainer/HBox/NameINput.text = str(randi() % 1000)
	var j = classes.new()
	add_child(j)
	var i = 0
	for n in classes.CLASS:
		var choice = class_choice.duplicate()
		choice.text = str(j.Name[classes.CLASS[n]])
		choice.show()
		choice.connect("pressed", self, "ButtonPressed", [n])
		class_vbox.add_child(choice)
		i = i + 1

func ButtonPressed(n):
	class_vbox.get_parent().get_node("cur_class").text = n.capitalize()
	G.PlayerClass = classes.CLASS[n]

func _on_Button_pressed():
	#print(self.get_name())
	N.DEF_IP = $IPadr.text
	G.PlayerColor = $VBoxContainer/PlayerCol.color
	if $VBoxContainer/CheckBox.pressed:
		N.create_server($VBoxContainer/HBox/NameINput.text)
	else:
		N.join_server($VBoxContainer/HBox/NameINput.text)
	get_tree().change_scene("res://Game.tscn")



func _on_CheckBox_pressed():
	if $VBoxContainer/CheckBox.pressed:
		$VBoxContainer/CheckBox.text = "Server"
		N.DEF_IP = $IPadr.text
		$IPadr.text = "Your IP"
#		$HTTPRequest.request("https://api.myip.com/") #Leaving out for testing
	else:
		$VBoxContainer/CheckBox.text = "Client"
		$IPadr.text = N.DEF_IP

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	$IPadr.text = json.result.ip