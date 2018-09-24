extends Control

onready var Label = get_node("Margin/Label")

func show_label():
	Label.show()
	$Timer.start()

func set_label(text):
	Label.text = text

func _on_Timer_timeout():
	hide_label()
	
func hide_label():
	Label.hide()
