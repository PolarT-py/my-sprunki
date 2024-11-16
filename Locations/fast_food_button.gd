extends Button


func _ready() -> void:
	self.pressed.connect(self._on_pressed)


func _process(delta: float) -> void:
	#print(Global.your_sprunkis_last_position_before_going_to_eat)
	pass

func _on_pressed() -> void:
	# Set last sprunki position for smooth transition when switching between eat and menu mode
	get_parent().get_parent().get_parent().get_node("sprunki_choosing_food_wr").can_move = false
	Global.your_sprunkis_last_position_before_going_to_eat =\
	get_parent().get_child(0).get_child(0).global_position
	# Table animation before switching to eat mode
	var table = get_parent().get_parent()
	table.up_animation()
	get_parent().get_node("Timer").start()
	# Sprunki slightly moves bottom-left a bit when transitioning to eat. Why?


func _on_timer_timeout() -> void:
	# Finally change sceneto eat
	get_tree().change_scene_to_file("res://Locations/wendas_restaurant.tscn")
