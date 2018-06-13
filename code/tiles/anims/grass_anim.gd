extends Node
const mt = 15
var t = 0
var p = 0
export var tile_to_anim = 0
export var tile_orig_x = 128
export var tile_orig_y = 0
export var anim_tiles = 4

func _process(delta):
	t += 1
	if (t > mt):
		t = 0
		p = (p + 1) % anim_tiles
		$"..".tile_set.tile_set_region(tile_to_anim,Rect2(
			(tile_orig_x+p*32) % 3200,
			tile_orig_y +(tile_orig_x+p*32) / 3200,
			32,
			32)
		)