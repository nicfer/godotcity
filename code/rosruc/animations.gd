extends Node
var anim_l = 0
var anim_r = 0
var anim_y = 0

func anim(x,y):
	anim_y += y
	if (anim_y < 0):
		anim_y = 3
	elif (anim_y > 3):
		anim_y = 0
	if (x > 0):
		anim_r = (anim_r + 1) % 4
		anim_r()
	elif (x < 0):
		anim_l = (anim_l + 1) % 4
		anim_l()
	if (x == 0 and y == 0):
		anim_l = 0
		anim_r = 0
		anim_y = 0
	anim_h()
	
func anim_h():
	var l1 = $"../face/body/leg1"
	var l2 = $"../face/body/leg2"
	if (anim_y % 3 != 0):
		l1.region_rect.size.y = 2
	else:
		l1.region_rect.size.y = 4
	if (anim_y >= 2):
		l2.region_rect.size.y = 2
	else:
		l2.region_rect.size.y = 4
	
func anim_r():
	var l1 = $"../face/body/leg1"
	var l2 = $"../face/body/leg2"
	if (anim_r % 3 != 0):
		l2.position.x = 2
	else:
		l2.position.x = 0
	if (anim_r >= 2):
		l1.position.x = 2
	else:
		l1.position.x = 0
	
func anim_l():
	var l1 = $"../face/body/leg1"
	var l2 = $"../face/body/leg2"
	if (anim_l % 3 != 0):
		l1.position.x = -2
	else:
		l1.position.x = 0
	if (anim_l >= 2):
		l2.position.x = -2
	else:
		l2.position.x = 0