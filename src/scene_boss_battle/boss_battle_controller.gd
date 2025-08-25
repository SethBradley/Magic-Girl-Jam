extends Node2D
@onready var player: CharacterBody2D = $Player
@onready var boss: CharacterBody2D = $Boss

#signals
signal player_turn_start
signal boss_turn_start


var whose_turn = "boss" #either boss or player
var phase = 0
func step_increment():
	phase = phase + 1
	
func _process(delta: float) -> void:
	match phase:
		0:	#first phase, do nothing since boss is already active
			step_increment()
		1: 	#wait for signal from boss
			pass
		2:	#activate second phase - player turn
			player_turn_start.emit()
			step_increment()
		3:	#wait for player input
			pass	
		4:	#activate boss phase 2
			boss_turn_start.emit()
			step_increment()
			pass
		5:	#wait for the boss
			pass
			


func _on_boss_turn_done() -> void:
	step_increment()
	pass # Replace with function body.


func _on_player_turn_done() -> void:
	step_increment()
	pass # Replace with function body.
