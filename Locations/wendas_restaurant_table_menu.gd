extends Sprite2D


var tween

func _ready() -> void:
	#tween.tween_property(self, "global_position", global_position - Vector2(0, 1080), 1.2)
	#up_animation()
	pass


func _process(delta: float) -> void:
	pass

func up_animation() -> void:
	#print("Hey I'm here")
	tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_CIRC)
	tween.tween_property(self, "global_position", global_position - Vector2(0, 1080), 1.0)


# Already being called
#func _on_fast_food_button_pressed() -> void:
	#up_animation()
