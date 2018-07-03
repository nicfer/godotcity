extends Node
var cont = ""
var mapsize = {"x":0,"y":0}
var mx = 1
var my = 0

func fload(f):
	var file = File.new()
	file.open("res://assets/maps/"+f+".map",File.READ)
	cont = file.get_as_text()
	file.close()
	var nt = next_tile()
	while (!nt.eof):
		$"..".set_cell(nt.y,nt.x,nt.tile)
		nt = next_tile()
	return mapsize

func next_char():
	if (cont.length() == 0):
		return -1
	var c = cont.ord_at(0)
	cont = cont.right(1)
	return c

func next_tile():
	var rt = {"eof":false}#,"mapsize":mapsize}
	var c = next_char()
	while (c == 10):
		mapsize.y = int(max(mapsize.y,my))
		my = 0
		c = next_char()
	if (my == 0):
		mapsize.x += 1
		if (c == 35):
			while (next_char() != 10):
				pass
			mapsize.y = int(max(mapsize.y,my))
			my = 0
			c = next_char()
	if (c == -1):
		rt.eof = true
		rt.mapsize = mapsize
		return rt
	my += 1
	rt.tile = parse_ascii(c)
	rt.x = mapsize.x
	rt.y = my
	return rt

func parse_ascii(i):
	if (i >= 48 and i <= 57):
		return i - 48