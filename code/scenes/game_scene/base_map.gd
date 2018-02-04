extends Node2D

func _ready():
	var file = File.new()
	file.open("res://assets/example.map", file.READ)
	var x = 0
	var y = 0
	var msx = 0
	while (!file.eof_reached()):
		var line = file.get_line()
		for t in line:
			get_node("Land").set_cell(x,y,int(t))
			x += 1
		if (x > msx):
			msx = x
		if (x > 0):
			x = 0
			y += 1
	file.close()
	get_node("Camera2D").set_mapsize(msx,y)