extends Control
signal advance_requested
@export var text_box : RichTextLabel;


var dialogEntries: Array[DialogEntry] = [];
var conversationText: = [];

var _skip := false;
var _typing := false;

func _ready():
	play_dialog_at_id(1);
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("dialog_action"):
		print("Pressing dialog action");
		if _typing:
			_skip = true;
		else:
			print("Emitting advance requested")
			advance_requested.emit();


func play_dialog_at_id(targetID: int):
	dialogEntries = staticdata.get_dialog_entries_at_conv_id(targetID);
	for entry in dialogEntries:
		await stream_text_to_textbox(entry.text);
		await advance_requested; 
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
		# Show indicator
		# Don't continue until clicked
	_typing = false;
	print("Finished")
	
