extends Node2D


# If you want to create your own food, you have to go to your file manager, then duplicate res://Refreshments/foods/food.tscn and rename it to the food you want to add. Then edit the animation.


var dragging = false
var of = Vector2(0, 0)
var being_eaten = false
var being_eaten_first = true
var just_released = false
var original_pos = self.position


func _ready() -> void:
	# Speed of eating, also basically FPS
	# Change in animation editor
	#$"AnimatedSprite2D".speed_scale = 4
	# Starting frame
	$"AnimatedSprite2D".frame = 0
	pass

func _process(delta: float) -> void:
	area_2d_shape_inside()
	if dragging and not being_eaten:
		just_released = false
		position = get_global_mouse_position() - of
	else:
		# Falling
		#print(self.position.y, " | ", original_pos.y)
		if self.position.y < original_pos.y and not being_eaten:
			self.position.y += 5
			just_released = false

func area_2d_shape_inside():
	for area in $"AnimatedSprite2D/Button/Area2D_food".get_overlapping_areas():
		if area.get_parent().name == "sprunki_eating" and just_released and being_eaten_first:
			eat()

func eat() -> void:
	#print("eat food signal recieved")
	# Set to 1 so it looks like it instantly ate
	# Oh and add empty.png to animation as lazy way to make them eat longer
	$"AnimatedSprite2D".frame = 1
	$"AnimatedSprite2D".play()
	$"AudioStreamPlayer".play()
	being_eaten = true
	being_eaten_first = false
	just_released = true

func _on_button_button_down() -> void:
	just_released = false
	dragging = true
	MouseStuff.holding = true
	of = get_global_mouse_position() - global_position


func _on_button_button_up() -> void:
	just_released = true
	MouseStuff.holding = false
	dragging = false


func _on_animated_sprite_2d_animation_finished() -> void:
	# KEY NOTE TO FUTURE SELF IN CASE SOMETHING LIKE THIS HAPPENS AGAIN:
	# THIS WILL NOT WORK IF LOOP IS TURNED ON
	#print("FINISHED")
	# In the future I will add after eating time
	for area in $"AnimatedSprite2D/Button/Area2D_food".get_overlapping_areas():
		if area.get_parent().name == "sprunki_eating":
			area.get_parent().currently_eating = false
	queue_free()


func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	# Problem with this is it only accounts for the frame the food enters
	# So I made another function
	#if area.get_parent().name == "sprunki_eating" and just_released:
		#eat()
	pass


func _on_animated_sprite_2d_frame_changed() -> void:
	# Bite each time new animation, so it doesn't look like the sprunki is chewing on each bite
	#print("FRAMES CHANGED")
	for area in $"AnimatedSprite2D/Button/Area2D_food".get_overlapping_areas():
		if area.get_parent().name == "sprunki_eating":
			area.get_parent().new_bite = true
			#area.get_children()[0].texture = area.get_parent().open_mouth
			print("REQUEST SENT")
	# WRONG FUNCTION x2
	pass
