extends Node
onready var root = get_node("/root/Node")
onready var terrain = root.get_node("bg")
var cost = 25

func on_click(pm):
	for t in terrain.get_children():
		if t.get_type() != "TileMap": continue
		if t.get_cellv(pm) != -1: return -1
	var nmine = Mine.new()
	terrain.add_child(nmine)
	nmine.init(pm)

class Mine extends Node:
	onready var root = get_node("/root/Node")
	onready var panel = root.get_node("CanvasLayer/Panel")
	onready var terrain = root.get_node("bg")
	var pos = Vector2()

	var jobs = 25

	func init(p):
		pos = p
		add_to_group("mines")
		terrain.set_builds(pos,0)
		for h in get_tree().get_nodes_in_group("habitants"):
			if h.is_unemployed():
				h.set_work(self)
				jobs -= 1
				if jobs <= 0: break
#
#	func add_workers(w):
#		var d = get_av_jobs() - w
#		jobs = min(jobs+w,mjobs)
#		panel.refresh_hab()
#		return d