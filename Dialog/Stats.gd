extends CanvasLayer

onready var stats = get_node("/root/BaseNode/Player/").stats

func _ready():
	stats.connect('disp_update', self, 'disp_update')
	G.connect('disp_update', self, 'disp_update')
	
func disp_update():
	set_hp(stats.hp)
	set_gold(stats.gold)
	set_level(stats.level)
	set_dungeon(G.Dlevel)
	set_exp(stats.expr)

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
