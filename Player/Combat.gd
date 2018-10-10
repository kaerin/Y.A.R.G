#extends Object

#var timer
#
#func _init():
#	print("setup timer")
#	timer = Timer.new()
#	add_child(timer)
#	timer.wait_time = 2
#	timer.connect("timeout", self, "time_out")
#	timer.start()
#func time_out():
#	print("Timed out")

func attack(from,to):
	print("Attacking")
	var dmg = from.stats.get_dmg()
	var res = to.stats.get_res(dmg)
	var totDmg = 0
	print(dmg, " -> ", res)
	var brk = false
	for d in dmg:
		var noRes = true
		for r in res:
			if d[0] == r[0]:
				noRes = false
				var roll = randi() % 20 + from.stats.level
				print("Rolls:",roll)
				if roll > r[1]:
					print("Hits take ",d[1]," dmg")
					totDmg += d[1]
				else:
					print("miss, ending combat")
					brk = true
					break
		if brk:
			break
		if noRes:
			print("No ",d[0]," res taking all damage")
			totDmg += d[1]
	print("Dmg taken:",totDmg)
	to.take_dmg(totDmg)
	
	
#	var enemy = grid_map.get_cell_node(get_position(), target_direction)
#	if enemy:
#		is_fighting = true
#		var roll = randi() % 20
#		enemy.take_dmg(roll, stats.get_dmg()) #weapon needs to get equippped
#		$Timer.start()
#
#func take_dmg(roll, dmg = 0):
##	stats.test_print_method() #4. Used as a trigger to call methods in wepaon from attrib
#	if roll > stats.get_res(dmg):
#		hp -= dmg[0][1]		# THIS IS SHITTY. was working on resistance and just needed a hack here for now.
#		print("roll:",roll, " target:",stats.get_res(dmg), "You took " + str(dmg) + " damage. HP:" + str(hp))
#
#func atake_dmg(roll, dmg):
#	if roll > stats.get_res(dmg):
#		hp -= dmg[0][1]		# THIS IS SHITTY. was working on resistance and just needed a hack here for now.
#		print("roll:",roll, " target:", stats.get_res(dmg), " ",Name, " took " + str(dmg) + " damage. HP:" + str(hp))
#		if hp <= 0:
#			grid_map.set_kill_me(self)
#		else:
#			attack() #Fight player
#
#
##after player moves all enemies are triggered to move from Grid_Map		
#func aattack():
#	var roll = randi() % 20 + G.Dlevel
#	print("Attacks with ", inv.weapon.get_name(), " rolls:", roll)
#	player.take_dmg(roll, stats.get_dmg())#+G.Dlevel)
#	#this should call for each individual attack type. but im out of time.
#	#hacked above in Take_damage that only first attack does acctual damage.
	
