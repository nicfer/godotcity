extends Node2D

func _on_newgame_button_up():
	$"..".start_game()

func _on_exit_button_up():
	get_tree().quit()
