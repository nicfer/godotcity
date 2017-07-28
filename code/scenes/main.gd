extends Node2D

var lclasses = {
	"House":preload("res://code/scripts/house.gd")
	,"Road":preload("res://code/scripts/road.gd")
}

static func fib_growth(pob):
	pass#[2,3]->1;[4,5]->2;[]

func get_class(c):
	return lclasses[c].new().get(c).new()