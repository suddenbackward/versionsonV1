extends CharacterBody2D

class_name Entity

var max_health: int = 400
var health: int = 400
var has_shield: bool = false


func take_damage(damage: int):
	if !has_shield:
		health -= damage
	else:
		health -= damage / 2
