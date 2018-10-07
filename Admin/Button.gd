extends HBoxContainer

var id

func _on_Button_pressed():
	var i = instance_from_id(id)
	i.inv._inventory()

func _on_Button2_pressed():
	var i = instance_from_id(id)
	i.get_node("CharSheet")._character_sheet()