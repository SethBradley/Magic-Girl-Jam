class_name LoadingScreen extends CanvasLayer

signal transition_in_complete
signal game_ready();
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer

var starting_animation_name: String; 

func _ready():
	print("Load Screen Ready");

func start_transition(animation_name:String):
	if(!anim_player.has_animation(animation_name)):
		push_warning("animation_name does not exist")
	starting_animation_name = animation_name;
	anim_player.play(animation_name);
	
	timer.start(); 
	return;

func finish_transition():
	if timer:
		timer.stop();
	
	var ending_animation_name: String = starting_animation_name.replace("to","from");
	
	if (!anim_player.has_animation(ending_animation_name)):
		push_warning("ending_animation_name does not exist")
	
	anim_player.play(ending_animation_name);
	
	await anim_player.animation_finished
	game_ready.emit();
	queue_free();
	return;

func update_bar (somenum: int):
	print("");
	
func report_midpoint() -> void:    #Might not use this
	print("EMITTING");
	transition_in_complete.emit(); #So thisll be the signal that lets me know the vision is fully obscured and ready to load/move shit around
