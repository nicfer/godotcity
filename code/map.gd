extends TileMap
var mapsize = {}

func _ready():
	$map_loader.fload("example")
	var nt = $map_loader.next_tile()
	while (!nt.eof):
		set_cell(nt.y,nt.x,nt.tile)
		nt = $map_loader.next_tile()
	mapsize = $map_loader.mapsize
	$"../rosruc".map_created()

#	for x in range(mapsize.x):
#		for y in range(mapsize.y):
#			set_cell(y,x,$map_loader.next_tile())