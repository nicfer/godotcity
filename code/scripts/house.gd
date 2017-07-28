extends Node

class House extends Node:
	onready var root = get_node("/root/Node")
	onready var terrain = get_node("..")#/root/Node/terrain
	onready var panel = root.get_node("CanvasLayer/Panel")
	var prog = [0,5]
	var hab = [0,20]
	var seedhab = 0
	var hgrow = [0,2]
	var pos = Vector2()

	func init(p,sh):
		pos = p
		seedhab = sh
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

	func advance_growth():
		hgrow[0] += 1
		if hgrow[0] >= hgrow[1]:
			hgrow[0] = 0
			hab[0] += 1
			if hab[0] >= hab[1]:
				panel.add_whab(hab[0] - hab[1])
				hab[0] = hab[1]
			panel.refresh_hab()

	func can_grow():
		return true
		var start_pos = terrain.get_ady_road(pos)

	func advance_construction():
		prog[0] += 1
		if prog[0] >= prog[1]:
			remove_from_group("houses_in_construction")
			if can_grow():
				add_to_group("growing_houses")
			terrain.set_cellv(pos,15)
			hab[0] = seedhab
			panel.refresh_hab()