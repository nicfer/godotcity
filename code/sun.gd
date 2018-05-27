extends Sprite
var pos = 165.0#to3600

func _process(d):
	pos += 0.5
	if (pos == 180):
		pos = 30.0
	position.x = (768 * cos(deg2rad(pos)) + 512)
	position.y = (-300 * sin(deg2rad(pos)) + 400)
