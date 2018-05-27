extends Node
var speed = 3.0
var base_speed = 3.0
var sprint = 3

func _process(d):
	var dir = Vector2()
	if (Input.is_action_pressed("rosruc_sprint")):
		speed = base_speed * sprint
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
	$"../animations".anim( int(sign(dir.x)) , int(sign(dir.y)) )