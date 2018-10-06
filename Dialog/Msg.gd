extends Control

onready var Label = get_node("Margin/Label")
var timer_default = 1
var max_msg = 50

onready var msg_window = get_node("CanvasLayer/PanelContainer/ScrollContainer/VBoxContainer/Label")

func show_label(time = timer_default):
	$Timer.wait_time = time
	Label.show()
	$Timer.start()

func set_label(text):
	Label.text = text
	set_label_window(text)	#here is the start of the Dialog window call change

func _on_Timer_timeout():
	hide_label()
	
func hide_label():
	Label.hide()

func print_label(text, time = timer_default):
	set_label(text)
	show_label(time)

func set_label_window(text):
	check_max_msg()	
	var a = msg_window.duplicate()
	a.text = text
	a.show()
	msg_window.get_parent().add_child(a)
	yield(get_tree(), "idle_frame")	
	msg_window.get_node("../..").set_v_scroll(999999) 

func check_max_msg():
	var b = msg_window.get_parent().get_children()
	if b.size() >= max_msg:
		b[1].queue_free()	#skip template label, and delete oldest message