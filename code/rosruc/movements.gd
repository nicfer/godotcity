extends Node
var limit_u = 0
var limit_l = 0
var limit_d
var limit_r

var base_speed = 3.0
var sprint = 3
var active = false
var def_zoom = 0.75
var map

func map_created(m):
	limit_d = (Globals.gn("bg").mapsize.y + 1) * ($"..".tilesize - 1)
	limit_r = (Globals.gn("bg").mapsize.x) * ($"..".tilesize - 1)
	map = m
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
		if (Input.is_action_pressed("rosruc_zoom_in")):
			$"..".add_zoom(-0.001)
		if (Input.is_action_pressed("rosruc_zoom_out")):
			$"..".add_zoom(0.001)
		if (Input.is_action_just_pressed("rosruc_press_tile")):
			map.screen_pressed($"..".position)
		if (Input.is_action_just_pressed("rosruc_inventory")):
			pass
		$"../face/eyes".looking_at(dir)
		$"..".move(dir,limit_u,limit_l,limit_d,limit_r)
		$"../../CanvasLayer/debug".text =\
			str($"..".position) + "    "\
		+ str((Vector2(
					int($"..".position.x / 32)
				, int($"..".position.y / 32)
			)))
		$"../animations".anim( int(sign(dir.x)) , int(sign(dir.y)) )