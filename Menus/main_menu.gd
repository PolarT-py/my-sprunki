extends Node2D


func _ready() -> void:
	# Should make it loop the song
	AudioPlayer.play_music("cipher2")


func _process(delta: float) -> void:
	pass
