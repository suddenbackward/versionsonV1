extends Sprite2D

@export var fade_time: float = 0.5  # Time in seconds for the fade-out
@export var fall_distance: float = 50  # Distance to fall

func _ready():
	# Start the effect when the scene is ready
	modulate = Color(1, 1, 1, 1)  # Make sure the sprite is fully visible
	position.y -= fall_distance  # Start the sprite higher
	fall_and_fade()

func fall_and_fade():
	# Animate the fall
	var fall_tween = create_tween()
	fall_tween.tween_property(self, "position:y", position.y + fall_distance, fade_time)

	# Animate the fade-out
	var fade_tween = create_tween()
	fade_tween.tween_property(self, "modulate:a", 0, fade_time)
	
	# Optionally, queue free after fading
	fade_tween.tween_callback(Callable(self, "queue_free"))
