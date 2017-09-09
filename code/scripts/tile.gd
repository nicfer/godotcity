class Tile extends Node:
	onready var root = get_node("/root/Node")
	onready var terrain = root.get_node("bg")

	var pos = Vector2()
	var ady = {
		"u":null,"d":null,"l":null,"r":null
	}

	func init(p):
		pos = p