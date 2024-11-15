extends Node2D


var idle
var eat1
var eat2
var open_mouth

var character = Global.character
var food_being_dragged
var currently_eating = false
var new_bite = false
var first_new_bite = true


func change_char(new_char = "simon") -> void:
	# Preloading too skibidi for me
	Global.character = new_char
	character = Global.character
	idle = load("res://Assets/Images/characters/" + character + "/idle.png")
	eat1 = load("res://Assets/Images/characters/" + character + "/eat1.png")
	eat2 = load("res://Assets/Images/characters/" + character + "/eat2.png")
	open_mouth = load("res://Assets/Images/characters/" + character + "/open_mouth.png")


func _ready() -> void:
	change_char("simon")

func _process(delta: float) -> void:
	# Check collision
	for area in $"Area2D".get_overlapping_areas():
		var food_node = area.get_parent().get_parent().get_parent()
		if area.name == "Area2D_food" and food_node.just_released and food_node.being_eaten_first:
			#print("Yes I'm eating a peice of food")
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
			if first_new_bite:
				$"open_mouth_timer".start()
				first_new_bite = false
				#print("I TOOK A NEW BITE!!!!!!!!!!!!!!!!!!")
		#print(new_bite)

# I should make it so that the sprunki bites(open mouth) again when the animation gets updated
# - finished

func _on_timer_timeout() -> void:
	for area in $"Area2D".get_overlapping_areas():
		var food_node = area.get_parent().get_parent().get_parent()
		if food_node.being_eaten and not new_bite:
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
	pass
