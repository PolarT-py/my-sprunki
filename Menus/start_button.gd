extends Button


var tween


func _ready() -> void:
	self.position = Vector2(-1000, 578)
	self.pressed.connect(self._button_pressed)
	tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_SPRING)
	tween.tween_property(self, "position", Vector2(484, 578), 1.2)


func _process(delta: float) -> void:
	pass

func _button_pressed():
	get_tree().change_scene_to_file("res://Menus/map_menu.tscn")
