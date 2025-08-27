extends CharacterBody2D

const tile_size = 128
const move_speed = 0.25
var boss_phase = 0
var is_moving = false
var input_vector

signal turn_done

var state = 0
func state_increment():
	state = state + 1
	
func move_grid():
	if ((input_vector != Vector2.ZERO) and (!is_moving)):
		is_moving = true
		var tween = create_tween()
		tween.tween_property(self, "position", position + input_vector * tile_size, move_speed)
		tween.tween_callback(is_moving_disable)
		pass

func is_moving_disable():
	input_vector = Vector2.ZERO
	is_moving = false

func _process(delta: float) -> void:
	#state machine
	match boss_phase:
		0: #phase 1
			match state:
				0:	#start movement
					input_vector = Vector2(0, 1)
					state_increment()
				1:
					if (!is_moving):
						input_vector = Vector2(-1, 0)
						state_increment()
				2:
					if (!is_moving):
						input_vector = Vector2(0, -1)
						state_increment()
				3:
					#send done signal
					turn_done.emit()
					state_increment()
				4:	#now just wait for the next phase
					pass					
		1:	#phase 2
			match state:
				0:	#start movement
					input_vector = Vector2(0, 1)
					state_increment()
				1:
					if (!is_moving):
						input_vector = Vector2(0, -1)
						state_increment()
				2:
					if (!is_moving):
						input_vector = Vector2(-1, 0)
						state_increment()
				3:
					#send done signal
					turn_done.emit()
					state_increment()
				4:	#now just wait for the next phase
					pass	
			pass
			
			
	
	
	#movement
	move_grid()


func _on_node_2d_boss_turn_start() -> void:
	boss_phase = boss_phase + 1
	state = 0
	pass # Replace with function body.
