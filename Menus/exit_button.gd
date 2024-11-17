extends Button


var tween


func _ready() -> void:
	self.position = Vector2(2000, 864)
	self.pressed.connect(self._button_pressed)
	tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_SPRING)
	tween.tween_property(self, "position", Vector2(650, 864), 1.2)


func _button_pressed():
	get_tree().quit()
