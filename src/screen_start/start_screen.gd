extends Control

func _on_start_pressed():
	SceneService.load_new_scene("res://src/scenes/main/main.tscn", "fade_to_white",2)
	pass # Replace with function body.


func _on_options_pressed():
	get_tree().change_scene_to_file("res://src/screen_options/options_menu.tscn")


func _on_exit_pressed():
	get_tree().quit()
