class_name DialogEntry
extends RefCounted

var id: int
var prev_id: Variant = null 
var speaker: String
var text: String
var next_id: Variant  # next int or null
var has_clue: bool
var has_reply: bool
var reply_choices: Array;

func _init(dialogData: Dictionary) -> void:
	id = dialogData["DialogId"]
	prev_id = dialogData["PrevDialogId"]
	speaker = dialogData["Speaker"]
	text = dialogData["Text"]
	next_id = dialogData["NextDialogId"]
	has_clue = dialogData["HasClue"]
	has_reply = dialogData["HasReply"]
	reply_choices = dialogData["ReplyChoices"]

#func get_reply_as_array() -> Array[String]:
	#if not has_reply:
		#return []
	#var result : Array[String] = []
	#for reply in reply_choices:
		#result.append(reply["reply"])
	#return result;
