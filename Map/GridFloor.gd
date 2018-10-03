extends TileMap

var BLOOD = ["Blood1","Blood2","Blood3","Blood4","Blood5","Blood6","Blood7","Blood8"]

func set_blood(pos):
	set_cellv(pos,tile_set.find_tile_by_name(BLOOD[randi() % BLOOD.size()]))
	
func set_hidden(pos):
	set_cellv(pos,tile_set.find_tile_by_name("Hidden1"))