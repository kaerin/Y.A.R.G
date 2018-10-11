extends CanvasLayer

func set_hp(i):
	$Panel/HBox/HP.text = str(i)

func set_gold(i):
	$Panel/HBox/Gold.text = str(i)

func set_level(i):
	$Panel/HBox/Level.text = str(i)
	
func set_dungeon(i):
	$Panel/HBox/Dlvl.text = str(i)

func set_exp(i):
	$Panel/HBox/Exp.text = str(i)
