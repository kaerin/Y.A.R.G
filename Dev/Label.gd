extends Label

var map = []
var height = 70
var width = 140
var factor = 2.5 #higher means less blocks removed
var start = Vector2()
var end = Vector2()
var delay = .01
var delay2 = 1
var goodMap = "Bad"

var dirs = [Vector2(1,0),Vector2(0,1),Vector2(-1,0),Vector2(0,-1)]

func _ready():
	randomize()
	for i in height:
		map.append([])
		for j in width:
			map[i].append([])
			map[i][j] = "+"
	
	show()
	yield(get_tree().create_timer(delay2),"timeout")
	
	start.x = randi() % height
	start.y = randi() % width
	end.x = randi() % height
	while abs(end.x - start.x) < height * 0.4:
		end.x = randi() % height
	end.y = randi() % width
	while abs(end.y - start.y) < width * 0.4:
		end.y = randi() % width
	map[start.x][start.y] = "S"
	map[end.x][end.y] = "E"
	
	show()
	yield(get_tree().create_timer(delay2),"timeout")
	
	for i in range(int(height * width / factor)):
		var clear = Vector2()
		clear.x = randi() % height
		clear.y = randi() % width
		while clear == start or clear == end:
			clear.x = randi() % height
			clear.y = randi() % width
		map[clear.x][clear.y] = " "
	
	show()
	yield(get_tree().create_timer(delay2),"timeout")

	var path = []
	path.append(start)
	while path.size() > 0:
		path = findNeigh(path)
		show()
		yield(get_tree().create_timer(delay),"timeout")
	
	show("Map is " + goodMap)

func findNeigh(path):
	var newPath = []
	for i in path:
		for d in dirs:
			var check = i + d
			if check.x < 0:
				check.x = 0
			if check.y < 0:
				check.y = 0
			if check.x == height:
				check.x -= 1
			if check.y == width:
				check.y -= 1
			if map[check.x][check.y] == "E":
				goodMap = "Good"
				return []
			if map[check.x][check.y] == "+":
				map[check.x][check.y] = "X"
				newPath.append(check)
	return newPath

func show(text = ""):
	var maptext = text
	for i in height:
		maptext += "\n"
		for j in width:
			maptext += map[i][j]
	self.text = maptext 
	

