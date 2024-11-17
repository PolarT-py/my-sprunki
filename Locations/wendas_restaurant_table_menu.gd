extends Sprite2D


var tween


func up_animation() -> void:
	#print("Hey I'm here")
	tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_CIRC)
	tween.tween_property(self, "global_position", global_position - Vector2(0, 1080), 1.0)
