extends Node
var selected = "check"

func action_for(b):
	return get_node(b).action_for()