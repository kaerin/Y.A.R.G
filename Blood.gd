extends TileMap

var BLOOD = ["Blood1","Blood2","Blood3","Blood4","Blood5","Blood6","Blood7","Blood8"]

func set_blood(pos):
	var t = tile_set.find_tile_by_name(BLOOD[randi() % BLOOD.size()])
	print("setting blood ", pos)
	set_cellv(pos,t)