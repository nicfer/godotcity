extends TileMap
const MAPSIZE = Vector2(32,32)
onready var buttons = get_node("../CanvasLayer/Panel/buttons")

func _ready():
	for x in range(MAPSIZE.x):
		for y in range(MAPSIZE.y):
			set_cell(x,y,1)

func click_on(p):
	var pm = world_to_map(p)
	var brush = buttons.get_selected()