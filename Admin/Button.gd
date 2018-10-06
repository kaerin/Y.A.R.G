extends HBoxContainer

var id

func _on_Button_pressed():
	var i = instance_from_id(id)
	i.inv._inventory()