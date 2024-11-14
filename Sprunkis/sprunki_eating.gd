extends Node2D


# I need this to be dynamic in the future
const character = "simon"

var idle = preload("res://Assets/Images/characters/" + character + "/idle.png")
var eat1 = preload("res://Assets/Images/characters/" + character + "/eat1.png")
var eat2 = preload("res://Assets/Images/characters/" + character + "/eat2.png")
var open_mouth = preload("res://Assets/Images/characters/" + character + "/open_mouth.png")

var food_being_dragged
var currently_eating = false
var new_bite = false


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	# Check collision
	for area in $"Area2D".get_overlapping_areas():
		var food_node = area.get_parent().get_parent().get_parent()
		if area.name == "Area2D_food" and food_node.just_released and food_node.being_eaten_first:
			print("Yes I'm eating a peice of food")
			currently_eating = true
			$"Timer".start()

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
				new_bite = false
				print("I TOOK A NEW BITE!!!!!!!!!!!!!!!!!!")

# I should make it so that the sprunki bites(open mouth) again when the animation gets updated
# - working on it

func _on_timer_timeout() -> void:
	for area in $"Area2D".get_overlapping_areas():
		var food_node = area.get_parent().get_parent().get_parent()
		if food_node.being_eaten:
			if $"Area2D/Sprite2D".texture in [idle, eat2]:
				$"Area2D/Sprite2D".texture = eat1
				$"Timer".start()
			else:
				$"Area2D/Sprite2D".texture = eat2
				$"Timer".start()
