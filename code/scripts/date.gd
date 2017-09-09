extends Label
onready var money_node = get_node("../money")
onready var bg = get_node("Panel")

var ticks = 0
var ticks_speeds = [10,30,60,100,150]
var stp = ticks_speeds.size()/2
var tspeed_sel = stp
var can_incr_spd = true
var paused = false
var ticks_max = ticks_speeds[tspeed_sel]
var hour = 0
var hour_max = 24
var day = 0
var day_max = 30
var month = 0
var month_max = 12
var year = 0

func _ready(): set_fixed_process(true)

func _proc_hour():
	for hic in get_tree().get_nodes_in_group("houses"):
		if hic.is_being_built():
			hic.advance_construction()
		if hic.is_growing():
			hic.advance_growth()
	for r in get_tree().get_nodes_in_group("rubbles"):
		r.tick_down()

func _proc_day():
	for hic in get_tree().get_nodes_in_group("habitants"):
		if !hic.is_unemployed():
			money_node.add_money(10)

func next_hour():
	ticks -= ticks_max
	ticks_max = ticks_speeds[tspeed_sel]
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
	set_text(td)

func speed_changed():
	can_incr_spd = false
	if paused:
		bg.get_stylebox("panel").set_bg_color(Color(1,1,0,0.5))
		bg.set_margin(0,35)
		bg.set_margin(2,-35)
	else:
		var slide = 0
		if tspeed_sel < stp:
			bg.get_stylebox("panel").set_bg_color(Color(0,1,0,0.5))
			slide = 35 - 17.5 * tspeed_sel
		else:
			bg.get_stylebox("panel").set_bg_color(Color(1,0,0,0.5))
			slide = 17.5 * tspeed_sel - 35
		bg.set_margin(0,slide)
		bg.set_margin(2,-slide)
#		StyleBoxFlat.new().set_bg_color()

func change_speed():
	if Input.is_action_pressed("simspeed_down") and can_incr_spd\
					and tspeed_sel < ticks_speeds.size() - 1:
		tspeed_sel += 1
		speed_changed()
	if Input.is_action_pressed("simspeed_up") and can_incr_spd\
					and tspeed_sel > 0:
		tspeed_sel -= 1
		speed_changed()
	if Input.is_action_pressed("simspeed_pause") and can_incr_spd:
		paused = !paused
		speed_changed()
	if !can_incr_spd:
		can_incr_spd = !(Input.is_action_pressed("simspeed_down")\
									or Input.is_action_pressed("simspeed_up")\
									or Input.is_action_pressed("simspeed_pause"))

func _fixed_process(d):
	change_speed()
	if ticks_max > 0 and !paused:
		ticks += 1
		if ticks >= ticks_max:
			next_hour()
			refresh_date()