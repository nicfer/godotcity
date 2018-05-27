extends Node

func start_game():
	$start_screen.queue_free()
	var gscreen = preload("res://code/screens/game/game_screen.tscn").\
		instance()
	add_child(gscreen)