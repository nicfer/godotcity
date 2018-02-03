extends Node

func start_game():
	for ch in get_children():
		ch.queue_free()
	var game_scene = preload("res://code/scenes/game_scene/game.tscn").instance()
	add_child(game_scene)