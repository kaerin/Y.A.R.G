extends Label

signal drawn

func _process(delta):
	emit_signal("drawn")
#	for i in ["fun","fgdafd","stuff"]:
#		print ("word: ", i)
#	self.get_parent().connect("display", self, "display")
