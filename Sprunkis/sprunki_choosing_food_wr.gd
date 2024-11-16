extends Node2D


var can_move = true

func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	if can_move:
		global_position.x = lerp(global_position.x, get_global_mouse_position().x, 0.05)
		position.y = lerp(position.y, get_global_mouse_position().y / 10 - 150, 0.1)
