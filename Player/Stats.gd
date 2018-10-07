extends Reference

#var dic_classes = get_parent().get_parent().get_node("Dictionaries/Classes").classes

var weapon
var wearable
var armour
var attributes

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
	#I figure everything in combat should pull damage from here. Stats just act as a combiner of all things.
	#effect, spells and skills dont really belong in inventory, but make up part of damage.
	#would mean inventory just becomes a storage container for items.
	
	#not now, but maybe damage should have a type associated to it. eg slashing, blunt etc.
	#eg. turtle has slash damage resistance, but low Blunt damage resistance. 
	
	var dmg = weapon.get_damage()			#could be done with inventory instead of seperated like this.
	dmg += wearable.get_bonus_damage()
	#dmg += effect.get_damage()		#doesnt exist yet
	#dmg += skill.get_damage()		#doesnt exist yet
	return(dmg)
	
func get_dmg_text():	#this would be extended to include spells effec etc
	var min_dmg = 0
	var max_dmg = 0
	var bonus_dmg = 0
	for n in weapon.inv:
		if n.is_equipped:
			min_dmg += (n.get_min_dmg())
			max_dmg += (n.get_max_dmg())
			bonus_dmg += (n.get_bonus_dmg())
	for n in wearable.inv:
		if n.is_equipped:
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
	
func get_ac_text():	#this would be extended to include spells effec etc
	return(str(armour.get_ac() + wearable.get_bonus_ac() + attributes.get_ac()) #
)
	
func get_ac_list(): #this would be extended to include spells effec etc
	var list = []
	for n in armour.inv:
		if n.is_equipped:
			list.append(n)
			
	for n in wearable.inv:
		if n.is_equipped:
			if n.get_bonus_ac():
				list.append(n)
	return(list)		