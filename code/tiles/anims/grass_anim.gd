extends Node
const mt = 15
var t = 0
var p = 0

func _process(delta):
	t += 1
	if (t > mt):
		t = 0
		p = (p + 1) % 4
		$"..".tile_set.tile_set_region(0,Rect2(128+p*32,0,32,32))