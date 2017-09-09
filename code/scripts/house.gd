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
	terrain.add_child(nhouse)
	nhouse.init(pm)

class House extends Node:
	onready var root = get_node("/root/Node")
	onready var terrain = root.get_node("bg")#/root/Node/terrain
	onready var panel = root.get_node("CanvasLayer/Panel")
	var prog = 5
	var mhab = 20
	var growstat = 0 # 0 = Can't build; 1 = Building; 2 = Built, not growing
										# 3 = Growing
	var hgrow = 0
	var mhgrow = 2
	var habs = []
	var pos = Vector2()

	func init(p):
		pos = p
		terrain.set_builds(pos,1)
		add_to_group("destroyable")
		add_to_group("houses")
		for h in get_tree().get_nodes_in_group("habitants"):
			if h.needs_home():
				habs.append(h)
		if habs.size() >= 2:
			growstat = 1

	func is_growing(): return growstat >= 3

	func is_being_built(): return growstat == 1

	func is_deserted(): return growstat <= 0

	func can_grow():
		var d = false
		for r in get_tree().get_nodes_in_group("roads"):
			d = r.is_ady_to_point(pos)
			if d:
				growstat = 3
				break

	func advance_construction():
		prog -= 1
		if prog > 0: return #Still not built
		growstat = 2
		can_grow()
		terrain.set_builds(pos,2)
		assign_habs()

	func assign_habs(nh=[]):
		for n in nh:
			habs.append(n)
		for h in habs:
			h.set_home(self)

	func leave(h):
		habs.erase(h)

	func advance_growth():
		hgrow += 1
		if hgrow < mhgrow: return #Still didn't grow
		hgrow = 0
		var nh = panel.new_hab(self)
		if habs.size() >= mhab: return #House is full
		habs.append(nh)
		if habs.size() > mhab / 2:
			var migr = 0
			while habs[migr].is_mudating():
				migr += 1
			habs[migr].set_mudating(true)

#	var tassign = panel.assign_house()
#	if tassign.size() >= 2:
#		nhouse.add_seedhab(tassign)
#
#		hab[0] = seedhab
#		seedhab = 0
#		panel.refresh_hab()
#
#	func add_seedhab(sh):
#		hab = sh
#		for h in hab:
#			h.set_home(self)
#		growstat = 1

#	func get_newhomers():
#		return int(clamp((hab[0]-seedhab) * (hab[0]*3/hab[1]+1),0,hab[0]))
#
#	func mudate(h):
#		var m = []
#		for i in range(h):
#			m.append(hab.pop_back())
#		return m
#
#	func assign_job(w=1):
#		var j = get_unemployed()
#		if j <= 0: return 0
#		for m in get_tree().get_nodes_in_group("mines"):
#			var mw = int(min(j,w))
#			var nw = m.add_workers(mw)
#			if nw <= 0: return 0
#			j -= nw
#		return j
#
#	func get_available_jobs():
#		for m in get_tree().get_nodes_in_group("mines"):
#			if m.get_av_jobs() > 0:
#				return m
#		return null
#
#	func get_unemployed():
#		var u = []
#		for h in hab:
#			if h.is_unemployed():
#				u.append(h)
#		return u
#
#	func get_employed():
#		var u = []
#		for h in hab:
#			if !h.is_unemployed():
#				u.append(h)
#		return u
#
#	func employ(j):#j=10
#		var nj = j.get_av_jobs()
#		var unemp = get_unemployed()
#		var mj = unemp.size() > 0
#		while mj:
#			for h in hab:
#				if h.is_unemployed():
#					h.set_work(j)
#					unemp.erase(h)
#					if unemp.size() <= 0:
#						mj = false
#			mj = false
#
#	func born_hab():
#		var nh = root.get_class("Habitant").new_hab(self)
#		nh.set_home(self)
#		return nh
#		if hgrow[0] >= hgrow[1]:
#			hgrow[0] = 0
#			hab.append(born_hab())
#			var aj = get_available_jobs()
#			if aj != null:
#				hab.set_work(aj)
#			if hab[0] >= hab[1]:
#				panel.add_whab(hab[0] - hab[1])
#				hab[0] = hab[1]
#			panel.refresh_hab()