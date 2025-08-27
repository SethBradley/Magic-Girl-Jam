extends Control

func _on_start_pressed():
	get_tree().change_scene_to_file("res://src/scene_boss_battle/boss_battle.tscn")
	
func _on_options_pressed():
	get_tree().change_scene_to_file("res://src/screen_options/options_menu.tscn")

func _on_exit_pressed():
	get_tree().quit()

func _on_boss_battle_pressed() -> void:
	get_tree().change_scene_to_file("res://src/scene_boss_battle/boss_battle.tscn")
