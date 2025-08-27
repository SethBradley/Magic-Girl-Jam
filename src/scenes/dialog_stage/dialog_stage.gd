extends Control


func _ready():
	if !GameDataService.has_seen_intro():
		var dialog_window: DialogWindow = DialogService.get_loaded_dialog_window();
		get_tree().current_scene.add_child(dialog_window);
		dialog_window.play_dialog_at_id(1);
		# await dialog_window.complete
