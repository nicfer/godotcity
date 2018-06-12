extends Node2D
const sprsize = Vector2(27,31)
const titlesize = 16
const yoffset = 23
const tilesize = 32

func map_created():
	position.x = Globals.gn("bg").mapsize.x * tilesize * 0.5
	position.y = Globals.gn("bg").mapsize.y * tilesize * 0.5 + titlesize
# set_cam_limit():
	$cam.limit_right  = (Globals.gn("bg").mapsize.x)\
		* tilesize + sprsize.x
	$cam.limit_bottom = (Globals.gn("bg").mapsize.y)\
		* tilesize + sprsize.y + yoffset + titlesize
	$movements.map_created()
#	prints($cam.limit_bottom,$cam.limit_right,position)