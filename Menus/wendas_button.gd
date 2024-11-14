extends Button


func _ready() -> void:
	self.pressed.connect(self._button_pressed)


func _process(delta: float) -> void:
	pass

func _button_pressed():
	get_tree().change_scene_to_file("res://Locations/wendas_restaurant.tscn")
