extends Entity

class_name Enemy

@onready var enemy_timer = $EnemyTimer

func _ready() -> void:
	enemy_timer.start()

func _on_enemy_timer_timeout() -> void:
	shoot_laser()

func shoot_laser():
	var laser_scene = preload("res://Scenes/laser.tscn")
	var laser = laser_scene.instantiate()
	laser.position = position
	get_parent().add_child(laser)
