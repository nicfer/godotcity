extends Panel
onready var root = get_node("/root/Node")
onready var terrain = root.get_node("terrain")
onready var money_node = get_node("money")
onready var hab_label = get_node("hab")
onready var date = get_node("date")
onready var buttons = get_node("buttons")
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
var tset = preload("res://code/tilesets/tset.xml")

var credits = 0
var loan_taken = 0
var loan_max = 10
var loan_step = 1000
var whab = 2

var tools = {\
		"place":{\
			1:16,\
			2:-1,\
			3:13,\
			4:14\
		},\
		"cost":{\
			1:10,\
			2:10,\
			3:50,\
			4:0\
		},\
		"on_place":{\
			1:"on_destroy",\
			2:"on_road",\
			3:"on_mine",\
			4:"on_house"\
		}\
	}

func _ready():
	refresh_credits()
	refresh_hab()
	set_fixed_process(true)

func get_tool():
	return buttons.get_selected()

func on_destroy(pm):
	if terrain.get_cellv(pm) < 1: return -1
	return 16

func on_mine(pm):
	if terrain.get_cellv(pm) != 0: return -1
	return 13

func on_road(pm):
	if terrain.get_cellv(pm) != 0: return -1
	var nroad = root.get_class("Road")
	terrain.add_child(nroad)
	return nroad.init(pm)#tools.place[get_tool()]

func assign_house():
	if whab < 2: return 0
	var tseed = min(whab,20)
	whab -= tseed
	refresh_hab()
	return tseed

func on_house(pm):
	if terrain.get_cellv(pm) != 0: return -1
	var nhouse = root.get_class("House")
	var tassign = assign_house()
	if tassign <= 0:
		for hic in get_tree().get_nodes_in_group("growing_houses"):
			var newcomers = hic.get_newhomers()
			print(newcomers)#print
			if newcomers + whab >= 2:
				tassign = newcomers
				if newcomers <= 1:
					tassign += whab
					whab = 0
				hic.mudate(newcomers)
				break
	nhouse.init(pm,tassign)
	terrain.add_child(nhouse)
	return 14

func add_whab(h):
	whab += h
	for hic in get_tree().get_nodes_in_group("desert_houses"):
		hic.add_hab(assign_house())

func place_stuff(pm):
#	var r = call(tools.on_place[get_tool()],pm)
#	if call(tools.on_place[get_tool()],pm):
	return call(tools.on_place[get_tool()],pm)
#	return -1

#func on_build_stuff():
#	if buttons.get_selected() == 4:
#		pass
#panel.on_build_stuff()

func click_on(pm):
	if get_tool() != 0:
		if has_enough_money():
			deduct_money()
			return call(tools.on_place[get_tool()],pm)
	return -1
#			var bplace = place_stuff(pm)
#			if bplace != null and bplace >= 0:

func _proc_hour():
	for hic in get_tree().get_nodes_in_group("houses_in_construction"):
		hic.advance_construction()
	for hic in get_tree().get_nodes_in_group("growing_houses"):
		hic.advance_growth()

func _proc_day():
	for hic in get_tree().get_nodes_in_group("growing_houses"):
		credits += hic.hab[0] * 10
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
	for hic in get_tree().get_nodes_in_group("growing_houses"):
		thab += hic.hab[0]
	hab_label.set_text("Popul: %d (%d homeless)" % [thab,whab])

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

func has_enough_money():
	return credits >= tools.cost[buttons.get_selected()]

func deduct_money():
	credits -= tools.cost[buttons.get_selected()]
	refresh_credits()

func _loan_up():
	if can_take_loan():
		credits += loan_step
		loan_taken += 1
		refresh_credits()

func _loan_down():
	if can_pay_loan():
		credits -= loan_step
		loan_taken -= 1
		refresh_credits()
#func refresh_loan_buttons():
#		refresh_loan_buttons()