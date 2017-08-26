extends Node
onready var camera = get_node("/root/Node/Camera2D")
var cost = 0

func on_click(pm):
	camera.center()