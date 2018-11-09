extends Reference

var Damages = load("res://Spells/Damages.gd")
var spells = []

func _init():
	var a = Damages.new()
	spells.append(a)

	spells[0].set_name("stab self")
	spells[0].set_type(G.SPELL.DMG)
	spells[0].set_amount(10)
	spells[0].set_cycle(1)
	spells[0].set_duration(10)
