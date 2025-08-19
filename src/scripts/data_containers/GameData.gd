class_name GameData
extends RefCounted

var conversation_1_watched := false;
var conversation_2_watched := false;
var conversation_3_watched := false;
var conversation_4_watched := false;
var conversation_5_watched := false;
var conversation_6_watched := false;

var clue_1_found := false;
var clue_2_found := false;
var clue_3_found := false;
var clue_4_found := false;

func _init(gameData: Dictionary) -> void:
	print("")
