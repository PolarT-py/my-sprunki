extends Sprite2D


var tween


func _ready() -> void:
	self.position.y = -1080
	tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_CIRC)
	tween.tween_property(self, "position", Vector2(0, 0), 0.5)

func _process(delta: float) -> void:
	pass
