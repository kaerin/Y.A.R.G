extends Label

func _on_Button_pressed():
	G.PlayerColor = $PlayerCol.color
	get_tree().change_scene("res://Game.tscn")
