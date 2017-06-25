extends Camera2D
onready var terrain = get_node("../terrain")

func _ready():
	set_process_input(true)
	set_fixed_process(true)

func _input(e):
	if e.type == InputEvent.MOUSE_BUTTON:
		if e.y >= 16:
			if e.is_pressed() and e.button_index == 1:
				terrain.click_on(e.pos+get_pos())

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