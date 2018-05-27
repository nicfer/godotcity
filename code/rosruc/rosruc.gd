extends Node2D
#var speed = 3.0
#var base_speed = 3.0
#var sprint = 3
#var anim_x = 0
#var anim_y = 0
#
#func _process(d):
#	var dir = Vector2()
#	if (Input.is_action_pressed("rosruc_sprint")):
#		speed = base_speed * sprint
#	if (Input.is_action_pressed("rosruc_down")):
#		dir.y = speed
#	if (Input.is_action_pressed("rosruc_up")):
#		dir.y -= speed
#	if (Input.is_action_pressed("rosruc_right")):
#		dir.x = speed
#	if (Input.is_action_pressed("rosruc_left")):
#		dir.x -= speed
#	$face/eyes.position = Vector2(sign(dir.x),sign(dir.y))
#	position += dir
#	anim_x += int(sign(dir.x)) % 4
#	if (anim_x < 0):
#		anim_x = 3
#	elif (anim_x > 3):
#		anim_x = 0
#	anim_y += int(sign(dir.y)) % 4
#	if (anim_y < 0):
#		anim_y = 3
#	elif (anim_y > 3):
#		anim_y = 0
