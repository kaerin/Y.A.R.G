extends Sprite

var id = 0

func init(info):
	$Name.text = info.name #out of sync

func _process(delta):
	#should be called not executed every frame
	if N.players:
		for i in N.players:
			if i == id:
				self.position = N.players[i].pos
				$Name.text = N.players[i].name #FIXME
				if N.players[i].Dlevel == G.Dlevel:
					self.show()
				else:
					self.hide()
