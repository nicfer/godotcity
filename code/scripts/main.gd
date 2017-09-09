extends Node2D

var lclasses = {
	"Habitant":preload("res://code/scripts/habitant.gd")
}

func get_class(c):
	return lclasses[c].new()