extends LineEdit

var dialog = load("res://Dialog/Msg.gd")
onready var Game = get_node("/root/BaseNode")

func _on_ChatEdit_text_entered(new_text):
	print('sent: ', text)
#	rpc('chat_msg', text)
	N.rpc('chat_msg', text)
	self.text = ''
	

