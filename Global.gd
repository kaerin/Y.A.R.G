extends Node

#ALL UUPERCASE FOR ENUMS
enum	WEAP	{FIST, SWORD, DAGGER, CLUB, SPEAR, TEETH, CLAW, TAIL} #Wepaons
enum	MAT		{CLOTH, LEATHER, CHAIN, PLATE, SKIN} #Material
enum	LOC		{CHEST, HEAD, ARMS, LEGS} #Location
enum	WEAR	{AMULET, NECKLACE, RING, EARING} #Wear location/type
enum	CHAR	{PLAYER, ENEMY, NPC}
enum	SPELL	{HEAL, DMG, BUFF}

#CamelCaseForText
const Mat = {Cloth = "Cloth", Leather = "Leather", Chain = "Chain", Plate = "Plate"}
const BaseType = {BodyWeap = "Body Weapon", Weap = "Weapon", Armour = "Armour", Wear = "Wearable"}
const DmgType = {Slash = "Slash", Stab = "Stab", Blunt = "Blunt", Fire = "Fire", Poison = "Poison"}
const ResType = DmgType
const Weap = {Fist = "Fist", Sword = "Sword", Dagger = "Dagger", Club = "Club", Spear = "Spear", Teeth = "Teeth", Claw = "Claw", Tail="Tail"}
const Loc = {Chest = "Chest", Head = "Head", Arms = "Arms", Legs = "Legs"}
const WearType = {Amulet = "Amulet", Ring = "Ring"}
const En = {Rat="Rat", Turtle="Turtle", Mole="Mole", Bee="Bee",Gnome="Gnome"}
const Heal = {Heal = "Heal"}

var TODO_img = Rect2(1184,1600,32,32)

var Dlevel = 1 setget dlvl_update #Dungeon Level

var PlayerColor
var PlayerClass = 0

signal disp_update

func is_within(i,j):
	if i.x < j.x and i.x >= 0 and i.y < j.y and i.y >= 0:
		return true
	else:
		return false

var debug = false

func dlvl_update(i):
	Dlevel = i
	emit_signal("disp_update")