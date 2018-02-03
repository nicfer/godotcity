extends Node2D
class Tile:

	func test(x):
		print(x)

func _ready():
	var file = File.new()
	file.open("res://media/example.map", file.READ)
	var mapsz = file.get_csv_line()
	var mapx = int(mapsz[0])
	var mapy = int(mapsz[1])
	get_node("Camera2D").set_mapsize(mapx,mapy)
	for y in range(mapy):
		var line = file.get_line()
		for x in range(mapx):
			var tid = int(line[x])
			if (tid):
				pass
#			var tile = preload("res://code/tile.tscn").instance()\
#				.create(x,y,tid)
#			add_child(tile)
	file.close()
#	for x in range(0,4096):
#		var t = Tile.new()
#		t.test(x)