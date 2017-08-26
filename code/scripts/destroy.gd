extends Node
onready var root = get_node("/root/Node")
onready var terrain = root.get_node("bg")

var cost = 1

func on_click(pm):
	for r in get_tree().get_nodes_in_group("destroyable"):
		if r.pos == pm:
			r.destroy()
			var rb = Rubble.new()
			terrain.add_child(rb)
			rb.init(pm)
			return 3
	return -1

class Rubble extends Node:
	onready var root = get_node("/root/Node")
	onready var terrain = root.get_node("bg")
	var pos
	var tleft = 30

	func init(p):
		pos = p
		terrain.set_cellv(pos,3)
		add_to_group("rubbles")

	func tick_down():
		tleft -= 1
		if tleft > 0:
			terrain.set_cellv(pos,tleft/10+1)
		else:
			terrain.set_cellv(pos,0)
			queue_free()