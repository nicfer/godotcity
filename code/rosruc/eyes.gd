extends Sprite

func looking_at(d):
	position.x = sign(d.x)
	position.y = sign(d.y)