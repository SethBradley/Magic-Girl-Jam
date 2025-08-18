extends Control
signal advance_requested
@export var text_box : RichTextLabel;
@export var next_indicator : ColorRect;
@onready var clue_found_window = $clue_found;

var dialogEntries: Array[DialogEntry] = [];
var conversationText: = [];

var _skip := false;
var _typing := false;

func _ready():
	_initialize();
	play_dialog_at_id(1);
	#test();
	
	
func test():
	var loader = ResourceLoader.load_threaded_request("res://src/scenes/loading_screen/loading_screen.tscn"); # returns an error such as OK or ERR_BUSY. Doesnt return the resource
	if (!ResourceLoader.exists("res://src/scenes/loading_screen/loading_screen.tscn") or loader == null):
		print(loader)
	print(loader)
	
func _initialize():
	next_indicator.visible = false;
	clue_found_window.hide();

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("dialog_action"):
		if _typing:
			_skip = true;
		else:
			advance_requested.emit();

func _set_indicator(show: bool) -> void:
	next_indicator.visible = show;
		
		

func play_dialog_at_id(targetID: int):
	dialogEntries = staticdata.get_dialog_entries_at_conv_id(targetID);
	for entry in dialogEntries:
		_set_indicator(false);
		await stream_text_to_textbox(entry.text);
		await advance_requested; 
		if(entry.has_clue):
			clue_found_window.show();
	return;

func stream_text_to_textbox(sourceText: String):
	text_box.text = sourceText
	_typing = true;
	_skip = false;
	for i in sourceText.length():
		text_box.visible_characters = i + 1
		if(_skip):
			text_box.visible_characters = sourceText.length();
			break;
		await get_tree().create_timer(0.05).timeout
	_typing = false;
	_set_indicator(true);
	
