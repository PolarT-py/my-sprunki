extends Node2D


var change_amount = 480


func _ready() -> void:
	change()


func change() -> void:
	if Global.character == "gray":
		self.position = Vector2(0, 0)
	elif Global.character == "simon":
		self.position = Vector2(change_amount * 1, 0)
