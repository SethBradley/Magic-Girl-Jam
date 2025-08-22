extends Node
@onready var player := get_parent() as CharacterBody2D

var input_vector

func _physics_process(delta: float) -> void:
	input_vector = Vector2.ZERO
	if Input.is_action_just_pressed("ui_down"):
		input_vector = Vector2(0, 1)
	if Input.is_action_just_pressed("ui_up"):
		input_vector = Vector2(0, -1)
	if Input.is_action_just_pressed("ui_right"):
		input_vector = Vector2(1, 0)
	if Input.is_action_just_pressed("ui_left"):
		input_vector = Vector2(-1, 0)
	player.velocity = input_vector*10000*delta
	player.move_and_slide()







#
#const tile_size = 16
#var is_moving = false
	#move_grid()
	#
#func move_grid():
	#if ((input_dir != Vector2.ZERO) and (!is_moving)):
		#is_moving = true
		#var tween = create_tween()
		#tween.tween_property(self, "position", position + input_dir * tile_size, 0.35)
		#tween.tween_callback(is_moving_disable)
		#pass
#
#func is_moving_disable():
	#is_moving = false
		#
	#
