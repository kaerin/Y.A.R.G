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

###################################
# DMG & RES. used for combat
###################################

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

################################
# DAMAGE TOTALS. eg. Char Sheet
################################

func get_dmg_all(i=0):	#this would be extended to include spells effec etc
	var dmg = []
	#var bonus_res = 0
	dmg = weapon.get_dmg_all(dmg)
	dmg = wearable.get_dmg_all(dmg)
	if i==0:		
		return dmg	
	if i==1:
		return convert_to_text(dmg)	
	
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
	
##############################
# RESISTANCE TOTALS. eg. Char sheet.
##############################	
	
func get_res_all(i=0):	#this would be extended to include spells effec etc
	var res = []
	#var bonus_res = 0
	res = armour.get_res_all(res)
	res = wearable.get_res_all(res)
	if i==0:		
		return res	
	if i==1:
		return convert_to_text(res)	
		
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
	
##############################
#	ease of use functions
##############################	
	
func convert_to_text(i):
	var string = ""
	for j in i:
		j = str(j)
		j.erase(j.find("["),1)
		j.erase(j.find("]"),1)
		if j.find(","):
			j = j.insert(j.find(",")+1,":")
			j.erase(j.find(","),1)
			if j.find(",") >= 0:
				j = j.insert(j.find(",")+2,"-")
				j.erase(j.find(","),2)
		j += " "		
		string += j
	return string