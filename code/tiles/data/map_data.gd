extends Node

func tile_at(x,y):
	var nd
	if (!has_node(str(x))):
		nd = preload("res://code/tiles/data/map_row.tscn").instance()
		nd.name = str(x)
		add_child(nd)
		nd.tile_at(y)
	return get_node(str(x)).tile_at(y)