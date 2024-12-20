extends Node2D


var idle

var character = Global.character
var can_move = true
var offset = Vector2(250, 0)
var movability = Vector2(0.05, 0.1)


func _ready() -> void:
	change_char(Global.character)
	$"Sprite2D".texture = idle


func _process(_delta: float) -> void:
	# Smooth movement
	if can_move:
		global_position.x = lerp(global_position.x, get_global_mouse_position().x, movability.x)
		position.y = lerp(position.y, get_global_mouse_position().y / 10 - 150, movability.y)
	# X-axis borders
	if global_position.x - offset.x < 0:
		global_position.x = offset.x
	elif global_position.x + offset.x > 1920:
		global_position.x = 1920 - offset.x  

func change_char(new_char = "simon") -> void:
	Global.character = new_char
	character = Global.character
	idle = load("res://Assets/Images/characters/" + character + "/idle.png")
