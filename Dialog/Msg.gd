extends Control

onready var Label = get_node("Margin/Label")
var timer_default = 1

func show_label(time = timer_default):
	$Timer.wait_time = time
	Label.show()
	$Timer.start()

func set_label(text):
	Label.text = text

func _on_Timer_timeout():
	hide_label()
	
func hide_label():
	Label.hide()

func print_label(text, time = timer_default):
	set_label(text)
	show_label(time)
