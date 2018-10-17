extends Node

onready var Heal = load("res://Spells/Heal.gd")
onready var Damage = load("res://Spells/Damage.gd")
onready var Buff = load("res://Spells/Buff.gd")
onready var parent = get_parent()

#var inv_displayed = false
var heal
var damage
var buff



func _ready():
	heal = Heal.new() 
	damage = Damage.new()
	buff = Buff.new()