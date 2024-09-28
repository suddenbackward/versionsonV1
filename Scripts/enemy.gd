extends Entity

class_name Enemy

@onready var enemy_timer = $EnemyTimer

func _ready() -> void:
	enemy_timer.start()
	
	
func take_damage(damage: int) -> void:
	super(damage)
	if health <= 0:
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_enemy_timer_timeout() -> void:
	shoot_laser()
	if randf() < 0.5:
		enemy_timer.wait_time = 3
		# angry
	else:
		enemy_timer.wait_time = 2
		# less angry

func shoot_laser():
	var laser_scene = preload("res://Scenes/laser.tscn")
	var laser = laser_scene.instantiate()
	laser.position = position
	get_parent().add_child(laser)
