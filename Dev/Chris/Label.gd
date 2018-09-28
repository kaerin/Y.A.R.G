extends Node

var size = Vector2(50,50)
#var height = 8
#var width = 16
var factor = 2.3 #higher means less blocks removed
var start = Vector2()
var end = Vector2()
var delay = .01
var cross_size = 5
var goodMap

var dirs = [Vector2(1,0),Vector2(0,1),Vector2(-1,0),Vector2(0,-1)]

func _ready():
	pass

func map():
	var map
	var maps = 0
	var mapsGood = 0
#	while true:
	var map2 = []
	goodMap = false
	var try = 0
#
	while goodMap == false:
		map2 = []
		try += 1
		randomize()
		map = map_gen()
		map = map_gen_start_end(map)
		map = map_clear(map)
		map = map_add_cross(map,cross_size,5)
		for i in size.x:
			map2.append([])
			for j in size.y:
				map2[i].append(null)
				map2[i][j] = map[i][j]
		var path = []
		path.append(start)
		while path.size():
			var newPath = []
			for i in path:
				for d in dirs:
					var check = i + d
					if check.x < 0 or check.x == size.x or check.y < 0 or check.y == size.y:
						pass
					elif map[check.x][check.y] == "+":
						map[check.x][check.y] = "X"
						newPath.append(check)
					elif map[check.x][check.y] == "E":
						goodMap = true
				if goodMap:
					break		
			path = newPath			
#			show(map)
#			yield(get_node("Label"), "drawn")
#			if goodMap == false:
#				show(map, "Map is " + str(goodMap))
#				yield(get_tree().create_timer(1), "timeout")
	var time = OS.get_ticks_msec()
	maps += try
	mapsGood += 1
	var rate = int(float(mapsGood) / maps * 100)
	var avg_time = time / maps
#	show(map2, "Map is " + str(goodMap) + " maps: " + str(maps) + " Avg:" + str(avg_time) + "ms Rate:" + str(rate) + "%")
#		yield(get_tree().create_timer(1), "timeout")
#	yield(get_node("Label"), "drawn")
	return map2
		
func map_add_cross(map, csize, num = 0):
	var crosses = [start,end]
	for i in num:
		var c = Vector2(randi() % int(size.x), randi() % int(size.y))
		crosses.append(c)
	var cross = []
	for pos in crosses:
		for d in dirs:
			for i in range(1, csize):
				var point = pos + (d*i)
				if point.x < 0 or point.x == size.x or point.y < 0 or point.y == size.y:
					break
				cross.append(point)
	for i in cross:
		map[i.x][i.y] = "+"
	return map

func map_clear(map):
	for i in int(size.x * size.y / factor):
		var clear = Vector2()
		clear.x = randi() % int(size.x)
		clear.y = randi() % int(size.y)
		while clear == start or clear == end or map[clear.x][clear.y] == " ":
			clear.x = randi() % int(size.x)
			clear.y = randi() % int(size.y)
		map[clear.x][clear.y] = " "
	return map
		
func map_gen_start_end(map):
	start.x = randi() % int(size.x)
	start.y = randi() % int(size.y)
	end = start
		
	while abs(end.x - start.x) < size.x * 0.45:
		end.x = randi() % int(size.x)
	while abs(end.y - start.y) < size.y * 0.45:
		end.y = randi() % int(size.y)
#
	map[start.x][start.y] = "S"
	map[end.x][end.y] = "E"
	return map
	
func map_gen():
	if size.x < 8:
		size.x = 8
	if size.y < 8:
		size.y = 8
	var map = []
	for i in size.x:
		map.append([])
		for j in size.y:
			map[i].append([])
			map[i][j] = "+"
	return map

func show(map, text = ""):
	var maptext = text
	for i in size.x:
		maptext += "\n"
		for j in size.y:
			maptext += map[i][j]
	$Label.text = maptext 
	
