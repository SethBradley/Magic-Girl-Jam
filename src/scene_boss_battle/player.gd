extends CharacterBody2D

const tile_size = 64
var my_turn = false
var is_moving = false
var input_vector
var move_count = 0

#signals
signal turn_done

#start my turn
func _on_node_2d_player_turn_start() -> void:
	my_turn = true

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
	move_grid()
	
func move_grid():
	#check if its my turn
	if ((input_vector != Vector2.ZERO) and (!is_moving)) and (my_turn):
		# should not be here but is here for now
		move_count = move_count + 1
		
		if move_count == 4:
			turn_done.emit()
			move_count = 0
			my_turn = false
		else:
			is_moving = true
			var tween = create_tween()
			tween.tween_property(self, "position", position + input_vector * tile_size, 0.25)
			tween.tween_callback(is_moving_disable)
			pass

func is_moving_disable():
	is_moving = false
		
