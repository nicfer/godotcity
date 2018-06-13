extends Node2D
const sprsize = Vector2(27,31)
const titlesize = 16
const yoffset = 31
const tilesize = 32

func map_created():
	position.x = Globals.gn("bg").mapsize.x * tilesize * 0.5
	position.y = Globals.gn("bg").mapsize.y * tilesize * 0.5 + titlesize
# set_cam_limit():
	$cam.limit_right  = (Globals.gn("bg").mapsize.x)\
		* tilesize + sprsize.x
	$cam.limit_bottom = (Globals.gn("bg").mapsize.y)\
		* (tilesize + 1) + sprsize.y + titlesize
	$cam.limit_top = 48 - 16 * $cam.zoom.y
	$movements.map_created()
#	prints($cam.limit_bottom,$cam.limit_right,position)

func set_zoom(z):
	$cam.zoom.x = z
	$cam.zoom.y = z
	$cam.limit_top = 48 - 16 * $cam.zoom.y

func add_zoom(z):
	set_zoom($cam.zoom.y + z)

func move(d):
	position += dir
	position.x = clamp(position.x, limit_l, limit_r)
	position.y = clamp(position.y, limit_u, limit_d)