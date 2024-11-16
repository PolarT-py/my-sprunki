extends Node2D


func _ready() -> void:
	AudioPlayer.play_music("presenterator")


func _process(delta: float) -> void:
	#get_tree().change_scene_to_file("res://Locations/wendas_restaurant.tscn")
	pass
