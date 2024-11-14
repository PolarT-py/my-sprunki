extends Node2D


var tween


func _ready() -> void:
	self.position.y = -1080
	tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self, "position", Vector2(0, 0), 1.1)
	#print(get_children())
	for child in get_children():
		child.original_pos = child.position


func _process(delta: float) -> void:
	pass
