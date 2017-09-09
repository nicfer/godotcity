extends TileMap
const MAPSIZE = Vector2(32,32)
onready var roads = get_node("roads")
onready var builds = get_node("builds")
onready var tools = get_node("../CanvasLayer/tools")

func _ready():
	for x in range(MAPSIZE.x):
		for y in range(MAPSIZE.y):
			set_cell(x,y,0)

func click_on(p):
	var pm = world_to_map(p)
	tools.click_on(pm)
	return pm

func set_road(p,r):
	roads.set_cellv(p,r)

func set_builds(p,r):
	builds.set_cellv(p,r)