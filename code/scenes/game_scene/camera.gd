extends Camera2D
onready var windowsize = get_viewport_rect().size

var panning
var rheld = false
var mapsize

func _ready():
	set_process_input(true)
	set_process(true)

func set_mapsize(sx,sy):
	mapsize = {"x":sx,"y":sy}

func scroll_keyb():
	var scrlSpd = 1
	var pos = Vector2(0,0)
	if (Input.is_action_pressed("scroll_up")):
		pos.y -= scrlSpd
	if (Input.is_action_pressed("scroll_down")):
		pos.y += scrlSpd
	if (Input.is_action_pressed("scroll_left")):
		pos.x -= scrlSpd
	if (Input.is_action_pressed("scroll_right")):
		pos.x += scrlSpd
	if (pos.length() > 0):
		translate(pos.normalized())

func translate(tr):
	if (mapsize == null): return
	var scrlLim = {
		"x":int(max(Globals.TILESIZE * mapsize.x-windowsize.x,0)),
		"y":int(max(Globals.TILESIZE * mapsize.y-windowsize.y,0))
	}
	var pos = position + tr
#	print(pos)
	pos.x = clamp(pos.x,0,scrlLim.x)
	pos.y = clamp(pos.y,0,scrlLim.y)
#	print(pos)
	position = pos

func _input(e):
	if (e is InputEventMouseButton):
		if (e.position.y >= 16):
			if (e.is_pressed()):
				if (e.button_index == 3):
					panning = e.position
			else:
				if (e.button_index == 3):
					Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
					Input.warp_mouse_position(panning)
					panning = null
	elif (e is InputEventMouseMotion):
		if (e.position.y >= 16):
			if (panning != null):
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				var newpos = e.position-OS.get_window_size()*0.5
				panning += newpos
				translate(newpos)

func _process(delta):
	scroll_keyb()