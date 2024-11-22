extends Button


var ending


func _ready() -> void:
	self.pressed.connect(self._on_pressed)
	ending = false


func _process(_delta: float) -> void:
	var sprunki_char = get_parent().get_parent().get_parent().get_node("sprunki_choosing_food_wr")
	if ending and sprunki_char.movability.x > 0 and sprunki_char.movability.y > 0:
		sprunki_char.movability = Vector2(sprunki_char.movability.x - 0.0005, sprunki_char.movability.y - 0.0005)


func _on_pressed() -> void:
	# Table flying upwards animation before switching to eat mode
	var table = get_parent().get_parent()
	table.up_animation()
	$"Timer".start()
	ending = true


func _on_timer_timeout() -> void:
	# Set last sprunki position for smooth transition when switching between eat and menu mode
	get_parent().get_parent().get_parent().get_node("sprunki_choosing_food_wr").can_move = false
	Global.your_sprunkis_last_position_before_going_to_eat =\
	get_parent().get_parent().get_parent().get_node("sprunki_choosing_food_wr").global_position
	
	# Finally change scene to eat
	get_tree().change_scene_to_file("res://Locations/wendas_restaurant_breakfast.tscn")