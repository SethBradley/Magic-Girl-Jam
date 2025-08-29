extends CharacterBody2D

const tile_size = 155
var my_turn = false
var is_moving = false
var input_vector
var move_count = 0
var all_moves_count = 0 #array of every single move, for checking right/wrong
var vector_correct = [
	Vector2(0, 1), Vector2(1, 0), Vector2(0, -1), 
	Vector2(0, 1), Vector2(0, 1), Vector2(0, 1)
]

#signals
signal turn_done
signal game_lose

#start my turn
func _on_node_2d_player_turn_start() -> void:
	move_count = 0
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
		#first check if the move is right
		if (input_vector == vector_correct[all_moves_count]):
			#if right, move, else emit game lose
			move_count = move_count + 1
			all_moves_count = all_moves_count + 1
			
			is_moving = true
			var tween = create_tween()
			tween.tween_property(self, "position", position + input_vector * tile_size, 0.25)
			tween.tween_callback(is_moving_disable)
		else:
			game_lose.emit()
		pass

func is_moving_disable():
	is_moving = false
	if move_count == 3:
		turn_done.emit()
		my_turn = false		
