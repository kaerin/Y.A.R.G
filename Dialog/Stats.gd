extends CanvasLayer

func set_hp(hp):
	$Panel/HBox/HPContainer/HP.text = str(hp)

func set_gold(gold):
	$Panel/HBox/GoldContainer/Gold.text = str(gold)