extends CharacterBody2D

class_name Entity

var max_health: int = 400
var health: int = 400
var has_shield: bool = false


func take_damage():
	if !has_shield:
		health -= 20
	else:
		health -= 5
