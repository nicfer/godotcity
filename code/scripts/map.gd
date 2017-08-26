extends TileMap
const MAPSIZE = Vector2(32,32)
onready var roads = get_node("roads")
onready var builds = get_node("builds")
onready var tools = get_node("../CanvasLayer/tools")

func _ready():
	for x in range(MAPSIZE.x):
		for y in range(MAPSIZE.y):
			set_cell(x,y,0)

func click_on(p):
	var pm = world_to_map(p)
	tools.click_on(pm)
	return pm

func set_road(p,r):
	roads.set_cellv(p,r)

func set_builds(p,r):
	builds.set_cellv(p,r)

#	if res >= 0:
#		set_cellv(pm,res)
#res != null and
#func get_ady_road(pm):
#	var rd = 0
#	if get_cell(pm.x,pm.y-1) >= 1 and get_cell(pm.x,pm.y-1) <= 12:#u
#		rd += 1
#	if get_cell(pm.x,pm.y+1) >= 1 and get_cell(pm.x,pm.y+1) <= 12:#d
#		rd += 2
#	if get_cell(pm.x-1,pm.y) >= 1 and get_cell(pm.x-1,pm.y) <= 12:#l
#		rd += 4
#	if get_cell(pm.x+1,pm.y) >= 1 and get_cell(pm.x+1,pm.y) <= 12:#r
#		rd += 8
#	return rd

#func recalc_road(pm):
#	if get_cell(pm.x,pm.y) < 1 or get_cell(pm.x,pm.y) > 12: return
#	var rd = get_ady_road(pm)
#	if rd == 0:
#		set_cellv(pm,1)
#	elif rd >= 9:
#		set_cellv(pm,rd-3)
#	elif rd % 4 == 0:
#		set_cellv(pm,9)
#	elif rd >= 5:
#		set_cellv(pm,rd-2)
#	else:#if rd >= 1
#		set_cellv(pm,2)

#func place_road(pm):
#	set_cellv(pm,1)
#	recalc_road(pm)
#	recalc_road(pm-Vector2(1,0))#l
#	recalc_road(pm+Vector2(1,0))#r
#	recalc_road(pm-Vector2(0,1))#u
#	recalc_road(pm+Vector2(0,1))#d

#	var pm = world_to_map(p)
#	var brush = panel.get_tool()
#	if brush != 0:
#		if panel.has_enough_money():
#			panel.deduct_money()
#			var bplace = panel.place_stuff(pm)
#			if bplace != null and bplace >= 0:
#				set_cellv(pm,bplace)
#				panel.on_build_stuff()
#	return pm

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