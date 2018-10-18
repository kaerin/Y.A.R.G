extends Label

var id = 0

func init(info):
	self.text = info.name

func _process(delta):
	if N.players:
		for i in N.players:
			if i == id:
				self.rect_position = N.players[i].pos