extends CanvasLayer

func _ready():
	for i in get_parent().get_parent().get_children():
		if i.is_in_group("Enemy"):
			var j = $VBox/HBox.duplicate()
			j.get_node("Label").text = i.Name
			j.id = i.get_instance_id()
			j.visible = true
			$VBox.add_child(j)
			
			
