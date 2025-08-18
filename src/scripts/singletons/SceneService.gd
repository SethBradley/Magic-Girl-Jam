extends Node

signal content_finished_loading(content);
signal content_invalid(path: String);
signal content_failed_to_load(path: String);

var loading_screen: LoadingScreen;
var _loading_screen_scene:PackedScene = preload("res://src/scenes/loading_screen/loading_screen.tscn");
var _transition: String;
var _path:String;
var _load_progress_timer: Timer;
var _transition_hold_time: int = 0;

func _ready():
	content_finished_loading.connect(on_content_finished_loading)

func load_new_scene(path: String, transition_type:String ="fade_to_black", transition_hold_time: int = 0) -> void:
	_transition = transition_type;
	_transition_hold_time = transition_hold_time;
	loading_screen = _loading_screen_scene.instantiate() as LoadingScreen;
	get_tree().root.add_child(loading_screen)
	loading_screen.start_transition(transition_type);
	_load_content(path);


func _load_content(path:String):
	_path = path;
	var loader = ResourceLoader.load_threaded_request(path); # returns an error such as OK or ERR_BUSY. Doesnt return the resource
	if (!ResourceLoader.exists(path) or loader == null):
		content_invalid.emit(path);
	
	_load_progress_timer = Timer.new();
	_load_progress_timer.wait_time = 0.1;
	_load_progress_timer.timeout.connect(monitor_load_status) # Every 0.1 second, check the load status
	add_child(_load_progress_timer);
	_load_progress_timer.start();

func monitor_load_status():   # This is being ran every 0.1 second
	var load_progress = [];
	var load_status = ResourceLoader.load_threaded_get_status(_path, load_progress);
	
	match load_status:
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:  #Invalid Resource means
			content_invalid.emit(_path);
			_load_progress_timer.stop();
			return;
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			if(loading_screen != null):
				loading_screen.update_bar(load_progress[0] * 100);
		ResourceLoader.THREAD_LOAD_FAILED:
			content_failed_to_load.emit(_path);
			_load_progress_timer.stop();
			return;
		ResourceLoader.THREAD_LOAD_LOADED:
			_load_progress_timer.stop();
			_load_progress_timer.queue_free() # This deletes the object at the end of the current frame
			content_finished_loading.emit(ResourceLoader.load_threaded_get(_path).instantiate());

			
		
func on_content_finished_loading(content) -> void:
	await loading_screen.transition_in_complete;
	var outgoing_scene = get_tree().current_scene;  # The screen that executed this command
	
	outgoing_scene.queue_free();
	
	get_tree().root.call_deferred("add_child", content);  # research these 2 more later
	get_tree().set_deferred("current_scene", content);
	if(_transition_hold_time > 0):
		await get_tree().create_timer(_transition_hold_time).timeout
	loading_screen.finish_transition();
	return;
