extends Object

#var dic_classes = get_parent().get_parent().get_node("Dictionaries/Classes").classes

var weapon
var wearable
var armour
var attributes
var attacker

var expr = 0 setget chk_level
var hp = 1000 #should belong in stats
var hp_max = 1000 #should belong in stats
var gold = 0 #should belong in stats
var level = 1 #should belong in stats

signal levelup

func chk_level(i):
	if i >= level * level * 10:
		level += 1
		emit_signal("levelup")
	expr = i

func test_print_method():
#	weapon.print_test() #3. execute as nmethod as normal
	print("get dmage ",weapon.get_damage())

func set_weapon(i): 
	weapon = i #2. assign class sent by player to a variable
	
func set_wearable(i): 
	wearable = i #2. assign class sent by player to a variable
	
func set_armour(i): 
	armour = i #2. assign class sent by player to a variable	

func set_attributes(i): 
	attributes = i #2. assign class sent by player to a variable	
	
func get_dmg():		
	var damage = weapon.get_dmg()
	damage = wearable.add_dmg(damage)
	return(damage)		# damage is now sent as array of arrays. needed for resistance testing.
	
func get_res(dmg):
	var j = []
	var k = 0
	for i in dmg:
		j.append([i[0],armour.get_res_specific(i)])	
		j[k][1] += wearable.add_res_specific(i)
		k += 1
	return j	#collects all armours pieces resistance for applied damage type
		
func get_dmg_text(i=0):	#this would be extended to include spells effec etc
	var min_dmg = 0
	var max_dmg = 0
	var bonus_dmg = 0
	for n in weapon.inv:
		if n.is_equipped:
			min_dmg += (n.get_min_dmg(i))
			max_dmg += (n.get_max_dmg(i))
			bonus_dmg += (n.get_bonus_dmg())
	for n in wearable.inv:
		if n.is_equipped:
			min_dmg += (n.get_min_dmg(i))
			max_dmg += (n.get_max_dmg(i))
			bonus_dmg += (n.get_bonus_dmg())

	var dmg_string = str(min_dmg,"-",max_dmg)
	if bonus_dmg > 0:
		dmg_string += str("+",bonus_dmg) 
	elif bonus_dmg < 0:
		dmg_string += str(bonus_dmg)
	return(dmg_string)
	
func get_dmg_list(): #this would be extended to include spells effec etc
	var list = []
	for n in weapon.inv:
		if n.is_equipped:
			list.append(n)
			
	for n in wearable.inv:
		if n.is_equipped:
			if n.get_bonus_dmg():
				list.append(n)
	return(list)	
	
func get_res_text():	#this would be extended to include spells effec etc
	var res = []
	var bonus_res = 0
	res = armour.get_res(res)
	res = wearable.get_res(res)
		
	return str(res,bonus_res)	
	
func get_res_list(): #this would be extended to include spells effec etc
	var list = []
	for n in armour.inv:
		if n.is_equipped:
			list.append(n)
			
	for n in wearable.inv:
		if n.is_equipped:
			if n.get_bonus_res():
				list.append(n)
	return(list)		