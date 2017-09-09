extends Node
onready var root = get_node("/root/Node")
onready var terrain = root.get_node("bg")
var cost = 10

func on_click(pm):
	for t in terrain.get_children():
		if t.get_type() != "TileMap": continue
		if t.get_cellv(pm) != -1: return -1
	var nroad = Road.new()
	terrain.add_child(nroad)
	nroad.init(pm)

class Road extends "res://code/scripts/destroyable.gd".Destroyable:
	const teq = {
		1:["u","d","ud"],2:["l","r","lr"],3:["udlr"],
		4:["ul"],5:["dl"],6:["ur"],7:["dr"],
		8:["udl"],9:["dlr"],10:["ulr"],11:["udr"]
	}
	var ntile = 0

	func init(p):
		.init(p)
		add_to_group("roads")
		add_to_group("destroyable")
		look_adyacent()
		var y = [self]
		for a in ady:
			if ady[a] == null: continue
			ady[a].set_adyacent(get_opposite(a),self)
			y.append(ady[a])
		for r in y:
			r.set_rtile()
		for uh in get_tree().get_nodes_in_group("houses"):
			if is_ady_to_point(uh.pos):
				uh.can_grow()
		return ntile

	func set_adyacent(p,r):
		ady[p] = r

	func is_ady_to_point(p):
		return get_ady_points(p) != null

	func get_ady_points(p):
		var d = pos - p
		if d.x == 0:#u,d
			if d.y == 1:#u
				return "u"
			elif d.y == -1:
				return "d"
		elif d.y == 0:#l,r
			if d.x == 1:#l
				return "l"
			elif d.x == -1:
				return "r"

	func look_adyacent():
		for a in ady: ady[a] = null
		for r in get_tree().get_nodes_in_group("roads"):
			var d = get_ady_points(r.pos)
			if d != null:
				set_adyacent(d,r)

	func eq_tile(rd):
		for t in teq:
			if teq[t].has(rd):
				return t
		return 0

	func set_tile():
		var rd = ""
		if ady.u != null:#u
			rd += "u"
		if ady.d != null:#d
			rd += "d"
		if ady.l != null:#l
			rd += "l"
		if ady.r != null:#r
			rd += "r"
		print(rd)
		ntile = eq_tile(rd)

	func set_rtile(t=null):
		set_tile()
		if t == null: t = ntile
		terrain.set_road(pos,t)

	func get_opposite(d):
		if d == "d":
			return "u"
		if d == "u":
			return "d"
		if d == "r":
			return "l"
		if d == "l":
			return "r"

	func destroy():
		for a in ady:
			if ady[a] != null:
				ady[a].set_adyacent(get_opposite(a),null)
				ady[a].set_rtile()
		terrain.set_road(pos,-1)
		queue_free()