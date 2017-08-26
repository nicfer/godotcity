extends Camera2D
onready var terrain = get_node("../bg")
var lpress
var rpress

func _ready():
	set_process_input(true)
	set_fixed_process(true)

func center(p=null):
	if p == null:
		p = get_viewport().get_mouse_pos()
	var t = p - OS.get_window_size()/2
	translate(t)

func translate(p):
	.translate(p)
	if get_pos().x < get_limit(0):
		set_pos(Vector2(get_limit(0),get_pos().y))
	elif get_pos().x > get_limit(2):
		set_pos(Vector2(get_limit(2),get_pos().y))
	if get_pos().y < get_limit(1):
		set_pos(Vector2(get_pos().x,get_limit(1)))
	elif get_pos().y > get_limit(3):
		set_pos(Vector2(get_pos().x,get_limit(3)))

func _input(e):
	if e.type == InputEvent.MOUSE_BUTTON:
		if e.y >= 16:
			if e.button_index == 1:
				lpress = null
				if e.is_pressed():
					lpress = terrain.click_on(e.pos+get_pos())
			elif e.button_index == 2:
				if e.is_pressed():
					rpress = e.pos
				else:
					rpress = null
	elif e.type == InputEvent.MOUSE_MOTION:
		if e.y >= 16:
			if lpress != null:
				var nlpress = terrain.world_to_map(e.pos)
				if nlpress != lpress:
					lpress = terrain.click_on(e.pos+get_pos())
			if rpress != null:
				var nrpress = e.pos - rpress
				translate(nrpress)
				rpress = e.pos

func _fixed_process(d):
	var _dir = Vector2(0,0)
	if Input.is_action_pressed("camera_up"):
		_dir.y = -1
	if Input.is_action_pressed("camera_down"):
		_dir.y += 1
	if Input.is_action_pressed("camera_left"):
		_dir.x = -1
	if Input.is_action_pressed("camera_right"):
		_dir.x += 1
	if Input.is_action_pressed("camera_fast"):
		_dir *= 3
	translate(_dir)