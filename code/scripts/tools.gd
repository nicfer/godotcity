extends Control
onready var status = get_node("../Panel")

var tools = {}
var selected = ""

func set_selected(n):
	selected = n
	for t in tools:
		tools[t].set_selected(t == selected)

func _ready():
	for c in get_children():
		var cn = c.get_name()
		tools[cn] = get_node(cn)
	set_selected("Road")

func get_selected(): return tools[selected]

func click_on(pm):
	var cost = get_selected().get_cost()
	if status.has_enough_money(cost):
		var rt = get_selected().on_click(pm)#call(tools.on_place[get_tool()],pm)
		if rt != null and rt <= -1: return -1
		status.deduct_money(cost)
		return rt
	return -1