extends Node2D


func _process(delta: float) -> void:
	for children in get_children():
		if children.global_position.y > 1400:
			children.queue_free()
