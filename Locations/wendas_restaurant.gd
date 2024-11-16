extends Node2D

func _ready() -> void:
	AudioPlayer.play_music("presenterator")
	#for food in $"Foods".get_children():
		#$"Wendas-restaurant-background/sprunki_eating".connect("eat_food", Callable(food, "eat"))
# third child also gets eaten somehow

func _process(delta: float) -> void:
	if $"Foods".get_child_count() == 0:
		get_tree().change_scene_to_file("res://Locations/wendas_restaurant_order.tscn")
