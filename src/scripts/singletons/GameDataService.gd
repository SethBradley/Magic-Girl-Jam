extends Node
var gameData_file_path = "res://assets/Seth/GameData.json";
var gameData = {};


func _ready():
	gameData = staticdata.load_json_file(gameData_file_path);
	

func get_watched_conversations():
	var watched_conversations: Array;
	for conversationId in gameData["watchedConversations"]:
		watched_conversations.append(conversationId);
	print(watched_conversations);
