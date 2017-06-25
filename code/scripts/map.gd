extends TileMap
const MAPSIZE = Vector2(32,32)
onready var panel = get_node("../CanvasLayer/Panel")

func _ready():
	for x in range(MAPSIZE.x):
		for y in range(MAPSIZE.y):
			set_cell(x,y,0)

func recalc_road(pm):
	if get_cell(pm.x,pm.y) < 1 or get_cell(pm.x,pm.y) > 12: return
	var rd = 0
	if get_cell(pm.x,pm.y-1) >= 1 and get_cell(pm.x,pm.y-1) <= 12:#u
		rd += 1
	if get_cell(pm.x,pm.y+1) >= 1 and get_cell(pm.x,pm.y+1) <= 12:#d
		rd += 2
	if get_cell(pm.x-1,pm.y) >= 1 and get_cell(pm.x-1,pm.y) <= 12:#l
		rd += 4
	if get_cell(pm.x+1,pm.y) >= 1 and get_cell(pm.x+1,pm.y) <= 12:#r
		rd += 8
	if rd == 0:
		set_cellv(pm,1)
	elif rd >= 9:
		set_cellv(pm,rd-3)
	elif rd % 4 == 0:
		set_cellv(pm,9)
	elif rd >= 5:
		set_cellv(pm,rd-2)
	else:#if rd >= 1
		set_cellv(pm,2)

func place_road(pm):
	set_cellv(pm,1)
	recalc_road(pm)
	recalc_road(pm-Vector2(1,0))#l
	recalc_road(pm+Vector2(1,0))#r
	recalc_road(pm-Vector2(0,1))#u
	recalc_road(pm+Vector2(0,1))#d

func click_on(p):
	var pm = world_to_map(p)
	var brush = panel.get_tool()
	if brush != -1:
		if brush == 1:
			place_road(pm)
		else:
			set_cellv(pm,brush)
	return pm

#	var adj = get_adjacent(pm)
#	for row in adj:
#		var t = get_cell(row[0],row[1])
#		if t >= 1 and t <= 12:
#			pass
#			if get_cell(x,y) <= 12:
#				row[y] = get_cell(x,y)
#			else:
#				row[y] = 0
#		col[x] = row
#		row = {}
#	var row = {}
#	var col = {}
#	print(col)
#	col[pm.x][pm.y] = 1

#func set_road(pm,tr):
#	if tr == 1:
#		set_cellv(pm,1)
#	elif tr > 1:
#		if tr < 4:#2or3
#			if tr == 2:
#				set_cellv(pm,5)
#			else:
#				set_cellv(pm,5,false,false,true)
#
#func get_adjacent(pm):
#	return [[pm.x-1,pm.y],[pm.x,pm.y-1],[pm.x+1,pm.y],[pm.x,pm.y+1]]