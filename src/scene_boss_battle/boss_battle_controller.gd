extends Node2D
@onready var player: CharacterBody2D = $Player
@onready var boss: CharacterBody2D = $Boss
@onready var label_lose = $LabelLose
@onready var label_boss_turn = $LabelBossTurn
@onready var label_player_turn = $LabelPlayerTurn


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
			set_turn_visible_label($LabelBossTurn)
			step_increment()
		1: 	#wait for signal from boss
			pass
		2:	#activate second phase - player turn
			set_turn_visible_label($LabelPlayerTurn)
			player_turn_start.emit()
			step_increment()
		3:	#wait for player input
			pass	
		4:	#activate boss phase 2
			set_turn_visible_label($LabelBossTurn)
			boss_turn_start.emit()
			step_increment()
			pass
		5:	#wait for the boss
			pass
		6:	#activate second phase - player turn
			set_turn_visible_label($LabelPlayerTurn)
			player_turn_start.emit()
			step_increment()
		7:	#wait for player input
			pass	
		
		99: #game_lose
			set_turn_visible_label($LabelLose)
			step_increment()
			pass
		100: #restart with SPACE
			if Input.is_key_pressed(KEY_SPACE):
				get_tree().reload_current_scene()
			pass
			


func _on_boss_turn_done() -> void:
	step_increment()
	pass # Replace with function body.

func _on_player_turn_done() -> void:
	step_increment()
	pass # Replace with function body.

func _on_player_game_lose():
	phase = 99
	pass # Replace with function body.
	
func set_turn_visible_label(_label_obj = null) -> void:
	#reset all visibilities
	$LabelBossTurn.visible = false
	$LabelPlayerTurn.visible = false
	$LabelLose.visible = false
	#set specified label visibility to true	
	if (_label_obj != null):
		_label_obj.visible = true
