extends Sprite

var id = 0

func init(info):
	$Name.text = info.name

func _process(delta):
	if N.players:
		for i in N.players:
			if i == id:
				self.position = N.players[i].pos