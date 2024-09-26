extends Panel

@onready var beat_timer = $BeatTimer
@onready var sub_beat_timer = $SubBeatTimer
@onready var audio = $AudioStreamPlayer
@onready var input_sound = $InputSound
@onready var player: Player = get_parent()

var last_key_pressed = ''
var queue = []

func _ready() -> void:
	audio.play()
	beat_timer.start()
	self.modulate.a = 0


func _on_beat_timer_timeout() -> void: # S'éxécute à chaque beat
	blink()
	sub_beat_timer.start()


func _on_sub_beat_timer_timeout() -> void: # À la fin de la période d'input valide
	sub_beat_timer.stop()
	if last_key_pressed.is_empty(): # pas d'input sur le beat
		queue.clear()
	else:
		queue.append(last_key_pressed)
		last_key_pressed = ''
	print(queue)
	check_combo()


func _input(event) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_A:
			handle_input('A')
		elif event.keycode == KEY_E:
			handle_input('E')


func handle_input(key: String) -> void:
	var sprite_scene = load("res://Scenes/input_key.tscn")
	var sprite_instance = sprite_scene.instantiate()
	get_parent().add_child(sprite_instance)

	var threshold = beat_timer.wait_time / 4
	if beat_timer.time_left <= threshold * 3 and beat_timer.time_left >= threshold:
		# input pas sur le beat
		input_sound.play_failed()
		queue.clear()
	else:
		# success
		input_sound.play_success()
		last_key_pressed = key


func blink() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, beat_timer.wait_time / 2).set_ease(Tween.EASE_IN)
	self.modulate.a = 1


func check_combo() -> void:
	match queue:
		['A', 'E', 'A', 'E']: player.fire_rocket(); queue.clear()
		['E', 'A', 'A', 'E']: player.activate_shield(); queue.clear()
		['A', 'A', 'A', 'E']: player.dodge_up(); queue.clear()
		['A', 'A', 'E', 'A']: player.dodge_down(); queue.clear()
