extends Node
onready var root = get_node("/root/Node")
onready var terrain = root.get_node("bg")#/root/Node/terrain
onready var panel = root.get_node("CanvasLayer/Panel")
var cost = 0

func on_click(pm):
	for t in terrain.get_children():
		if t.get_type() != "TileMap": continue
		if t.get_cellv(pm) != -1: return -1
	var nhouse = House.new()
	var tassign = panel.assign_house()
	terrain.add_child(nhouse)
	nhouse.init(pm,tassign)

class House extends Node:
	onready var root = get_node("/root/Node")
	onready var terrain = root.get_node("bg")#/root/Node/terrain
	onready var panel = root.get_node("CanvasLayer/Panel")
	var prog = [0,5]
	var hab = [0,20]
	var working = 0
	var seedhab = 0
	var hgrow = [0,2]
	var pos = Vector2()

	func init(p,sh):
		pos = p
		seedhab = sh
		add_to_group("destroyable")
		add_to_group("houses")
		terrain.set_builds(pos,1)
		if seedhab >= 2:
			add_to_group("houses_in_construction")
		else:
			add_to_group("desert_houses")

	func add_hab(h):
		seedhab = h
		remove_from_group("desert_houses")
		add_to_group("houses_in_construction")

	func get_newhomers():
		return int(clamp((hab[0]-seedhab) * (hab[0]*3/hab[1]+1),0,hab[0]))

	func mudate(h):
		hab[0] -= h

	func assign_job(w=1):
		var j = get_unemployed()
		for m in get_tree().get_nodes_in_group("mines"):
			var mw = min(j,w)
			working += mw
			var nw = m.add_workers(mw)
			if nw <= 0: return 0
			j -= nw
		return j

	func get_available_jobs():
		var j = 0
		for m in get_tree().get_nodes_in_group("mines"):
			j += m.get_av_jobs()
		return j

	func get_unemployed(): return hab[0] - working#5-2=3

	func employ(j):#j=10
		var nj = min(get_unemployed(),j)
		working += nj
		return nj

	func advance_growth():
		hgrow[0] += 1
		if hgrow[0] >= hgrow[1]:
			hgrow[0] = 0
			hab[0] += 1
			assign_job()
			if hab[0] >= hab[1]:
				panel.add_whab(hab[0] - hab[1])
				hab[0] = hab[1]
			panel.refresh_hab()

	func can_grow():
		var d = false
		for r in get_tree().get_nodes_in_group("roads"):
			d = r.is_ady_to_point(pos)
			if d: break
		if d:
			add_to_group("growing_houses")
			if is_in_group("unemployed_houses"):
				remove_from_group("unemployed_houses")
		else:
			add_to_group("unemployed_houses")
			if is_in_group("growing_houses"):
				remove_from_group("growing_houses")

	func advance_construction():
		prog[0] += 1
		if prog[0] >= prog[1]:
			remove_from_group("houses_in_construction")
			can_grow()
			terrain.set_builds(pos,2)
			hab[0] = seedhab
			seedhab = 0
			panel.refresh_hab()