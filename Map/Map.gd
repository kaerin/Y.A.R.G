extends TileMap

onready var Map = load("res://Dev/Chris/Label.gd")
var start = Vector2()
var end = Vector2()

func _ready():
	var map = Map.new()
	var mapgrid = map.map()
	print(mapgrid.size())
	for x in mapgrid.size():
		for y in mapgrid[x].size():
			var i = mapgrid[x][y]
			if i == "+":
				i = 0
			elif i == " ":
				i = 1
			elif i == "S":
				i = 2
				start = Vector2(x,y)
			elif i == "E":
				i = 3
				end = Vector2(x,y)
			set_cell(x,y,int(i))
	set_cell(0,0,0)

