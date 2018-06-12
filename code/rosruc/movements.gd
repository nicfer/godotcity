extends Node
var limit_u = 0
var limit_l = 0
var limit_d
var limit_r

var base_speed = 3.0
var sprint = 3
var active = false

func map_created():
	limit_d = (Globals.gn("bg").mapsize.y + 1) * ($"..".tilesize - 1)
	limit_r = (Globals.gn("bg").mapsize.x) * ($"..".tilesize - 1)
	active = true

func _process(d):
	if (active):
		var speed = base_speed
		var dir = Vector2()
		if (Input.is_action_pressed("rosruc_sprint")):
			speed *= sprint
		if (Input.is_action_pressed("rosruc_down")):
			dir.y = speed
		if (Input.is_action_pressed("rosruc_up")):
			dir.y -= speed
		if (Input.is_action_pressed("rosruc_right")):
			dir.x = speed
		if (Input.is_action_pressed("rosruc_left")):
			dir.x -= speed
		$"../face/eyes".position = Vector2(sign(dir.x),sign(dir.y))
		$"..".position += dir
		$"..".position.x = clamp($"..".position.x, limit_l, limit_r)
		$"..".position.y = clamp($"..".position.y, limit_u, limit_d)
		$"../../CanvasLayer/debug".text = str($"..".position) + "    " + str(
			(Vector2(int($"..".position.x / 32),int($"..".position.y / 32)))
		)
		$"../animations".anim( int(sign(dir.x)) , int(sign(dir.y)) )