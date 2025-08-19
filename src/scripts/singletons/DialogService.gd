extends Node

var dialogData_file_path = "res://assets/Seth/SampleDialog.json";
var dialogData = {};


func _ready():
	dialogData = staticdata.load_json_file(dialogData_file_path);


func get_conversation_at_ID(target_id: int):
	for conversation in dialogData["Conversations"]:
		if conversation["ConversationId"] == target_id:
			return conversation;
				
	
func get_dialog_entries_at_conv_id(target_id: int):
	var result: Array[DialogEntry] = [];
	for conversation in dialogData["Conversations"]:
		if conversation["ConversationId"] == target_id:
			for dialogEntry in conversation["Data"]:
				var newEntry = DialogEntry.new(dialogEntry);
				result.append(newEntry);
	return result;
