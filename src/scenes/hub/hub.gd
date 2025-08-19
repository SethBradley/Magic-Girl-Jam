extends Control


func _ready():
	await SceneService.loading_screen.game_ready;
#	if !GameData.Has_Seen_Intro:
#		print("Play Intro Dialog")
#	else
#		print("Load the gameworld") # make separate methods. check for new data too somhow
		

func load_dialog_1():
	SceneService.load_new_scene("res://src/scenes/dialog_stage/dialog_stage.tscn","slide_to_black",1);



func _on_button_pressed(extra_arg_0: int) -> void:
	print(extra_arg_0);
	pass 
