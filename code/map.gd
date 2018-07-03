extends TileMap
var mapsize = {}

func _ready():
	mapsize =  $map_loader.fload("example")
	$"../rosruc".map_created(self)

func screen_pressed(p,t):
	var pm = world_to_map(p)
	print(pm)

#	for x in range(mapsize.x):
#		for y in range(mapsize.y):
#			set_cell(y,x,$map_loader.next_tile())