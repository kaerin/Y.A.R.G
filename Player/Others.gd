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
					
func take_dmg(dmg, direction = Vector2(0,0), blood_splatter = true):
	#stats.hp -= dmg		# THIS IS SHITTY. was working on resistance and just needed a hack here for now.
	#if stats.hp < 0:
	#	get_tree().change_scene("res://Scenes/End.tscn")
	#else:
	if not dmg == 0:
		$Effects.dmg_counter(dmg)
	if dmg > 0 && blood_splatter:
		$Effects.blood_splatter(direction, dmg)
		$Effects.blood_splatter(direction, dmg)
