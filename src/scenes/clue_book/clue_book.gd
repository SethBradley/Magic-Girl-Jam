extends Control


func _ready():
	print_tree_structure();

func print_tree_structure(node: Node = self, indent: int = 0) -> void:
	var prefix := ""   # explicitly a String
	for i in range(indent):
		prefix += "  "   # add two spaces per indent
	print(prefix, node.name, " (", node.get_class(), ")")
	for child in node.get_children():
		print_tree_structure(child, indent + 1)
