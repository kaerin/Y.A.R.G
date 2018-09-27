extends Label

signal drawn

func _process(delta):
	emit_signal("drawn")
#	self.get_parent().connect("display", self, "display")
