extends Panel
onready var root = get_node("/root/Node")
onready var terrain = root.get_node("bg")
onready var money_node = get_node("money")
onready var hab_label = get_node("hab")
onready var homeless_label = get_node("homeless")
onready var unemp_label = get_node("unemp")
onready var date = get_node("date")
onready var tools = get_node("../tools")
onready var loan_up_button = get_node("loan_up")
onready var loan_down_button = get_node("loan_down")

var ticks = 0
var ticks_max = 60
var hour = 0
var hour_max = 24
var day = 0
var day_max = 30
var month = 0
var month_max = 12
var year = 0
var jobs = 0
var tset = preload("res://code/tilesets/tset.xml")

var credits = 0
var loan_taken = 0
var loan_max = 10
var loan_step = 1000
var whab = 2

func _ready():
	refresh_credits()
	refresh_hab()
	set_fixed_process(true)

func on_mine(pm):
	for t in terrain.get_children():
		if t.get_type() != "TileMap": continue
		if t.get_cellv(pm) != -1: return -1
	var nmine = root.get_class("Mine")
	terrain.add_child(nmine)
	nmine.init(pm)

func assign_house():
	if whab < 2: return 0
	var tseed = min(whab,20)
	whab -= tseed
	refresh_hab()
	return tseed

func add_whab(h):
	whab += h
	for hic in get_tree().get_nodes_in_group("desert_houses"):
		hic.add_hab(assign_house())

func _proc_hour():
	for hic in get_tree().get_nodes_in_group("houses_in_construction"):
		hic.advance_construction()
	for hic in get_tree().get_nodes_in_group("growing_houses"):
		hic.advance_growth()
	for r in get_tree().get_nodes_in_group("rubbles"):
		r.tick_down()

func _proc_day():
	for hic in get_tree().get_nodes_in_group("growing_houses"):
		credits += hic.working * 10
		refresh_credits()

func next_hour():
	ticks -= ticks_max
	hour += 1
	_proc_hour()
	if hour < hour_max: return
	hour -= hour_max
	day += 1
	_proc_day()
	if day < day_max: return
	day -= day_max
	month += 1
	if month < month_max: return
	month -= month_max
	year += 1

func refresh_date():
	var td = str(year) + "/"
	if month < 10: td += "0"
	td += str(month) + "/"
	if day < 10: td += "0"
	td += str(day) + ":"
	if hour < 10: td += "0"
	td += str(hour)
	date.set_text(td)

func refresh_hab():
	var thab = 0
	var jobs = 0
	for hic in get_tree().get_nodes_in_group("houses"):
		thab += hic.hab[0]
		jobs += hic.working
	hab_label.set_text(str(thab))
	homeless_label.set_text(str(whab))
	unemp_label.set_text(str(thab-jobs))

func _fixed_process(d):
	ticks += 1
	if ticks >= ticks_max:
		next_hour()
		refresh_date()

func can_take_loan(): return loan_taken < loan_max

func can_pay_loan(): return credits >= loan_step and loan_taken > 0

func refresh_credits():
	money_node.set_text("$"+str(credits))
	if can_take_loan(): loan_up_button.set_modulate(Color(1,1,1,1))
	else: loan_up_button.set_modulate(Color(1,1,1,0.5))
	if can_pay_loan(): loan_down_button.set_modulate(Color(1,1,1,1))
	else: loan_down_button.set_modulate(Color(1,1,1,0.5))

func has_enough_money(m):
	return credits >= m

func deduct_money(m):
	credits -= m
	refresh_credits()

func _loan_up():
	if !can_take_loan(): return
	credits += loan_step
	loan_taken += 1
	refresh_credits()

func _loan_down():
	if !can_pay_loan(): return
	credits -= loan_step
	loan_taken -= 1
	refresh_credits()

#var tools = {\
#		"place":{\
#			1:16,\
#			2:-1,\
#			3:13,\
#			4:14\
#		},\
#		"cost":{\
#			1:10,\
#			2:10,\
#			3:50,\
#			4:0\
#		},\
#		"on_place":{\
#			1:"on_destroy",\
#			2:"on_road",\
#			3:"on_mine",\
#			4:"on_house"\
#		}\
#	}

#func get_tool():
#	return buttons.get_selected()

#func on_destroy(pm):
#	for r in get_tree().get_nodes_in_group("destroyable"):
#		if r.pos == pm:
#			r.destroy()
#			return 1
#	return -1

#func on_road(pm):
#	for t in terrain.get_children():
#		if t.get_type() != "TileMap": continue
#		if t.get_cellv(pm) != -1: return -1
#	var nroad = root.get_class("Road")
#	terrain.add_child(nroad)
#	nroad.init(pm)

#func on_house(pm):
#	for t in terrain.get_children():
#		if t.get_type() != "TileMap": continue
#		if t.get_cellv(pm) != -1: return -1
#	var nhouse = root.get_class("House")
#	terrain.add_child(nhouse)
#	var tassign = assign_house()
#	nhouse.init(pm,tassign)
#	terrain.set_road(pm,nroad.init(pm))
#	if tassign <= 0:
#		for hic in get_tree().get_nodes_in_group("growing_houses"):
#			var newcomers = hic.get_newhomers()
#			if newcomers + whab >= 2:
#				tassign = newcomers
#				if newcomers <= 1:
#					tassign += whab
#					whab = 0
#				hic.mudate(newcomers)
#				break