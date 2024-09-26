extends AudioStreamPlayer

@onready var sound_success = preload("res://Sounds/input_soundeffect.ogg")
@onready var sound_failed = preload("res://Sounds/sheep_baa.ogg")

func play_success() -> void:
	self.stream = sound_success
	self.play()

func play_failed() -> void:
	self.stream = sound_failed
	self.play()
