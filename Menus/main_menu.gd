extends Node2D


# Setting some variables for title so it can have a bobbing animation
var original_position = Vector2(70, -10)
var position_ = Vector2(70, -10)


func _ready() -> void:
	AudioPlayer.play_music("cipher2")


func _process(float) -> void:
	var offset = sin(Time.get_ticks_msec() / 1000.0 * 0.3 * TAU) * 10
	$"Temp Title".global_position = original_position + position_ - Vector2(0, offset)
