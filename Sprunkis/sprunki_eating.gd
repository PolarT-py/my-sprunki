extends Node2D


var tween

var idle
var eat1
var eat2
var open_mouth

var character = Global.character
var food_being_dragged
var currently_eating = false
var new_bite = false
var first_new_bite = true
var final_munches = false
var original_position = global_position
var the_center = Vector2(1000, 450)


func _ready() -> void:
	change_char("simon")
	# Smoothly go from where sprunki was last time to the "middle"
	global_position = Global.your_sprunkis_last_position_before_going_to_eat
	tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_CIRC)
	tween.tween_property(self, "global_position", the_center, 1.2)

func change_char(new_char = "simon") -> void:
	# Preloading too skibidi for me, because I'm too lazy
	Global.character = new_char
	character = Global.character
	idle = load("res://Assets/Images/characters/" + character + "/idle.png")
	eat1 = load("res://Assets/Images/characters/" + character + "/eat1.png")
	eat2 = load("res://Assets/Images/characters/" + character + "/eat2.png")
	open_mouth = load("res://Assets/Images/characters/" + character + "/open_mouth.png")

func _process(delta: float) -> void:
	# Check collision for foods
	for area in $"Area2D".get_overlapping_areas():
		var food_node = area.get_parent().get_parent().get_parent()
		if area.name == "Area2D_food" and food_node.just_released and food_node.being_eaten_first:
			currently_eating = true
			$"Timer".start()
	# Cool bobbing animation
	var offset = sin(Time.get_ticks_msec() / 1000.0 * 0.3 * TAU) * 2
	global_position = original_position + the_center - Vector2(0, offset)
	# Idk why but it looks smoother with 'original_position' in

	# Animation
	# Notice: This gets the food's root node, not the Area2D node
	var foods = get_tree().get_nodes_in_group("food")
	#print(new_bite)
	if not currently_eating:
		# Put here so that if theres not food it will default to idle
		$"Area2D/Sprite2D".texture = idle
		for food in foods:
			#print(foods)
			if food.dragging:
				$"Area2D/Sprite2D".texture = open_mouth
				break
			else:
				$"Area2D/Sprite2D".texture = idle
	else:
		if new_bite:
			$"Area2D/Sprite2D".texture = open_mouth
			if first_new_bite:
				$"open_mouth_timer".start()
				first_new_bite = false
				#print("I TOOK A NEW BITE!!!!!!!!!!!!!!!!!!")
		#print(new_bite)
	# If final munches
	if final_munches:
		if $"Area2D/Sprite2D".texture in [idle, eat2]:
			$"Area2D/Sprite2D".texture = eat1
			$"Timer".start()
		else:
			$"Area2D/Sprite2D".texture = eat2
			$"Timer".start()

# I should make it so that the sprunki bites(open mouth) again when the animation gets updated
# - finished

func _on_timer_timeout() -> void:
	for area in $"Area2D".get_overlapping_areas():
		var food_node = area.get_parent().get_parent().get_parent()
		if food_node.being_eaten and not new_bite and not final_munches:
			if $"Area2D/Sprite2D".texture in [idle, eat2]:
				$"Area2D/Sprite2D".texture = eat1
				$"Timer".start()
			else:
				$"Area2D/Sprite2D".texture = eat2
				$"Timer".start()


func _on_open_mouth_timer_timeout() -> void:
	new_bite = false
	first_new_bite = true
	$"Timer".stop()
	$"Timer".start()
	#print("New bite timeout!")


func _on_after_eat_timer_timeout() -> void:
	currently_eating = false
	final_munches = false
