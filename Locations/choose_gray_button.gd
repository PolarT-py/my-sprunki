extends Button


func _on_pressed() -> void:
	Global.character = "gray"
	get_tree().current_scene.get_node("selected_box").change()
