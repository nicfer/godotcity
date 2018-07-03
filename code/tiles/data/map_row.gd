extends Node

func tile_at(y):
	var nd
	if (!has_node(str(y))):
		nd = preload("res://code/tiles/data/tile_container.tscn").instance()
		nd.name = str(y)
		add_child(nd)
	return get_node(str(y))