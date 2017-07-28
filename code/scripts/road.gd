extends Node

class Road extends Node:
	onready var root = get_node("/root/Node")
	onready var terrain = get_node("..")

	const teq = {
		2:["u","d","ud"],3:["l","r","lr"],4:["udlr"],
		5:["ul"],6:["dl"],7:["ur"],8:["dr"],
		9:["udl"],10:["dlr"],11:["ulr"],12:["udr"]
	}

	var pos = Vector2()
	var ady = {
		"u":null,"d":null,"l":null,"r":null
	}
	var ntile = 0

	func set_adyacent(p,r):
		ady[p] = r
#		print(pos,ady)
#		set_tile()

	func look_adyacent(r):
		var d = self.pos - r.pos
		if d.x == 0:#u,d
			if d.y == 1:#u
				set_adyacent("u",r)
				r.set_adyacent("d",self)
				return "u"
			elif d.y == -1:
				set_adyacent("d",r)
				r.set_adyacent("u",self)
				return "d"
		elif d.y == 0:#l,r
			if d.x == 1:#l
				set_adyacent("l",r)
				r.set_adyacent("r",self)
				return "l"
			elif d.x == -1:
				set_adyacent("r",r)
				r.set_adyacent("l",self)
				return "r"

	func eq_tile(rd):
		for t in teq:
			if teq[t].has(rd):
				return t
		return 1

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
		ntile = eq_tile(rd)
#		terrain.set_cellv(terrain.map_to_world(pos),ntile)

	func set_rtile():
		set_tile()
		terrain.set_cellv(pos,ntile)

	func init(p):
		pos = p
		for r in get_tree().get_nodes_in_group("roads"):
			if look_adyacent(r) != null:
				r.set_rtile()
		set_tile()
		add_to_group("roads")
		return ntile
#		for r in range(4):
#			if ady[r] != null:
#				ady[r].set_adyacent(r,self)
#				ady[r].set_tile()