extends Node

var height = 50
var width = 100
var factor = 2.5 #higher means less blocks removed
var start = Vector2()
var end = Vector2()
var delay = .01
var cross_size = 10
var goodMap

var dirs = [Vector2(1,0),Vector2(0,1),Vector2(-1,0),Vector2(0,-1)]

func _ready():
#	set_process(true)
#
#func _process(delta):
	var map
	var maps = 0
	var mapsGood = 0
	while true:
		goodMap = false
		var try = 0
	#
		while goodMap == false:
			try += 1
			randomize()
			map = map_gen()
			map = map_gen_start_end(map)
			map = map_clear(map)
#			map_check(map)
			
			var path = []
			path.append(start)
			while path.size():
				var newPath = []
				for i in path:
					for d in dirs:
						var check = i + d
						if check.x < 0:
							check.x = 0
						elif check.x == height:
							check.x -= 1
						if check.y < 0:
							check.y = 0
						elif check.y == width:
							check.y -= 1
						if map[check.x][check.y] == "+":
							map[check.x][check.y] = "X"
							newPath.append(check)
						elif map[check.x][check.y] == "E":
							goodMap = true
				path = newPath			
				show(map)
				yield(get_node("Label"), "drawn")
			if goodMap == false:
				show(map, "Map is " + str(goodMap))
				yield(get_tree().create_timer(1), "timeout")
		var time = OS.get_ticks_msec()
		maps += try
		mapsGood += 1
		var rate = int(float(mapsGood) / maps * 100)
		var avg_time = time / maps
		show(map, "Map is " + str(goodMap) + " maps: " + str(maps) + " Avg:" + str(avg_time) + "ms Rate:" + str(rate) + "%")
		yield(get_tree().create_timer(1), "timeout")
#		yield(get_node("Label"), "drawn")
		
#func map_add_cross(map, size):
#	pass
#	for i in range

func map_check(map):
	var path = []
	path.append(start)
	while path.size():
		var newPath = []
		for i in path:
			for d in dirs:
				var check = i + d
				if check.x < 0:
					check.x = 0
				elif check.x == height:
					check.x -= 1
				if check.y < 0:
					check.y = 0
				elif check.y == width:
					check.y -= 1
				if map[check.x][check.y] == "+":
					map[check.x][check.y] = "X"
					newPath.append(check)
				elif map[check.x][check.y] == "E":
					goodMap = true
		path = newPath
	return goodMap
	
func map_clear(map):
	for i in range(int(height * width / factor)):
		var clear = Vector2()
		clear.x = randi() % height
		clear.y = randi() % width
		while clear == start or clear == end or map[clear.x][clear.y] == " ":
			clear.x = randi() % height
			clear.y = randi() % width
		map[clear.x][clear.y] = " "
	return map
		
func map_gen_start_end(map):
	start.x = randi() % height
	start.y = randi() % width
	end = start
		
	while abs(end.x - start.x) < height * 0.45:
		end.x = randi() % height
	while abs(end.y - start.y) < width * 0.45:
		end.y = randi() % width
#
	map[start.x][start.y] = "S"
	map[end.x][end.y] = "E"
	return map
	
func map_gen():
	if height < 10:
		height = 10
	if width < 10:
		width = 10
	var map = []
	for i in height:
		map.append([])
		for j in width:
			map[i].append([])
			map[i][j] = "+"
	return map

func show(map, text = ""):
	var maptext = text
	for i in height:
		maptext += "\n"
		for j in width:
			maptext += map[i][j]
	$Label.text = maptext 
	
