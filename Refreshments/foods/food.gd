extends Node2D


# If you want to create your own food, you have to go to your file manager, then duplicate res://Refreshments/foods/food.tscn and rename it to the food you want to add. Then edit the animation.
# -- Frames Guide --
# Frame 0:  Idle
# Frame 1:  Dragging
# Frame 2+: Eating animations
# Tip: Add a empty.png at the very end of the animation for the food's last bite to be biten
#              |
#              L  It is located at res://Assets/Images/icons/empty.png

var dragging = false
var of = Vector2(0, 0)
var being_eaten = false
var being_eaten_first = true
var just_released = false
var original_pos = self.position

# Time sprunki munches on food after food gone
var food_after_eat_time = {
	"Food": 1,
	"fry": 0,
	"chicken_nugget": 1,
	"bread": 2,
}


# Change speed of eating food in the SpriteFrames editor in the AnimatedSprite2D
func _ready() -> void:
	# Starting frame
	$"AnimatedSprite2D".frame = 0
	pass

func _process(delta: float) -> void:
	area_2d_shape_inside()
	if dragging and not being_eaten:
		# Normal dragging in the air
		just_released = false
		position = get_global_mouse_position() - of
		# Make sprite switch the the dragging frame
		$"AnimatedSprite2D".frame = 1
	else:
		# Falling
		if self.position.y < original_pos.y and not being_eaten:
			self.position.y += 5
			just_released = false
		#print(self.position.y, " | ", original_pos.y)
	if not dragging and not being_eaten:
		# Reset sprite to normal frame
		$"AnimatedSprite2D".frame = 0

func area_2d_shape_inside():
	for area in $"AnimatedSprite2D/Button/Area2D_food".get_overlapping_areas():
		if area.get_parent().name == "sprunki_eating" and just_released and being_eaten_first:
			eat()

func eat() -> void:
	#print("eat food signal recieved")
	# Set to 1 so it looks like it instantly ate
	# Oh and add empty.png to animation as lazy way to make them eat longer
	$"AnimatedSprite2D".frame = 2
	$"AnimatedSprite2D".play()
	$"AudioStreamPlayer".play()
	being_eaten = true
	being_eaten_first = false
	just_released = true
	for area in $"AnimatedSprite2D/Button/Area2D_food".get_overlapping_areas():
		if area.get_parent().name == "sprunki_eating":
			area.get_parent().first_new_bite = true
			area.get_parent().get_node("open_mouth_timer").wait_time = 0.01
			#print("YEEHAW")

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
			#area.get_parent().get_node("after_eat_timer").wait_time = food_after_eat_time[name]
			#area.get_parent().final_munches = true
	#
	queue_free()


func _on_animated_sprite_2d_frame_changed() -> void:
	# Bite each time new animation, so it doesn't look like the sprunki is chewing on each bite
	#print("FRAMES CHANGED")
	for area in $"AnimatedSprite2D/Button/Area2D_food".get_overlapping_areas():
		if area.get_parent().name == "sprunki_eating":
			area.get_parent().new_bite = true
			#area.get_children()[0].texture = area.get_parent().open_mouth
			#print("REQUEST SENT")
	# WRONG FUNCTION x2
	pass
