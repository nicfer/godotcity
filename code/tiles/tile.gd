extends Node2D
var x
var y

func init(x,y,t):
	self.x = x
	self.y = y
	add_child(load("res://code/tiles/"+t+".tscn").instance())
	position.x = x * 32
	position.y = y * 32 + 12
	return self