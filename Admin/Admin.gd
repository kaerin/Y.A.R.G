extends CanvasLayer

func _ready():
	for i in get_node("/root/BaseNode/Level-"+str(G.Dlevel)+"/Enemies").get_children():
		if i.is_in_group("Enemy"):
			var j = $VBox/HBox.duplicate()
			j.get_node("Label").text = i.Name
			j.id = i.get_instance_id()
			j.visible = true
			$VBox.add_child(j)
			
func clear():
	for i in $VBox.get_children():
		if i.id:
			var j = instance_from_id(i.id)
			if j.get_node("CharSheet").charsheet_displayed:
				j.get_node("CharSheet")._character_sheet()
			if j.inv.inv_displayed:
				j.inv._inventory()