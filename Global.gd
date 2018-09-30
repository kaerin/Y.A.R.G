extends Node

#ALL UUPERCASE FOR ENUMS
enum	WEAP	{FIST, SWORD, DAGGER, CLUB, SPEAR} #Wepaons
enum	MAT		{CLOTH, LEATHER, CHAIN, PLATE} #Material
enum	LOC		{CHEST, HEAD, ARMS, LEGS} #Location
enum	WEAR	{AMULET, NECKLACE, RING, EARING} #Wear location/type
enum	CHAR	{PLAYER, ENEMY, NPC}

#CamelCaseForText
var Mat = {Cloth = "Cloth", Leather = "Leather", Chain = "Chain", Plate = "Plate"}
var BaseType = {Weap = "Weapon", Armour = "Armour", Wear = "Wearable"}
var WeapType = {Slash = "Slash", Stab = "Stab", Blunt = "Blunt"}
var Weap = {Fist = "Fist", Sword = "Sword", Dagger = "Dagger", Club = "Club", Spear = "Spear"}
var Loc = {Chest = "Chest", Head = "Head", Arms = "Arms", Legs = "Legs"}
var WearType = {Amulet = "Amulet", Ring = "Ring"}

var TODO_img = Rect2(1184,1600,32,32)