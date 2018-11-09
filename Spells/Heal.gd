extends Reference

var Heals = load("res://Spells/Heals.gd")
var spells = []

func _init():
	var a = Heals.new()
	spells.append(a)
	
	spells[0].set_name("Mr. Fixit Spell")
	spells[0].set_type(G.SPELL.HEAL)
	spells[0].set_amount(-10)
	spells[0].set_cycle(1)
	spells[0].set_duration(10)




