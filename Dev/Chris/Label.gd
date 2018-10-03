extends Node

var gsize = Vector2(15,15) #Size of grid
var factor = 2.3 #higher means less blocks removed
var start = Vector2()
var end = Vector2()
var delay = .01
var cross_size = (gsize.x + gsize.y)/15 #size of placed cross shaped paths
var cross_num = cross_size / 2 #number of crosses
var goodMap = false
var hidden = false
var special = [Vector2()]

var dirs = [Vector2(1,0),Vector2(0,1),Vector2(-1,0),Vector2(0,-1)]

func _ready():
	pass

func map(i = gsize):
	gsize = i
	var map
	var maps = 0
	var mapsGood = 0
	var map2 = []
	var try = 0
	var trying = OS.get_ticks_msec() + 1000
	while goodMap == false or hidden == false:
		hidden = false
		goodMap = false
		if trying < OS.get_ticks_msec():
			trying = OS.get_ticks_msec() + 1000
			cross_num += 1
			cross_size += 2
			factor += 0.1
			print("cant find solution, making map easier, try #:", try)
		map2 = []
		try += 1
		randomize()
		map = map_gen()
		map = map_clear(map)
		map = map_gen_start_end(map)
		map = map_add_cross(map,cross_size,cross_num)
		for i in gsize.x:
			map2.append([])
			for j in gsize.y:
				map2[i].append(null)
				map2[i][j] = map[i][j]
		var path = []
		path.append(start)
		while path.size():
			var newPath = []
			for i in path:
				for d in dirs:
					var check = i + d
					if check.x < 0 or check.x == gsize.x or check.y < 0 or check.y == gsize.y:
						pass
					elif map[check.x][check.y] == "+":
						map[check.x][check.y] = "X"
						newPath.append(check)
					elif map[check.x][check.y] == "E":
						goodMap = true
					elif map[check.x][check.y] == "H":
						hidden = true
				if goodMap and hidden:
					break		
			path = newPath			
#			show(map)
#			yield(get_node("Label"), "drawn")
#		if goodMap == false:
#			show(map, "Map is " + str(goodMap))
#			yield(get_tree().create_timer(1), "timeout")
	var time = OS.get_ticks_msec()
	maps += try
	mapsGood += 1
	var rate = int(float(mapsGood) / maps * 100)
	var avg_time = time / maps
#	show(map, "Map is " + str(goodMap) + str(hidden) + " maps: " + str(maps) + " Avg:" + str(avg_time) + "ms Rate:" + str(rate) + "%")
#	yield(get_tree().create_timer(1), "timeout")
#	yield(get_node("Label"), "drawn")
	return map2
		
func map_add_cross(map, csize, num = 0):
	var crosses = [start,end]
	for i in num:
		var c = Vector2(randi() % int(gsize.x), randi() % int(gsize.y))
		crosses.append(c)
	var cross = []
	for pos in crosses:
		for d in dirs:
			for i in range(1, csize):
				var point = pos + (d*i)
				if point.x < 0 or point.x == gsize.x or point.y < 0 or point.y == gsize.y:
					break
				cross.append(point)
	for i in cross:
		if map[i.x][i.y] == " ":
			map[i.x][i.y] = "+"
	return map

func map_clear(map):
	for i in int(gsize.x * gsize.y / factor):
		var clear = Vector2()
		clear.x = randi() % int(gsize.x)
		clear.y = randi() % int(gsize.y)
		while clear == start or clear == end or map[clear.x][clear.y] == " ":
			clear.x = randi() % int(gsize.x)
			clear.y = randi() % int(gsize.y)
		map[clear.x][clear.y] = " "
	return map
		
func map_gen_start_end(map):
	start.x = randi() % int(gsize.x)
	while start.x > gsize.x * 0.2 and start.x < gsize.x * 0.8:
		start.x = randi() % int(gsize.x)
	start.y = randi() % int(gsize.y)
	while start.y > gsize.y * 0.2 and start.y < gsize.y * 0.8:
		start.y = randi() % int(gsize.y)
	end = start
	special[0] = Vector2(randi() % int(gsize.x),randi() % int(gsize.y))
	while abs(end.x - start.x) < gsize.x * 0.66:
		end.x = randi() % int(gsize.x)
	while abs(end.y - start.y) < gsize.y * 0.66:
		end.y = randi() % int(gsize.y)
#
	map[start.x][start.y] = "S"
	map[end.x][end.y] = "E"
	for i in special:
		map[i.x][i.y] = "H"
	return map
	
func map_gen():
	if gsize.x < 6:
		gsize.x = 6
	if gsize.y < 6:
		gsize.y = 6
	var map = []
	for i in gsize.x:
		map.append([])
		for j in gsize.y:
			map[i].append([])
			map[i][j] = "+"
	return map

func show(map, text = ""):
	var maptext = text
	for i in gsize.x:
		maptext += "\n"
		for j in gsize.y:
			maptext += map[i][j]
	$Label.text = maptext 
	
