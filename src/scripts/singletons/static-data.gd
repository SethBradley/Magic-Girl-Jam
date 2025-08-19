extends Node

func load_json_file(filePath: String):
	if FileAccess.file_exists(filePath):
		var dataFile = FileAccess.open(filePath, FileAccess.READ); 
		var parsedResult = JSON.parse_string(dataFile.get_as_text());
		return parsedResult;
	else:
		print("File does not exist")
